package controller;

import dao.UserDAO;
import model.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class RegisterServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String fullname = request.getParameter("fullname");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");

        // ✅ Validate input phía server
        if (username == null || username.trim().length() < 4) {
            request.setAttribute("error", "Tên đăng nhập phải có ít nhất 4 ký tự!");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }
        if (password == null || password.length() < 6) {
            request.setAttribute("error", "Mật khẩu phải có ít nhất 6 ký tự!");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }
        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Mật khẩu xác nhận không khớp!");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }
        if (email == null || !email.matches("^[\\w.-]+@[\\w.-]+\\.[a-zA-Z]{2,}$")) {
            request.setAttribute("error", "Email không hợp lệ!");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        UserDAO dao = new UserDAO();

        // ✅ Kiểm tra username đã tồn tại
        if (dao.isUsernameExist(username.trim())) {
            request.setAttribute("error", "Tên đăng nhập đã được sử dụng!");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        // ✅ Kiểm tra email đã tồn tại
        if (dao.isEmailExist(email.trim())) {
            request.setAttribute("error", "Email đã được sử dụng!");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        User user = new User();
        user.setUsername(username.trim());
        user.setPassword(password);
        user.setFullname(fullname != null ? fullname.trim() : "");
        user.setEmail(email.trim());
        user.setPhone(phone != null ? phone.trim() : "");

        boolean success = dao.register(user);
        if (success) {
            request.setAttribute("message", "Đăng ký thành công! Vui lòng đăng nhập.");
            response.sendRedirect("login?registered=true");
        } else {
            request.setAttribute("error", "Đăng ký thất bại! Vui lòng thử lại.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        }
    }
}
