package com.medictrack.web;

import com.medictrack.dao.PatientDAO;
import com.medictrack.dao.StaffDAO;
import com.medictrack.model.Patient;
// User import removed; no login/session logic
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
// All session/user checks removed for unrestricted access
import java.io.IOException;
import java.sql.Date;
import java.util.List;

@WebServlet("/patients")
public class PatientServlet extends HttpServlet {

    private PatientDAO patientDAO;
    private StaffDAO staffDAO;

    public void init() {
        patientDAO = new PatientDAO();
        staffDAO = new StaffDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // All session/user checks removed for unrestricted access
        // }

        String action = request.getParameter("action");
        
        if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            patientDAO.deletePatient(id);
            response.sendRedirect("patients");
            return;
        }
        
        if ("edit".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            Patient patient = patientDAO.getPatientById(id);
            request.setAttribute("patient", patient);
            request.setAttribute("doctors", staffDAO.getAllDoctors());
            request.setAttribute("editMode", true);
        }

        List<Patient> patients = patientDAO.getAllPatients();
        request.setAttribute("patients", patients);
        request.setAttribute("doctors", staffDAO.getAllDoctors());
        request.getRequestDispatcher("patientlist.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // All session/user checks removed for unrestricted access
        // }

        String action = request.getParameter("action");
        
        Patient patient = new Patient();
        patient.setFullName(request.getParameter("fullName"));
        
        String dobStr = request.getParameter("dob");
        if (dobStr != null && !dobStr.isEmpty()) {
            patient.setDob(Date.valueOf(dobStr));
        }
        
        patient.setGender(request.getParameter("gender"));
        patient.setPhone(request.getParameter("phone"));
        patient.setAddress(request.getParameter("address"));
        patient.setMedicalCondition(request.getParameter("medicalCondition"));
        patient.setStatus(request.getParameter("status"));
        
        String lastVisitStr = request.getParameter("lastVisit");
        if (lastVisitStr != null && !lastVisitStr.isEmpty()) {
            patient.setLastVisit(Date.valueOf(lastVisitStr));
        }
        
        String doctorId = request.getParameter("assignedDoctorId"); 
        if (doctorId != null && !doctorId.isEmpty()) {
            patient.setAssignedDoctorId(Integer.parseInt(doctorId));
        }

        if ("update".equals(action)) {
            patient.setId(Integer.parseInt(request.getParameter("id")));
            patientDAO.updatePatient(patient);
        } else {
            patientDAO.addPatient(patient);
        }

        response.sendRedirect("patients");
    }
}
