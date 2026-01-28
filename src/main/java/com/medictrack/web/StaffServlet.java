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

        List<Staff> staffList = staffDAO.getAllStaff();
        request.setAttribute("staffList", staffList);
        request.getRequestDispatcher("staff.jsp").forward(request, response);
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
