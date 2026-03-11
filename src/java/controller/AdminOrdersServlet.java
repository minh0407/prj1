package controller;

import dao.OrderDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

import java.io.IOException;

public class AdminOrdersServlet extends HttpServlet {

    private final OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "updateStatus":
                int orderId = Integer.parseInt(request.getParameter("id"));
                String status = request.getParameter("status");
                orderDAO.updateStatus(orderId, status);
                response.sendRedirect(request.getContextPath() + "/admin/orders");
                break;

            default: // list
                request.setAttribute("orders", orderDAO.getAllOrders());
                request.getRequestDispatcher("/admin/orders.jsp").forward(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");
        String status  = request.getParameter("status");

        if (idParam != null && status != null) {
            orderDAO.updateStatus(Integer.parseInt(idParam), status);
        }

        response.sendRedirect(request.getContextPath() + "/admin/orders");
    }
}
