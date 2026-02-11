package com.medictrack.web;

import com.medictrack.dao.StaffDAO;
import com.medictrack.model.Staff;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
// Session management import removed for unrestricted access
import java.io.IOException;
import java.util.List;

@WebServlet("/staff")
public class StaffServlet extends HttpServlet {

    private StaffDAO staffDAO;

    public void init() {
        staffDAO = new StaffDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // All session/user checks removed for unrestricted access

        String action = request.getParameter("action");

        if ("edit".equals(action)) {
            int userId = Integer.parseInt(request.getParameter("userId"));
            Staff staff = staffDAO.getStaffByUserId(userId);
            request.setAttribute("staffMember", staff);
            request.setAttribute("editMode", true);
        }

        String keyword = request.getParameter("keyword");
        String role = request.getParameter("role");
        String department = request.getParameter("department");
        String status = request.getParameter("status");

        request.setAttribute("keyword", keyword);
        request.setAttribute("filterRole", role);
        request.setAttribute("filterDepartment", department);
        request.setAttribute("filterStatus", status);

        List<Staff> staffList;
        if ((keyword != null && !keyword.isEmpty()) || (role != null && !role.isEmpty()) ||
                (department != null && !department.isEmpty()) || (status != null && !status.isEmpty())) {
            staffList = staffDAO.searchStaff(keyword, role, department, status);
        } else {
            staffList = staffDAO.getAllStaff();
        }
        request.setAttribute("staffList", staffList);
        request.getRequestDispatcher("staff_v3.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // All session/user checks removed for unrestricted access

        String action = request.getParameter("action");

        if ("update".equals(action)) {
            int userId = Integer.parseInt(request.getParameter("userId"));

            Staff staff = new Staff();
            staff.setUserId(userId);
            staff.setDepartment(request.getParameter("department"));
            staff.setSpecialty(request.getParameter("specialty"));

            String shiftStartStr = request.getParameter("shiftStart");
            if (shiftStartStr != null && !shiftStartStr.isEmpty()) {
                staff.setShiftStart(shiftStartStr);
            }

            String shiftEndStr = request.getParameter("shiftEnd");
            if (shiftEndStr != null && !shiftEndStr.isEmpty()) {
                staff.setShiftEnd(shiftEndStr);
            }

            staff.setStatus(request.getParameter("status"));

            staffDAO.updateStaffDetails(staff);
        }

        response.sendRedirect("staff");
    }
}
