package controller;

import dao.CouponDAO;
import dao.OrderDAO;
import dao.OrderDetailDAO;
import dao.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import model.CartItem;
import model.Coupon;
import model.Order;
import model.OrderDetail;
import model.User;

import java.io.IOException;
import java.util.List;

public class CheckoutServlet extends HttpServlet {

    private final OrderDAO       orderDAO       = new OrderDAO();
    private final OrderDetailDAO orderDetailDAO = new OrderDetailDAO();
    private final ProductDAO     productDAO     = new ProductDAO();
    private final CouponDAO      couponDAO      = new CouponDAO();

    /** GET: hiển thị trang checkout */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        request.getRequestDispatcher("/checkout.jsp").forward(request, response);
    }

    /** POST: xử lý đặt hàng */
    @Override
    @SuppressWarnings("unchecked")
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession(false);

        // Kiểm tra đăng nhập
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

        // Kiểm tra giỏ hàng
        if (cart == null || cart.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }

        // Lấy thông tin từ form
        String receiverName    = request.getParameter("receiverName");
        String phoneReceiver   = request.getParameter("phoneReceiver");
        String shippingAddress = request.getParameter("shippingAddress");
        String paymentMethod   = request.getParameter("paymentMethod");
        String note            = request.getParameter("note");
        String couponCode      = request.getParameter("couponCode");

        // Tính tổng tiền gốc
        double totalAmount = cart.stream().mapToDouble(CartItem::getSubtotal).sum();

        // Xử lý coupon
        double discountAmount = 0;
        Integer couponId = null;

        if (couponCode != null && !couponCode.trim().isEmpty()) {
            Coupon coupon = couponDAO.getByCode(couponCode.trim());
            if (coupon != null && totalAmount >= coupon.getMinOrderAmount()) {
                if ("percent".equalsIgnoreCase(coupon.getDiscountType())) {
                    discountAmount = totalAmount * coupon.getDiscountValue() / 100;
                } else {
                    discountAmount = coupon.getDiscountValue();
                }
                discountAmount = Math.min(discountAmount, totalAmount);
                couponId = coupon.getId();
                couponDAO.increaseUsedCount(coupon.getId());
            }
        }

        double finalAmount = totalAmount - discountAmount;

        // Tạo đơn hàng
        Order order = new Order();
        order.setUserId(user.getId());
        order.setCouponId(couponId);
        order.setDiscountAmount(discountAmount);
        order.setTotalAmount(finalAmount);
        order.setShippingAddress(shippingAddress);
        order.setPhoneReceiver(phoneReceiver);
        order.setReceiverName(receiverName);
        order.setNote(note);
        order.setPaymentMethod(paymentMethod);
        order.setPaymentStatus("Unpaid");
        order.setStatus("Pending");

        int orderId = orderDAO.insertOrder(order);

        if (orderId > 0) {
            boolean allOk = true;

            for (CartItem item : cart) {
                OrderDetail detail = new OrderDetail();
                detail.setOrderId(orderId);
                detail.setProductId(item.getProductId());
                detail.setQuantity(item.getQuantity());
                detail.setPrice(item.getPrice());
                detail.setDiscount(0);

                if (!orderDetailDAO.insertOrderDetail(detail)) {
                    allOk = false;
                    break;
                }

                // Cập nhật tồn kho
                productDAO.updateStock(item.getProductId(), item.getQuantity());
            }

            if (allOk) {
                session.removeAttribute("cart");
                session.setAttribute("successMsg", "Đặt hàng thành công! Mã đơn hàng: #" + orderId);
                response.sendRedirect(request.getContextPath() + "/orders");
                return;
            }
        }

        // Lỗi
        request.setAttribute("cart", cart);
        request.setAttribute("error", "Đặt hàng thất bại! Vui lòng thử lại.");
        request.getRequestDispatcher("/checkout.jsp").forward(request, response);
    }
}
