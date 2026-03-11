package controller;

import dao.UserDAO;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

import java.io.IOException;

public class ChangePasswordServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user           = (User) session.getAttribute("user");
        String oldPassword  = request.getParameter("oldPassword");
        String newPassword  = request.getParameter("newPassword");
        String confirmPass  = request.getParameter("confirmPassword");

        if (!newPassword.equals(confirmPass)) {
            request.setAttribute("error", "Mật khẩu xác nhận không khớp!");
            request.setAttribute("user", user);
            request.getRequestDispatcher("/profile.jsp").forward(request, response);
            return;
        }

        if (newPassword.length() < 6) {
            request.setAttribute("error", "Mật khẩu mới phải có ít nhất 6 ký tự!");
            request.setAttribute("user", user);
            request.getRequestDispatcher("/profile.jsp").forward(request, response);
            return;
        }

        UserDAO dao = new UserDAO();
        boolean ok  = dao.changePassword(user.getId(), oldPassword, newPassword);

        if (ok) {
            request.setAttribute("message", "Đổi mật khẩu thành công!");
        } else {
            request.setAttribute("error", "Mật khẩu cũ không chính xác!");
        }

        request.setAttribute("user", user);
        request.getRequestDispatcher("/profile.jsp").forward(request, response);
    }
}
