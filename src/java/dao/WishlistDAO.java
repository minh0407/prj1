package dao;

import java.sql.*;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Product;

public class WishlistDAO extends DBContext {

    private static final Logger LOGGER = Logger.getLogger(WishlistDAO.class.getName());

    /**
     * Lấy danh sách sản phẩm trong wishlist của user
     */
    public List<Product> getByUser(int userId) {
        String sql = "SELECT p.*, b.name AS brandName, c.name AS categoryName " +
                     "FROM Wishlist w " +
                     "JOIN Products p ON w.productId = p.id " +
                     "LEFT JOIN Brands b ON p.brandId = b.id " +
                     "LEFT JOIN Categories c ON p.categoryId = c.id " +
                     "WHERE w.userId = ? " +
                     "ORDER BY w.id DESC";
        List<Product> list = new ArrayList<>();
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Product p = new Product();
                    p.setId(rs.getInt("id"));
                    p.setName(rs.getString("name"));
                    p.setSlug(rs.getString("slug"));
                    p.setDescription(rs.getString("description"));
                    p.setPrice(rs.getDouble("price"));
                    p.setStock(rs.getInt("stock"));
                    p.setSold(rs.getInt("sold"));
                    p.setImage(rs.getString("image"));
                    p.setDiscount(rs.getDouble("discount"));
                    p.setWarranty(rs.getInt("warranty"));
                    p.setIsFeatured(rs.getBoolean("isFeatured"));
                    p.setStatus(rs.getBoolean("status"));
                    java.sql.Timestamp ts = rs.getTimestamp("createdDate");
                    p.setCreatedDate(ts != null ? ts.toLocalDateTime() : null);
                    p.setCategoryId(rs.getInt("categoryId"));
                    p.setBrandId(rs.getInt("brandId"));
                    p.setBrandName(rs.getString("brandName"));
                    p.setCategoryName(rs.getString("categoryName"));
                    list.add(p);
                }
            }
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "getByUser error", e);
        }
        return list;
    }

    /**
     * Kiểm tra sản phẩm đã có trong wishlist chưa
     */
    public boolean exists(int userId, int productId) {
        String sql = "SELECT COUNT(*) FROM Wishlist WHERE userId=? AND productId=?";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, productId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1) > 0;
            }
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "exists error", e);
        }
        return false;
    }

    /**
     * Thêm sản phẩm vào wishlist (bỏ qua nếu đã tồn tại)
     */
    public void add(int userId, int productId) {
        if (exists(userId, productId)) return;
        String sql = "INSERT INTO Wishlist(userId, productId) VALUES(?, ?)";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, productId);
            ps.executeUpdate();
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "add error", e);
        }
    }

    /**
     * Xóa sản phẩm khỏi wishlist
     */
    public void remove(int userId, int productId) {
        String sql = "DELETE FROM Wishlist WHERE userId=? AND productId=?";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, productId);
            ps.executeUpdate();
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "remove error", e);
        }
    }

    /**
     * Đếm số sản phẩm trong wishlist của user
     */
    public int countByUser(int userId) {
        String sql = "SELECT COUNT(*) FROM Wishlist WHERE userId=?";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
            }
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "countByUser error", e);
        }
        return 0;
    }
}