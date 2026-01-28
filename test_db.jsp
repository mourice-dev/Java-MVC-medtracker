<%@ page import="java.sql.*" %>
<%@ page import="com.medictrack.util.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head><title>DB Test</title></head>
<body>
<h1>Database Connection Test</h1>
<%
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        out.println("<p>Driver loaded successfully.</p>");
        
        // Try to connect using the utility class settings (redefining here to test parameters directly)
        String url = "jdbc:mysql://localhost:3306/medictrack?useSSL=false&serverTimezone=UTC";
        String user = "root";
        String password = ""; // Intentionally empty as per code
        
        try (Connection conn = DriverManager.getConnection(url, user, password)) {
            out.println("<p style='color:green'>Connection Successful!</p>");
            
            // Check schema
            DatabaseMetaData meta = conn.getMetaData();
            ResultSet rs = meta.getColumns(null, null, "users", null);
            out.println("<h3>Users Table Columns:</h3><ul>");
            boolean hasFullName = false;
            while (rs.next()) {
                String colName = rs.getString("COLUMN_NAME");
                out.println("<li>" + colName + "</li>");
                if ("full_name".equalsIgnoreCase(colName)) hasFullName = true;
            }
            out.println("</ul>");
            
            if (!hasFullName) {
                out.println("<p style='color:red'>WARNING: 'full_name' column missing! Found 'name' instead?</p>");
            } else {
                out.println("<p style='color:green'>Schema check passed: 'full_name' exists.</p>");
            }
            
        } catch (SQLException e) {
            out.println("<p style='color:red'>Connection Failed: " + e.getMessage() + "</p>");
            out.println("<p>Check if your MySQL password is empty. If not, update DBConnection.java.</p>");
        }
    } catch (ClassNotFoundException e) {
        out.println("<p style='color:red'>Driver not found: " + e.getMessage() + "</p>");
    }
%>
<p><a href="register.jsp">Back to Register</a></p>
</body>
</html>