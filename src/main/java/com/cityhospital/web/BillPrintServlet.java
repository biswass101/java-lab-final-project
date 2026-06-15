package com.cityhospital.web;

import com.cityhospital.dao.BillDao;
import com.cityhospital.model.Bill;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/app/billing/print")
public class BillPrintServlet extends HttpServlet {
    private final BillDao billDao = new BillDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id;
        try {
            id = Integer.parseInt(req.getParameter("id"));
        } catch (Exception e) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid bill id");
            return;
        }

        Bill bill = billDao.findById(id);
        if (bill == null) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Bill not found");
            return;
        }

        req.setAttribute("bill", bill);
        req.getRequestDispatcher("/WEB-INF/jsp/bill-print.jsp").forward(req, resp);
    }
}
