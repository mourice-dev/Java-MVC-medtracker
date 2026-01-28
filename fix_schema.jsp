<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head><title>Fix DB Schema</title></head>
<body>
<h1>Database Schema Fixer</h1>
<%
    String url = "jdbc:mysql://localhost:3306/medictrack?useSSL=false&serverTimezone=UTC";
    String user = "root";
    String password = ""; // Assuming empty, change if needed
    
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        try (Connection conn = DriverManager.getConnection(url, user, password)) {
            out.println("<p style='color:green'>Connected to database.</p>");
            
            DatabaseMetaData meta = conn.getMetaData();
            ResultSet rs = meta.getColumns(null, null, "users", "full_name");
            if (rs.next()) {
                out.println("<p style='color:blue'>Column 'full_name' already exists. No action needed.</p>");
            } else {
                // Check if 'name' exists
                ResultSet rsName = meta.getColumns(null, null, "users", "name");
                if (rsName.next()) {
                    out.println("<p>Found 'name' column. Attempting to rename to 'full_name'...</p>");
                    try (Statement stmt = conn.createStatement()) {
                        stmt.execute("ALTER TABLE users CHANGE name full_name VARCHAR(100) NOT NULL");
                        out.println("<p style='color:green'>SUCCESS: Renamed 'name' to 'full_name'.</p>");
                    } catch (SQLException ex) {
                        out.println("<p style='color:red'>Failed to rename: " + ex.getMessage() + "</p>");
                    }
                } else {
                     out.println("<p style='color:red'>Neither 'name' nor 'full_name' column found. Table structure might be very different.</p>");
                }
            }
        } catch (SQLException e) {
            out.println("<p style='color:red'>Connection Failed: " + e.getMessage() + "</p>");
            if (e.getErrorCode() == 1049) {
                 out.println("<p>Database 'medictrack' does not exist. Please run the setup SQL script.</p>");
            }
        }
    } catch (ClassNotFoundException e) {
        out.println("<p style='color:red'>Driver not found.</p>");
    }
%>
<p><a href="register.jsp">Go to Register</a></p>
</body>
</html>