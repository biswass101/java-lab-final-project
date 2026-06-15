package com.cityhospital.dao;

import com.cityhospital.model.SearchResult;
import com.cityhospital.util.DbUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class SearchDao {

    public List<SearchResult> search(String query, String type) {
        String q = query == null ? "" : query.trim();
        String t = type == null ? "" : type.trim();
        List<SearchResult> results = new ArrayList<>();

        if (t.isEmpty() || "Patient".equalsIgnoreCase(t)) {
            results.addAll(searchPatients(q));
        }
        if (t.isEmpty() || "Appointment".equalsIgnoreCase(t)) {
            results.addAll(searchAppointments(q));
        }
        if (t.isEmpty() || "Prescription".equalsIgnoreCase(t)) {
            results.addAll(searchPrescriptions(q));
        }
        if (t.isEmpty() || "Billing".equalsIgnoreCase(t)) {
            results.addAll(searchBills(q));
        }
        return results;
    }

    private List<SearchResult> searchPatients(String query) {
        String sql = "SELECT patient_code, name, phone FROM patients WHERE name LIKE ? OR patient_code LIKE ? OR phone LIKE ? ORDER BY id DESC LIMIT 50";
        List<SearchResult> list = new ArrayList<>();
        try (Connection conn = DbUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            String like = "%" + query + "%";
            ps.setString(1, like);
            ps.setString(2, like);
            ps.setString(3, like);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(new SearchResult("Patient", rs.getString("patient_code"), rs.getString("name"), "-", "Phone: " + rs.getString("phone")));
                }
            }
        } catch (Exception e) {
            throw new RuntimeException("Patient search failed", e);
        }
        return list;
    }

    private List<SearchResult> searchAppointments(String query) {
        String sql = "SELECT a.appointment_code, p.name patient_name, a.appointment_date, d.name doctor_name, a.appointment_time " +
                "FROM appointments a JOIN patients p ON a.patient_id=p.id JOIN doctors d ON a.doctor_id=d.id " +
                "WHERE a.appointment_code LIKE ? OR p.name LIKE ? OR d.name LIKE ? OR a.appointment_date LIKE ? ORDER BY a.appointment_date DESC LIMIT 50";
        List<SearchResult> list = new ArrayList<>();
        try (Connection conn = DbUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            String like = "%" + query + "%";
            ps.setString(1, like);
            ps.setString(2, like);
            ps.setString(3, like);
            ps.setString(4, like);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    String detail = rs.getString("doctor_name") + " - " + rs.getString("appointment_time").substring(0, 5);
                    list.add(new SearchResult("Appointment", rs.getString("appointment_code"), rs.getString("patient_name"), rs.getDate("appointment_date").toString(), detail));
                }
            }
        } catch (Exception e) {
            throw new RuntimeException("Appointment search failed", e);
        }
        return list;
    }

    private List<SearchResult> searchPrescriptions(String query) {
        String sql = "SELECT r.prescription_code, p.name patient_name, r.prescription_date, r.diagnosis, r.medicine_name " +
                "FROM prescriptions r JOIN patients p ON r.patient_id=p.id " +
                "WHERE r.prescription_code LIKE ? OR p.name LIKE ? OR r.diagnosis LIKE ? OR r.prescription_date LIKE ? ORDER BY r.prescription_date DESC LIMIT 50";
        List<SearchResult> list = new ArrayList<>();
        try (Connection conn = DbUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            String like = "%" + query + "%";
            ps.setString(1, like);
            ps.setString(2, like);
            ps.setString(3, like);
            ps.setString(4, like);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    String detail = rs.getString("diagnosis") + " - " + rs.getString("medicine_name");
                    list.add(new SearchResult("Prescription", rs.getString("prescription_code"), rs.getString("patient_name"), rs.getDate("prescription_date").toString(), detail));
                }
            }
        } catch (Exception e) {
            throw new RuntimeException("Prescription search failed", e);
        }
        return list;
    }

    private List<SearchResult> searchBills(String query) {
        String sql = "SELECT b.bill_code, p.name patient_name, b.bill_date, b.total_amount, b.payment_status " +
                "FROM bills b JOIN patients p ON b.patient_id=p.id " +
                "WHERE b.bill_code LIKE ? OR p.name LIKE ? OR b.bill_date LIKE ? OR b.payment_status LIKE ? ORDER BY b.bill_date DESC LIMIT 50";
        List<SearchResult> list = new ArrayList<>();
        try (Connection conn = DbUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            String like = "%" + query + "%";
            ps.setString(1, like);
            ps.setString(2, like);
            ps.setString(3, like);
            ps.setString(4, like);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    String detail = "TK " + rs.getDouble("total_amount") + " - " + rs.getString("payment_status");
                    list.add(new SearchResult("Billing", rs.getString("bill_code"), rs.getString("patient_name"), rs.getDate("bill_date").toString(), detail));
                }
            }
        } catch (Exception e) {
            throw new RuntimeException("Billing search failed", e);
        }
        return list;
    }
}
