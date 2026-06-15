package com.cityhospital.dao;

import com.cityhospital.model.Doctor;
import com.cityhospital.util.AppUtil;
import com.cityhospital.util.DbUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DoctorDao {

    public List<Doctor> list(String query) {
        List<Doctor> doctors = new ArrayList<>();
        String sql = "SELECT id, doctor_code, name, specialization, phone, email, available_days, consultation_fee, availability " +
                "FROM doctors WHERE (?='' OR name LIKE ? OR specialization LIKE ? OR doctor_code LIKE ?) ORDER BY id DESC";

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
                    doctors.add(map(rs));
                }
            }
        } catch (Exception e) {
            throw new RuntimeException("Failed to list doctors", e);
        }
        return doctors;
    }

    public List<Doctor> allForSelect() {
        List<Doctor> doctors = new ArrayList<>();
        String sql = "SELECT id, doctor_code, name, specialization, phone, email, available_days, consultation_fee, availability FROM doctors ORDER BY name";
        try (Connection conn = DbUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                doctors.add(map(rs));
            }
        } catch (Exception e) {
            throw new RuntimeException("Failed to load doctors", e);
        }
        return doctors;
    }

    public void insert(Doctor doctor) {
        String sql = "INSERT INTO doctors (doctor_code, name, specialization, phone, email, available_days, consultation_fee, availability) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DbUtil.getConnection()) {
            conn.setAutoCommit(false);
            int nextId = nextId(conn);
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, AppUtil.doctorCode(nextId));
                ps.setString(2, doctor.getName());
                ps.setString(3, doctor.getSpecialization());
                ps.setString(4, doctor.getPhone());
                ps.setString(5, doctor.getEmail());
                ps.setString(6, doctor.getAvailableDays());
                ps.setDouble(7, doctor.getConsultationFee());
                ps.setString(8, doctor.getAvailability());
                ps.executeUpdate();
            }
            conn.commit();
        } catch (Exception e) {
            throw new RuntimeException("Failed to add doctor", e);
        }
    }

    public void delete(int id) {
        String sql = "DELETE FROM doctors WHERE id = ?";
        try (Connection conn = DbUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
            throw new RuntimeException("Failed to delete doctor", e);
        }
    }

    public void update(Doctor doctor) {
        String sql = "UPDATE doctors SET name=?, specialization=?, phone=?, email=?, available_days=?, consultation_fee=?, availability=? WHERE id=?";
        try (Connection conn = DbUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, doctor.getName());
            ps.setString(2, doctor.getSpecialization());
            ps.setString(3, doctor.getPhone());
            ps.setString(4, doctor.getEmail());
            ps.setString(5, doctor.getAvailableDays());
            ps.setDouble(6, doctor.getConsultationFee());
            ps.setString(7, doctor.getAvailability());
            ps.setInt(8, doctor.getId());
            ps.executeUpdate();
        } catch (Exception e) {
            throw new RuntimeException("Failed to update doctor", e);
        }
    }

    public int count() {
        String sql = "SELECT COUNT(*) FROM doctors";
        try (Connection conn = DbUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            rs.next();
            return rs.getInt(1);
        } catch (Exception e) {
            throw new RuntimeException("Failed to count doctors", e);
        }
    }

    private int nextId(Connection conn) throws SQLException {
        try (PreparedStatement ps = conn.prepareStatement("SELECT COALESCE(MAX(id), 0) + 1 FROM doctors");
             ResultSet rs = ps.executeQuery()) {
            rs.next();
            return rs.getInt(1);
        }
    }

    private Doctor map(ResultSet rs) throws SQLException {
        Doctor d = new Doctor();
        d.setId(rs.getInt("id"));
        d.setDoctorCode(rs.getString("doctor_code"));
        d.setName(rs.getString("name"));
        d.setSpecialization(rs.getString("specialization"));
        d.setPhone(rs.getString("phone"));
        d.setEmail(rs.getString("email"));
        d.setAvailableDays(rs.getString("available_days"));
        d.setConsultationFee(rs.getDouble("consultation_fee"));
        d.setAvailability(rs.getString("availability"));
        return d;
    }
}
