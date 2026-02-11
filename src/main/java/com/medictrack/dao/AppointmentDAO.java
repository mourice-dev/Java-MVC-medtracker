package com.medictrack.dao;

import com.medictrack.model.Appointment;
import com.medictrack.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AppointmentDAO {

    public List<Appointment> getAllAppointments() {
        List<Appointment> appointments = new ArrayList<>();
        String sql = "SELECT a.*, p.full_name as patient_name, u.full_name as doctor_name " +
                "FROM appointments a " +
                "LEFT JOIN patients p ON a.patient_id = p.id " +
                "LEFT JOIN users u ON a.doctor_id = u.id " +
                "ORDER BY a.appointment_time DESC";

        try (Connection conn = DBConnection.getConnection();
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Appointment a = new Appointment();
                a.setId(rs.getInt("id"));
                a.setPatientId(rs.getInt("patient_id"));
                a.setDoctorId(rs.getInt("doctor_id"));
                a.setAppointmentTime(rs.getTimestamp("appointment_time"));
                a.setType(rs.getString("type"));
                a.setStatus(rs.getString("status"));
                a.setNotes(rs.getString("notes"));
                a.setPatientName(rs.getString("patient_name"));
                a.setDoctorName(rs.getString("doctor_name"));
                appointments.add(a);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return appointments;
    }

    public List<Appointment> getTodayAppointments() {
        List<Appointment> appointments = new ArrayList<>();
        String sql = "SELECT a.*, p.full_name as patient_name, u.full_name as doctor_name " +
                "FROM appointments a " +
                "LEFT JOIN patients p ON a.patient_id = p.id " +
                "LEFT JOIN users u ON a.doctor_id = u.id " +
                "WHERE DATE(a.appointment_time) = CURDATE() " +
                "ORDER BY a.appointment_time ASC";

        try (Connection conn = DBConnection.getConnection();
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Appointment a = new Appointment();
                a.setId(rs.getInt("id"));
                a.setPatientId(rs.getInt("patient_id"));
                a.setDoctorId(rs.getInt("doctor_id"));
                a.setAppointmentTime(rs.getTimestamp("appointment_time"));
                a.setType(rs.getString("type"));
                a.setStatus(rs.getString("status"));
                a.setNotes(rs.getString("notes"));
                a.setPatientName(rs.getString("patient_name"));
                a.setDoctorName(rs.getString("doctor_name"));
                appointments.add(a);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return appointments;
    }

    public Appointment getAppointmentById(int id) {
        String sql = "SELECT a.*, p.full_name as patient_name, u.full_name as doctor_name " +
                "FROM appointments a " +
                "LEFT JOIN patients p ON a.patient_id = p.id " +
                "LEFT JOIN users u ON a.doctor_id = u.id " +
                "WHERE a.id = ?";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Appointment a = new Appointment();
                a.setId(rs.getInt("id"));
                a.setPatientId(rs.getInt("patient_id"));
                a.setDoctorId(rs.getInt("doctor_id"));
                a.setAppointmentTime(rs.getTimestamp("appointment_time"));
                a.setType(rs.getString("type"));
                a.setStatus(rs.getString("status"));
                a.setNotes(rs.getString("notes"));
                a.setPatientName(rs.getString("patient_name"));
                a.setDoctorName(rs.getString("doctor_name"));
                return a;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean addAppointment(Appointment appointment) {
        String sql = "INSERT INTO appointments (patient_id, doctor_id, appointment_time, type, status, notes) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, appointment.getPatientId());
            stmt.setInt(2, appointment.getDoctorId());
            stmt.setTimestamp(3, appointment.getAppointmentTime());
            stmt.setString(4, appointment.getType());
            stmt.setString(5, appointment.getStatus());
            stmt.setString(6, appointment.getNotes());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateAppointment(Appointment appointment) {
        String sql = "UPDATE appointments SET patient_id=?, doctor_id=?, appointment_time=?, type=?, status=?, notes=? WHERE id=?";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, appointment.getPatientId());
            stmt.setInt(2, appointment.getDoctorId());
            stmt.setTimestamp(3, appointment.getAppointmentTime());
            stmt.setString(4, appointment.getType());
            stmt.setString(5, appointment.getStatus());
            stmt.setString(6, appointment.getNotes());
            stmt.setInt(7, appointment.getId());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteAppointment(int id) {
        String sql = "DELETE FROM appointments WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Appointment> searchAppointments(String keyword, Date date, Time start, Time end, String status,
            String type) {
        List<Appointment> appointments = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT a.*, p.full_name as patient_name, u.full_name as doctor_name " +
                "FROM appointments a " +
                "LEFT JOIN patients p ON a.patient_id = p.id " +
                "LEFT JOIN users u ON a.doctor_id = u.id " +
                "WHERE 1=1 ");

        List<Object> params = new ArrayList<>();

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append("AND (p.full_name LIKE ? OR u.full_name LIKE ? OR a.notes LIKE ?) ");
            String pattern = "%" + keyword.trim() + "%";
            params.add(pattern);
            params.add(pattern);
            params.add(pattern);
        }

        if (date != null) {
            sql.append("AND DATE(a.appointment_time) = ? ");
            params.add(date);
        }

        if (start != null) {
            sql.append("AND TIME(a.appointment_time) >= ? ");
            params.add(start);
        }

        if (end != null) {
            sql.append("AND TIME(a.appointment_time) <= ? ");
            params.add(end);
        }

        if (status != null && !status.trim().isEmpty()) {
            sql.append("AND a.status = ? ");
            params.add(status);
        }

        if (type != null && !type.trim().isEmpty()) {
            sql.append("AND a.type = ? ");
            params.add(type);
        }

        sql.append("ORDER BY a.appointment_time DESC");

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql.toString())) {

            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Appointment a = new Appointment();
                a.setId(rs.getInt("id"));
                a.setPatientId(rs.getInt("patient_id"));
                a.setDoctorId(rs.getInt("doctor_id"));
                a.setAppointmentTime(rs.getTimestamp("appointment_time"));
                a.setType(rs.getString("type"));
                a.setStatus(rs.getString("status"));
                a.setNotes(rs.getString("notes"));
                a.setPatientName(rs.getString("patient_name"));
                a.setDoctorName(rs.getString("doctor_name"));
                appointments.add(a);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return appointments;
    }
}
