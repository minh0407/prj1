package controller;

import dao.ReportDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

import java.io.IOException;

public class AdminReportsServlet extends HttpServlet {

    private final ReportDAO reportDAO = new ReportDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("totalRevenue",  reportDAO.getTotalRevenue());
        request.setAttribute("orderCount",    reportDAO.getOrderCount());
        request.setAttribute("productCount",  reportDAO.getProductCount());
        request.setAttribute("userCount",     reportDAO.getUserCount());
        request.setAttribute("maxPrice",      reportDAO.getMaxPrice());
        request.setAttribute("minPrice",      reportDAO.getMinPrice());
        request.setAttribute("avgPrice",      reportDAO.getAvgPrice());

        request.getRequestDispatcher("/admin/reports.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
