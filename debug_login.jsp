<%@ page import="java.sql.*" %>
<%@ page import="com.medictrack.util.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Debug Login</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-slate-100 p-8">
<div class="max-w-2xl mx-auto bg-white rounded-xl shadow p-6 space-y-6">
    <h1 class="text-2xl font-bold">🔍 Login Debug Tool</h1>
    
    <div class="border rounded p-4">
        <h2 class="font-bold mb-2">Step 1: Database Connection</h2>
        <%
        Connection conn = null;
        boolean connected = false;
        try {
            conn = DBConnection.getConnection();
            connected = true;
            out.println("<div class='text-green-600'>✅ Connected to MySQL successfully!</div>");
            out.println("<div class='text-sm text-slate-500'>Database URL: jdbc:mysql://localhost:3306/medictrack</div>");
        } catch (Exception e) {
            out.println("<div class='text-red-600'>❌ Connection FAILED: " + e.getMessage() + "</div>");
            out.println("<div class='text-sm text-slate-500 mt-2'>Check if MySQL is running and password is correct in DBConnection.java</div>");
        }
        %>
    </div>
    
    <% if (connected) { %>
    <div class="border rounded p-4">
        <h2 class="font-bold mb-2">Step 2: Check Table Structure</h2>
        <%
        try {
            DatabaseMetaData meta = conn.getMetaData();
            ResultSet tables = meta.getTables(null, null, "users", null);
            if (tables.next()) {
                out.println("<div class='text-green-600'>✅ Table 'users' exists</div>");
                
                ResultSet cols = meta.getColumns(null, null, "users", null);
                out.println("<div class='mt-2'><strong>Columns:</strong></div><ul class='list-disc pl-5 text-sm'>");
                boolean hasFullName = false;
                boolean hasName = false;
                while(cols.next()) {
                    String colName = cols.getString("COLUMN_NAME");
                    out.println("<li>" + colName + "</li>");
                    if ("full_name".equals(colName)) hasFullName = true;
                    if ("name".equals(colName)) hasName = true;
                }
                out.println("</ul>");
                
                if (hasFullName) {
                    out.println("<div class='text-green-600 mt-2'>✅ Column 'full_name' found (correct!)</div>");
                } else if (hasName) {
                    out.println("<div class='text-red-600 mt-2'>❌ Column is 'name' but code expects 'full_name'!</div>");
                    out.println("<div class='text-sm'>Use setup_db.jsp to fix this</div>");
                } else {
                    out.println("<div class='text-red-600 mt-2'>❌ Neither 'name' nor 'full_name' column found!</div>");
                }
            } else {
                out.println("<div class='text-red-600'>❌ Table 'users' does NOT exist!</div>");
                out.println("<div class='text-sm'>Use setup_db.jsp to create the tables</div>");
            }
        } catch (Exception e) {
            out.println("<div class='text-red-600'>Error: " + e.getMessage() + "</div>");
        }
        %>
    </div>
    
    <div class="border rounded p-4">
        <h2 class="font-bold mb-2">Step 3: Check Users in Database</h2>
        <%
        try {
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM users");
            
            out.println("<table class='w-full text-sm border-collapse'>");
            out.println("<tr class='bg-slate-100'><th class='border p-2'>ID</th><th class='border p-2'>Name</th><th class='border p-2'>Email</th><th class='border p-2'>Password</th><th class='border p-2'>Role</th></tr>");
            
            int count = 0;
            while(rs.next()) {
                count++;
                String nameCol = "";
                try { nameCol = rs.getString("full_name"); } 
                catch (Exception e) { 
                    try { nameCol = rs.getString("name"); } catch (Exception e2) { nameCol = "N/A"; }
                }
                out.println("<tr>");
                out.println("<td class='border p-2'>" + rs.getInt("id") + "</td>");
                out.println("<td class='border p-2'>" + nameCol + "</td>");
                out.println("<td class='border p-2'><strong>" + rs.getString("email") + "</strong></td>");
                out.println("<td class='border p-2 font-mono text-xs'>" + rs.getString("password") + "</td>");
                out.println("<td class='border p-2'>" + rs.getString("role") + "</td>");
                out.println("</tr>");
            }
            out.println("</table>");
            
            if (count == 0) {
                out.println("<div class='text-amber-600 mt-2'>⚠️ No users found in database!</div>");
                out.println("<div class='text-sm'>Use setup_db.jsp to insert test data</div>");
            } else {
                out.println("<div class='text-green-600 mt-2'>Found " + count + " user(s)</div>");
            }
            
        } catch (Exception e) {
            out.println("<div class='text-red-600'>Error querying users: " + e.getMessage() + "</div>");
        }
        %>
    </div>
    
    <div class="border rounded p-4 bg-slate-50">
        <h2 class="font-bold mb-2">Step 4: Test Login Query</h2>
        <form method="post" class="space-y-3">
            <div>
                <label class="block text-sm">Email:</label>
                <input type="text" name="testEmail" value="admin@medictrack.com" class="border rounded px-3 py-2 w-full"/>
            </div>
            <div>
                <label class="block text-sm">Password:</label>
                <input type="text" name="testPassword" value="admin123" class="border rounded px-3 py-2 w-full"/>
            </div>
            <button type="submit" class="bg-teal-600 text-white px-4 py-2 rounded">Test Login Query</button>
        </form>
        
        <%
        String testEmail = request.getParameter("testEmail");
        String testPassword = request.getParameter("testPassword");
        if (testEmail != null && testPassword != null) {
            out.println("<div class='mt-4 p-3 bg-white rounded border'>");
            out.println("<div class='font-mono text-xs mb-2'>Query: SELECT * FROM users WHERE email = '" + testEmail + "' AND password = '" + testPassword + "'</div>");
            
            try {
                PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM users WHERE email = ? AND password = ?");
                pstmt.setString(1, testEmail);
                pstmt.setString(2, testPassword);
                ResultSet rs = pstmt.executeQuery();
                
                if (rs.next()) {
                    out.println("<div class='text-green-600 font-bold'>✅ LOGIN WOULD SUCCEED!</div>");
                    out.println("<div class='text-sm'>User ID: " + rs.getInt("id") + "</div>");
                } else {
                    out.println("<div class='text-red-600 font-bold'>❌ LOGIN WOULD FAIL - No matching row</div>");
                    out.println("<div class='text-sm mt-2'>This means:</div>");
                    out.println("<ul class='list-disc pl-5 text-sm'>");
                    out.println("<li>Email doesn't exist in database, OR</li>");
                    out.println("<li>Password doesn't match what's stored</li>");
                    out.println("</ul>");
                }
            } catch (Exception e) {
                out.println("<div class='text-red-600'>Query error: " + e.getMessage() + "</div>");
            }
            out.println("</div>");
        }
        %>
    </div>
    <% 
    if (conn != null) try { conn.close(); } catch (Exception e) {}
    } %>
    
    <div class="flex gap-4 text-sm">
        <a href="setup_db.jsp" class="text-teal-600 hover:underline">→ Setup Database</a>
        <!-- Login link removed -->
    </div>
</div>
</body>
</html>