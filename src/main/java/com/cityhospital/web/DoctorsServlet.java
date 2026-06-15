package com.cityhospital.web;

import com.cityhospital.dao.DoctorDao;
import com.cityhospital.model.Doctor;
import com.cityhospital.util.AppUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/app/doctors")
public class DoctorsServlet extends HttpServlet {
    private final DoctorDao doctorDao = new DoctorDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String query = req.getParameter("q");
        req.setAttribute("page", "doctors");
        req.setAttribute("title", "Doctor Management");
        req.setAttribute("query", query == null ? "" : query);
        req.setAttribute("doctors", doctorDao.list(query));
        req.getRequestDispatcher("/WEB-INF/jsp/doctors.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String action = req.getParameter("action");
        if ("delete".equals(action)) {
            doctorDao.delete(AppUtil.parseInt(req.getParameter("id")));
        } else if ("update".equals(action)) {
            Doctor doctor = new Doctor();
            doctor.setId(AppUtil.parseInt(req.getParameter("id")));
            doctor.setName(req.getParameter("name"));
            doctor.setSpecialization(req.getParameter("specialization"));
            doctor.setPhone(req.getParameter("phone"));
            doctor.setEmail(req.getParameter("email"));
            doctor.setAvailableDays(req.getParameter("availableDays"));
            doctor.setConsultationFee(AppUtil.parseDouble(req.getParameter("consultationFee")));
            doctor.setAvailability(req.getParameter("availability"));
            doctorDao.update(doctor);
        } else {
            Doctor doctor = new Doctor();
            doctor.setName(req.getParameter("name"));
            doctor.setSpecialization(req.getParameter("specialization"));
            doctor.setPhone(req.getParameter("phone"));
            doctor.setEmail(req.getParameter("email"));
            doctor.setAvailableDays(req.getParameter("availableDays"));
            doctor.setConsultationFee(AppUtil.parseDouble(req.getParameter("consultationFee")));
            doctor.setAvailability(req.getParameter("availability"));
            doctorDao.insert(doctor);
        }
        resp.sendRedirect(req.getContextPath() + "/app/doctors");
    }
}
