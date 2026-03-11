package controller;

import dao.UserDAO;
import model.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class LoginServlet extends HttpServlet {

    private static final int MAX_FAIL = 5;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Nếu đã login rồi thì redirect luôn
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            User user = (User) session.getAttribute("user");
            if ("admin".equals(user.getRole())) {
                response.sendRedirect(request.getContextPath() + "/admin/dashboard");
            } else {
                response.sendRedirect(request.getContextPath() + "/home");
            }
            return;
        }
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // ✅ Validate input
        if (username == null || username.trim().isEmpty()
                || password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin!");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        // ✅ Giới hạn số lần đăng nhập sai (brute force protection)
        HttpSession session = request.getSession();
        Integer failCount = (Integer) session.getAttribute("failCount");
        if (failCount == null) failCount = 0;

        if (failCount >= MAX_FAIL) {
            request.setAttribute("error", "Bạn đã nhập sai quá " + MAX_FAIL + " lần. Vui lòng thử lại sau!");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        UserDAO dao = new UserDAO();
        User user = dao.login(username.trim(), password);

        if (user != null) {
            session.removeAttribute("failCount");
            session.setAttribute("user", user);
            session.setMaxInactiveInterval(30 * 60); // session 30 phút
            if ("admin".equals(user.getRole())) {
                response.sendRedirect(request.getContextPath() + "/admin/dashboard");
            } else {
                response.sendRedirect(request.getContextPath() + "/home");
            }
        } else {
            failCount++;
            session.setAttribute("failCount", failCount);
            int remaining = MAX_FAIL - failCount;
            if (remaining > 0) {
                request.setAttribute("error", "Sai tài khoản hoặc mật khẩu! Còn " + remaining + " lần thử.");
            } else {
                request.setAttribute("error", "Bạn đã nhập sai quá " + MAX_FAIL + " lần. Vui lòng thử lại sau!");
            }
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }
}
