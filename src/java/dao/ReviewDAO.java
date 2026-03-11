package dao;

import java.sql.*;

public class ReviewDAO extends DBContext {

    public void insert(int userId, int productId, int rating, String comment) {
        String sql = "INSERT INTO Reviews(userId,productId,rating,comment) VALUES(?,?,?,?)";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.setInt(2, productId);
            ps.setInt(3, rating);
            ps.setString(4, comment);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}