<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.medictrack.model.Appointment" %>
<%@ page import="com.medictrack.model.Patient" %>
<%@ page import="com.medictrack.model.User" %>
<%
    // Session check temporarily disabled for testing
    User currentUser = (User) session.getAttribute("user");
    // Login redirect removed
    List<Appointment> appointments = (List<Appointment>) request.getAttribute("appointments");
    if (appointments == null) { response.sendRedirect("appointments"); return; }
    List<Patient> patients = (List<Patient>) request.getAttribute("patients");
    List<User> doctors = (List<User>) request.getAttribute("doctors");
    Appointment editAppointment = (Appointment) request.getAttribute("appointment");
    Boolean editMode = (Boolean) request.getAttribute("editMode");
    if (editMode == null) editMode = false;
    SimpleDateFormat timeFormat = new SimpleDateFormat("hh:mm a");
    SimpleDateFormat dateTimeFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Appointments - MedicTrack</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/lucide@latest"></script>
</head>
<body class="bg-slate-50 font-sans text-slate-800 overflow-hidden">
    <div class="flex h-screen bg-slate-50">
        <jsp:include page="components/sidebar.jsp"><jsp:param name="active" value="appointments" /></jsp:include>
        <div class="flex-1 flex flex-col h-full overflow-hidden">
            <jsp:include page="components/header.jsp" />
            <main class="flex-1 overflow-y-auto p-6 bg-slate-50">
                <div class="max-w-7xl mx-auto space-y-6">
                    <div class="flex justify-between items-center">
                        <h2 class="text-2xl font-bold text-slate-800">Appointment Management</h2>
                        <button onclick="openModal()" class="bg-teal-600 text-white px-4 py-2 rounded-lg text-sm font-medium hover:bg-teal-700 shadow-lg shadow-teal-600/20 flex items-center">
                            <i data-lucide="plus" class="w-4 h-4 mr-2"></i> New Appointment
                        </button>
                    </div>

                    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                    <% if (appointments != null && !appointments.isEmpty()) { for (Appointment apt : appointments) {
                        String statusColor = "bg-gray-100 text-gray-600";
                        String status = apt.getStatus();
                        if ("Completed".equals(status)) statusColor = "bg-green-100 text-green-700";
                        else if ("In Progress".equals(status)) statusColor = "bg-blue-100 text-blue-700";
                        else if ("Scheduled".equals(status)) statusColor = "bg-slate-100 text-slate-700";
                        else if ("Cancelled".equals(status)) statusColor = "bg-red-100 text-red-700";
                        String timeStr = apt.getAppointmentTime() != null ? timeFormat.format(apt.getAppointmentTime()) : "N/A";
                    %>
                        <div class="bg-white p-5 rounded-xl border border-slate-200 shadow-sm flex flex-col hover:border-teal-200 transition duration-200">
                            <div class="flex justify-between items-start mb-4">
                                <div class="bg-blue-50 text-blue-700 px-3 py-1 rounded-md text-sm font-bold flex items-center">
                                    <i data-lucide="clock" class="w-4 h-4 mr-1"></i> <%= timeStr %>
                                </div>
                                <span class="px-2.5 py-0.5 rounded-full text-xs font-semibold <%= statusColor %>"><%= status %></span>
                            </div>
                            <h3 class="text-lg font-bold text-slate-800"><%= apt.getPatientName() != null ? apt.getPatientName() : "Unknown Patient" %></h3>
                            <p class="text-slate-500 text-sm mb-4"><%= apt.getType() != null ? apt.getType() : "General" %></p>
                            <div class="mt-auto pt-4 border-t border-slate-100 flex items-center justify-between">
                                <div class="flex items-center text-sm text-slate-600">
                                    <i data-lucide="stethoscope" class="w-4 h-4 mr-2 text-teal-600"></i> <%= apt.getDoctorName() != null ? apt.getDoctorName() : "Unassigned" %>
                                </div>
                                <div class="flex gap-2">
                                    <a href="appointments?action=edit&id=<%= apt.getId() %>" class="text-blue-600 hover:text-blue-800"><i data-lucide="edit" class="w-4 h-4"></i></a>
                                    <a href="appointments?action=delete&id=<%= apt.getId() %>" onclick="return confirm('Delete this appointment?')" class="text-red-600 hover:text-red-800"><i data-lucide="trash-2" class="w-4 h-4"></i></a>
                                </div>
                            </div>
                        </div>
                    <% } } else { %>
                        <div class="col-span-3 bg-white p-8 rounded-xl border border-slate-200 text-center text-slate-500">
                            No appointments found. Click "New Appointment" to schedule one.
                        </div>
                    <% } %>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <!-- Add/Edit Appointment Modal -->
    <div id="appointmentModal" class="fixed inset-0 bg-black bg-opacity-50 <%= editMode ? "flex" : "hidden" %> items-center justify-center z-50">
        <div class="bg-white rounded-xl p-6 w-full max-w-lg mx-4">
            <div class="flex justify-between items-center mb-4">
                <h2 class="text-xl font-bold text-slate-800"><%= editMode ? "Edit Appointment" : "New Appointment" %></h2>
                <button onclick="closeModal()" class="text-slate-500 hover:text-slate-700"><i data-lucide="x" class="w-6 h-6"></i></button>
            </div>
            <form action="appointments" method="post">
                <input type="hidden" name="action" value="<%= editMode ? "update" : "add" %>">
                <% if (editMode && editAppointment != null) { %><input type="hidden" name="id" value="<%= editAppointment.getId() %>"><% } %>
                <div class="space-y-4">
                    <div>
                        <label class="block text-sm font-medium text-slate-700 mb-1">Patient *</label>
                        <select name="patientId" required class="w-full p-2 border rounded-lg focus:ring-2 focus:ring-teal-500">
                            <option value="">Select Patient</option>
                            <% if (patients != null) { for (Patient pt : patients) { %>
                            <option value="<%= pt.getId() %>" <%= editMode && editAppointment != null && editAppointment.getPatientId() == pt.getId() ? "selected" : "" %>><%= pt.getFullName() %></option>
                            <% } } %>
                        </select>
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-slate-700 mb-1">Doctor *</label>
                        <select name="doctorId" required class="w-full p-2 border rounded-lg focus:ring-2 focus:ring-teal-500">
                            <option value="">Select Doctor</option>
                            <% if (doctors != null) { for (User doc : doctors) { %>
                            <option value="<%= doc.getId() %>" <%= editMode && editAppointment != null && editAppointment.getDoctorId() == doc.getId() ? "selected" : "" %>><%= doc.getFullName() %></option>
                            <% } } %>
                        </select>
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-slate-700 mb-1">Date & Time *</label>
                        <input type="datetime-local" name="appointmentTime" required value="<%= editMode && editAppointment != null && editAppointment.getAppointmentTime() != null ? dateTimeFormat.format(editAppointment.getAppointmentTime()) : "" %>" class="w-full p-2 border rounded-lg focus:ring-2 focus:ring-teal-500">
                    </div>
                    <div class="grid grid-cols-2 gap-4">
                        <div>
                            <label class="block text-sm font-medium text-slate-700 mb-1">Type</label>
                            <select name="type" class="w-full p-2 border rounded-lg focus:ring-2 focus:ring-teal-500">
                                <option value="Consultation" <%= editMode && editAppointment != null && "Consultation".equals(editAppointment.getType()) ? "selected" : "" %>>Consultation</option>
                                <option value="Follow-up" <%= editMode && editAppointment != null && "Follow-up".equals(editAppointment.getType()) ? "selected" : "" %>>Follow-up</option>
                                <option value="Lab Review" <%= editMode && editAppointment != null && "Lab Review".equals(editAppointment.getType()) ? "selected" : "" %>>Lab Review</option>
                                <option value="Emergency" <%= editMode && editAppointment != null && "Emergency".equals(editAppointment.getType()) ? "selected" : "" %>>Emergency</option>
                            </select>
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-slate-700 mb-1">Status</label>
                            <select name="status" class="w-full p-2 border rounded-lg focus:ring-2 focus:ring-teal-500">
                                <option value="Scheduled" <%= editMode && editAppointment != null && "Scheduled".equals(editAppointment.getStatus()) ? "selected" : "" %>>Scheduled</option>
                                <option value="In Progress" <%= editMode && editAppointment != null && "In Progress".equals(editAppointment.getStatus()) ? "selected" : "" %>>In Progress</option>
                                <option value="Completed" <%= editMode && editAppointment != null && "Completed".equals(editAppointment.getStatus()) ? "selected" : "" %>>Completed</option>
                                <option value="Cancelled" <%= editMode && editAppointment != null && "Cancelled".equals(editAppointment.getStatus()) ? "selected" : "" %>>Cancelled</option>
                            </select>
                        </div>
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-slate-700 mb-1">Notes</label>
                        <textarea name="notes" rows="2" class="w-full p-2 border rounded-lg focus:ring-2 focus:ring-teal-500"><%= editMode && editAppointment != null && editAppointment.getNotes() != null ? editAppointment.getNotes() : "" %></textarea>
                    </div>
                </div>
                <div class="flex justify-end gap-3 mt-6">
                    <button type="button" onclick="closeModal()" class="px-4 py-2 border rounded-lg hover:bg-slate-50">Cancel</button>
                    <button type="submit" class="px-4 py-2 bg-teal-600 text-white rounded-lg hover:bg-teal-700"><%= editMode ? "Update" : "Schedule" %></button>
                </div>
            </form>
        </div>
    </div>

    <script>
        lucide.createIcons();
        function openModal() { document.getElementById('appointmentModal').classList.remove('hidden'); document.getElementById('appointmentModal').classList.add('flex'); }
        function closeModal() { window.location.href = 'appointments'; }
    </script>
</body>
</html>