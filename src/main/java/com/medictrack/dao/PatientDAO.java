package com.medictrack.dao;

import com.medictrack.model.Patient;
import com.medictrack.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PatientDAO {

    public List<Patient> getAllPatients() {
        List<Patient> patients = new ArrayList<>();
        String sql = "SELECT p.*, u.full_name as doctor_name FROM patients p LEFT JOIN users u ON p.assigned_doctor_id = u.id ORDER BY p.id DESC";
        
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Patient p = new Patient();
                p.setId(rs.getInt("id"));
                p.setFullName(rs.getString("full_name"));
                p.setDob(rs.getDate("dob"));
                p.setGender(rs.getString("gender"));
                p.setPhone(rs.getString("phone"));
                p.setAddress(rs.getString("address"));
                p.setMedicalCondition(rs.getString("medical_condition"));
                p.setStatus(rs.getString("status"));
                p.setLastVisit(rs.getDate("last_visit"));
                p.setAssignedDoctorId(rs.getInt("assigned_doctor_id"));
                p.setDoctorName(rs.getString("doctor_name"));
                patients.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return patients;
    }

    public Patient getPatientById(int id) {
        String sql = "SELECT p.*, u.full_name as doctor_name FROM patients p LEFT JOIN users u ON p.assigned_doctor_id = u.id WHERE p.id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                Patient p = new Patient();
                p.setId(rs.getInt("id"));
                p.setFullName(rs.getString("full_name"));
                p.setDob(rs.getDate("dob"));
                p.setGender(rs.getString("gender"));
                p.setPhone(rs.getString("phone"));
                p.setAddress(rs.getString("address"));
                p.setMedicalCondition(rs.getString("medical_condition"));
                p.setStatus(rs.getString("status"));
                p.setLastVisit(rs.getDate("last_visit"));
                p.setAssignedDoctorId(rs.getInt("assigned_doctor_id"));
                p.setDoctorName(rs.getString("doctor_name"));
                return p;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean addPatient(Patient patient) {
        String sql = "INSERT INTO patients (full_name, dob, gender, phone, address, medical_condition, status, last_visit, assigned_doctor_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, patient.getFullName());
            stmt.setDate(2, patient.getDob());
            stmt.setString(3, patient.getGender());
            stmt.setString(4, patient.getPhone());
            stmt.setString(5, patient.getAddress());
            stmt.setString(6, patient.getMedicalCondition());
            stmt.setString(7, patient.getStatus());
            stmt.setDate(8, patient.getLastVisit());
            stmt.setInt(9, patient.getAssignedDoctorId());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updatePatient(Patient patient) {
        String sql = "UPDATE patients SET full_name=?, dob=?, gender=?, phone=?, address=?, medical_condition=?, status=?, last_visit=?, assigned_doctor_id=? WHERE id=?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, patient.getFullName());
            stmt.setDate(2, patient.getDob());
            stmt.setString(3, patient.getGender());
            stmt.setString(4, patient.getPhone());
            stmt.setString(5, patient.getAddress());
            stmt.setString(6, patient.getMedicalCondition());
            stmt.setString(7, patient.getStatus());
            stmt.setDate(8, patient.getLastVisit());
            stmt.setInt(9, patient.getAssignedDoctorId());
            stmt.setInt(10, patient.getId());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deletePatient(int id) {
        String sql = "DELETE FROM patients WHERE id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
