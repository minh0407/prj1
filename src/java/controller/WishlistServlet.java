package controller;

import dao.WishlistDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import model.Product;
import model.User;

import java.io.IOException;
import java.util.List;

public class WishlistServlet extends HttpServlet {

    private final WishlistDAO wishlistDAO = new WishlistDAO();

    /**
     * GET /wishlist  → hiển thị trang danh sách yêu thích
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User user = (User) request.getSession().getAttribute("user");

        if (user == null) {
            // Chưa đăng nhập → chuyển sang trang login
            response.sendRedirect(request.getContextPath() + "/login?redirect=wishlist");
            return;
        }

        List<Product> wishlist = wishlistDAO.getByUser(user.getId());
        int wishlistCount = wishlist.size();

        request.setAttribute("wishlist", wishlist);
        request.setAttribute("wishlistCount", wishlistCount);
        request.getRequestDispatcher("/wishlist.jsp").forward(request, response);
    }

    /**
     * POST /wishlist  → thêm hoặc xóa sản phẩm
     *   action=add    productId=?
     *   action=remove productId=?
     *   action=toggle productId=?   (dùng cho nút ❤️ trên product cards)
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User user = (User) request.getSession().getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login?redirect=wishlist");
            return;
        }

        String action    = request.getParameter("action");
        String productIdStr = request.getParameter("productId");
        String redirectTo   = request.getParameter("redirect"); // trang trả về sau action

        if (action == null || productIdStr == null) {
            response.sendRedirect(request.getContextPath() + "/wishlist");
            return;
        }

        int productId;
        try {
            productId = Integer.parseInt(productIdStr);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/wishlist");
            return;
        }

        switch (action) {
            case "add":
                wishlistDAO.add(user.getId(), productId);
                break;
            case "remove":
                wishlistDAO.remove(user.getId(), productId);
                break;
            case "toggle":
                if (wishlistDAO.exists(user.getId(), productId)) {
                    wishlistDAO.remove(user.getId(), productId);
                } else {
                    wishlistDAO.add(user.getId(), productId);
                }
                break;
            default:
                break;
        }

        // Quay lại trang gọi (ví dụ: productdetail) hoặc về wishlist
        if (redirectTo != null && !redirectTo.isEmpty()) {
            response.sendRedirect(redirectTo);
        } else if ("remove".equals(action)) {
            response.sendRedirect(request.getContextPath() + "/wishlist");
        } else {
            // Sau khi add/toggle từ trang sản phẩm, quay lại trang trước
            String referer = request.getHeader("Referer");
            if (referer != null && !referer.isEmpty()) {
                response.sendRedirect(referer);
            } else {
                response.sendRedirect(request.getContextPath() + "/wishlist");
            }
        }
    }
}