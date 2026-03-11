package controller;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import model.User;

public class AdminCustomersServlet extends HttpServlet {

    private final UserDAO dao = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "list";

        switch (action) {

            case "lock":
                // Khóa tài khoản (status → false)
                int lockId = Integer.parseInt(request.getParameter("id"));
                dao.lockUser(lockId, true);
                response.sendRedirect(request.getContextPath() + "/admin/customers");
                break;

            case "unlock":
                // Mở khóa tài khoản (status → true)
                int unlockId = Integer.parseInt(request.getParameter("id"));
                dao.lockUser(unlockId, false);
                response.sendRedirect(request.getContextPath() + "/admin/customers");
                break;

            default: // list
                List<User> users = dao.getAllUsers();
                request.setAttribute("users", users);
                request.getRequestDispatcher("/admin/customers.jsp").forward(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
