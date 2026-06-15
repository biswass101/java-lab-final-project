package com.cityhospital.web;

import com.cityhospital.dao.BillDao;
import com.cityhospital.dao.PatientDao;
import com.cityhospital.model.Bill;
import com.cityhospital.util.AppUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/app/billing")
public class BillingServlet extends HttpServlet {
    private final BillDao billDao = new BillDao();
    private final PatientDao patientDao = new PatientDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("page", "billing");
        req.setAttribute("title", "Billing System");
        req.setAttribute("patients", patientDao.allForSelect());
        req.setAttribute("bills", billDao.listAll());
        req.getRequestDispatcher("/WEB-INF/jsp/billing.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String action = req.getParameter("action");
        if ("delete".equals(action)) {
            billDao.delete(AppUtil.parseInt(req.getParameter("id")));
        } else if ("update".equals(action)) {
            Bill bill = new Bill();
            bill.setId(AppUtil.parseInt(req.getParameter("id")));
            bill.setPatientId(AppUtil.parseInt(req.getParameter("patientId")));
            bill.setBillDate(req.getParameter("billDate"));
            bill.setConsultationFee(AppUtil.parseDouble(req.getParameter("consultationFee")));
            bill.setMedicineCost(AppUtil.parseDouble(req.getParameter("medicineCost")));
            bill.setServiceCharge(AppUtil.parseDouble(req.getParameter("serviceCharge")));
            bill.setTotalAmount(bill.getConsultationFee() + bill.getMedicineCost() + bill.getServiceCharge());
            bill.setPaymentStatus(req.getParameter("paymentStatus"));
            billDao.update(bill);
        } else {
            Bill bill = new Bill();
            bill.setPatientId(AppUtil.parseInt(req.getParameter("patientId")));
            bill.setBillDate(req.getParameter("billDate"));
            bill.setConsultationFee(AppUtil.parseDouble(req.getParameter("consultationFee")));
            bill.setMedicineCost(AppUtil.parseDouble(req.getParameter("medicineCost")));
            bill.setServiceCharge(AppUtil.parseDouble(req.getParameter("serviceCharge")));
            bill.setTotalAmount(bill.getConsultationFee() + bill.getMedicineCost() + bill.getServiceCharge());
            bill.setPaymentStatus(req.getParameter("paymentStatus"));
            billDao.insert(bill);
        }
        resp.sendRedirect(req.getContextPath() + "/app/billing");
    }
}
