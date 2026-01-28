package com.medictrack.model;

import java.sql.Date;

public class Patient {
    private int id;
    private String fullName;
    private Date dob;
    private String gender;
    private String phone;
    private String address;
    private String medicalCondition;
    private String status;
    private Date lastVisit;
    private int assignedDoctorId;
    private String doctorName;

    public Patient() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public Date getDob() { return dob; }
    public void setDob(Date dob) { this.dob = dob; }

    public String getGender() { return gender; }
    public void setGender(String gender) { this.gender = gender; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getMedicalCondition() { return medicalCondition; }
    public void setMedicalCondition(String medicalCondition) { this.medicalCondition = medicalCondition; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public Date getLastVisit() { return lastVisit; }
    public void setLastVisit(Date lastVisit) { this.lastVisit = lastVisit; }

    public int getAssignedDoctorId() { return assignedDoctorId; }
    public void setAssignedDoctorId(int assignedDoctorId) { this.assignedDoctorId = assignedDoctorId; }

    public String getDoctorName() { return doctorName; }
    public void setDoctorName(String doctorName) { this.doctorName = doctorName; }

    public int getAge() {
        if (dob == null) return 0;
        long ageInMillis = System.currentTimeMillis() - dob.getTime();
        return (int) (ageInMillis / (1000L * 60 * 60 * 24 * 365));
    }
}
