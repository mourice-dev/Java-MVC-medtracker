<%@ page import="java.sql.*" %>
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <title>MedicTrack Database Setup</title>
            <script src="https://cdn.tailwindcss.com"></script>
        </head>

        <body class="bg-slate-50 p-10">
            <div class="max-w-3xl mx-auto bg-white rounded-xl shadow-md overflow-hidden p-8">
                <h1 class="text-2xl font-bold text-slate-800 mb-6">🔧 Database Setup Tool</h1>

                <% String dbUrl="jdbc:mysql://localhost:3306/?useSSL=false&serverTimezone=UTC" ; String dbUser="root" ;
                    String dbPassword="" ; // Change if your MySQL has a password String
                    action=request.getParameter("action"); if ("setup".equals(action)) { try {
                    Class.forName("com.mysql.cj.jdbc.Driver"); Connection conn=DriverManager.getConnection(dbUrl,
                    dbUser, dbPassword); Statement stmt=conn.createStatement(); out.println("<div
                    class='space-y-2 text-sm font-mono bg-slate-900 text-green-400 p-4 rounded-lg overflow-x-auto'>");

                    // 1. Create Database
                    stmt.execute("CREATE DATABASE IF NOT EXISTS medictrack");
                    out.println("<div>✓ Database 'medictrack' created/verified</div>");

                    stmt.execute("USE medictrack");
                    out.println("<div>✓ Using database 'medictrack'</div>");

                    // 2. Drop existing tables (for clean setup)
                    stmt.execute("SET FOREIGN_KEY_CHECKS = 0");
                    stmt.execute("DROP TABLE IF EXISTS medical_records");
                    stmt.execute("DROP TABLE IF EXISTS appointments");
                    stmt.execute("DROP TABLE IF EXISTS patients");
                    stmt.execute("DROP TABLE IF EXISTS staff_details");
                    stmt.execute("DROP TABLE IF EXISTS users");
                    stmt.execute("SET FOREIGN_KEY_CHECKS = 1");
                    out.println("<div>✓ Cleaned old tables</div>");

                    // 3. Create users table
                    stmt.execute("CREATE TABLE users (" +
                    "id INT AUTO_INCREMENT PRIMARY KEY," +
                    "full_name VARCHAR(100) NOT NULL," +
                    "email VARCHAR(100) NOT NULL UNIQUE," +
                    "password VARCHAR(255) NOT NULL," +
                    "role VARCHAR(50) NOT NULL," +
                    "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP" +
                    ")");
                    out.println("<div>✓ Created 'users' table with 'full_name' column</div>");

                    // 4. Create other tables
                    stmt.execute("CREATE TABLE staff_details (" +
                    "id INT AUTO_INCREMENT PRIMARY KEY," +
                    "user_id INT," +
                    "department VARCHAR(100)," +
                    "specialty VARCHAR(100)," +
                    "shift_start TIME," +
                    "shift_end TIME," +
                    "status VARCHAR(50) DEFAULT 'Off Duty'," +
                    "FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE" +
                    ")");
                    out.println("<div>✓ Created 'staff_details' table</div>");

                    stmt.execute("CREATE TABLE patients (" +
                    "id INT AUTO_INCREMENT PRIMARY KEY," +
                    "full_name VARCHAR(100) NOT NULL," +
                    "dob DATE," +
                    "gender VARCHAR(10)," +
                    "phone VARCHAR(20)," +
                    "address TEXT," +
                    "medical_condition VARCHAR(255)," +
                    "status VARCHAR(50) DEFAULT 'Stable'," +
                    "last_visit DATE," +
                    "assigned_doctor_id INT," +
                    "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP," +
                    "FOREIGN KEY (assigned_doctor_id) REFERENCES users(id) ON DELETE SET NULL" +
                    ")");
                    out.println("<div>✓ Created 'patients' table</div>");

                    stmt.execute("CREATE TABLE appointments (" +
                    "id INT AUTO_INCREMENT PRIMARY KEY," +
                    "patient_id INT," +
                    "doctor_id INT," +
                    "appointment_time DATETIME NOT NULL," +
                    "type VARCHAR(50)," +
                    "status VARCHAR(50) DEFAULT 'Scheduled'," +
                    "notes TEXT," +
                    "FOREIGN KEY (patient_id) REFERENCES patients(id) ON DELETE CASCADE," +
                    "FOREIGN KEY (doctor_id) REFERENCES users(id) ON DELETE SET NULL" +
                    ")");
                    out.println("<div>✓ Created 'appointments' table</div>");

                    // 5. Insert test users
                    stmt.execute("INSERT INTO users (full_name, email, password, role) VALUES " +
                    "('Dr. Admin', 'admin@medictrack.com', 'admin123', 'ADMIN')," +
                    "('Dr. Ayesha Rao', 'ayesha@medictrack.com', 'admin123', 'DOCTOR')," +
                    "('Dr. John Smith', 'smith@medictrack.com', 'admin123', 'DOCTOR')");
                    out.println("<div>✓ Inserted test users</div>");

                    // 6. Insert test patients
                    stmt.execute("INSERT INTO patients (full_name, dob, medical_condition, status, last_visit,
                    assigned_doctor_id) VALUES " +
                    "('Sarah Jenkins', '1990-05-15', 'Hypertension', 'Stable', '2023-10-24', 2)," +
                    "('Michael Chen', '1966-02-10', 'Type 2 Diabetes', 'Attention', '2023-10-22', 2)," +
                    "('Robert Wilson', '1979-11-30', 'Post-Op Recovery', 'Critical', '2023-10-25', 3)");
                    out.println("<div>✓ Inserted test patients</div>");

                    out.println("
            </div>");

            out.println("<div class='mt-6 p-4 bg-green-50 border border-green-200 rounded-lg'>");
                out.println("<h3 class='font-bold text-green-800 mb-2'>✅ Setup Complete!</h3>");
                out.println("<p class='text-green-700'>You can now login with:</p>");
                out.println("<ul class='list-disc pl-5 text-green-700'>");
                    out.println("<li><strong>Email:</strong> admin@medictrack.com</li>");
                    out.println("<li><strong>Password:</strong> admin123</li>");
                    out.println("</ul>");
                out.println("</div>");

            conn.close();

            } catch (Exception e) {
            out.println("<div class='p-4 bg-red-50 border border-red-200 rounded-lg text-red-700'>");
                out.println("<strong>Error:</strong> " + e.getMessage());
                out.println("<p class='mt-2 text-sm'>Make sure MySQL is running and the password in this file is
                    correct.</p>");
                out.println("</div>");
            e.printStackTrace();
            }
            } else {
            %>

            <div class="space-y-4">
                <div class="p-4 bg-amber-50 border border-amber-200 rounded-lg">
                    <h3 class="font-bold text-amber-800">⚠️ Warning</h3>
                    <p class="text-amber-700 text-sm">This will <strong>DROP and recreate</strong> all database tables.
                        Any existing data will be lost.</p>
                </div>

                <div class="p-4 bg-blue-50 border border-blue-200 rounded-lg">
                    <h3 class="font-bold text-blue-800 mb-2">This will:</h3>
                    <ul class="list-disc pl-5 text-blue-700 text-sm space-y-1">
                        <li>Create database 'medictrack' if it doesn't exist</li>
                        <li>Create 'users' table with correct 'full_name' column</li>
                        <li>Create 'patients', 'appointments', 'staff_details' tables</li>
                        <li>Insert test users (admin@medictrack.com / admin123)</li>
                    </ul>
                </div>

                <form method="post">
                    <input type="hidden" name="action" value="setup" />
                    <button type="submit"
                        class="w-full bg-teal-600 text-white py-3 rounded-lg font-bold hover:bg-teal-700 transition">
                        🚀 Setup Database Now
                    </button>
                </form>
            </div>

            <% } %>

                <div class="mt-8 pt-6 border-t flex justify-between text-sm">
                    <a href="login.jsp" class="text-teal-600 hover:underline">← Go to Login</a>
                    <a href="register.jsp" class="text-teal-600 hover:underline">→ Go to Register</a>
                </div>
                </div>
        </body>

        </html>