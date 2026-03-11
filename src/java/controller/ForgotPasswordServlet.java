package controller;

import dao.UserDAO;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

import java.io.IOException;

public class ForgotPasswordServlet extends HttpServlet {

    /** GET: Hiển thị form quên mật khẩu */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/forgot.jsp").forward(request, response);
    }

    /** POST: Xác minh username + email rồi đặt lại mật khẩu */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username    = request.getParameter("username");
        String email       = request.getParameter("email");
        String newPassword = request.getParameter("newPassword");
        String confirmPass = request.getParameter("confirmPassword");

        // Validate
        if (username == null || username.trim().isEmpty()
                || email == null || email.trim().isEmpty()
                || newPassword == null || newPassword.isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin!");
            request.getRequestDispatcher("/forgot.jsp").forward(request, response);
            return;
        }

        if (newPassword.length() < 6) {
            request.setAttribute("error", "Mật khẩu mới phải có ít nhất 6 ký tự!");
            request.getRequestDispatcher("/forgot.jsp").forward(request, response);
            return;
        }

        if (!newPassword.equals(confirmPass)) {
            request.setAttribute("error", "Mật khẩu xác nhận không khớp!");
            request.getRequestDispatcher("/forgot.jsp").forward(request, response);
            return;
        }

        UserDAO dao  = new UserDAO();
        User    user = dao.checkUserByUsernameAndEmail(username.trim(), email.trim());

        if (user == null) {
            request.setAttribute("error", "Tên đăng nhập hoặc email không đúng!");
            request.getRequestDispatcher("/forgot.jsp").forward(request, response);
            return;
        }

        // Đặt lại mật khẩu: truyền oldPassword bất kỳ nhưng dùng trực tiếp SQL reset
        boolean ok = dao.resetPassword(user.getId(), newPassword);

        if (ok) {
            request.setAttribute("message", "Đặt lại mật khẩu thành công! Vui lòng đăng nhập.");
        } else {
            request.setAttribute("error", "Có lỗi xảy ra! Vui lòng thử lại.");
        }
        request.getRequestDispatcher("/forgot.jsp").forward(request, response);
    }
}
