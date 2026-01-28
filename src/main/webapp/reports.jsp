<!-- @format -->

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Reports - MedicTrack</title>
        <!-- Tailwind CSS -->
        <script src="https://cdn.tailwindcss.com"></script>
        <!-- Lucide Icons -->
        <script src="https://unpkg.com/lucide@latest"></script>
    </head>

    <body class="bg-slate-50 font-sans text-slate-800 overflow-hidden">
        <div class="flex h-screen bg-slate-50">
            <!-- Sidebar Inclusion -->
            <jsp:include page="components/sidebar.jsp">
                <jsp:param name="active" value="reports" />
            </jsp:include>

            <!-- Main Content -->
            <div class="flex-1 flex flex-col h-full overflow-hidden">
                <!-- Top Header -->
                <jsp:include page="components/header.jsp" />

                <!-- Scrollable Content Area -->
                <main class="flex-1 overflow-y-auto p-6 bg-slate-50">
                    <div class="max-w-7xl mx-auto">
                        <div
                            class="flex items-center justify-center p-12 text-slate-400 bg-white rounded-xl border border-slate-100 h-96">
                            <div class="text-center">
                                <i data-lucide="file-text" width="48" class="mx-auto mb-4 text-teal-600"></i>
                                <h3 class="text-lg font-bold mb-2">Patient Report</h3>
                                <p class="mb-4 text-slate-500">Generate a PDF list of all patients.</p>
                                <a href="report?type=patients" target="_blank"
                                    class="inline-flex items-center justify-center px-4 py-2 border border-transparent text-sm font-medium rounded-md text-white bg-teal-600 hover:bg-teal-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-teal-500">
                                    Generate PDF
                                </a>
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