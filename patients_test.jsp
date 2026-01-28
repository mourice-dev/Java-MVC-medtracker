<!-- @format -->

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ page import="java.util.*" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8" />
            <meta name="viewport" content="width=device-width, initial-scale=1.0" />
            <title>Patients Test - MedicTrack</title>
            <!-- Tailwind CSS -->
            <script src="https://cdn.tailwindcss.com"></script>
            <!-- Lucide Icons -->
            <script src="https://unpkg.com/lucide@latest"></script>
        </head>

        <body class="bg-slate-50 font-sans text-slate-800 overflow-hidden">
            <div class="flex h-screen bg-slate-50">
                <!-- Sidebar Inclusion -->
                <jsp:include page="components/sidebar.jsp">
                    <jsp:param name="active" value="patients" />
                </jsp:include>

                <!-- Main Content -->
                <div class="flex-1 flex flex-col h-full overflow-hidden">
                    <!-- Top Header -->
                    <jsp:include page="components/header.jsp" />

                    <!-- Scrollable Content Area -->
                    <main class="flex-1 overflow-y-auto p-6 bg-slate-50">
                        <div class="max-w-7xl mx-auto space-y-6">

                            <% // Mock Data for Patients matches the React example List<Map<String, String>> patients =
                                new ArrayList<>();
                                    Map<String, String> p1 = new HashMap<>();
                                            p1.put("id", "PT-001");
                                            p1.put("name", "Sarah Jenkins");
                                            p1.put("age", "34");
                                            p1.put("condition", "Hypertension");
                                            p1.put("status", "Stable");
                                            p1.put("lastVisit", "2023-10-24");
                                            p1.put("doctor", "Dr. Smith");
                                            patients.add(p1);

                                            Map<String, String> p2 = new HashMap<>();
                                                    p2.put("id", "PT-002");
                                                    p2.put("name", "Michael Chen");
                                                    p2.put("age", "58");
                                                    p2.put("condition", "Type 2 Diabetes");
                                                    p2.put("status", "Attention");
                                                    p2.put("lastVisit", "2023-10-22");
                                                    p2.put("doctor", "Dr. Rao");
                                                    patients.add(p2);

                                                    Map<String, String> p3 = new HashMap<>();
                                                            p3.put("id", "PT-003");
                                                            p3.put("name", "Emily Davis");
                                                            p3.put("age", "22");
                                                            p3.put("condition", "Routine Checkup");
                                                            p3.put("status", "Discharged");
                                                            p3.put("lastVisit", "2023-10-25");
                                                            p3.put("doctor", "Dr. Smith");
                                                            patients.add(p3);

                                                            Map<String, String> p4 = new HashMap<>();
                                                                    p4.put("id", "PT-004");
                                                                    p4.put("name", "Robert Wilson");
                                                                    p4.put("age", "45");
                                                                    p4.put("condition", "Post-Op Recovery");
                                                                    p4.put("status", "Critical");
                                                                    p4.put("lastVisit", "2023-10-25");
                                                                    p4.put("doctor", "Dr. Alverez");
                                                                    patients.add(p4);

                                                                    Map<String, String> p5 = new HashMap<>();
                                                                            p5.put("id", "PT-005");
                                                                            p5.put("name", "Anita Patel");
                                                                            p5.put("age", "29");
                                                                            p5.put("condition", "Migraine");
                                                                            p5.put("status", "Stable");
                                                                            p5.put("lastVisit", "2023-10-20");
                                                                            p5.put("doctor", "Dr. Rao");
                                                                            patients.add(p5);
                                                                            %>

                                                                            <div
                                                                                class="bg-white rounded-xl shadow-sm border border-slate-100 flex flex-col h-full">
                                                                                <div
                                                                                    class="p-6 border-b border-slate-100 flex justify-between items-center">
                                                                                    <h2
                                                                                        class="text-lg font-bold text-slate-800">
                                                                                        Patient Records</h2>
                                                                                    <button
                                                                                        class="bg-teal-600 hover:bg-teal-700 text-white px-4 py-2 rounded-lg text-sm font-medium flex items-center transition shadow-lg shadow-teal-600/20">
                                                                                        <i data-lucide="user-plus"
                                                                                            width="16" class="mr-2"></i>
                                                                                        Add Patient
                                                                                    </button>
                                                                                </div>
                                                                                <div class="overflow-x-auto">
                                                                                    <table class="w-full text-left">
                                                                                        <thead
                                                                                            class="bg-slate-50 text-slate-500 text-xs uppercase font-semibold">
                                                                                            <tr>
                                                                                                <th class="px-6 py-4">ID
                                                                                                </th>
                                                                                                <th class="px-6 py-4">
                                                                                                    Patient Name</th>
                                                                                                <th class="px-6 py-4">
                                                                                                    Age</th>
                                                                                                <th class="px-6 py-4">
                                                                                                    Condition</th>
                                                                                                <th class="px-6 py-4">
                                                                                                    Assigned Dr.</th>
                                                                                                <th class="px-6 py-4">
                                                                                                    Last Visit</th>
                                                                                                <th class="px-6 py-4">
                                                                                                    Status</th>
                                                                                                <th class="px-6 py-4">
                                                                                                    Actions</th>
                                                                                            </tr>
                                                                                        </thead>
                                                                                        <tbody
                                                                                            class="divide-y divide-slate-100">
                                                                                            <% for(Map<String, String>
                                                                                                pt : patients) {
                                                                                                String statusColor =
                                                                                                "bg-gray-100
                                                                                                text-gray-600";
                                                                                                String status =
                                                                                                pt.get("status");
                                                                                                if("Stable".equals(status))
                                                                                                statusColor =
                                                                                                "bg-green-100
                                                                                                text-green-700";
                                                                                                else
                                                                                                if("Discharged".equals(status))
                                                                                                statusColor =
                                                                                                "bg-gray-100
                                                                                                text-gray-700";
                                                                                                else
                                                                                                if("Attention".equals(status))
                                                                                                statusColor =
                                                                                                "bg-amber-100
                                                                                                text-amber-700";
                                                                                                else
                                                                                                if("Critical".equals(status))
                                                                                                statusColor =
                                                                                                "bg-rose-100
                                                                                                text-rose-700";

                                                                                                String initials = "";
                                                                                                if(pt.get("name") !=
                                                                                                null) {
                                                                                                String[] parts =
                                                                                                pt.get("name").split("
                                                                                                ");
                                                                                                for(String part : parts)
                                                                                                if(part.length()>0)
                                                                                                initials+=part.substring(0,1);
                                                                                                }
                                                                                                %>
                                                                                                <tr
                                                                                                    class="hover:bg-slate-50 transition">
                                                                                                    <td
                                                                                                        class="px-6 py-4 text-sm font-medium text-slate-900">
                                                                                                        <%= pt.get("id")
                                                                                                            %>
                                                                                                    </td>
                                                                                                    <td
                                                                                                        class="px-6 py-4">
                                                                                                        <div
                                                                                                            class="flex items-center">
                                                                                                            <div
                                                                                                                class="h-8 w-8 rounded-full bg-teal-100 flex items-center justify-center text-teal-700 font-bold text-xs mr-3">
                                                                                                                <%= initials
                                                                                                                    %>
                                                                                                            </div>
                                                                                                            <span
                                                                                                                class="text-sm text-slate-800 font-medium">
                                                                                                                <%= pt.get("name")
                                                                                                                    %>
                                                                                                            </span>
                                                                                                        </div>
                                                                                                    </td>
                                                                                                    <td
                                                                                                        class="px-6 py-4 text-sm text-slate-600">
                                                                                                        <%= pt.get("age")
                                                                                                            %>
                                                                                                    </td>
                                                                                                    <td
                                                                                                        class="px-6 py-4 text-sm text-slate-600">
                                                                                                        <%= pt.get("condition")
                                                                                                            %>
                                                                                                    </td>
                                                                                                    <td
                                                                                                        class="px-6 py-4 text-sm text-slate-600">
                                                                                                        <%= pt.get("doctor")
                                                                                                            %>
                                                                                                    </td>
                                                                                                    <td
                                                                                                        class="px-6 py-4 text-sm text-slate-600">
                                                                                                        <%= pt.get("lastVisit")
                                                                                                            %>
                                                                                                    </td>
                                                                                                    <td
                                                                                                        class="px-6 py-4">
                                                                                                        <span
                                                                                                            class="px-2.5 py-0.5 rounded-full text-xs font-semibold <%= statusColor %>">
                                                                                                            <%= status
                                                                                                                %>
                                                                                                        </span>
                                                                                                    </td>
                                                                                                    <td
                                                                                                        class="px-6 py-4">
                                                                                                        <button
                                                                                                            class="text-slate-400 hover:text-teal-600 transition">
                                                                                                            <i data-lucide="more-vertical"
                                                                                                                width="16"></i>
                                                                                                        </button>
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
            <script>
                lucide.createIcons();
            </script>
        </body>

        </html>