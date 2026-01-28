package com.medictrack.model;

import java.sql.Timestamp;

public class Appointment {
    private int id;
    private int patientId;
    private int doctorId;
    private Timestamp appointmentTime;
    private String type;
    private String status;
    private String notes;
    private String patientName;
    private String doctorName;

    public Appointment() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getPatientId() { return patientId; }
    public void setPatientId(int patientId) { this.patientId = patientId; }

    public int getDoctorId() { return doctorId; }
    public void setDoctorId(int doctorId) { this.doctorId = doctorId; }

    public Timestamp getAppointmentTime() { return appointmentTime; }
    public void setAppointmentTime(Timestamp appointmentTime) { this.appointmentTime = appointmentTime; }

    public String getType() { return type; }
    public void setType(String type) { this.type = type; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getNotes() { return notes; }
    public void setNotes(String notes) { this.notes = notes; }

    public String getPatientName() { return patientName; }
    public void setPatientName(String patientName) { this.patientName = patientName; }

    public String getDoctorName() { return doctorName; }
    public void setDoctorName(String doctorName) { this.doctorName = doctorName; }
}
