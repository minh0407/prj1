package controller;

import dao.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Date;
import java.util.List;
import model.Product;

public class AdminProductsServlet extends HttpServlet {

    private final ProductDAO dao = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "list";

        switch (action) {

            case "new":
                // Hiển thị form thêm mới (không set attribute "product")
                request.getRequestDispatcher("/admin/products.jsp").forward(request, response);
                break;

            case "edit":
                int id = Integer.parseInt(request.getParameter("id"));
                Product product = dao.getById(id);
                request.setAttribute("product", product);
                request.getRequestDispatcher("/admin/products.jsp").forward(request, response);
                break;

            case "delete":
                int deleteId = Integer.parseInt(request.getParameter("id"));
                dao.delete(deleteId);   // soft delete: status = 0
                response.sendRedirect(request.getContextPath() + "/admin/products");
                break;

            default: // list
                List<Product> list = dao.getAll();
                request.setAttribute("list", list);
                request.getRequestDispatcher("/admin/products.jsp").forward(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam      = request.getParameter("id");
        String name         = request.getParameter("name");
        String slug         = request.getParameter("slug");
        String description  = request.getParameter("description");
        double price        = Double.parseDouble(request.getParameter("price"));
        int    stock        = Integer.parseInt(request.getParameter("stock"));
        String image        = request.getParameter("image");
        double discount     = Double.parseDouble(request.getParameter("discount"));
        int    warranty     = Integer.parseInt(request.getParameter("warranty"));
        boolean isFeatured  = request.getParameter("isFeatured") != null;
        boolean status      = request.getParameter("status")     != null;
        int    categoryId   = Integer.parseInt(request.getParameter("categoryId"));
        int    brandId      = Integer.parseInt(request.getParameter("brandId"));

        if (idParam == null || idParam.isEmpty()) {
            // INSERT
            Product p = new Product(0, name, slug, description,
                    price, stock, 0, image,
                    discount, warranty, isFeatured, true,
                    new Date(), categoryId, brandId);
            dao.insert(p);
        } else {
            // UPDATE
            Product p = new Product(Integer.parseInt(idParam),
                    name, slug, description,
                    price, stock, 0, image,
                    discount, warranty, isFeatured, status,
                    null, categoryId, brandId);
            dao.update(p);
        }

        response.sendRedirect(request.getContextPath() + "/admin/products");
    }
}
