package com.cityhospital.web;

import com.cityhospital.dao.*;
import com.cityhospital.model.DashboardStats;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/app/dashboard")
public class DashboardServlet extends HttpServlet {
    private final PatientDao patientDao = new PatientDao();
    private final DoctorDao doctorDao = new DoctorDao();
    private final AppointmentDao appointmentDao = new AppointmentDao();
    private final BillDao billDao = new BillDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        DashboardStats stats = new DashboardStats();
        stats.setTotalPatients(patientDao.count());
        stats.setTotalDoctors(doctorDao.count());
        stats.setTodayAppointments(appointmentDao.countToday());
        stats.setPendingBills(billDao.countPending());

        req.setAttribute("page", "dashboard");
        req.setAttribute("title", "Dashboard");
        req.setAttribute("stats", stats);
        req.setAttribute("recentAppointments", appointmentDao.recent(8));
        req.getRequestDispatcher("/WEB-INF/jsp/dashboard.jsp").forward(req, resp);
    }
}
