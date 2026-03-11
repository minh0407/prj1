package controller;

import dao.BrandDAO;
import dao.CategoryDAO;
import dao.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

import java.io.IOException;

public class HomeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        ProductDAO  productDAO  = new ProductDAO();
        CategoryDAO categoryDAO = new CategoryDAO();
        BrandDAO    brandDAO    = new BrandDAO();

        req.setAttribute("categories",         categoryDAO.getAll());
        req.setAttribute("brands",             brandDAO.getAll());
        req.setAttribute("flashSaleProducts",  productDAO.getFlashSaleProducts(6));
        req.setAttribute("featuredProducts",   productDAO.getFeaturedProducts(8));
        req.setAttribute("newProducts",        productDAO.getNewProducts(8));
        req.setAttribute("bestSellerProducts", productDAO.getBestSellerProducts(8));

        req.getRequestDispatcher("/home.jsp").forward(req, res);
    }
}
