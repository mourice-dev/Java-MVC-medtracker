<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <% String error=request.getParameter("error"); %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Login - MedicTrack</title>
            <script src="https://cdn.tailwindcss.com"></script>
            <script src="https://unpkg.com/lucide@latest"></script>
        </head>

        <body
            class="bg-gradient-to-br from-teal-900 via-teal-800 to-slate-900 min-h-screen flex items-center justify-center p-4">
            <div class="w-full max-w-md">
                <!-- Logo -->
                <div class="text-center mb-8">
                    <div class="inline-flex items-center text-white">
                        <div class="bg-white text-teal-600 p-3 rounded-xl mr-3 shadow-lg">
                            <i data-lucide="activity" width="32" height="32"></i>
                        </div>
                        <span class="text-3xl font-bold tracking-tight">Medic<span
                                class="text-teal-300">Track</span></span>
                    </div>
                    <p class="text-teal-200 mt-2">Hospital Management System</p>
                </div>

                <!-- Login Card -->
                <div class="bg-white rounded-2xl shadow-2xl p-8">
                    <h2 class="text-2xl font-bold text-slate-800 text-center mb-2">Welcome Back</h2>
                    <p class="text-slate-500 text-center mb-6">Sign in to your account</p>

                    <% if (error !=null) { %>
                        <div
                            class="bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded-lg mb-4 flex items-center">
                            <i data-lucide="alert-circle" class="w-5 h-5 mr-2"></i>
                            <span class="text-sm">Invalid email or password. Please try again.</span>
                        </div>
                        <% } %>

                            <form action="login" method="post" class="space-y-5">
                                <div>
                                    <label class="block text-sm font-medium text-slate-700 mb-2">Email Address</label>
                                    <div class="relative">
                                        <i data-lucide="mail" class="absolute left-3 top-3 text-slate-400 w-5 h-5"></i>
                                        <input type="email" name="email" required placeholder="doctor@medictrack.com"
                                            class="w-full pl-10 pr-4 py-3 border border-slate-200 rounded-xl focus:ring-2 focus:ring-teal-500 focus:border-teal-500 transition">
                                    </div>
                                </div>

                                <div>
                                    <label class="block text-sm font-medium text-slate-700 mb-2">Password</label>
                                    <div class="relative">
                                        <i data-lucide="lock" class="absolute left-3 top-3 text-slate-400 w-5 h-5"></i>
                                        <input type="password" name="password" required
                                            placeholder="Enter your password"
                                            class="w-full pl-10 pr-4 py-3 border border-slate-200 rounded-xl focus:ring-2 focus:ring-teal-500 focus:border-teal-500 transition">
                                    </div>
                                </div>

                                <div class="flex items-center justify-between">
                                    <label class="flex items-center">
                                        <input type="checkbox"
                                            class="w-4 h-4 text-teal-600 border-slate-300 rounded focus:ring-teal-500">
                                        <span class="ml-2 text-sm text-slate-600">Remember me</span>
                                    </label>
                                    <a href="#" class="text-sm text-teal-600 hover:text-teal-700 font-medium">Forgot
                                        password?</a>
                                </div>

                                <button type="submit"
                                    class="w-full bg-teal-600 hover:bg-teal-700 text-white py-3 rounded-xl font-bold text-lg transition shadow-lg shadow-teal-600/30 flex items-center justify-center">
                                    <i data-lucide="log-in" class="w-5 h-5 mr-2"></i>
                                    Sign In
                                </button>
                            </form>

                            <div class="mt-6 text-center">
                                <p class="text-slate-500 text-sm">
                                    Don't have an account?
                                    <a href="register.jsp"
                                        class="text-teal-600 hover:text-teal-700 font-medium">Register here</a>
                                </p>
                            </div>

                            <!-- Demo Credentials -->
                            <div class="mt-6 pt-6 border-t border-slate-100">
                                <p class="text-xs text-slate-400 text-center mb-3">Demo Credentials</p>
                                <div class="bg-slate-50 rounded-lg p-3 text-sm">

                                </div>
                            </div>
                </div>
            </div>

            <!-- Footer -->
            <p class="text-center text-teal-300 text-sm mt-6">
                &copy; 2026 MedicTrack. All rights reserved.
            </p>
            </div>

            <script>
                lucide.createIcons();
            </script>
        </body>

        </html>