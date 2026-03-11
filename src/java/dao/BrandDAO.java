package dao;

import java.sql.*;
import java.util.*;
import model.Brand;

public class BrandDAO extends DBContext {

    public List<Brand> getAll() {
        List<Brand> list = new ArrayList<>();
        String sql = "SELECT * FROM Brands WHERE status=1";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(new Brand(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("logo"),
                        rs.getString("country"),
                        rs.getBoolean("status")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}