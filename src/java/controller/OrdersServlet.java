package controller;

import dao.OrderDAO;
import dao.OrderDetailDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Order;
import model.OrderDetail;
import model.User;

import java.io.IOException;
import java.util.List;

@WebServlet("/orders")
public class OrdersServlet extends HttpServlet {

    private final OrderDAO       orderDAO       = new OrderDAO();
    private final OrderDetailDAO orderDetailDAO = new OrderDetailDAO();

    /** GET /orders — hiển thị danh sách đơn hàng của user đang đăng nhập */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Chưa đăng nhập → về trang login
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");

        // Lấy danh sách đơn hàng của user
        List<Order> orders = orderDAO.getOrdersByUserId(user.getId());
        request.setAttribute("orders", orders);

        // Lấy successMsg từ session (sau khi checkout thành công) rồi xóa ngay
        String successMsg = (String) session.getAttribute("successMsg");
        if (successMsg != null) {
            request.setAttribute("successMsg", successMsg);
            session.removeAttribute("successMsg");
        }

        // Xem chi tiết đơn hàng (nếu có param orderId)
        String orderIdParam = request.getParameter("orderId");
        if (orderIdParam != null && !orderIdParam.isEmpty()) {
            try {
                int orderId = Integer.parseInt(orderIdParam);
                // Chỉ cho xem đơn của chính mình
                Order detail = orderDAO.getOrderById(orderId);
                if (detail != null && detail.getUserId() == user.getId()) {
                    List<OrderDetail> orderDetails = orderDetailDAO.getDetailsByOrderId(orderId);
                    request.setAttribute("selectedOrder", detail);
                    request.setAttribute("orderDetails", orderDetails);
                }
            } catch (NumberFormatException ignored) {}
        }

        request.getRequestDispatcher("/userOrders.jsp").forward(request, response);
    }

    /** POST /orders — dùng để hủy đơn hàng */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        String action = request.getParameter("action");

        if ("cancel".equals(action)) {
            try {
                int orderId = Integer.parseInt(request.getParameter("orderId"));
                Order order = orderDAO.getOrderById(orderId);

                // Chỉ cho hủy đơn của chính mình và khi đơn còn ở trạng thái Pending
                if (order != null && order.getUserId() == user.getId()
                        && "Pending".equalsIgnoreCase(order.getStatus())) {
                    orderDAO.updateStatus(orderId, "Cancelled");
                    session.setAttribute("successMsg", "Đã hủy đơn hàng #" + orderId + " thành công.");
                }
            } catch (NumberFormatException ignored) {}
        }

        response.sendRedirect(request.getContextPath() + "/orders");
    }
}
