package com.medictrack.model;

public class Staff {
    private int id;
    private int userId;
    private String fullName;
    private String email;
    private String role;
    private String department;
    private String specialty;
    private String shiftStart;
    private String shiftEnd;
    private String status;

    public Staff() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }

    public String getDepartment() { return department; }
    public void setDepartment(String department) { this.department = department; }

    public String getSpecialty() { return specialty; }
    public void setSpecialty(String specialty) { this.specialty = specialty; }

    public String getShiftStart() { return shiftStart; }
    public void setShiftStart(String shiftStart) { this.shiftStart = shiftStart; }

    public String getShiftEnd() { return shiftEnd; }
    public void setShiftEnd(String shiftEnd) { this.shiftEnd = shiftEnd; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getShift() {
        if (shiftStart != null && shiftEnd != null) {
            return shiftStart + " - " + shiftEnd;
        }
        return "N/A";
    }
}
