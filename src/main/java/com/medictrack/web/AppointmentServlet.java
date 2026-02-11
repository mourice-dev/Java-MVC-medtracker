package com.medictrack.web;

import com.medictrack.dao.AppointmentDAO;
import com.medictrack.dao.PatientDAO;
import com.medictrack.dao.StaffDAO;
import com.medictrack.model.Appointment;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
// All session/user checks removed for unrestricted access
import java.io.IOException;
import java.sql.Timestamp;
import java.util.List;

@WebServlet("/appointments")
public class AppointmentServlet extends HttpServlet {

    private AppointmentDAO appointmentDAO;
    private PatientDAO patientDAO;
    private StaffDAO staffDAO;

    public void init() {
        appointmentDAO = new AppointmentDAO();
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
            appointmentDAO.deleteAppointment(id);
            response.sendRedirect("appointments");
            return;
        }

        if ("edit".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            Appointment appointment = appointmentDAO.getAppointmentById(id);
            request.setAttribute("appointment", appointment);
            request.setAttribute("editMode", true);
        }

        String keyword = request.getParameter("keyword");
        String dateStr = request.getParameter("searchDate");
        String timeFromStr = request.getParameter("timeFrom");
        String timeToStr = request.getParameter("timeTo");
        String status = request.getParameter("status");
        String type = request.getParameter("type");

        request.setAttribute("keyword", keyword);
        request.setAttribute("searchDate", dateStr);
        request.setAttribute("timeFrom", timeFromStr);
        request.setAttribute("timeTo", timeToStr);
        request.setAttribute("filterStatus", status);
        request.setAttribute("filterType", type);

        List<Appointment> appointments;
        if ((keyword != null && !keyword.isEmpty()) || (dateStr != null && !dateStr.isEmpty()) ||
                (timeFromStr != null && !timeFromStr.isEmpty()) || (timeToStr != null && !timeToStr.isEmpty()) ||
                (status != null && !status.isEmpty()) || (type != null && !type.isEmpty())) {

            java.sql.Date date = (dateStr != null && !dateStr.isEmpty()) ? java.sql.Date.valueOf(dateStr) : null;
            java.sql.Time timeFrom = (timeFromStr != null && !timeFromStr.isEmpty())
                    ? java.sql.Time.valueOf(timeFromStr + ":00")
                    : null;
            java.sql.Time timeTo = (timeToStr != null && !timeToStr.isEmpty())
                    ? java.sql.Time.valueOf(timeToStr + ":00")
                    : null;

            appointments = appointmentDAO.searchAppointments(keyword, date, timeFrom, timeTo, status, type);
        } else {
            appointments = appointmentDAO.getAllAppointments();
        }
        request.setAttribute("appointments", appointments);
        request.setAttribute("patients", patientDAO.getAllPatients());
        request.setAttribute("doctors", staffDAO.getAllDoctors());
        request.getRequestDispatcher("appointment_list.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // All session/user checks removed for unrestricted access
        // }

        String action = request.getParameter("action");

        Appointment appointment = new Appointment();

        String patientId = request.getParameter("patientId");
        if (patientId != null && !patientId.isEmpty()) {
            appointment.setPatientId(Integer.parseInt(patientId));
        }

        String doctorId = request.getParameter("doctorId");
        if (doctorId != null && !doctorId.isEmpty()) {
            appointment.setDoctorId(Integer.parseInt(doctorId));
        }

        String dateTime = request.getParameter("appointmentTime");
        if (dateTime != null && !dateTime.isEmpty()) {
            appointment.setAppointmentTime(Timestamp.valueOf(dateTime.replace("T", " ") + ":00"));
        }

        appointment.setType(request.getParameter("type"));
        appointment.setStatus(request.getParameter("status"));
        appointment.setNotes(request.getParameter("notes"));

        if ("update".equals(action)) {
            appointment.setId(Integer.parseInt(request.getParameter("id")));
            appointmentDAO.updateAppointment(appointment);
        } else {
            appointmentDAO.addAppointment(appointment);
        }

        response.sendRedirect("appointments");
    }
}
