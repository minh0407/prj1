package filter;

import dao.CategoryDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

/**
 * Tự động set attribute "categories" cho mọi request
 * để header.jsp luôn hiển thị nav category đúng.
 */
public class CategoryFilter implements Filter {

    @Override
    public void init(FilterConfig fc) throws ServletException {}

    @Override
    public void doFilter(ServletRequest request, ServletResponse response,
                         FilterChain chain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        // Chỉ inject cho request HTML (không cần cho static resources)
        String uri = req.getRequestURI();
        if (!uri.contains(".") || uri.endsWith(".jsp")) {
            if (req.getAttribute("categories") == null) {
                req.setAttribute("categories", new CategoryDAO().getAll());
            }
        }
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {}
}
