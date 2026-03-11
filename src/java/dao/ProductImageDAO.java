package dao;

import java.sql.*;
import java.util.*;
import model.ProductImage;

public class ProductImageDAO extends DBContext {

    public List<ProductImage> getByProduct(int productId) {
        List<ProductImage> list = new ArrayList<>();
        String sql = "SELECT * FROM ProductImages WHERE productId=? ORDER BY sortOrder";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, productId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(new ProductImage(
                        rs.getInt("id"),
                        rs.getInt("productId"),
                        rs.getString("imageUrl"),
                        rs.getInt("sortOrder")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}