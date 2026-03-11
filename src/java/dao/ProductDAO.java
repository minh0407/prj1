package dao;

import java.sql.*;
import java.util.*;
import model.Product;

public class ProductDAO extends DBContext {

    // ─────────────────────────────────────────────────────────────
    //  TRANG HOME
    // ─────────────────────────────────────────────────────────────

    public List<Product> getFlashSaleProducts(int limit) {
        String sql = "SELECT TOP(?) p.*, b.name AS brandName, c.name AS categoryName " +
                     "FROM Products p " +
                     "LEFT JOIN Brands b ON p.brandId=b.id " +
                     "LEFT JOIN Categories c ON p.categoryId=c.id " +
                     "WHERE p.status=1 AND p.discount>0 ORDER BY p.discount DESC";
        return queryList(sql, limit);
    }

    public List<Product> getFeaturedProducts(int limit) {
        String sql = "SELECT TOP(?) p.*, b.name AS brandName, c.name AS categoryName " +
                     "FROM Products p " +
                     "LEFT JOIN Brands b ON p.brandId=b.id " +
                     "LEFT JOIN Categories c ON p.categoryId=c.id " +
                     "WHERE p.status=1 AND p.isFeatured=1 ORDER BY p.createdDate DESC";
        return queryList(sql, limit);
    }

    public List<Product> getNewProducts(int limit) {
        String sql = "SELECT TOP(?) p.*, b.name AS brandName, c.name AS categoryName " +
                     "FROM Products p " +
                     "LEFT JOIN Brands b ON p.brandId=b.id " +
                     "LEFT JOIN Categories c ON p.categoryId=c.id " +
                     "WHERE p.status=1 ORDER BY p.createdDate DESC";
        return queryList(sql, limit);
    }

    public List<Product> getBestSellerProducts(int limit) {
        String sql = "SELECT TOP(?) p.*, b.name AS brandName, c.name AS categoryName " +
                     "FROM Products p " +
                     "LEFT JOIN Brands b ON p.brandId=b.id " +
                     "LEFT JOIN Categories c ON p.categoryId=c.id " +
                     "WHERE p.status=1 ORDER BY p.sold DESC";
        return queryList(sql, limit);
    }

    // ─────────────────────────────────────────────────────────────
    //  TRANG PRODUCTS (filter + phân trang)
    // ─────────────────────────────────────────────────────────────

