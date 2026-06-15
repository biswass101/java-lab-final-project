package com.cityhospital.dao;

import com.cityhospital.model.HospitalSetting;
import com.cityhospital.util.DbUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class HospitalSettingDao {

    public HospitalSetting get() {
        String sql = "SELECT id, hospital_name, contact_number, address, email FROM hospital_settings ORDER BY id LIMIT 1";
        try (Connection conn = DbUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                HospitalSetting setting = new HospitalSetting();
                setting.setId(rs.getInt("id"));
                setting.setHospitalName(rs.getString("hospital_name"));
                setting.setContactNumber(rs.getString("contact_number"));
                setting.setAddress(rs.getString("address"));
                setting.setEmail(rs.getString("email"));
                return setting;
            }
            return null;
        } catch (Exception e) {
            throw new RuntimeException("Failed to read hospital settings", e);
        }
    }

    public void update(HospitalSetting setting) {
        String sql = "UPDATE hospital_settings SET hospital_name=?, contact_number=?, address=?, email=? WHERE id=?";
        try (Connection conn = DbUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, setting.getHospitalName());
            ps.setString(2, setting.getContactNumber());
            ps.setString(3, setting.getAddress());
            ps.setString(4, setting.getEmail());
            ps.setInt(5, setting.getId());
            ps.executeUpdate();
        } catch (Exception e) {
            throw new RuntimeException("Failed to update hospital settings", e);
        }
    }
}
