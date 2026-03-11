package controller;

import dao.UserDAO;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

import java.io.IOException;

public class ProfileServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        req.setAttribute("user", session.getAttribute("user"));
        req.getRequestDispatcher("/profile.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        User user     = (User) session.getAttribute("user");
        String fullname = req.getParameter("fullname");
        String email    = req.getParameter("email");
        String phone    = req.getParameter("phone");

        UserDAO dao   = new UserDAO();
        boolean ok    = dao.updateUser(user.getId(), fullname, email, phone);

        if (ok) {
            user.setFullname(fullname);
            user.setEmail(email);
            user.setPhone(phone);
            session.setAttribute("user", user);
            req.setAttribute("message", "Cập nhật thông tin thành công!");
        } else {
            req.setAttribute("error", "Cập nhật thất bại! Vui lòng thử lại.");
        }

        req.setAttribute("user", user);
        req.getRequestDispatcher("/profile.jsp").forward(req, res);
    }
}
