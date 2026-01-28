CREATE DATABASE IF NOT EXISTS medictrack;
USE medictrack;

-- Users Table (Admin, Doctor, Staff)
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role ENUM('ADMIN', 'DOCTOR', 'NURSE', 'STAFF') NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Doctors/Staff Extensions
CREATE TABLE staff_details (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    department VARCHAR(100),
    specialty VARCHAR(100),
    shift_start TIME,
    shift_end TIME,
    status ENUM('On Duty', 'Off Duty', 'In Surgery', 'On Break') DEFAULT 'Off Duty',
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Patients Table
CREATE TABLE patients (
    id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    dob DATE, -- Calculate age from this
    gender ENUM('Male', 'Female', 'Other'),
    phone VARCHAR(20),
    address TEXT,
    medical_condition VARCHAR(255), -- e.g., Hypertension
    status ENUM('Stable', 'Critical', 'Discharged', 'Attention') DEFAULT 'Stable',
    last_visit DATE,
    assigned_doctor_id INT, -- Link to users(id) where role=DOCTOR
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (assigned_doctor_id) REFERENCES users(id) ON DELETE SET NULL
);

-- Appointments Table
CREATE TABLE appointments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    appointment_time DATETIME NOT NULL,
    type VARCHAR(50), -- Consultation, Follow-up, etc.
    status ENUM('Scheduled', 'Completed', 'In Progress', 'Cancelled') DEFAULT 'Scheduled',
    notes TEXT,
    FOREIGN KEY (patient_id) REFERENCES patients(id) ON DELETE CASCADE,
    FOREIGN KEY (doctor_id) REFERENCES users(id) ON DELETE SET NULL
);

-- Medical Records Table
CREATE TABLE medical_records (
    id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    diagnosis TEXT,
    prescription TEXT,
    treatment_notes TEXT,
    record_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES patients(id) ON DELETE CASCADE,
    FOREIGN KEY (doctor_id) REFERENCES users(id) ON DELETE SET NULL
);

-- Insert Mock Data for Testing
INSERT INTO users (email, password, role, full_name) VALUES 
('admin@medictrack.com', 'admin123', 'ADMIN', 'Dr. Admin'),
('ayesha@medictrack.com', 'admin123', 'DOCTOR', 'Dr. Ayesha Rao'),
('smith@medictrack.com', 'admin123', 'DOCTOR', 'Dr. John Smith');

INSERT INTO patients (full_name, dob, medical_condition, status, last_visit, assigned_doctor_id) VALUES 
('Sarah Jenkins', '1990-05-15', 'Hypertension', 'Stable', '2023-10-24', 2),
('Michael Chen', '1966-02-10', 'Type 2 Diabetes', 'Attention', '2023-10-22', 2),
('Robert Wilson', '1979-11-30', 'Post-Op Recovery', 'Critical', '2023-10-25', 3);
USE medictrack;

-- Create patients table
CREATE TABLE IF NOT EXISTS patients (
    id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    dob DATE,
    gender VARCHAR(10),
    phone VARCHAR(20),
    address TEXT,
    medical_condition VARCHAR(255),
    status VARCHAR(50) DEFAULT 'Active',
    last_visit TIMESTAMP,
    assigned_doctor_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create appointments table  
CREATE TABLE IF NOT EXISTS appointments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    appointment_time TIMESTAMP,
    type VARCHAR(50),
    status VARCHAR(50) DEFAULT 'Scheduled',
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create staff_details table
CREATE TABLE IF NOT EXISTS staff_details (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    department VARCHAR(100),
    specialty VARCHAR(100),
    shift_start TIME,
    shift_end TIME,
    status VARCHAR(50) DEFAULT 'Active'
);