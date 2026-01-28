<!-- @format -->

<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ page
import="com.medictrack.model.User" %> <% // Session/user checks removed for
unrestricted guest access String fullName = "Guest User"; String role = "Guest";
String initials = "GU"; %>
<header
  class="h-16 bg-white border-b border-slate-200 flex justify-between items-center px-6 shadow-sm z-10">
  <button class="md:hidden text-slate-500 hover:text-slate-700">
    <i data-lucide="menu" width="24"></i>
  </button>

  <div class="hidden md:flex relative w-96">
    <i
      data-lucide="search"
      class="absolute left-3 top-2.5 text-slate-400"
      width="18"></i>
    <input
      type="text"
      placeholder="Search patients, doctors, or records..."
      class="w-full pl-10 pr-4 py-2 bg-slate-50 border border-slate-200 rounded-lg text-sm focus:outline-none focus:border-teal-500 focus:bg-white transition" />
  </div>

  <div class="flex items-center space-x-4">
    <button
      class="relative p-2 text-slate-400 hover:bg-slate-50 rounded-full transition">
      <i data-lucide="bell" width="20"></i>
      <span
        class="absolute top-2 right-2 h-2 w-2 bg-rose-500 rounded-full border-2 border-white"></span>
    </button>
    <button
      class="p-2 text-slate-400 hover:bg-slate-50 rounded-full transition">
      <i data-lucide="settings" width="20"></i>
    </button>
    <div class="flex items-center pl-2 border-l border-slate-200">
      <div
        class="h-8 w-8 rounded-full bg-teal-600 flex items-center justify-center text-white font-bold text-sm mr-2 shadow-sm ring-2 ring-teal-100">
        <%= initials %>
      </div>
      <div class="hidden lg:block">
        <p class="text-sm font-bold text-slate-800"><%= fullName %></p>
        <p class="text-xs text-slate-500"><%= role %></p>
      </div>
    </div>
  </div>
</header>
