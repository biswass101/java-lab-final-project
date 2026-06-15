package com.cityhospital.dao;

import com.cityhospital.model.Appointment;
import com.cityhospital.util.AppUtil;
import com.cityhospital.util.DbUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AppointmentDao {

    public List<Appointment> listAll() {
        String sql = "SELECT a.id, a.appointment_code, a.patient_id, a.doctor_id, p.name patient_name, d.name doctor_name, " +
                "a.appointment_date, a.appointment_time, a.reason, a.status " +
                "FROM appointments a JOIN patients p ON a.patient_id = p.id JOIN doctors d ON a.doctor_id = d.id ORDER BY a.appointment_date DESC, a.appointment_time DESC";
        return query(sql);
    }

    public List<Appointment> recent(int limit) {
        String sql = "SELECT a.id, a.appointment_code, a.patient_id, a.doctor_id, p.name patient_name, d.name doctor_name, " +
                "a.appointment_date, a.appointment_time, a.reason, a.status " +
                "FROM appointments a JOIN patients p ON a.patient_id = p.id JOIN doctors d ON a.doctor_id = d.id ORDER BY a.appointment_date DESC, a.appointment_time DESC LIMIT ?";
        List<Appointment> appointments = new ArrayList<>();
        try (Connection conn = DbUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, limit);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    appointments.add(map(rs));
                }
            }
        } catch (Exception e) {
            throw new RuntimeException("Failed to load recent appointments", e);
        }
        return appointments;
    }

    public void insert(Appointment appointment) {
        String sql = "INSERT INTO appointments (appointment_code, patient_id, doctor_id, appointment_date, appointment_time, reason, status) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DbUtil.getConnection()) {
            conn.setAutoCommit(false);
            int nextId = nextId(conn);
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, AppUtil.appointmentCode(nextId));
                ps.setInt(2, appointment.getPatientId());
                ps.setInt(3, appointment.getDoctorId());
                ps.setDate(4, Date.valueOf(appointment.getAppointmentDate()));
                ps.setTime(5, Time.valueOf(appointment.getAppointmentTime() + ":00"));
                ps.setString(6, appointment.getReason());
                ps.setString(7, appointment.getStatus());
                ps.executeUpdate();
            }
            conn.commit();
        } catch (Exception e) {
            throw new RuntimeException("Failed to book appointment", e);
        }
    }

    public void delete(int id) {
        try (Connection conn = DbUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement("DELETE FROM appointments WHERE id = ?")) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
            throw new RuntimeException("Failed to delete appointment", e);
        }
    }

    public void update(Appointment appointment) {
        String sql = "UPDATE appointments SET patient_id=?, doctor_id=?, appointment_date=?, appointment_time=?, reason=?, status=? WHERE id=?";
        try (Connection conn = DbUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, appointment.getPatientId());
            ps.setInt(2, appointment.getDoctorId());
            ps.setDate(3, Date.valueOf(appointment.getAppointmentDate()));
            ps.setTime(4, Time.valueOf(appointment.getAppointmentTime() + ":00"));
            ps.setString(5, appointment.getReason());
            ps.setString(6, appointment.getStatus());
            ps.setInt(7, appointment.getId());
            ps.executeUpdate();
        } catch (Exception e) {
            throw new RuntimeException("Failed to update appointment", e);
        }
    }

    public int countToday() {
        String sql = "SELECT COUNT(*) FROM appointments WHERE appointment_date = CURDATE()";
        try (Connection conn = DbUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            rs.next();
            return rs.getInt(1);
        } catch (Exception e) {
            throw new RuntimeException("Failed to count today's appointments", e);
        }
    }

    private int nextId(Connection conn) throws SQLException {
        try (PreparedStatement ps = conn.prepareStatement("SELECT COALESCE(MAX(id), 0) + 1 FROM appointments");
             ResultSet rs = ps.executeQuery()) {
            rs.next();
            return rs.getInt(1);
        }
    }

    private List<Appointment> query(String sql) {
        List<Appointment> appointments = new ArrayList<>();
        try (Connection conn = DbUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                appointments.add(map(rs));
            }
        } catch (Exception e) {
            throw new RuntimeException("Failed to load appointments", e);
        }
        return appointments;
    }

    private Appointment map(ResultSet rs) throws SQLException {
        Appointment a = new Appointment();
        a.setId(rs.getInt("id"));
        a.setAppointmentCode(rs.getString("appointment_code"));
        a.setPatientId(rs.getInt("patient_id"));
        a.setDoctorId(rs.getInt("doctor_id"));
        a.setPatientName(rs.getString("patient_name"));
        a.setDoctorName(rs.getString("doctor_name"));
        a.setAppointmentDate(rs.getDate("appointment_date").toString());
        a.setAppointmentTime(rs.getTime("appointment_time").toString().substring(0, 5));
        a.setReason(rs.getString("reason"));
        a.setStatus(rs.getString("status"));
        return a;
    }
}
