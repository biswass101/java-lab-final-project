package com.cityhospital.dao;

import com.cityhospital.model.Bill;
import com.cityhospital.util.AppUtil;
import com.cityhospital.util.DbUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BillDao {

    public List<Bill> listAll() {
        List<Bill> items = new ArrayList<>();
        String sql = "SELECT b.id, b.bill_code, b.patient_id, p.name patient_name, b.bill_date, b.consultation_fee, b.medicine_cost, b.service_charge, b.total_amount, b.payment_status " +
                "FROM bills b JOIN patients p ON b.patient_id = p.id ORDER BY b.bill_date DESC, b.id DESC";
        try (Connection conn = DbUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                items.add(map(rs));
            }
        } catch (Exception e) {
            throw new RuntimeException("Failed to load bills", e);
        }
        return items;
    }

    public Bill findById(int id) {
        String sql = "SELECT b.id, b.bill_code, b.patient_id, p.name patient_name, b.bill_date, b.consultation_fee, b.medicine_cost, b.service_charge, b.total_amount, b.payment_status " +
                "FROM bills b JOIN patients p ON b.patient_id = p.id WHERE b.id = ?";
        try (Connection conn = DbUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return map(rs);
                }
                return null;
            }
        } catch (Exception e) {
            throw new RuntimeException("Failed to find bill", e);
        }
    }

    public void insert(Bill bill) {
        String sql = "INSERT INTO bills (bill_code, patient_id, bill_date, consultation_fee, medicine_cost, service_charge, total_amount, payment_status) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DbUtil.getConnection()) {
            conn.setAutoCommit(false);
            int nextId = nextId(conn);
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, AppUtil.billCode(nextId));
                ps.setInt(2, bill.getPatientId());
                ps.setDate(3, Date.valueOf(bill.getBillDate()));
                ps.setDouble(4, bill.getConsultationFee());
                ps.setDouble(5, bill.getMedicineCost());
                ps.setDouble(6, bill.getServiceCharge());
                ps.setDouble(7, bill.getTotalAmount());
                ps.setString(8, bill.getPaymentStatus());
                ps.executeUpdate();
            }
            conn.commit();
        } catch (Exception e) {
            throw new RuntimeException("Failed to add bill", e);
        }
    }

    public void delete(int id) {
        try (Connection conn = DbUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement("DELETE FROM bills WHERE id=?")) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
            throw new RuntimeException("Failed to delete bill", e);
        }
    }

    public void update(Bill bill) {
        String sql = "UPDATE bills SET patient_id=?, bill_date=?, consultation_fee=?, medicine_cost=?, service_charge=?, total_amount=?, payment_status=? WHERE id=?";
        try (Connection conn = DbUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bill.getPatientId());
            ps.setDate(2, Date.valueOf(bill.getBillDate()));
            ps.setDouble(3, bill.getConsultationFee());
            ps.setDouble(4, bill.getMedicineCost());
            ps.setDouble(5, bill.getServiceCharge());
            ps.setDouble(6, bill.getTotalAmount());
            ps.setString(7, bill.getPaymentStatus());
            ps.setInt(8, bill.getId());
            ps.executeUpdate();
        } catch (Exception e) {
            throw new RuntimeException("Failed to update bill", e);
        }
    }

    public int countPending() {
        String sql = "SELECT COUNT(*) FROM bills WHERE payment_status = 'Unpaid'";
        try (Connection conn = DbUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            rs.next();
            return rs.getInt(1);
        } catch (Exception e) {
            throw new RuntimeException("Failed to count pending bills", e);
        }
    }

    private int nextId(Connection conn) throws SQLException {
        try (PreparedStatement ps = conn.prepareStatement("SELECT COALESCE(MAX(id), 0) + 1 FROM bills");
             ResultSet rs = ps.executeQuery()) {
            rs.next();
            return rs.getInt(1);
        }
    }

    private Bill map(ResultSet rs) throws SQLException {
        Bill b = new Bill();
        b.setId(rs.getInt("id"));
        b.setBillCode(rs.getString("bill_code"));
        b.setPatientId(rs.getInt("patient_id"));
        b.setPatientName(rs.getString("patient_name"));
        b.setBillDate(rs.getDate("bill_date").toString());
        b.setConsultationFee(rs.getDouble("consultation_fee"));
        b.setMedicineCost(rs.getDouble("medicine_cost"));
        b.setServiceCharge(rs.getDouble("service_charge"));
        b.setTotalAmount(rs.getDouble("total_amount"));
        b.setPaymentStatus(rs.getString("payment_status"));
        return b;
    }
}
