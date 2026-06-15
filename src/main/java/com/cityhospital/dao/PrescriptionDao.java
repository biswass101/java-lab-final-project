package com.cityhospital.dao;

import com.cityhospital.model.Prescription;
import com.cityhospital.model.PrescriptionItem;
import com.cityhospital.util.AppUtil;
import com.cityhospital.util.DbUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PrescriptionDao {

    public List<Prescription> listAll() {
        List<Prescription> items = new ArrayList<>();
        String sql = "SELECT r.id, r.prescription_code, r.patient_id, r.doctor_id, p.name patient_name, d.name doctor_name, " +
                "r.prescription_date, r.diagnosis, r.medicine_name, r.dosage, r.instructions, " +
                "COALESCE(GROUP_CONCAT(CONCAT(pi.medicine_name, '||', pi.dosage) SEPARATOR '##'), '') items_blob " +
                "FROM prescriptions r " +
                "JOIN patients p ON r.patient_id = p.id " +
                "JOIN doctors d ON r.doctor_id = d.id " +
                "LEFT JOIN prescription_items pi ON pi.prescription_id = r.id " +
                "GROUP BY r.id, r.prescription_code, r.patient_id, r.doctor_id, p.name, d.name, r.prescription_date, r.diagnosis, r.medicine_name, r.dosage, r.instructions " +
                "ORDER BY r.prescription_date DESC, r.id DESC";
        try (Connection conn = DbUtil.getConnection()) {
            ensureItemsTable(conn);
            try (PreparedStatement ps = conn.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    items.add(map(rs));
                }
            }
        } catch (Exception e) {
            throw new RuntimeException("Failed to load prescriptions", e);
        }
        return items;
    }

    public Prescription findById(int id) {
        String sql = "SELECT r.id, r.prescription_code, r.patient_id, r.doctor_id, p.name patient_name, d.name doctor_name, " +
                "r.prescription_date, r.diagnosis, r.medicine_name, r.dosage, r.instructions " +
                "FROM prescriptions r JOIN patients p ON r.patient_id = p.id JOIN doctors d ON r.doctor_id = d.id WHERE r.id = ?";
        try (Connection conn = DbUtil.getConnection()) {
            ensureItemsTable(conn);
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, id);
                try (ResultSet rs = ps.executeQuery()) {
                    if (!rs.next()) {
                        return null;
                    }
                    Prescription p = map(rs);
                    p.setItems(loadItems(conn, id));
                    if (p.getItems().isEmpty() && p.getMedicineName() != null && !p.getMedicineName().isBlank()) {
                        p.getItems().add(new PrescriptionItem(p.getMedicineName(), p.getDosage()));
                    }
                    return p;
                }
            }
        } catch (Exception e) {
            throw new RuntimeException("Failed to find prescription", e);
        }
    }

    public void insert(Prescription prescription, List<PrescriptionItem> medicineItems) {
        String sql = "INSERT INTO prescriptions (prescription_code, patient_id, doctor_id, prescription_date, diagnosis, medicine_name, dosage, instructions) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DbUtil.getConnection()) {
            ensureItemsTable(conn);
            conn.setAutoCommit(false);
            int nextId = nextId(conn);
            int createdId;
            try (PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
                ps.setString(1, AppUtil.prescriptionCode(nextId));
                ps.setInt(2, prescription.getPatientId());
                ps.setInt(3, prescription.getDoctorId());
                ps.setDate(4, Date.valueOf(prescription.getPrescriptionDate()));
                ps.setString(5, prescription.getDiagnosis());
                PrescriptionItem first = firstItem(medicineItems);
                ps.setString(6, first == null ? "" : first.getMedicineName());
                ps.setString(7, first == null ? "" : first.getDosage());
                ps.setString(8, prescription.getInstructions());
                ps.executeUpdate();
                try (ResultSet keys = ps.getGeneratedKeys()) {
                    keys.next();
                    createdId = keys.getInt(1);
                }
            }
            saveItems(conn, createdId, medicineItems);
            conn.commit();
        } catch (Exception e) {
            throw new RuntimeException("Failed to add prescription", e);
        }
    }

    public void update(Prescription prescription, List<PrescriptionItem> medicineItems) {
        String sql = "UPDATE prescriptions SET patient_id=?, doctor_id=?, prescription_date=?, diagnosis=?, medicine_name=?, dosage=?, instructions=? WHERE id=?";
        try (Connection conn = DbUtil.getConnection()) {
            ensureItemsTable(conn);
            conn.setAutoCommit(false);
            PrescriptionItem first = firstItem(medicineItems);
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, prescription.getPatientId());
                ps.setInt(2, prescription.getDoctorId());
                ps.setDate(3, Date.valueOf(prescription.getPrescriptionDate()));
                ps.setString(4, prescription.getDiagnosis());
                ps.setString(5, first == null ? "" : first.getMedicineName());
                ps.setString(6, first == null ? "" : first.getDosage());
                ps.setString(7, prescription.getInstructions());
                ps.setInt(8, prescription.getId());
                ps.executeUpdate();
            }

            try (PreparedStatement del = conn.prepareStatement("DELETE FROM prescription_items WHERE prescription_id=?")) {
                del.setInt(1, prescription.getId());
                del.executeUpdate();
            }
            saveItems(conn, prescription.getId(), medicineItems);
            conn.commit();
        } catch (Exception e) {
            throw new RuntimeException("Failed to update prescription", e);
        }
    }

    public void delete(int id) {
        try (Connection conn = DbUtil.getConnection()) {
            ensureItemsTable(conn);
            try (PreparedStatement ps = conn.prepareStatement("DELETE FROM prescriptions WHERE id=?")) {
                ps.setInt(1, id);
                ps.executeUpdate();
            }
        } catch (Exception e) {
            throw new RuntimeException("Failed to delete prescription", e);
        }
    }

    private void saveItems(Connection conn, int prescriptionId, List<PrescriptionItem> medicineItems) throws SQLException {
        if (medicineItems == null || medicineItems.isEmpty()) {
            return;
        }
        try (PreparedStatement ps = conn.prepareStatement("INSERT INTO prescription_items (prescription_id, medicine_name, dosage) VALUES (?, ?, ?)")) {
            for (PrescriptionItem item : medicineItems) {
                if (item.getMedicineName() == null || item.getMedicineName().isBlank()) {
                    continue;
                }
                ps.setInt(1, prescriptionId);
                ps.setString(2, item.getMedicineName());
                ps.setString(3, item.getDosage() == null ? "" : item.getDosage());
                ps.addBatch();
            }
            ps.executeBatch();
        }
    }

    private List<PrescriptionItem> loadItems(Connection conn, int prescriptionId) throws SQLException {
        List<PrescriptionItem> list = new ArrayList<>();
        try (PreparedStatement ps = conn.prepareStatement("SELECT id, prescription_id, medicine_name, dosage FROM prescription_items WHERE prescription_id=? ORDER BY id")) {
            ps.setInt(1, prescriptionId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    PrescriptionItem item = new PrescriptionItem();
                    item.setId(rs.getInt("id"));
                    item.setPrescriptionId(rs.getInt("prescription_id"));
                    item.setMedicineName(rs.getString("medicine_name"));
                    item.setDosage(rs.getString("dosage"));
                    list.add(item);
                }
            }
        }
        return list;
    }

    private PrescriptionItem firstItem(List<PrescriptionItem> medicineItems) {
        if (medicineItems == null || medicineItems.isEmpty()) {
            return null;
        }
        for (PrescriptionItem i : medicineItems) {
            if (i.getMedicineName() != null && !i.getMedicineName().isBlank()) {
                return i;
            }
        }
        return null;
    }

    private int nextId(Connection conn) throws SQLException {
        try (PreparedStatement ps = conn.prepareStatement("SELECT COALESCE(MAX(id), 0) + 1 FROM prescriptions");
             ResultSet rs = ps.executeQuery()) {
            rs.next();
            return rs.getInt(1);
        }
    }

    private Prescription map(ResultSet rs) throws SQLException {
        Prescription p = new Prescription();
        p.setId(rs.getInt("id"));
        p.setPrescriptionCode(rs.getString("prescription_code"));
        p.setPatientId(rs.getInt("patient_id"));
        p.setDoctorId(rs.getInt("doctor_id"));
        p.setPatientName(rs.getString("patient_name"));
        p.setDoctorName(rs.getString("doctor_name"));
        p.setPrescriptionDate(rs.getDate("prescription_date").toString());
        p.setDiagnosis(rs.getString("diagnosis"));
        p.setMedicineName(rs.getString("medicine_name"));
        p.setDosage(rs.getString("dosage"));
        p.setInstructions(rs.getString("instructions"));

        String itemsBlob = "";
        try {
            itemsBlob = rs.getString("items_blob");
        } catch (SQLException ignored) {
        }
        if ((itemsBlob == null || itemsBlob.isBlank()) && p.getMedicineName() != null && !p.getMedicineName().isBlank()) {
            itemsBlob = p.getMedicineName() + "||" + (p.getDosage() == null ? "" : p.getDosage());
        }
        p.setItemsBlob(itemsBlob == null ? "" : itemsBlob);
        p.setMedicinesSummary(buildSummary(p.getItemsBlob()));
        return p;
    }

    private String buildSummary(String itemsBlob) {
        if (itemsBlob == null || itemsBlob.isBlank()) {
            return "-";
        }
        StringBuilder sb = new StringBuilder();
        String[] rows = itemsBlob.split("##");
        for (int i = 0; i < rows.length; i++) {
            if (rows[i].isBlank()) {
                continue;
            }
            String[] parts = rows[i].split("\\|\\|", 2);
            if (sb.length() > 0) {
                sb.append(", ");
            }
            sb.append(parts[0]);
            if (parts.length > 1 && !parts[1].isBlank()) {
                sb.append(" (").append(parts[1]).append(")");
            }
        }
        return sb.length() == 0 ? "-" : sb.toString();
    }

    private void ensureItemsTable(Connection conn) throws SQLException {
        try (PreparedStatement ps = conn.prepareStatement(
                "CREATE TABLE IF NOT EXISTS prescription_items (" +
                        "id INT PRIMARY KEY AUTO_INCREMENT," +
                        "prescription_id INT NOT NULL," +
                        "medicine_name VARCHAR(255) NOT NULL," +
                        "dosage VARCHAR(255)," +
                        "CONSTRAINT fk_prescription_items_prescription FOREIGN KEY (prescription_id) REFERENCES prescriptions(id) ON DELETE CASCADE" +
                        ")"
        )) {
            ps.execute();
        }
    }
}
