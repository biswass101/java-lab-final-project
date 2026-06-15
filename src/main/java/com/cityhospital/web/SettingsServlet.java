package com.cityhospital.web;

import com.cityhospital.dao.HospitalSettingDao;
import com.cityhospital.dao.UserDao;
import com.cityhospital.model.HospitalSetting;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/app/settings")
public class SettingsServlet extends HttpServlet {
    private final HospitalSettingDao settingDao = new HospitalSettingDao();
    private final UserDao userDao = new UserDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("page", "settings");
        req.setAttribute("title", "Admin Settings");
        req.setAttribute("setting", settingDao.get());
        req.setAttribute("admin", userDao.getAdmin());
        req.getRequestDispatcher("/WEB-INF/jsp/settings.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String section = req.getParameter("section");

        if ("hospital".equals(section)) {
            HospitalSetting setting = new HospitalSetting();
            setting.setId(Integer.parseInt(req.getParameter("id")));
            setting.setHospitalName(req.getParameter("hospitalName"));
            setting.setContactNumber(req.getParameter("contactNumber"));
            setting.setAddress(req.getParameter("address"));
            setting.setEmail(req.getParameter("email"));
            settingDao.update(setting);
        } else if ("admin".equals(section)) {
            userDao.updateAdmin(
                    req.getParameter("username"),
                    req.getParameter("role"),
                    req.getParameter("newPassword")
            );
        }

        resp.sendRedirect(req.getContextPath() + "/app/settings");
    }
}
