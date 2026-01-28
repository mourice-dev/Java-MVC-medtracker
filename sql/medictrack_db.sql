CREATE DATABASE IF NOT EXISTS medictrack;
USE medictrack;

-- Users table
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(50) DEFAULT 'STAFF',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Staff details table (for additional staff info)
CREATE TABLE IF NOT EXISTS staff_details (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    department VARCHAR(100),
    specialty VARCHAR(100),
    shift_start TIME,
    shift_end TIME,
    status VARCHAR(50) DEFAULT 'Active',
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Patients table
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
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (assigned_doctor_id) REFERENCES users(id) ON DELETE SET NULL
);

-- Appointments table
CREATE TABLE IF NOT EXISTS appointments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_time TIMESTAMP NOT NULL,
    type VARCHAR(50),
    status VARCHAR(50) DEFAULT 'Scheduled',
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES patients(id) ON DELETE CASCADE,
    FOREIGN KEY (doctor_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Insert default users
INSERT INTO users (full_name, email, password, role) VALUES 
('Admin User', 'admin@medictrack.com', 'admin123', 'ADMIN'),
('Dr. John Smith', 'smith@medictrack.com', 'doctor123', 'DOCTOR'),
('Dr. Ayesha Rao', 'rao@medictrack.com', 'doctor123', 'DOCTOR'),
('Nurse Clara Wu', 'clara@medictrack.com', 'nurse123', 'NURSE')
ON DUPLICATE KEY UPDATE full_name=full_name;

-- Insert staff details for the doctors and nurses
INSERT INTO staff_details (user_id, department, specialty, shift_start, shift_end, status) 
SELECT id, 'General Medicine', 'General Practitioner', '09:00:00', '17:00:00', 'Active' FROM users WHERE email = 'smith@medictrack.com'
ON DUPLICATE KEY UPDATE department=department;

INSERT INTO staff_details (user_id, department, specialty, shift_start, shift_end, status) 
SELECT id, 'Cardiology', 'Cardiologist', '08:00:00', '16:00:00', 'Active' FROM users WHERE email = 'rao@medictrack.com'
ON DUPLICATE KEY UPDATE department=department;

INSERT INTO staff_details (user_id, department, specialty, shift_start, shift_end, status) 
SELECT id, 'ER', 'Emergency Nurse', '07:00:00', '19:00:00', 'Active' FROM users WHERE email = 'clara@medictrack.com'
ON DUPLICATE KEY UPDATE department=department;

-- Insert sample patients
INSERT INTO patients (full_name, dob, gender, phone, address, medical_condition, status, assigned_doctor_id)
SELECT 'Sarah Jenkins', '1990-05-15', 'Female', '555-0101', '123 Main St', 'Hypertension', 'Active', id FROM users WHERE email = 'smith@medictrack.com'
ON DUPLICATE KEY UPDATE full_name=full_name;

INSERT INTO patients (full_name, dob, gender, phone, address, medical_condition, status, assigned_doctor_id)
SELECT 'Michael Chen', '1965-08-22', 'Male', '555-0102', '456 Oak Ave', 'Type 2 Diabetes', 'Active', id FROM users WHERE email = 'rao@medictrack.com'
ON DUPLICATE KEY UPDATE full_name=full_name;
