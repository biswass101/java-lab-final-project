package com.cityhospital.web;

import com.cityhospital.dao.SearchDao;
import com.cityhospital.model.SearchResult;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/app/search")
public class SearchServlet extends HttpServlet {
    private final SearchDao searchDao = new SearchDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String q = req.getParameter("q");
        String type = req.getParameter("type");
        List<SearchResult> results = searchDao.search(q, type);

        if ("json".equalsIgnoreCase(req.getParameter("format"))) {
            writeJson(resp, results);
            return;
        }

        req.setAttribute("page", "search");
        req.setAttribute("title", "Search Records");
        req.setAttribute("q", q == null ? "" : q);
        req.setAttribute("type", type == null ? "" : type);
        req.setAttribute("results", results);
        req.getRequestDispatcher("/WEB-INF/jsp/search.jsp").forward(req, resp);
    }

    private void writeJson(HttpServletResponse resp, List<SearchResult> results) throws IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        StringBuilder json = new StringBuilder();
        json.append("{\"results\":[");
        for (int i = 0; i < results.size(); i++) {
            SearchResult r = results.get(i);
            if (i > 0) {
                json.append(',');
            }
            json.append('{')
                    .append("\"type\":\"").append(escapeJson(r.getType())).append("\",")
                    .append("\"recordId\":\"").append(escapeJson(r.getRecordId())).append("\",")
                    .append("\"name\":\"").append(escapeJson(r.getName())).append("\",")
                    .append("\"date\":\"").append(escapeJson(r.getDate())).append("\",")
                    .append("\"detail\":\"").append(escapeJson(r.getDetail())).append("\"")
                    .append('}');
        }
        json.append("]}");
        resp.getWriter().write(json.toString());
    }

    private String escapeJson(String value) {
        if (value == null) {
            return "";
        }
        return value
                .replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\n", "\\n")
                .replace("\r", "\\r")
                .replace("\t", "\\t");
    }
}
