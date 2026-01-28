<%@ page contentType="text/html;charset=UTF-8" language="java" %>
  <!DOCTYPE html>
  <html lang="en">

  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Dashboard - MedicTrack</title>
    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Lucide Icons -->
    <script src="https://unpkg.com/lucide@latest"></script>
  </head>

  <body class="bg-slate-50 font-sans text-slate-800 overflow-hidden">
    <div class="flex h-screen bg-slate-50">
      <!-- Sidebar Inclusion -->
      <jsp:include page="components/sidebar.jsp">
        <jsp:param name="active" value="dashboard" />
      </jsp:include>

      <!-- Main Content -->
      <div class="flex-1 flex flex-col h-full overflow-hidden">
        <!-- Top Header -->
        <!-- Top Header -->
        <jsp:include page="components/header.jsp" />

        <!-- Scrollable Content Area -->
        <main class="flex-1 overflow-y-auto p-6 bg-slate-50">
          <div class="max-w-7xl mx-auto space-y-6">
            <!-- Welcome Header -->
            <div
              class="bg-gradient-to-r from-teal-800 to-teal-600 rounded-2xl p-8 text-white shadow-lg relative overflow-hidden">
              <div
                class="absolute top-0 right-0 w-64 h-64 bg-white opacity-10 rounded-full transform translate-x-1/2 -translate-y-1/2">
              </div>
              <div class="relative z-10">
                <h2 class="text-3xl font-bold mb-2">Welcome Back, Dr. Admin</h2>
                <p class="text-teal-100 mb-6 max-w-xl">
                  You have 4 appointments scheduled for today and 7 critical
                  patient cases requiring attention.
                </p>
                <div class="flex space-x-3">
                  <button
                    class="bg-white text-teal-800 px-4 py-2 rounded-lg text-sm font-bold hover:bg-teal-50 transition">
                    View Schedule
                  </button>
                  <button
                    class="bg-teal-700 text-white border border-teal-500 px-4 py-2 rounded-lg text-sm font-bold hover:bg-teal-600 transition">
                    Review Cases
                  </button>
                </div>
              </div>
            </div>

            <!-- Stats Grid -->
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
              <!-- Stat 1 -->
              <div
                class="bg-white p-6 rounded-xl shadow-sm border border-slate-100 transition hover:shadow-md hover:-translate-y-1 duration-300">
                <div class="flex justify-between items-start">
                  <div>
                    <p class="text-sm font-medium text-slate-500">
                      Total Patients
                    </p>
                    <h3 class="text-2xl font-bold text-slate-800 mt-1">
                      1,284
                    </h3>
                  </div>
                  <div class="p-2 rounded-lg bg-blue-100 text-blue-600">
                    <i data-lucide="users" width="20"></i>
                  </div>
                </div>
                <p class="text-xs font-medium text-slate-400 mt-4">
                  <span class="text-green-600">+12%</span> vs last month
                </p>
              </div>
              <!-- Stat 2 -->
              <div
                class="bg-white p-6 rounded-xl shadow-sm border border-slate-100 transition hover:shadow-md hover:-translate-y-1 duration-300">
                <div class="flex justify-between items-start">
                  <div>
                    <p class="text-sm font-medium text-slate-500">
                      Appointments Today
                    </p>
                    <h3 class="text-2xl font-bold text-slate-800 mt-1">42</h3>
                  </div>
                  <div class="p-2 rounded-lg bg-teal-100 text-teal-600">
                    <i data-lucide="calendar" width="20"></i>
                  </div>
                </div>
                <p class="text-xs font-medium text-slate-400 mt-4">
                  <span class="text-slate-600">On Track</span>
                </p>
              </div>
              <!-- Stat 3 -->
              <div
                class="bg-white p-6 rounded-xl shadow-sm border border-slate-100 transition hover:shadow-md hover:-translate-y-1 duration-300">
                <div class="flex justify-between items-start">
                  <div>
                    <p class="text-sm font-medium text-slate-500">
                      Active Staff
                    </p>
                    <h3 class="text-2xl font-bold text-slate-800 mt-1">38</h3>
                  </div>
                  <div class="p-2 rounded-lg bg-indigo-100 text-indigo-600">
                    <i data-lucide="stethoscope" width="20"></i>
                  </div>
                </div>
                <p class="text-xs font-medium text-slate-400 mt-4">
                  <span class="text-slate-600">Full Staff</span>
                </p>
              </div>
              <!-- Stat 4 -->
              <div
                class="bg-white p-6 rounded-xl shadow-sm border border-slate-100 transition hover:shadow-md hover:-translate-y-1 duration-300">
                <div class="flex justify-between items-start">
                  <div>
                    <p class="text-sm font-medium text-slate-500">
                      Critical Cases
                    </p>
                    <h3 class="text-2xl font-bold text-slate-800 mt-1">7</h3>
                  </div>
                  <div class="p-2 rounded-lg bg-rose-100 text-rose-600">
                    <i data-lucide="activity" width="20"></i>
                  </div>
                </div>
                <p class="text-xs font-medium text-slate-400 mt-4">
                  <span class="text-green-600">-2%</span> vs last month
                </p>
              </div>
            </div>

            <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
              <!-- Chart Area -->
              <div class="lg:col-span-2 bg-white p-6 rounded-xl shadow-sm border border-slate-100">
                <div class="flex justify-between items-center mb-6">
                  <h3 class="text-lg font-bold text-slate-800">
                    Patient Admittance Analytics
                  </h3>
                  <select class="text-sm border-slate-200 rounded-md text-slate-500 bg-slate-50 p-1">
                    <option>Last 7 Days</option>
                    <option>Last Month</option>
                  </select>
                </div>
                <div
                  class="h-64 bg-slate-50 rounded-lg flex items-center justify-center border border-dashed border-slate-300 relative overflow-hidden group">
                  <div class="text-center z-10">
                    <i data-lucide="activity" class="mx-auto text-slate-300 mb-2" width="48" height="48"></i>
                    <p class="text-slate-400 text-sm">
                      Real-time Visualization
                    </p>
                  </div>
                  <svg class="absolute bottom-0 left-0 right-0 h-32 w-full text-teal-100 opacity-50"
                    viewBox="0 0 100 40" preserveAspectRatio="none">
                    <path d="M0 40 L0 30 Q10 10 20 25 T40 15 T60 30 T80 10 T100 20 L100 40 Z" fill="currentColor" />
                  </svg>
                </div>
              </div>

              <!-- Upcoming Schedule -->
              <div class="bg-white p-6 rounded-xl shadow-sm border border-slate-100">
                <h3 class="text-lg font-bold text-slate-800 mb-4">
                  Upcoming Schedule
                </h3>
                <div class="space-y-4">
                  <!-- Appt 1 -->
                  <div class="flex items-start pb-4 border-b border-slate-50 last:border-0 last:pb-0">
                    <div class="bg-teal-50 text-teal-700 p-2 rounded-lg mr-3 text-center min-w-[60px]">
                      <span class="block text-xs font-bold">09:00 AM</span>
                    </div>
                    <div>
                      <h4 class="font-semibold text-slate-800 text-sm">
                        Sarah Jenkins
                      </h4>
                      <p class="text-xs text-slate-500">
                        Follow-up with Dr. Smith
                      </p>
                    </div>
                  </div>
                  <!-- Appt 2 -->
                  <div class="flex items-start pb-4 border-b border-slate-50 last:border-0 last:pb-0">
                    <div class="bg-teal-50 text-teal-700 p-2 rounded-lg mr-3 text-center min-w-[60px]">
                      <span class="block text-xs font-bold">10:30 AM</span>
                    </div>
                    <div>
                      <h4 class="font-semibold text-slate-800 text-sm">
                        James Carter
                      </h4>
                      <p class="text-xs text-slate-500">
                        Consultation with Dr. Alverez
                      </p>
                    </div>
                  </div>
                  <!-- Appt 3 -->
                  <div class="flex items-start pb-4 border-b border-slate-50 last:border-0 last:pb-0">
                    <div class="bg-teal-50 text-teal-700 p-2 rounded-lg mr-3 text-center min-w-[60px]">
                      <span class="block text-xs font-bold">01:00 PM</span>
                    </div>
                    <div>
                      <h4 class="font-semibold text-slate-800 text-sm">
                        Linda May
                      </h4>
                      <p class="text-xs text-slate-500">
                        Lab Review with Dr. Rao
                      </p>
                    </div>
                  </div>

                  <button
                    class="w-full mt-2 py-2 text-sm text-teal-600 font-medium hover:bg-teal-50 rounded-lg transition border border-transparent hover:border-teal-100">
                    View All Schedule
                  </button>
                </div>
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