package com.cityhospital.dao;

import com.cityhospital.model.Patient;
import com.cityhospital.util.AppUtil;
import com.cityhospital.util.DbUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PatientDao {

    public List<Patient> list(String query) {
        List<Patient> patients = new ArrayList<>();
        String sql = "SELECT id, patient_code, name, age, gender, phone, blood_group, email, address " +
                "FROM patients WHERE (?='' OR name LIKE ? OR patient_code LIKE ? OR phone LIKE ?) ORDER BY id DESC";

        try (Connection conn = DbUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            String q = query == null ? "" : query.trim();
            String like = "%" + q + "%";
            ps.setString(1, q);
            ps.setString(2, like);
            ps.setString(3, like);
            ps.setString(4, like);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    patients.add(map(rs));
                }
            }
        } catch (Exception e) {
            throw new RuntimeException("Failed to list patients", e);
        }
        return patients;
    }

    public List<Patient> allForSelect() {
        List<Patient> patients = new ArrayList<>();
        String sql = "SELECT id, patient_code, name, age, gender, phone, blood_group, email, address FROM patients ORDER BY name";
        try (Connection conn = DbUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                patients.add(map(rs));
            }
        } catch (Exception e) {
            throw new RuntimeException("Failed to load patients", e);
        }
        return patients;
    }

    public void insert(Patient patient) {
        String sql = "INSERT INTO patients (patient_code, name, age, gender, phone, blood_group, email, address) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DbUtil.getConnection()) {
            conn.setAutoCommit(false);
            int nextId = nextId(conn);
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, AppUtil.patientCode(nextId));
                ps.setString(2, patient.getName());
                ps.setInt(3, patient.getAge());
                ps.setString(4, patient.getGender());
                ps.setString(5, patient.getPhone());
                ps.setString(6, patient.getBloodGroup());
                ps.setString(7, patient.getEmail());
                ps.setString(8, patient.getAddress());
                ps.executeUpdate();
            }
            conn.commit();
        } catch (Exception e) {
            throw new RuntimeException("Failed to add patient", e);
        }
    }

    public void delete(int id) {
        String sql = "DELETE FROM patients WHERE id = ?";
        try (Connection conn = DbUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
            throw new RuntimeException("Failed to delete patient", e);
        }
    }

    public void update(Patient patient) {
        String sql = "UPDATE patients SET name=?, age=?, gender=?, phone=?, blood_group=?, email=?, address=? WHERE id=?";
        try (Connection conn = DbUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, patient.getName());
            ps.setInt(2, patient.getAge());
            ps.setString(3, patient.getGender());
            ps.setString(4, patient.getPhone());
            ps.setString(5, patient.getBloodGroup());
            ps.setString(6, patient.getEmail());
            ps.setString(7, patient.getAddress());
            ps.setInt(8, patient.getId());
            ps.executeUpdate();
        } catch (Exception e) {
            throw new RuntimeException("Failed to update patient", e);
        }
    }

    public int count() {
        String sql = "SELECT COUNT(*) FROM patients";
        try (Connection conn = DbUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            rs.next();
            return rs.getInt(1);
        } catch (Exception e) {
            throw new RuntimeException("Failed to count patients", e);
        }
    }

    private int nextId(Connection conn) throws SQLException {
        try (PreparedStatement ps = conn.prepareStatement("SELECT COALESCE(MAX(id), 0) + 1 FROM patients");
             ResultSet rs = ps.executeQuery()) {
            rs.next();
            return rs.getInt(1);
        }
    }

    private Patient map(ResultSet rs) throws SQLException {
        Patient p = new Patient();
        p.setId(rs.getInt("id"));
        p.setPatientCode(rs.getString("patient_code"));
        p.setName(rs.getString("name"));
        p.setAge(rs.getInt("age"));
        p.setGender(rs.getString("gender"));
        p.setPhone(rs.getString("phone"));
        p.setBloodGroup(rs.getString("blood_group"));
        p.setEmail(rs.getString("email"));
        p.setAddress(rs.getString("address"));
        return p;
    }
}
