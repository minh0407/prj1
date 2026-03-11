package dao;

import java.sql.*;
import model.Coupon;

public class CouponDAO extends DBContext {

    public Coupon getByCode(String code) {
        String sql = "SELECT * FROM Coupons WHERE code=? AND status=1";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, code);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return new Coupon(
                        rs.getInt("id"),
                        rs.getString("code"),
                        rs.getString("discountType"),
                        rs.getDouble("discountValue"),
                        rs.getDouble("minOrderAmount"),
                        rs.getInt("maxUsage"),
                        rs.getInt("usedCount"),
                        rs.getTimestamp("startDate"),
                        rs.getTimestamp("endDate"),
                        rs.getBoolean("status")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public void increaseUsedCount(int id) {
        String sql = "UPDATE Coupons SET usedCount = usedCount + 1 WHERE id=?";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}