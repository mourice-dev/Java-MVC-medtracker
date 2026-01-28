<!-- @format -->

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Register - MedicTrack</title>
        <!-- Tailwind CSS -->
        <script src="https://cdn.tailwindcss.com"></script>
        <!-- Lucide Icons -->
        <script src="https://unpkg.com/lucide@latest"></script>
    </head>

    <body class="bg-slate-50">
        <div class="min-h-screen flex bg-slate-50">
            <!-- Left Side - Brand & Info -->
            <div
                class="hidden lg:flex lg:w-1/2 bg-teal-600 text-white flex-col justify-between p-12 relative overflow-hidden">
                <div class="absolute top-0 right-0 w-64 h-64 bg-teal-500 rounded-bl-full opacity-50"></div>
                <div class="absolute bottom-0 left-0 w-48 h-48 bg-teal-700 rounded-tr-full opacity-50"></div>

                <div class="relative z-10">
                    <div class="flex items-center space-x-3 mb-8">
                        <div class="bg-white/20 p-2 rounded-lg backdrop-blur-sm">
                            <i data-lucide="activity" class="text-white" width="32" height="32"></i>
                        </div>
                        <span class="text-3xl font-bold tracking-tight">MedicTrack</span>
                    </div>
                    <h1 class="text-4xl font-bold leading-tight mb-4">
                        Join Our Healthcare Network
                    </h1>
                    <p class="text-teal-100 text-lg max-w-md">
                        Create an account to manage your medical practice efficiently and securely.
                    </p>
                </div>

                <div class="relative z-10 space-y-6">
                    <p class="text-sm text-teal-200">© 2026 MedicTrack Systems Inc.</p>
                </div>
            </div>

            <!-- Right Side - Register Form -->
            <div class="w-full lg:w-1/2 flex flex-col justify-center items-center p-8 lg:p-12">
                <div class="w-full max-w-md space-y-8">
                    <!-- Mobile Logo -->
                    <div class="lg:hidden flex items-center justify-center text-teal-600 mb-8">
                        <div class="bg-teal-600 text-white p-2 rounded-xl mr-3 shadow-lg">
                            <i data-lucide="activity" width="32" height="32"></i>
                        </div>
                        <span class="text-3xl font-bold tracking-tight text-slate-800">Medic<span
                                class="text-teal-600">Track</span></span>
                    </div>

                    <div class="text-center lg:text-left">
                        <h2 class="text-3xl font-bold text-slate-900">Create Account</h2>
                        <p class="mt-2 text-slate-500">
                            Sign up to get started.
                        </p>
                    </div>

                    <!-- Error Message -->
                    <% if(request.getAttribute("error") !=null) { %>
                        <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative mb-4"
                            role="alert">
                            <span class="block sm:inline">
                                <%= request.getAttribute("error") %>
                            </span>
                        </div>
                        <% } %>

                            <!-- Form -->
                            <form action="<%=request.getContextPath()%>/register" method="post" class="mt-8 space-y-6">
                                <div class="space-y-4">

                                    <!-- Name -->
                                    <div>
                                        <label class="block text-sm font-medium text-slate-700 mb-1">Full Name</label>
                                        <div class="relative">
                                            <div
                                                class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                                <i data-lucide="user" class="h-5 w-5 text-slate-400"></i>
                                            </div>
                                            <input type="text" name="name" required
                                                class="block w-full pl-10 pr-3 py-3 border border-slate-200 rounded-xl focus:ring-2 focus:ring-teal-500 focus:border-teal-500 bg-slate-50 focus:bg-white transition-all outline-none"
                                                placeholder="John Doe" />
                                        </div>
                                    </div>

                                    <!-- Email -->
                                    <div>
                                        <label class="block text-sm font-medium text-slate-700 mb-1">Email
                                            address</label>
                                        <div class="relative">
                                            <div
                                                class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                                <i data-lucide="mail" class="h-5 w-5 text-slate-400"></i>
                                            </div>
                                            <input type="email" name="email" required
                                                class="block w-full pl-10 pr-3 py-3 border border-slate-200 rounded-xl focus:ring-2 focus:ring-teal-500 focus:border-teal-500 bg-slate-50 focus:bg-white transition-all outline-none"
                                                placeholder="name@example.com" />
                                        </div>
                                    </div>

                                    <!-- Role Selection -->
                                    <div>
                                        <label class="block text-sm font-medium text-slate-700 mb-1">Role</label>
                                        <div class="relative">
                                            <div
                                                class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                                <i data-lucide="briefcase" class="h-5 w-5 text-slate-400"></i>
                                            </div>
                                            <select name="role"
                                                class="block w-full pl-10 pr-3 py-3 border border-slate-200 rounded-xl focus:ring-2 focus:ring-teal-500 focus:border-teal-500 bg-slate-50 focus:bg-white transition-all outline-none">
                                                <option value="DOCTOR">Doctor</option>
                                                <option value="NURSE">Nurse</option>
                                                <option value="STAFF" selected>Staff</option>
                                                <option value="ADMIN">Administrator</option>
                                            </select>
                                        </div>
                                    </div>

                                    <!-- Password -->
                                    <div>
                                        <label class="block text-sm font-medium text-slate-700 mb-1">Password</label>
                                        <div class="relative">
                                            <div
                                                class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                                <i data-lucide="lock" class="h-5 w-5 text-slate-400"></i>
                                            </div>
                                            <input type="password" name="password" required
                                                class="block w-full pl-10 pr-3 py-3 border border-slate-200 rounded-xl focus:ring-2 focus:ring-teal-500 focus:border-teal-500 bg-slate-50 focus:bg-white transition-all outline-none"
                                                placeholder="Create a password" />
                                        </div>
                                    </div>
                                </div>

                                <button type="submit"
                                    class="group relative w-full flex justify-center py-3 px-4 border border-transparent text-sm font-bold rounded-xl text-white bg-teal-600 hover:bg-teal-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-teal-500 shadow-lg shadow-teal-600/30 transition-all active:scale-[0.98]">
                                    Create Account
                                    <i data-lucide="arrow-right"
                                        class="ml-2 h-4 w-4 group-hover:translate-x-1 transition-transform"></i>
                                </button>
                            </form>

                            <p class="text-center text-sm text-slate-500">
                                Already have an account?
                                <a href="login.jsp" class="text-teal-600 hover:text-teal-700 font-medium">Sign in</a>
                            </p>
                </div>
            </div>
        </div>
        <script>
            lucide.createIcons();
        </script>
    </body>

    </html>