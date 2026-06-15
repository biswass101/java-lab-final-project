package com.cityhospital.web;

import com.cityhospital.dao.AppointmentDao;
import com.cityhospital.dao.DoctorDao;
import com.cityhospital.dao.PatientDao;
import com.cityhospital.model.Appointment;
import com.cityhospital.util.AppUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/app/appointments")
public class AppointmentsServlet extends HttpServlet {
    private final AppointmentDao appointmentDao = new AppointmentDao();
    private final PatientDao patientDao = new PatientDao();
    private final DoctorDao doctorDao = new DoctorDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("page", "appointments");
        req.setAttribute("title", "Appointments");
        req.setAttribute("patients", patientDao.allForSelect());
        req.setAttribute("doctors", doctorDao.allForSelect());
        req.setAttribute("appointments", appointmentDao.listAll());
        req.getRequestDispatcher("/WEB-INF/jsp/appointments.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String action = req.getParameter("action");
        if ("delete".equals(action)) {
            appointmentDao.delete(AppUtil.parseInt(req.getParameter("id")));
        } else if ("update".equals(action)) {
            Appointment appt = new Appointment();
            appt.setId(AppUtil.parseInt(req.getParameter("id")));
            appt.setPatientId(AppUtil.parseInt(req.getParameter("patientId")));
            appt.setDoctorId(AppUtil.parseInt(req.getParameter("doctorId")));
            appt.setAppointmentDate(req.getParameter("appointmentDate"));
            appt.setAppointmentTime(req.getParameter("appointmentTime"));
            appt.setReason(req.getParameter("reason"));
            appt.setStatus(req.getParameter("status"));
            appointmentDao.update(appt);
        } else {
            Appointment appt = new Appointment();
            appt.setPatientId(AppUtil.parseInt(req.getParameter("patientId")));
            appt.setDoctorId(AppUtil.parseInt(req.getParameter("doctorId")));
            appt.setAppointmentDate(req.getParameter("appointmentDate"));
            appt.setAppointmentTime(req.getParameter("appointmentTime"));
            appt.setReason(req.getParameter("reason"));
            appt.setStatus(req.getParameter("status"));
            appointmentDao.insert(appt);
        }
        resp.sendRedirect(req.getContextPath() + "/app/appointments");
    }
}
