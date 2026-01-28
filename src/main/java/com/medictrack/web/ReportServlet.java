package com.medictrack.web;

import com.medictrack.util.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import net.sf.jasperreports.engine.*;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/report")
public class ReportServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String type = request.getParameter("type");
        if ("patients".equals(type)) {
            generatePatientReport(response);
        } else {
            response.getWriter().println("Unknown report type");
        }
    }

    private void generatePatientReport(HttpServletResponse response) throws IOException {
        try (Connection conn = DBConnection.getConnection()) {

            // Load JRXML
            InputStream reportStream = getClass().getResourceAsStream("/patients_report.jrxml");
            if (reportStream == null) {
                response.getWriter().println("Report template not found.");
                return;
            }

            // Compile
            JasperReport jasperReport = JasperCompileManager.compileReport(reportStream);

            // Parameters (empty for now)
            Map<String, Object> parameters = new HashMap<>();

            // Fill
            JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, parameters, conn);

            // Export to PDF
            response.setContentType("application/pdf");
            response.setHeader("Content-Disposition", "inline; filename=patients_report.pdf");

            JasperExportManager.exportReportToPdfStream(jasperPrint, response.getOutputStream());

        } catch (SQLException | JRException e) {
            e.printStackTrace();
            response.getWriter().println("Error generating report: " + e.getMessage());
        }
    }
}
