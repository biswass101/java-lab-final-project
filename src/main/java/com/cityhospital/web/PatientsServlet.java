package com.cityhospital.web;

import com.cityhospital.dao.PatientDao;
import com.cityhospital.model.Patient;
import com.cityhospital.util.AppUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/app/patients")
public class PatientsServlet extends HttpServlet {
    private final PatientDao patientDao = new PatientDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String query = req.getParameter("q");
        req.setAttribute("page", "patients");
        req.setAttribute("title", "Patient Management");
        req.setAttribute("query", query == null ? "" : query);
        req.setAttribute("patients", patientDao.list(query));
        req.getRequestDispatcher("/WEB-INF/jsp/patients.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String action = req.getParameter("action");
        if ("delete".equals(action)) {
            patientDao.delete(AppUtil.parseInt(req.getParameter("id")));
        } else if ("update".equals(action)) {
            Patient patient = new Patient();
            patient.setId(AppUtil.parseInt(req.getParameter("id")));
            patient.setName(req.getParameter("name"));
            patient.setAge(AppUtil.parseInt(req.getParameter("age")));
            patient.setGender(req.getParameter("gender"));
            patient.setPhone(req.getParameter("phone"));
            patient.setBloodGroup(req.getParameter("bloodGroup"));
            patient.setEmail(req.getParameter("email"));
            patient.setAddress(req.getParameter("address"));
            patientDao.update(patient);
        } else {
            Patient patient = new Patient();
            patient.setName(req.getParameter("name"));
            patient.setAge(AppUtil.parseInt(req.getParameter("age")));
            patient.setGender(req.getParameter("gender"));
            patient.setPhone(req.getParameter("phone"));
            patient.setBloodGroup(req.getParameter("bloodGroup"));
            patient.setEmail(req.getParameter("email"));
            patient.setAddress(req.getParameter("address"));
            patientDao.insert(patient);
        }
        resp.sendRedirect(req.getContextPath() + "/app/patients");
    }
}
