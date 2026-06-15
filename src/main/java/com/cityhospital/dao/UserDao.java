package com.cityhospital.dao;

import com.cityhospital.model.User;
import com.cityhospital.util.DbUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDao {

    public User validate(String username, String password) {
        String sql = "SELECT id, username, password, role FROM users WHERE username = ? AND password = ?";
        try (Connection conn = DbUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, password);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    User user = new User();
                    user.setId(rs.getInt("id"));
                    user.setUsername(rs.getString("username"));
                    user.setPassword(rs.getString("password"));
                    user.setRole(rs.getString("role"));
                    return user;
                }
            }
        } catch (Exception e) {
            throw new RuntimeException("Failed to validate user", e);
        }
        return null;
    }

    public void updateAdmin(String username, String role, String newPassword) {
        String sql = "UPDATE users SET username = ?, role = ?, password = COALESCE(NULLIF(?, ''), password) WHERE id = (SELECT id FROM (SELECT id FROM users ORDER BY id LIMIT 1) t)";
        try (Connection conn = DbUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, role);
            ps.setString(3, newPassword);
            ps.executeUpdate();
        } catch (Exception e) {
            throw new RuntimeException("Failed to update admin settings", e);
        }
    }

    public User getAdmin() {
        String sql = "SELECT id, username, password, role FROM users ORDER BY id LIMIT 1";
        try (Connection conn = DbUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setRole(rs.getString("role"));
                return user;
            }
            return null;
        } catch (Exception e) {
            throw new RuntimeException("Failed to read admin", e);
        }
    }
}
