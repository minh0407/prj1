package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import model.CartItem;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class CartServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<CartItem> cart = getCart(request);
        double total = cart.stream().mapToDouble(CartItem::getSubtotal).sum();

        request.setAttribute("cart", cart);
        request.setAttribute("cartTotal", total);
        request.getRequestDispatcher("/cart.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "";

        switch (action) {
            case "addToCart":
                addToCart(request, response);
                break;
            case "updateQuantity":
                updateQuantity(request, response);
                break;
            case "removeItem":
                removeItem(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/cart");
        }
    }

    // ── Thêm sản phẩm vào giỏ ─────────────────────────────────────────────
    private void addToCart(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        List<CartItem> cart = getCart(request);

        int    productId   = Integer.parseInt(request.getParameter("productId"));
        String productName = request.getParameter("productName");
        String image       = request.getParameter("image");
        double price       = Double.parseDouble(request.getParameter("price"));
        int    quantity    = Integer.parseInt(request.getParameter("quantity"));
        int    stock       = Integer.parseInt(request.getParameter("stock"));

        boolean found = false;
        for (CartItem item : cart) {
            if (item.getProductId() == productId) {
                item.setQuantity(Math.min(item.getQuantity() + quantity, stock));
                found = true;
                break;
            }
        }

        if (!found) {
            cart.add(new CartItem(productId, productName, image, price, quantity, stock));
        }

        response.sendRedirect(request.getContextPath() + "/cart");
    }

    // ── Cập nhật số lượng ──────────────────────────────────────────────────
    private void updateQuantity(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        List<CartItem> cart = getCart(request);
        int productId = Integer.parseInt(request.getParameter("productId"));
        int quantity  = Integer.parseInt(request.getParameter("quantity"));

        for (CartItem item : cart) {
            if (item.getProductId() == productId) {
                if (quantity <= 0)               item.setQuantity(1);
                else if (quantity > item.getStock()) item.setQuantity(item.getStock());
                else                             item.setQuantity(quantity);
                break;
            }
        }

        response.sendRedirect(request.getContextPath() + "/cart");
    }

    // ── Xóa sản phẩm khỏi giỏ ─────────────────────────────────────────────
    private void removeItem(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        List<CartItem> cart = getCart(request);
        int productId = Integer.parseInt(request.getParameter("productId"));
        cart.removeIf(item -> item.getProductId() == productId);

        response.sendRedirect(request.getContextPath() + "/cart");
    }

    // ── Helper: lấy giỏ từ session ────────────────────────────────────────
    @SuppressWarnings("unchecked")
    private List<CartItem> getCart(HttpServletRequest request) {
        HttpSession session = request.getSession();
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
            session.setAttribute("cart", cart);
        }
        return cart;
    }
}
