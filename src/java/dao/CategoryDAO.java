package dao;

import java.sql.*;
import java.util.*;
import model.Category;

public class CategoryDAO extends DBContext {

    public List<Category> getAll() {
        List<Category> list = new ArrayList<>();
        String sql = "SELECT * FROM Categories WHERE status=1";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(new Category(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("slug"),
                        rs.getString("icon"),
                        rs.getBoolean("status")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}