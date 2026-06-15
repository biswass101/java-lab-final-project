package com.cityhospital.web;

import com.cityhospital.dao.DoctorDao;
import com.cityhospital.dao.PatientDao;
import com.cityhospital.dao.PrescriptionDao;
import com.cityhospital.model.Prescription;
import com.cityhospital.model.PrescriptionItem;
import com.cityhospital.util.AppUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/app/prescriptions")
public class PrescriptionsServlet extends HttpServlet {
    private final PrescriptionDao prescriptionDao = new PrescriptionDao();
    private final PatientDao patientDao = new PatientDao();
    private final DoctorDao doctorDao = new DoctorDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("page", "prescriptions");
        req.setAttribute("title", "Prescriptions");
        req.setAttribute("patients", patientDao.allForSelect());
        req.setAttribute("doctors", doctorDao.allForSelect());
        req.setAttribute("prescriptions", prescriptionDao.listAll());
        req.getRequestDispatcher("/WEB-INF/jsp/prescriptions.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String action = req.getParameter("action");
        if ("delete".equals(action)) {
            prescriptionDao.delete(AppUtil.parseInt(req.getParameter("id")));
        } else if ("update".equals(action)) {
            Prescription p = new Prescription();
            p.setId(AppUtil.parseInt(req.getParameter("id")));
            p.setPatientId(AppUtil.parseInt(req.getParameter("patientId")));
            p.setDoctorId(AppUtil.parseInt(req.getParameter("doctorId")));
            p.setPrescriptionDate(req.getParameter("prescriptionDate"));
            p.setDiagnosis(req.getParameter("diagnosis"));
            p.setInstructions(req.getParameter("instructions"));
            prescriptionDao.update(p, parseItems(req));
        } else {
            Prescription p = new Prescription();
            p.setPatientId(AppUtil.parseInt(req.getParameter("patientId")));
            p.setDoctorId(AppUtil.parseInt(req.getParameter("doctorId")));
            p.setPrescriptionDate(req.getParameter("prescriptionDate"));
            p.setDiagnosis(req.getParameter("diagnosis"));
            p.setInstructions(req.getParameter("instructions"));
            prescriptionDao.insert(p, parseItems(req));
        }
        resp.sendRedirect(req.getContextPath() + "/app/prescriptions");
    }

    private List<PrescriptionItem> parseItems(HttpServletRequest req) {
        String[] meds = req.getParameterValues("medicineName[]");
        String[] doses = req.getParameterValues("dosage[]");
        if (meds == null) {
            meds = req.getParameterValues("medicineName");
            doses = req.getParameterValues("dosage");
        }

        List<PrescriptionItem> list = new ArrayList<>();
        if (meds == null) {
            return list;
        }
        for (int i = 0; i < meds.length; i++) {
            String med = meds[i] == null ? "" : meds[i].trim();
            String dose = (doses != null && i < doses.length && doses[i] != null) ? doses[i].trim() : "";
            if (med.isBlank()) {
                continue;
            }
            list.add(new PrescriptionItem(med, dose));
        }
        return list;
    }
}
