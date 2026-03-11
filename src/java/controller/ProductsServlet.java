package controller;

import dao.BrandDAO;
import dao.CategoryDAO;
import dao.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

import java.io.IOException;

public class ProductsServlet extends HttpServlet {

    private int parseInt(String v, int def) {
        try { return Integer.parseInt(v); } catch (Exception e) { return def; }
    }

    private double parseDouble(String v, double def) {
        try { return Double.parseDouble(v); } catch (Exception e) { return def; }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        ProductDAO  productDAO  = new ProductDAO();
        CategoryDAO categoryDAO = new CategoryDAO();
        BrandDAO    brandDAO    = new BrandDAO();

        String keyword    = req.getParameter("keyword");
        int    categoryId = parseInt(req.getParameter("categoryId"), 0);
        int    brandId    = parseInt(req.getParameter("brandId"), 0);
        double minPrice   = parseDouble(req.getParameter("minPrice"), -1);
        double maxPrice   = parseDouble(req.getParameter("maxPrice"), -1);
        String sort       = req.getParameter("sort");
        int    page       = Math.max(1, parseInt(req.getParameter("page"), 1));
        int    pageSize   = 8;

        int totalProducts = productDAO.countProducts(keyword, categoryId, brandId, minPrice, maxPrice);
        int totalPages    = Math.max(1, (int) Math.ceil(totalProducts * 1.0 / pageSize));
        if (page > totalPages) page = totalPages;

        req.setAttribute("products",      productDAO.getProducts(keyword, categoryId, brandId, minPrice, maxPrice, sort, page, pageSize));
        req.setAttribute("categories",    categoryDAO.getAll());
        req.setAttribute("brands",        brandDAO.getAll());
        req.setAttribute("keyword",       keyword);
        req.setAttribute("categoryId",    categoryId);
        req.setAttribute("brandId",       brandId);
        req.setAttribute("minPrice",      minPrice);
        req.setAttribute("maxPrice",      maxPrice);
        req.setAttribute("sort",          sort);
        req.setAttribute("page",          page);
        req.setAttribute("totalPages",    totalPages);
        req.setAttribute("totalProducts", totalProducts);

        req.getRequestDispatcher("/products.jsp").forward(req, res);
    }
}
