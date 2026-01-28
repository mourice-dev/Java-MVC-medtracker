<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="java.util.List" %>
        <%@ page import="com.medictrack.model.Patient" %>
            <%@ page import="com.medictrack.model.User" %>
                <% List<Patient> patients = (List<Patient>) request.getAttribute("patients");
                        if (patients == null) {
                        response.sendRedirect("patients");
                        return;
                        }
                        List<User> doctors = (List<User>) request.getAttribute("doctors");
                                Patient editPatient = (Patient) request.getAttribute("patient");
                                boolean editMode = request.getAttribute("editMode") != null && (Boolean)
                                request.getAttribute("editMode");
                                String modalDisplay = editMode ? "flex" : "hidden";
                                String formAction = editMode ? "update" : "add";
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
                                        <!-- Sidebar -->
                                        <aside class="w-64 bg-white border-r border-slate-200">
                                            <div class="h-16 flex items-center px-6 border-b border-slate-100">
                                                <div class="flex items-center text-teal-600">
                                                    <div class="bg-teal-600 text-white p-1.5 rounded-lg mr-2 shadow-sm">
                                                        <i data-lucide="activity" class="w-5 h-5"></i>
                                                    </div>
                                                    <span
                                                        class="text-xl font-bold tracking-tight text-slate-800">Medic<span
                                                            class="text-teal-600">Track</span></span>
                                                </div>
                                            </div>
                                            <div class="py-6">
                                                <nav class="space-y-1">
                                                    <a href="dashboard.jsp"
                                                        class="flex items-center w-full px-6 py-3 text-sm font-medium text-slate-500 hover:text-slate-800 hover:bg-slate-50">
                                                        <i data-lucide="layout-dashboard"
                                                            class="w-5 h-5 mr-3"></i>Dashboard
                                                    </a>
                                                    <a href="patients"
                                                        class="flex items-center w-full px-6 py-3 text-sm font-medium text-teal-600 bg-teal-50 border-r-4 border-teal-600">
                                                        <i data-lucide="users" class="w-5 h-5 mr-3"></i>Patients
                                                    </a>
                                                    <a href="appointments"
                                                        class="flex items-center w-full px-6 py-3 text-sm font-medium text-slate-500 hover:text-slate-800 hover:bg-slate-50">
                                                        <i data-lucide="calendar" class="w-5 h-5 mr-3"></i>Appointments
                                                    </a>
                                                    <a href="staff"
                                                        class="flex items-center w-full px-6 py-3 text-sm font-medium text-slate-500 hover:text-slate-800 hover:bg-slate-50">
                                                        <i data-lucide="stethoscope" class="w-5 h-5 mr-3"></i>Staff
                                                    </a>
                                                </nav>
                                                <div class="px-6 mt-8">
                                                    <a href="index.jsp"
                                                        class="flex items-center w-full px-4 py-2 text-sm font-medium text-slate-500 hover:text-rose-600">
                                                        <i data-lucide="log-out" class="w-5 h-5 mr-3"></i>Exit
                                                    </a>
                                                </div>
                                            </div>
                                        </aside>

                                        <!-- Main Content -->
                                        <div class="flex-1 flex flex-col h-full overflow-hidden">
                                            <!-- Header -->
                                            <header
                                                class="h-16 bg-white border-b border-slate-200 flex justify-between items-center px-6 shadow-sm">
                                                <div class="flex relative w-96">
                                                    <i data-lucide="search"
                                                        class="absolute left-3 top-2.5 text-slate-400 w-4 h-4"></i>
                                                    <input type="text" placeholder="Search patients..."
                                                        class="w-full pl-10 pr-4 py-2 bg-slate-50 border border-slate-200 rounded-lg text-sm focus:outline-none focus:border-teal-500">
                                                </div>
                                                <div class="flex items-center space-x-4">
                                                    <button
                                                        class="relative p-2 text-slate-400 hover:bg-slate-50 rounded-full">
                                                        <i data-lucide="bell" class="w-5 h-5"></i>
                                                        <span
                                                            class="absolute top-2 right-2 h-2 w-2 bg-rose-500 rounded-full"></span>
                                                    </button>
                                                    <div class="flex items-center pl-2 border-l border-slate-200">
                                                        <div
                                                            class="h-8 w-8 rounded-full bg-teal-600 flex items-center justify-center text-white font-bold text-sm mr-2">
                                                            GU</div>
                                                        <div class="hidden lg:block">
                                                            <p class="text-sm font-bold text-slate-800">Guest User</p>
                                                            <p class="text-xs text-slate-500">Administrator</p>
                                                        </div>
                                                    </div>
                                                </div>
                                            </header>

                                            <!-- Content -->
                                            <main class="flex-1 overflow-y-auto p-6 bg-slate-50">
                                                <div class="max-w-7xl mx-auto">
                                                    <div class="bg-white rounded-xl shadow-sm border border-slate-100">
                                                        <div
                                                            class="p-6 border-b border-slate-100 flex justify-between items-center">
                                                            <h2 class="text-lg font-bold text-slate-800">Patient Records
                                                            </h2>
                                                            <button
                                                                onclick="document.getElementById('patientModal').classList.remove('hidden');document.getElementById('patientModal').classList.add('flex');"
                                                                class="bg-teal-600 hover:bg-teal-700 text-white px-4 py-2 rounded-lg text-sm font-medium flex items-center transition shadow-lg shadow-teal-600/20">
                                                                <i data-lucide="user-plus" class="w-4 h-4 mr-2"></i>Add
                                                                Patient
                                                            </button>
                                                        </div>
                                                        <div class="overflow-x-auto">
                                                            <table class="w-full text-left">
                                                                <thead
                                                                    class="bg-slate-50 text-slate-500 text-xs uppercase font-semibold">
                                                                    <tr>
                                                                        <th class="px-6 py-4">ID</th>
                                                                        <th class="px-6 py-4">Patient Name</th>
                                                                        <th class="px-6 py-4">Age</th>
                                                                        <th class="px-6 py-4">Condition</th>
                                                                        <th class="px-6 py-4">Assigned Dr.</th>
                                                                        <th class="px-6 py-4">Status</th>
                                                                        <th class="px-6 py-4">Actions</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody class="divide-y divide-slate-100">
                                                                    <% if (patients !=null && !patients.isEmpty()) { for
                                                                        (Patient p : patients) { String
                                                                        statusClass="Active" .equals(p.getStatus())
                                                                        ? "bg-green-100 text-green-700"
                                                                        : "bg-amber-100 text-amber-700" ; String
                                                                        initial=p.getFullName() !=null &&
                                                                        p.getFullName().length()> 0 ?
                                                                        p.getFullName().substring(0, 1).toUpperCase() :
                                                                        "?";
                                                                        %>
                                                                        <tr class="hover:bg-slate-50 transition">
                                                                            <td
                                                                                class="px-6 py-4 text-sm font-medium text-slate-900">
                                                                                PT-<%= String.format("%04d", p.getId())
                                                                                    %>
                                                                            </td>
                                                                            <td class="px-6 py-4">
                                                                                <div class="flex items-center">
                                                                                    <div
                                                                                        class="h-8 w-8 rounded-full bg-teal-100 flex items-center justify-center text-teal-700 font-bold text-xs mr-3">
                                                                                        <%= initial %>
                                                                                    </div>
                                                                                    <span
                                                                                        class="text-sm text-slate-800 font-medium">
                                                                                        <%= p.getFullName() %>
                                                                                    </span>
                                                                                </div>
                                                                            </td>
                                                                            <td
                                                                                class="px-6 py-4 text-sm text-slate-600">
                                                                                <%= p.getAge() %> yrs
                                                                            </td>
                                                                            <td
                                                                                class="px-6 py-4 text-sm text-slate-600">
                                                                                <%= p.getMedicalCondition() !=null ?
                                                                                    p.getMedicalCondition() : "-" %>
                                                                            </td>
                                                                            <td
                                                                                class="px-6 py-4 text-sm text-slate-600">
                                                                                <%= p.getDoctorName() !=null ?
                                                                                    p.getDoctorName() : "Unassigned" %>
                                                                            </td>
                                                                            <td class="px-6 py-4">
                                                                                <span
                                                                                    class="px-2.5 py-0.5 rounded-full text-xs font-semibold <%= statusClass %>">
                                                                                    <%= p.getStatus() !=null ?
                                                                                        p.getStatus() : "Active" %>
                                                                                </span>
                                                                            </td>
                                                                            <td class="px-6 py-4">
                                                                                <div class="flex gap-3">
                                                                                    <a href="patients?action=edit&id=<%= p.getId() %>"
                                                                                        class="text-blue-600 hover:text-blue-800 font-medium text-sm">Edit</a>
                                                                                    <a href="patients?action=delete&id=<%= p.getId() %>"
                                                                                        onclick="return confirm('Are you sure you want to delete this patient?');"
                                                                                        class="text-red-600 hover:text-red-800 font-medium text-sm">Delete</a>
                                                                                </div>
                                                                            </td>
                                                                        </tr>
                                                                        <% } } else { %>
                                                                            <tr>
                                                                                <td colspan="7"
                                                                                    class="px-6 py-12 text-center text-slate-500">
                                                                                    <i data-lucide="users"
                                                                                        class="w-12 h-12 mx-auto text-slate-300 mb-3"></i>
                                                                                    <p class="font-medium">No patients
                                                                                        found</p>
                                                                                    <p class="text-sm">Click "Add
                                                                                        Patient" to create your first
                                                                                        patient record.</p>
                                                                                </td>
                                                                            </tr>
                                                                            <% } %>
                                                                </tbody>
                                                            </table>
                                                        </div>
                                                    </div>
                                                </div>
                                            </main>
                                        </div>
                                    </div>

                                    <!-- Modal -->
                                    <div id="patientModal"
                                        class="fixed inset-0 bg-black bg-opacity-50 <%= modalDisplay %> items-center justify-center z-50">
                                        <div
                                            class="bg-white rounded-xl p-6 w-full max-w-lg mx-4 max-h-[90vh] overflow-y-auto shadow-2xl">
                                            <div class="flex justify-between items-center mb-6">
                                                <h2 class="text-xl font-bold text-slate-800">
                                                    <%= editMode ? "Edit Patient" : "Add New Patient" %>
                                                </h2>
                                                <button onclick="window.location.href='patients';"
                                                    class="text-slate-400 hover:text-slate-600">
                                                    <i data-lucide="x" class="w-6 h-6"></i>
                                                </button>
                                            </div>
                                            <form action="patients" method="post">
                                                <input type="hidden" name="action" value="<%= formAction %>">
                                                <% if (editMode && editPatient !=null) { %>
                                                    <input type="hidden" name="id" value="<%= editPatient.getId() %>">
                                                    <% } %>
                                                        <div class="space-y-4">
                                                            <div>
                                                                <label
                                                                    class="block text-sm font-medium text-slate-700 mb-1">Full
                                                                    Name *</label>
                                                                <input type="text" name="fullName" required
                                                                    value="<%= editMode && editPatient != null ? editPatient.getFullName() : "" %>"
                                                                    class="w-full p-3 border border-slate-200 rounded-lg focus:ring-2 focus:ring-teal-500 focus:border-teal-500">
                                                            </div>
                                                            <div class="grid grid-cols-2 gap-4">
                                                                <div>
                                                                    <label
                                                                        class="block text-sm font-medium text-slate-700 mb-1">Date
                                                                        of Birth *</label>
                                                                    <input type="date" name="dob" required
                                                                        value="<%= editMode && editPatient != null && editPatient.getDob() != null ? editPatient.getDob().toString() : "" %>"
                                                                        class="w-full p-3 border border-slate-200 rounded-lg focus:ring-2 focus:ring-teal-500">
                                                                </div>
                                                                <div>
                                                                    <label
                                                                        class="block text-sm font-medium text-slate-700 mb-1">Gender
                                                                        *</label>
                                                                    <select name="gender" required
                                                                        class="w-full p-3 border border-slate-200 rounded-lg focus:ring-2 focus:ring-teal-500">
                                                                        <option value="">Select Gender</option>
                                                                        <option value="Male" <%=editMode && editPatient
                                                                            !=null && "Male"
                                                                            .equals(editPatient.getGender())
                                                                            ? "selected" : "" %>>Male</option>
                                                                        <option value="Female" <%=editMode &&
                                                                            editPatient !=null && "Female"
                                                                            .equals(editPatient.getGender())
                                                                            ? "selected" : "" %>>Female</option>
                                                                        <option value="Other" <%=editMode && editPatient
                                                                            !=null && "Other"
                                                                            .equals(editPatient.getGender())
                                                                            ? "selected" : "" %>>Other</option>
                                                                    </select>
                                                                </div>
                                                            </div>
                                                            <div>
                                                                <label
                                                                    class="block text-sm font-medium text-slate-700 mb-1">Phone</label>
                                                                <input type="tel" name="phone"
                                                                    value="<%= editMode && editPatient != null && editPatient.getPhone() != null ? editPatient.getPhone() : "" %>"
                                                                    class="w-full p-3 border border-slate-200 rounded-lg focus:ring-2 focus:ring-teal-500">
                                                            </div>
                                                            <div>
                                                                <label
                                                                    class="block text-sm font-medium text-slate-700 mb-1">Address</label>
                                                                <textarea name="address" rows="2"
                                                                    class="w-full p-3 border border-slate-200 rounded-lg focus:ring-2 focus:ring-teal-500"><%= editMode && editPatient != null && editPatient.getAddress() != null ? editPatient.getAddress() : "" %></textarea>
                                                            </div>
                                                            <div>
                                                                <label
                                                                    class="block text-sm font-medium text-slate-700 mb-1">Medical
                                                                    Condition</label>
                                                                <input type="text" name="medicalCondition"
                                                                    value="<%= editMode && editPatient != null && editPatient.getMedicalCondition() != null ? editPatient.getMedicalCondition() : "" %>"
                                                                    class="w-full p-3 border border-slate-200 rounded-lg focus:ring-2 focus:ring-teal-500"
                                                                    placeholder="e.g., Hypertension, Diabetes">
                                                            </div>
                                                            <div class="grid grid-cols-2 gap-4">
                                                                <div>
                                                                    <label
                                                                        class="block text-sm font-medium text-slate-700 mb-1">Assigned
                                                                        Doctor</label>
                                                                    <select name="assignedDoctorId"
                                                                        class="w-full p-3 border border-slate-200 rounded-lg focus:ring-2 focus:ring-teal-500">
                                                                        <option value="">Select Doctor</option>
                                                                        <% if (doctors !=null) { for (User doc :
                                                                            doctors) { %>
                                                                            <option value="<%= doc.getId() %>"
                                                                                <%=editMode && editPatient !=null &&
                                                                                editPatient.getAssignedDoctorId()==doc.getId()
                                                                                ? "selected" : "" %>><%=
                                                                                    doc.getFullName() %>
                                                                            </option>
                                                                            <% } } %>
                                                                    </select>
                                                                </div>
                                                                <div>
                                                                    <label
                                                                        class="block text-sm font-medium text-slate-700 mb-1">Status</label>
                                                                    <select name="status"
                                                                        class="w-full p-3 border border-slate-200 rounded-lg focus:ring-2 focus:ring-teal-500">
                                                                        <option value="Active" <%=editMode &&
                                                                            editPatient !=null && "Active"
                                                                            .equals(editPatient.getStatus())
                                                                            ? "selected" : "" %>>Active</option>
                                                                        <option value="Stable" <%=editMode &&
                                                                            editPatient !=null && "Stable"
                                                                            .equals(editPatient.getStatus())
                                                                            ? "selected" : "" %>>Stable</option>
                                                                        <option value="Critical" <%=editMode &&
                                                                            editPatient !=null && "Critical"
                                                                            .equals(editPatient.getStatus())
                                                                            ? "selected" : "" %>>Critical</option>
                                                                        <option value="Discharged" <%=editMode &&
                                                                            editPatient !=null && "Discharged"
                                                                            .equals(editPatient.getStatus())
                                                                            ? "selected" : "" %>>Discharged</option>
                                                                    </select>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div
                                                            class="flex justify-end gap-3 mt-6 pt-4 border-t border-slate-100">
                                                            <a href="patients"
                                                                class="px-4 py-2 border border-slate-200 rounded-lg hover:bg-slate-50 font-medium text-slate-600">Cancel</a>
                                                            <button type="submit"
                                                                class="px-6 py-2 bg-teal-600 text-white rounded-lg hover:bg-teal-700 font-medium shadow-lg shadow-teal-600/20">
                                                                <%= editMode ? "Update Patient" : "Add Patient" %>
                                                            </button>
                                                        </div>
                                            </form>
                                        </div>
                                    </div>
                                    <script>lucide.createIcons();</script>
                                </body>

                                </html>