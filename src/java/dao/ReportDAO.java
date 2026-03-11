package dao;

import java.sql.*;

public class ReportDAO extends DBContext {

    /** Tổng doanh thu từ đơn đã hoàn thành */
    public double getTotalRevenue() {
        String sql = "SELECT ISNULL(SUM(totalAmount),0) FROM Orders WHERE status='Completed'";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getDouble(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

    /** Tổng số đơn hàng */
    public int getOrderCount() {
        String sql = "SELECT COUNT(*) FROM Orders";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

    /** Tổng số sản phẩm đang bán */
    public int getProductCount() {
        String sql = "SELECT COUNT(*) FROM Products WHERE status=1";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

    /** Tổng số khách hàng */
    public int getUserCount() {
        String sql = "SELECT COUNT(*) FROM Users WHERE role='user'";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

    /** Giá sản phẩm cao nhất */
    public double getMaxPrice() {
        String sql = "SELECT ISNULL(MAX(price),0) FROM Products WHERE status=1";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getDouble(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

    /** Giá sản phẩm thấp nhất */
    public double getMinPrice() {
        String sql = "SELECT ISNULL(MIN(price),0) FROM Products WHERE status=1";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getDouble(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

    /** Giá sản phẩm trung bình */
    public double getAvgPrice() {
        String sql = "SELECT ISNULL(AVG(price),0) FROM Products WHERE status=1";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getDouble(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }
}
