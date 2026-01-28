<%@ page import="java.sql.*" %>
<%@ page import="com.medictrack.util.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>MedicTrack System Diagnosis</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/lucide@latest"></script>
</head>
<body class="bg-slate-50 p-10">
    <div class="max-w-3xl mx-auto bg-white rounded-xl shadow-md overflow-hidden p-8">
        <h1 class="text-2xl font-bold text-slate-800 mb-6 flex items-center">
            <i data-lucide="stethoscope" class="mr-3 text-teal-600"></i> 
            System Diagnosis
        </h1>

        <div class="space-y-6">
            <!-- 1. Database Connection -->
            <div class="border rounded-lg p-4">
                <h2 class="font-bold text-lg mb-2">1. Database Connection</h2>
                <%
                boolean dbConnected = false;
                Connection conn = null;
                try {
                    conn = DBConnection.getConnection();
                    dbConnected = true;
                %>
                    <div class="flex items-center text-green-600 bg-green-50 p-3 rounded">
                        <i data-lucide="check-circle" class="mr-2"></i> Connection Successful
                    </div>
                <% } catch (Exception e) { %>
                    <div class="flex items-center text-red-600 bg-red-50 p-3 rounded">
                        <i data-lucide="x-circle" class="mr-2"></i> Connection Failed: <%= e.getMessage() %>
                    </div>
                    <p class="text-sm text-slate-500 mt-2 ml-8">Tip: Check <code>src/main/java/com/medictrack/util/DBConnection.java</code> for correct username/password.</p>
                <% } %>
            </div>

            <!-- 2. Schema Validation -->
            <% if (dbConnected) { %>
            <div class="border rounded-lg p-4">
                <h2 class="font-bold text-lg mb-2">2. Schema Check (Users Table)</h2>
                <%
                    boolean tableExists = false;
                    boolean hasFullName = false;
                    boolean hasName = false;
                    
                    try {
                        DatabaseMetaData meta = conn.getMetaData();
                        // Check Table
                        ResultSet rsTable = meta.getTables(null, null, "users", null);
                        if (rsTable.next()) tableExists = true;
                        
                        if (tableExists) {
                            out.println("<div class='flex items-center text-green-600 mb-2'><i data-lucide='check' class='mr-2 w-4'></i> Table 'users' found.</div>");
                            
                            // Check Columns
                            ResultSet rsCols = meta.getColumns(null, null, "users", null);
                            out.println("<ul class='list-disc pl-10 text-sm text-slate-600 mb-4'>");
                            while(rsCols.next()) {
                                String colName = rsCols.getString("COLUMN_NAME");
                                out.println("<li>" + colName + "</li>");
                                if ("full_name".equalsIgnoreCase(colName)) hasFullName = true;
                                if ("name".equalsIgnoreCase(colName)) hasName = true;
                            }
                            out.println("</ul>");
                            
                            if (hasFullName) {
                                out.println("<div class='flex items-center text-green-600 bg-green-50 p-3 rounded'><i data-lucide='check-circle' class='mr-2'></i> Column 'full_name' exists. (Correct)</div>");
                            } else if (hasName) {
                                out.println("<div class='flex items-center text-amber-600 bg-amber-50 p-3 rounded'><i data-lucide='alert-triangle' class='mr-2'></i> Found 'name' but code needs 'full_name'.</div>");
                                out.println("<form action='fix_schema.jsp' method='post' class='mt-3 ml-8'><button class='bg-teal-600 text-white px-4 py-2 rounded text-sm hover:bg-teal-700'>Fix Automatically</button></form>");
                            } else {
                                out.println("<div class='flex items-center text-red-600 bg-red-50 p-3 rounded'><i data-lucide='x-circle' class='mr-2'></i> Missing 'full_name' column!</div>");
                            }
                            
                        } else {
                            out.println("<div class='flex items-center text-red-600 bg-red-50 p-3 rounded'><i data-lucide='x-circle' class='mr-2'></i> Table 'users' NOT found!</div>");
                            out.println("<p class='text-sm text-slate-500 mt-2 ml-8'>Tip: Execute the SQL script in your database.</p>");
                        }
                        
                    } catch (Exception e) {
                        out.println("<div class='text-red-500'>Error checking schema: " + e.getMessage() + "</div>");
                    }
                %>
            </div>
            
            <!-- 3. Test Select -->
             <div class="border rounded-lg p-4">
                <h2 class="font-bold text-lg mb-2">3. Login Query Test</h2>
                <%
                if (hasFullName) {
                    try {
                        Statement stmt = conn.createStatement();
                        ResultSet rs = stmt.executeQuery("SELECT full_name, email, role FROM users LIMIT 1");
                        if (rs.next()) {
                             out.println("<div class='flex items-center text-green-600 bg-green-50 p-3 rounded'><i data-lucide='check-circle' class='mr-2'></i> Successfully read user: " + rs.getString("email") + "</div>");
                        } else {
                             out.println("<div class='flex items-center text-amber-600 bg-amber-50 p-3 rounded'><i data-lucide='info' class='mr-2'></i> No users found in table. Register a new user.</div>");
                        }
                    } catch (Exception e) {
                        out.println("<div class='flex items-center text-red-600 bg-red-50 p-3 rounded'><i data-lucide='x-circle' class='mr-2'></i> Query failed: " + e.getMessage() + "</div>");
                    }
                } else {
                    out.println("<div class='text-slate-400 italic'>Skipped (requires full_name)</div>");
                }
                %>
            </div>
             <% 
                // Close connection
                if (conn != null) try { conn.close(); } catch (SQLException e) {}
             } 
             %>
        </div>

        <div class="mt-8 flex justify-between border-t pt-6">
            <!-- Login link removed -->
            <a href="register.jsp" class="text-teal-600 hover:text-teal-800 font-medium">Go to Register</a>
        </div>
    </div>
    <script>lucide.createIcons();</script>
</body>
</html>