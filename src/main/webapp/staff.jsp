<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.medictrack.model.Staff" %>
<%@ page import="com.medictrack.model.User" %>
<%
    // Session/user checks removed for unrestricted access
    List<Staff> staffList = (List<Staff>) request.getAttribute("staffList");
    if (staffList == null) { response.sendRedirect("staff"); return; }
    Staff editStaff = (Staff) request.getAttribute("staffMember");
    Boolean editMode = (Boolean) request.getAttribute("editMode");
    if (editMode == null) editMode = false;
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Staff - MedicTrack</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/lucide@latest"></script>
</head>
<body class="bg-slate-50 font-sans text-slate-800 overflow-hidden">
    <div class="flex h-screen bg-slate-50">
        <jsp:include page="components/sidebar.jsp"><jsp:param name="active" value="staff" /></jsp:include>
        <div class="flex-1 flex flex-col h-full overflow-hidden">
            <jsp:include page="components/header.jsp" />
            <main class="flex-1 overflow-y-auto p-6 bg-slate-50">
                <div class="max-w-7xl mx-auto space-y-6">
                    <div class="bg-white rounded-xl shadow-sm border border-slate-100">
                        <div class="p-6 border-b border-slate-100 flex justify-between items-center">
                            <h2 class="text-lg font-bold text-slate-800">Medical Staff Directory</h2>
                        </div>
                        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6 p-6">
                        <% if (staffList != null && !staffList.isEmpty()) { for (Staff staff : staffList) {
                            String statusColor = "bg-gray-100 text-gray-600";
                            String status = staff.getStatus();
                            if ("Active".equals(status) || "On Duty".equals(status)) statusColor = "bg-green-100 text-green-700";
                            else if ("In Surgery".equals(status)) statusColor = "bg-purple-100 text-purple-700";
                            else if ("On Break".equals(status)) statusColor = "bg-orange-100 text-orange-700";
                            else if ("Off Duty".equals(status) || "Inactive".equals(status)) statusColor = "bg-gray-100 text-gray-700";
                            String initial = staff.getFullName() != null && staff.getFullName().length() > 0 ? staff.getFullName().substring(0, 1).toUpperCase() : "?";
                        %>
                            <div class="border border-slate-200 rounded-xl p-4 flex items-start space-x-4 hover:shadow-md transition bg-gradient-to-br from-white to-slate-50/50">
                                <div class="h-12 w-12 rounded-full bg-indigo-100 flex items-center justify-center text-indigo-700 font-bold text-lg"><%= initial %></div>
                                <div class="flex-1">
                                    <h4 class="font-bold text-slate-800"><%= staff.getFullName() %></h4>
                                    <p class="text-xs text-slate-500 uppercase tracking-wide mb-1"><%= staff.getRole() != null ? staff.getRole() : "Staff" %></p>
                                    <p class="text-sm text-slate-600 mb-2"><%= staff.getDepartment() != null ? staff.getDepartment() : "General" %></p>
                                    <div class="flex items-center justify-between mt-3">
                                        <span class="text-xs text-slate-400 bg-slate-100 px-2 py-1 rounded"><%= staff.getShift() %></span>
                                        <div class="flex items-center gap-2">
                                            <span class="px-2.5 py-0.5 rounded-full text-xs font-semibold <%= statusColor %>"><%= status != null ? status : "Active" %></span>
                                            <a href="staff?action=edit&userId=<%= staff.getUserId() %>" class="text-blue-600 hover:text-blue-800"><i data-lucide="edit" class="w-4 h-4"></i></a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        <% } } else { %>
                            <div class="col-span-3 p-8 text-center text-slate-500">No staff members found.</div>
                        <% } %>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <!-- Edit Staff Modal -->
    <div id="staffModal" class="fixed inset-0 bg-black bg-opacity-50 <%= editMode ? "flex" : "hidden" %> items-center justify-center z-50">
        <div class="bg-white rounded-xl p-6 w-full max-w-lg mx-4">
            <div class="flex justify-between items-center mb-4">
                <h2 class="text-xl font-bold text-slate-800">Edit Staff Details</h2>
                <button onclick="closeModal()" class="text-slate-500 hover:text-slate-700"><i data-lucide="x" class="w-6 h-6"></i></button>
            </div>
            <% if (editMode && editStaff != null) { %>
            <form action="staff" method="post">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="userId" value="<%= editStaff.getUserId() %>">
                <div class="space-y-4">
                    <div>
                        <label class="block text-sm font-medium text-slate-700 mb-1">Name</label>
                        <input type="text" value="<%= editStaff.getFullName() %>" disabled class="w-full p-2 border rounded-lg bg-slate-50 text-slate-600">
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-slate-700 mb-1">Role</label>
                        <input type="text" value="<%= editStaff.getRole() %>" disabled class="w-full p-2 border rounded-lg bg-slate-50 text-slate-600">
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-slate-700 mb-1">Department</label>
                        <input type="text" name="department" value="<%= editStaff.getDepartment() != null ? editStaff.getDepartment() : "" %>" class="w-full p-2 border rounded-lg focus:ring-2 focus:ring-teal-500">
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-slate-700 mb-1">Specialty</label>
                        <input type="text" name="specialty" value="<%= editStaff.getSpecialty() != null ? editStaff.getSpecialty() : "" %>" class="w-full p-2 border rounded-lg focus:ring-2 focus:ring-teal-500">
                    </div>
                    <div class="grid grid-cols-2 gap-4">
                        <div>
                            <label class="block text-sm font-medium text-slate-700 mb-1">Shift Start</label>
                            <input type="time" name="shiftStart" value="<%= editStaff.getShiftStart() != null ? editStaff.getShiftStart().toString().substring(0, 5) : "" %>" class="w-full p-2 border rounded-lg focus:ring-2 focus:ring-teal-500">
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-slate-700 mb-1">Shift End</label>
                            <input type="time" name="shiftEnd" value="<%= editStaff.getShiftEnd() != null ? editStaff.getShiftEnd().toString().substring(0, 5) : "" %>" class="w-full p-2 border rounded-lg focus:ring-2 focus:ring-teal-500">
                        </div>
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-slate-700 mb-1">Status</label>
                        <select name="status" class="w-full p-2 border rounded-lg focus:ring-2 focus:ring-teal-500">
                            <option value="Active" <%= "Active".equals(editStaff.getStatus()) ? "selected" : "" %>>Active</option>
                            <option value="On Duty" <%= "On Duty".equals(editStaff.getStatus()) ? "selected" : "" %>>On Duty</option>
                            <option value="On Break" <%= "On Break".equals(editStaff.getStatus()) ? "selected" : "" %>>On Break</option>
                            <option value="In Surgery" <%= "In Surgery".equals(editStaff.getStatus()) ? "selected" : "" %>>In Surgery</option>
                            <option value="Off Duty" <%= "Off Duty".equals(editStaff.getStatus()) ? "selected" : "" %>>Off Duty</option>
                            <option value="Inactive" <%= "Inactive".equals(editStaff.getStatus()) ? "selected" : "" %>>Inactive</option>
                        </select>
                    </div>
                </div>
                <div class="flex justify-end gap-3 mt-6">
                    <button type="button" onclick="closeModal()" class="px-4 py-2 border rounded-lg hover:bg-slate-50">Cancel</button>
                    <button type="submit" class="px-4 py-2 bg-teal-600 text-white rounded-lg hover:bg-teal-700">Update</button>
                </div>
            </form>
            <% } %>
        </div>
    </div>

    <script>
        lucide.createIcons();
        function closeModal() { window.location.href = 'staff'; }
    </script>
</body>
</html>