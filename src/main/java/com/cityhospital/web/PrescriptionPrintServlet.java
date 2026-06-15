package com.cityhospital.web;

import com.cityhospital.dao.PrescriptionDao;
import com.cityhospital.model.Prescription;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/app/prescriptions/print")
public class PrescriptionPrintServlet extends HttpServlet {
    private final PrescriptionDao prescriptionDao = new PrescriptionDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id;
        try {
            id = Integer.parseInt(req.getParameter("id"));
        } catch (Exception e) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid prescription id");
            return;
        }

        Prescription p = prescriptionDao.findById(id);
        if (p == null) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Prescription not found");
            return;
        }

        req.setAttribute("prescription", p);
        req.getRequestDispatcher("/WEB-INF/jsp/prescription-print.jsp").forward(req, resp);
    }
}
