package com.medictrack.dao;

import com.medictrack.model.Staff;
import com.medictrack.model.User;
import com.medictrack.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class StaffDAO {

    public List<Staff> getAllStaff() {
        List<Staff> staffList = new ArrayList<>();
        String sql = "SELECT u.id as user_id, u.full_name, u.email, u.role, " +
                     "sd.id, sd.department, sd.specialty, sd.shift_start, sd.shift_end, sd.status " +
                     "FROM users u LEFT JOIN staff_details sd ON u.id = sd.user_id " +
                     "WHERE u.role IN ('DOCTOR', 'NURSE', 'STAFF') " +
                     "ORDER BY u.full_name";
        
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Staff s = new Staff();
                s.setId(rs.getInt("id"));
                s.setUserId(rs.getInt("user_id"));
                s.setFullName(rs.getString("full_name"));
                s.setEmail(rs.getString("email"));
                s.setRole(rs.getString("role"));
                s.setDepartment(rs.getString("department"));
                s.setSpecialty(rs.getString("specialty"));
                s.setShiftStart(rs.getString("shift_start"));
                s.setShiftEnd(rs.getString("shift_end"));
                s.setStatus(rs.getString("status") != null ? rs.getString("status") : "Off Duty");
                staffList.add(s);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return staffList;
    }

    public List<User> getAllDoctors() {
        List<User> doctors = new ArrayList<>();
        String sql = "SELECT * FROM users WHERE role = 'DOCTOR' ORDER BY full_name";
        
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                User u = new User();
                u.setId(rs.getInt("id"));
                u.setFullName(rs.getString("full_name"));
                u.setEmail(rs.getString("email"));
                u.setRole(rs.getString("role"));
                doctors.add(u);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return doctors;
    }

    public Staff getStaffByUserId(int userId) {
        String sql = "SELECT u.id as user_id, u.full_name, u.email, u.role, " +
                     "sd.id, sd.department, sd.specialty, sd.shift_start, sd.shift_end, sd.status " +
                     "FROM users u LEFT JOIN staff_details sd ON u.id = sd.user_id " +
                     "WHERE u.id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                Staff s = new Staff();
                s.setId(rs.getInt("id"));
                s.setUserId(rs.getInt("user_id"));
                s.setFullName(rs.getString("full_name"));
                s.setEmail(rs.getString("email"));
                s.setRole(rs.getString("role"));
                s.setDepartment(rs.getString("department"));
                s.setSpecialty(rs.getString("specialty"));
                s.setShiftStart(rs.getString("shift_start"));
                s.setShiftEnd(rs.getString("shift_end"));
                s.setStatus(rs.getString("status") != null ? rs.getString("status") : "Off Duty");
                return s;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updateStaffDetails(Staff staff) {
        // First check if staff_details exists
        String checkSql = "SELECT id FROM staff_details WHERE user_id = ?";
        String insertSql = "INSERT INTO staff_details (user_id, department, specialty, shift_start, shift_end, status) VALUES (?, ?, ?, ?, ?, ?)";
        String updateSql = "UPDATE staff_details SET department=?, specialty=?, shift_start=?, shift_end=?, status=? WHERE user_id=?";
        
        try (Connection conn = DBConnection.getConnection()) {
            PreparedStatement checkStmt = conn.prepareStatement(checkSql);
            checkStmt.setInt(1, staff.getUserId());
            ResultSet rs = checkStmt.executeQuery();
            
            if (rs.next()) {
                // Update existing
                PreparedStatement updateStmt = conn.prepareStatement(updateSql);
                updateStmt.setString(1, staff.getDepartment());
                updateStmt.setString(2, staff.getSpecialty());
                updateStmt.setString(3, staff.getShiftStart());
                updateStmt.setString(4, staff.getShiftEnd());
                updateStmt.setString(5, staff.getStatus());
                updateStmt.setInt(6, staff.getUserId());
                return updateStmt.executeUpdate() > 0;
            } else {
                // Insert new
                PreparedStatement insertStmt = conn.prepareStatement(insertSql);
                insertStmt.setInt(1, staff.getUserId());
                insertStmt.setString(2, staff.getDepartment());
                insertStmt.setString(3, staff.getSpecialty());
                insertStmt.setString(4, staff.getShiftStart());
                insertStmt.setString(5, staff.getShiftEnd());
                insertStmt.setString(6, staff.getStatus());
                return insertStmt.executeUpdate() > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
