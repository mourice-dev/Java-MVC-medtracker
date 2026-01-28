package com.medictrack.dao;

import com.medictrack.model.User;
import com.medictrack.util.DBConnection;
import java.sql.*;

public class UserDAO {

    public User login(String email, String password) {
        User user = null;
        String sql = "SELECT * FROM users WHERE email = ? AND password = ?";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, email);
            stmt.setString(2, password);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                user = new User();
                user.setId(rs.getInt("id"));
                user.setFullName(rs.getString("full_name"));
                user.setEmail(rs.getString("email"));
                user.setRole(rs.getString("role"));
                // Don't set password in returned object for security
            }
        } catch (SQLException e) {
            System.err.println("Login SQL Error: " + e.getMessage());
            e.printStackTrace();
        }
        return user;
    }

    public boolean register(User user) throws SQLException {
        String sql = "INSERT INTO users (full_name, email, password, role) VALUES (?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, user.getFullName());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPassword());
            stmt.setString(4, user.getRole());

            int rowsInserted = stmt.executeUpdate();
            return rowsInserted > 0;
        }
    }
}
