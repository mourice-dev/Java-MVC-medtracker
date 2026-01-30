<!-- @format -->

# MedicTrack – Hospital Management System

Commit for January 28, 2026: Initial project setup.

Commit for January 29, 2026: Minor update for contribution.

Commit for January 30, 2026: Marked for contribution.

**MedicTrack** is a web-based **Hospital Management System** designed to simplify and automate daily hospital operations. The system provides a centralized platform where administrators, doctors, and hospital staff can efficiently manage patients, appointments, medical records, and hospital resources.

## Key Features

- **User Authentication & Roles**: Secure login system with access levels for Admin, Doctor, and Staff.
- **Patient Management**: Register, view, update, and delete patient records.
- **Appointment Management**: Schedule appointments and assign doctors.
- **Doctor Management**: Manage doctor profiles and availability.
- **Medical Records**: Store diagnoses, prescriptions, and treatment notes.
- **Dashboard**: Overview of hospital activities.

## Technology Stack

- **Frontend**: JSP, HTML, CSS, Tailwind CSS
- **Backend**: Java (JSP & Servlets)
- **Database**: MySQL
- **Server**: Apache Tomcat

## Getting Started

1.  Clone the repository.
2.  Set up the MySQL database (schema to be provided).
3.  Configure database credentials in `src/main/java/com/medictrack/util/DBConnection.java`.
4.  Build the project using Maven: `mvn clean install`.
5.  Deploy the generated WAR file to Apache Tomcat.