    public int countProducts(String keyword, int categoryId, int brandId,
                             double minPrice, double maxPrice) {
        StringBuilder sql = new StringBuilder(
                "SELECT COUNT(*) FROM Products p WHERE p.status=1");
        List<Object> params = buildFilter(sql, keyword, categoryId, brandId, minPrice, maxPrice);
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql.toString())) {
            setParams(ps, params);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

    public List<Product> getProducts(String keyword, int categoryId, int brandId,
                                     double minPrice, double maxPrice,
                                     String sort, int page, int pageSize) {
        StringBuilder sql = new StringBuilder(
                "SELECT p.*, b.name AS brandName, c.name AS categoryName " +
                "FROM Products p " +
                "LEFT JOIN Brands b ON p.brandId=b.id " +
                "LEFT JOIN Categories c ON p.categoryId=c.id " +
                "WHERE p.status=1");
        List<Object> params = buildFilter(sql, keyword, categoryId, brandId, minPrice, maxPrice);

        // FIX: sort key khớp với JSP option values
        if ("price_asc".equals(sort))       sql.append(" ORDER BY p.price ASC");
        else if ("price_desc".equals(sort)) sql.append(" ORDER BY p.price DESC");
        else if ("new".equals(sort))        sql.append(" ORDER BY p.createdDate DESC");
        else if ("sold".equals(sort))       sql.append(" ORDER BY p.sold DESC");
        else if ("discount".equals(sort))   sql.append(" ORDER BY p.discount DESC");
        else                                sql.append(" ORDER BY p.id DESC");

        int offset = (page - 1) * pageSize;
        sql.append(" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        params.add(offset);
        params.add(pageSize);

        List<Product> list = new ArrayList<>();
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql.toString())) {
            setParams(ps, params);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(extractProduct(rs));
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    // ─────────────────────────────────────────────────────────────
    //  CÁC PHƯƠNG THỨC CƠ BẢN
    // ─────────────────────────────────────────────────────────────

    public List<Product> getAll() {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT p.*, b.name AS brandName, c.name AS categoryName " +
                     "FROM Products p " +
                     "LEFT JOIN Brands b ON p.brandId=b.id " +
                     "LEFT JOIN Categories c ON p.categoryId=c.id " +
                     "WHERE p.status=1 ORDER BY p.createdDate DESC";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) list.add(extractProduct(rs));
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public Product getById(int id) {
        String sql = "SELECT p.*, b.name AS brandName, c.name AS categoryName " +
                     "FROM Products p " +
                     "LEFT JOIN Brands b ON p.brandId=b.id " +
                     "LEFT JOIN Categories c ON p.categoryId=c.id " +
                     "WHERE p.id=?";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return extractProduct(rs);
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

    public List<Product> getRelatedProducts(int categoryId, int excludeId, int limit) {
        String sql = "SELECT TOP(?) p.*, b.name AS brandName, c.name AS categoryName " +
                     "FROM Products p " +
                     "LEFT JOIN Brands b ON p.brandId=b.id " +
                     "LEFT JOIN Categories c ON p.categoryId=c.id " +
                     "WHERE p.status=1 AND p.categoryId=? AND p.id<>? ORDER BY p.sold DESC";
        List<Product> list = new ArrayList<>();
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, limit);
            ps.setInt(2, categoryId);
            ps.setInt(3, excludeId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(extractProduct(rs));
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public int countAll() {
        String sql = "SELECT COUNT(*) FROM Products WHERE status=1";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

    public boolean insert(Product p) {
        String sql = "INSERT INTO Products " +
                "(name,slug,description,price,stock,sold,image,discount,warranty,isFeatured,status,createdDate,categoryId,brandId) " +
                "VALUES(?,?,?,?,?,?,?,?,?,?,?,GETDATE(),?,?)";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, p.getName());
            ps.setString(2, p.getSlug());
            ps.setString(3, p.getDescription());
            ps.setDouble(4, p.getPrice());
            ps.setInt(5, p.getStock());
            ps.setInt(6, 0);
            ps.setString(7, p.getImage());
            ps.setDouble(8, p.getDiscount());
            ps.setInt(9, p.getWarranty());
            ps.setBoolean(10, p.isIsFeatured());
            ps.setBoolean(11, true);
            ps.setInt(12, p.getCategoryId());
            ps.setInt(13, p.getBrandId());
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

    public boolean update(Product p) {
        String sql = "UPDATE Products SET " +
                "name=?,slug=?,description=?,price=?,stock=?,image=?,discount=?,warranty=?,isFeatured=?,status=?,categoryId=?,brandId=? " +
                "WHERE id=?";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, p.getName());
            ps.setString(2, p.getSlug());
            ps.setString(3, p.getDescription());
            ps.setDouble(4, p.getPrice());
            ps.setInt(5, p.getStock());
            ps.setString(6, p.getImage());
            ps.setDouble(7, p.getDiscount());
            ps.setInt(8, p.getWarranty());
            ps.setBoolean(9, p.isIsFeatured());
            ps.setBoolean(10, p.isStatus());
            ps.setInt(11, p.getCategoryId());
            ps.setInt(12, p.getBrandId());
            ps.setInt(13, p.getId());
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

    public boolean delete(int id) {
        String sql = "UPDATE Products SET status=0 WHERE id=?";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

    public boolean updateStock(int productId, int quantity) {
        String sql = "UPDATE Products SET stock=stock-?, sold=sold+? WHERE id=? AND stock>=?";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, quantity);
            ps.setInt(2, quantity);
            ps.setInt(3, productId);
            ps.setInt(4, quantity);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

    // ─────────────────────────────────────────────────────────────
    //  HELPERS
    // ─────────────────────────────────────────────────────────────

    private List<Object> buildFilter(StringBuilder sql, String keyword,
                                     int categoryId, int brandId,
                                     double minPrice, double maxPrice) {
        List<Object> params = new ArrayList<>();
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND p.name LIKE ?");
            params.add("%" + keyword.trim() + "%");
        }
        if (categoryId > 0) { sql.append(" AND p.categoryId=?"); params.add(categoryId); }
        if (brandId > 0)    { sql.append(" AND p.brandId=?");    params.add(brandId);    }
        // FIX: chỉ filter giá khi người dùng thực sự nhập (> 0), không phải default -1
        if (minPrice > 0)   { sql.append(" AND p.price>=?");     params.add(minPrice);   }
        if (maxPrice > 0)   { sql.append(" AND p.price<=?");     params.add(maxPrice);   }
        return params;
    }

    private void setParams(PreparedStatement ps, List<Object> params) throws Exception {
        for (int i = 0; i < params.size(); i++) ps.setObject(i + 1, params.get(i));
    }

    private List<Product> queryList(String sql, int limit) {
        List<Product> list = new ArrayList<>();
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, limit);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(extractProduct(rs));
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    private Product extractProduct(ResultSet rs) throws Exception {
        Product p = new Product(
                rs.getInt("id"),
                rs.getString("name"),
                rs.getString("slug"),
                rs.getString("description"),
                rs.getDouble("price"),
                rs.getInt("stock"),
                rs.getInt("sold"),
                rs.getString("image"),
                rs.getDouble("discount"),
                rs.getInt("warranty"),
                rs.getBoolean("isFeatured"),
                rs.getBoolean("status"),
                rs.getTimestamp("createdDate"),
                rs.getInt("categoryId"),
                rs.getInt("brandId")
        );
        // Lấy brandName và categoryName từ JOIN
        try { p.setBrandName(rs.getString("brandName")); } catch (Exception ignored) {}
        try { p.setCategoryName(rs.getString("categoryName")); } catch (Exception ignored) {}
        return p;
    }
}
