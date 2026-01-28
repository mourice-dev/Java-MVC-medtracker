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
                                <i data-lucide="file-text" width="48" class="mx-auto mb-4 opacity-50"></i>
                                <h3 class="text-lg font-bold">Reports Module</h3>
                                <p>Coming Soon</p>
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