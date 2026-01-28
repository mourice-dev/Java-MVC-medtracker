<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.medictrack.model.Patient" %>
<%@ page import="com.medictrack.model.User" %>
<%
    // Session/user checks removed for unrestricted access
    List<Patient> patients = (List<Patient>) request.getAttribute("patients");
    if (patients == null) { response.sendRedirect("patients"); return; }
    List<User> doctors = (List<User>) request.getAttribute("doctors");
    Patient editPatient = (Patient) request.getAttribute("patient");
    Boolean editMode = (Boolean) request.getAttribute("editMode");
    if (editMode == null) editMode = false;
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Patients - MedicTrack</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/lucide@latest"></script>
</head>
<body class="bg-slate-50 font-sans text-slate-800 overflow-hidden">
    <div class="flex h-screen bg-slate-50">
        <jsp:include page="components/sidebar.jsp"><jsp:param name="active" value="patients" /></jsp:include>
        <div class="flex-1 flex flex-col h-full overflow-hidden">
            <jsp:include page="components/header.jsp" />
            <main class="flex-1 overflow-y-auto p-6 bg-slate-50">
                <div class="max-w-7xl mx-auto space-y-6">
                    <div class="bg-white rounded-xl shadow-sm border border-slate-100 flex flex-col">
                        <div class="p-6 border-b border-slate-100 flex justify-between items-center">
                            <h2 class="text-lg font-bold text-slate-800">Patient Records</h2>
                            <button onclick="openModal()" class="bg-teal-600 hover:bg-teal-700 text-white px-4 py-2 rounded-lg text-sm font-medium flex items-center transition shadow-lg shadow-teal-600/20">
                                <i data-lucide="user-plus" class="w-4 h-4 mr-2"></i> Add Patient
                            </button>
                        </div>
                        <div class="overflow-x-auto">
                            <table class="w-full text-left">
                                <thead class="bg-slate-50 text-slate-500 text-xs uppercase font-semibold">
                                    <tr>
                                        <th class="px-6 py-4">ID</th>
                                        <th class="px-6 py-4">Patient Name</th>
                                        <th class="px-6 py-4">Age/Gender</th>
                                        <th class="px-6 py-4">Condition</th>
                                        <th class="px-6 py-4">Assigned Dr.</th>
                                        <th class="px-6 py-4">Status</th>
                                        <th class="px-6 py-4">Actions</th>
                                    </tr>
                                </thead>
                                <tbody class="divide-y divide-slate-100">
                                <% if (patients != null && !patients.isEmpty()) { for (Patient p : patients) { 
                                    String statusColor = "Active".equals(p.getStatus()) ? "bg-green-100 text-green-700" : "bg-amber-100 text-amber-700";
                                    String initials = p.getFullName() != null && p.getFullName().length() > 0 ? p.getFullName().substring(0, 1).toUpperCase() : "?";
                                %>
                                    <tr class="hover:bg-slate-50 transition">
                                        <td class="px-6 py-4 text-sm font-medium text-slate-900">PT-<%= String.format("%04d", p.getId()) %></td>
                                        <td class="px-6 py-4">
                                            <div class="flex items-center">
                                                <div class="h-8 w-8 rounded-full bg-teal-100 flex items-center justify-center text-teal-700 font-bold text-xs mr-3"><%= initials %></div>
                                                <span class="text-sm text-slate-800 font-medium"><%= p.getFullName() %></span>
                                            </div>
                                        </td>
                                        <td class="px-6 py-4 text-sm text-slate-600"><%= p.getAge() %> yrs / <%= p.getGender() %></td>
                                        <td class="px-6 py-4 text-sm text-slate-600"><%= p.getMedicalCondition() != null ? p.getMedicalCondition() : "None" %></td>
                                        <td class="px-6 py-4 text-sm text-slate-600"><%= p.getDoctorName() != null ? p.getDoctorName() : "Unassigned" %></td>
                                        <td class="px-6 py-4"><span class="px-2.5 py-0.5 rounded-full text-xs font-semibold <%= statusColor %>"><%= p.getStatus() %></span></td>
                                        <td class="px-6 py-4">
                                            <div class="flex gap-2">
                                                <a href="patients?action=edit&id=<%= p.getId() %>" class="text-blue-600 hover:text-blue-800"><i data-lucide="edit" class="w-4 h-4"></i></a>
                                                <a href="patients?action=delete&id=<%= p.getId() %>" onclick="return confirm('Delete this patient?')" class="text-red-600 hover:text-red-800"><i data-lucide="trash-2" class="w-4 h-4"></i></a>
                                            </div>
                                        </td>
                                    </tr>
                                <% } } else { %>
                                    <tr><td colspan="7" class="px-6 py-8 text-center text-slate-500">No patients found. Click "Add Patient" to create one.</td></tr>
                                <% } %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <!-- Add/Edit Patient Modal -->
    <div id="patientModal" class="fixed inset-0 bg-black bg-opacity-50 <%= editMode ? "flex" : "hidden" %> items-center justify-center z-50">
        <div class="bg-white rounded-xl p-6 w-full max-w-lg mx-4 max-h-[90vh] overflow-y-auto">
            <div class="flex justify-between items-center mb-4">
                <h2 class="text-xl font-bold text-slate-800"><%= editMode ? "Edit Patient" : "Add New Patient" %></h2>
                <button onclick="closeModal()" class="text-slate-500 hover:text-slate-700"><i data-lucide="x" class="w-6 h-6"></i></button>
            </div>
            <form action="patients" method="post">
                <input type="hidden" name="action" value="<%= editMode ? "update" : "add" %>">
                <% if (editMode && editPatient != null) { %><input type="hidden" name="id" value="<%= editPatient.getId() %>"><% } %>
                <div class="space-y-4">
                    <div>
                        <label class="block text-sm font-medium text-slate-700 mb-1">Full Name *</label>
                        <input type="text" name="fullName" required value="<%= editMode && editPatient != null ? editPatient.getFullName() : "" %>" class="w-full p-2 border rounded-lg focus:ring-2 focus:ring-teal-500 focus:border-teal-500">
                    </div>
                    <div class="grid grid-cols-2 gap-4">
                        <div>
                            <label class="block text-sm font-medium text-slate-700 mb-1">Date of Birth *</label>
                            <input type="date" name="dob" required value="<%= editMode && editPatient != null && editPatient.getDob() != null ? editPatient.getDob().toString() : "" %>" class="w-full p-2 border rounded-lg focus:ring-2 focus:ring-teal-500">
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-slate-700 mb-1">Gender *</label>
                            <select name="gender" required class="w-full p-2 border rounded-lg focus:ring-2 focus:ring-teal-500">
                                <option value="">Select</option>
                                <option value="Male" <%= editMode && editPatient != null && "Male".equals(editPatient.getGender()) ? "selected" : "" %>>Male</option>
                                <option value="Female" <%= editMode && editPatient != null && "Female".equals(editPatient.getGender()) ? "selected" : "" %>>Female</option>
                                <option value="Other" <%= editMode && editPatient != null && "Other".equals(editPatient.getGender()) ? "selected" : "" %>>Other</option>
                            </select>
                        </div>
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-slate-700 mb-1">Phone</label>
                        <input type="tel" name="phone" value="<%= editMode && editPatient != null && editPatient.getPhone() != null ? editPatient.getPhone() : "" %>" class="w-full p-2 border rounded-lg focus:ring-2 focus:ring-teal-500">
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-slate-700 mb-1">Address</label>
                        <textarea name="address" rows="2" class="w-full p-2 border rounded-lg focus:ring-2 focus:ring-teal-500"><%= editMode && editPatient != null && editPatient.getAddress() != null ? editPatient.getAddress() : "" %></textarea>
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-slate-700 mb-1">Medical Condition</label>
                        <input type="text" name="medicalCondition" value="<%= editMode && editPatient != null && editPatient.getMedicalCondition() != null ? editPatient.getMedicalCondition() : "" %>" class="w-full p-2 border rounded-lg focus:ring-2 focus:ring-teal-500">
                    </div>
                    <div class="grid grid-cols-2 gap-4">
                        <div>
                            <label class="block text-sm font-medium text-slate-700 mb-1">Assigned Doctor</label>
                            <select name="assignedDoctorId" class="w-full p-2 border rounded-lg focus:ring-2 focus:ring-teal-500">
                                <option value="">Select Doctor</option>
                                <% if (doctors != null) { for (User doc : doctors) { %>
                                <option value="<%= doc.getId() %>" <%= editMode && editPatient != null && editPatient.getAssignedDoctorId() == doc.getId() ? "selected" : "" %>><%= doc.getFullName() %></option>
                                <% } } %>
                            </select>
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-slate-700 mb-1">Status</label>
                            <select name="status" class="w-full p-2 border rounded-lg focus:ring-2 focus:ring-teal-500">
                                <option value="Active" <%= editMode && editPatient != null && "Active".equals(editPatient.getStatus()) ? "selected" : "" %>>Active</option>
                                <option value="Inactive" <%= editMode && editPatient != null && "Inactive".equals(editPatient.getStatus()) ? "selected" : "" %>>Inactive</option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="flex justify-end gap-3 mt-6">
                    <button type="button" onclick="closeModal()" class="px-4 py-2 border rounded-lg hover:bg-slate-50">Cancel</button>
                    <button type="submit" class="px-4 py-2 bg-teal-600 text-white rounded-lg hover:bg-teal-700"><%= editMode ? "Update" : "Add" %> Patient</button>
                </div>
            </form>
        </div>
    </div>

    <script>
        lucide.createIcons();
        function openModal() { document.getElementById('patientModal').classList.remove('hidden'); document.getElementById('patientModal').classList.add('flex'); }
        function closeModal() { window.location.href = 'patients'; }
    </script>
</body>
</html>