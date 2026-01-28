package com.medictrack.web;

import com.medictrack.dao.UserDAO;
import com.medictrack.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import java.sql.SQLException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private UserDAO userDAO;

    public void init() {
        userDAO = new UserDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        User newUser = new User(name, email, password, role);

        try {
            if (userDAO.register(newUser)) {
                // Registration success
                response.getWriter().println("Registration successful. Login is disabled. You have unrestricted access.");
            } else {
                response.getWriter().println("Registration failed due to unknown error. No login or registration page is available.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            String errorMessage;
            if (e.getMessage().contains("Duplicate entry")) {
                errorMessage = "Email is already registered. Please use a different email.";
            } else if (e.getMessage().contains("Unknown column")) {
                errorMessage = "System Error: Database schema mismatch. " + e.getMessage();
            } else {
                errorMessage = "Database Error: " + e.getMessage();
            }
            request.setAttribute("error", errorMessage);
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}
