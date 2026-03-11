package dao;

import java.sql.*;
import java.util.*;
import model.UserAddress;

public class UserAddressDAO extends DBContext {

    // Lấy danh sách địa chỉ của user
    public List<UserAddress> getByUser(int userId) {

        List<UserAddress> list = new ArrayList<>();

        String sql = "SELECT * FROM UserAddresses WHERE userId=?";

        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                list.add(new UserAddress(
                        rs.getInt("id"),
                        rs.getInt("userId"),
                        rs.getString("fullAddress"),
                        rs.getString("receiverName"),
                        rs.getString("receiverPhone"),
                        rs.getBoolean("isDefault")
                ));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // Thêm địa chỉ mới
    public boolean addAddress(UserAddress a) {

        String sql = "INSERT INTO UserAddresses(userId,fullAddress,receiverName,receiverPhone,isDefault) VALUES(?,?,?,?,?)";

        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, a.getUserId());
            ps.setString(2, a.getFullAddress());
            ps.setString(3, a.getReceiverName());
            ps.setString(4, a.getReceiverPhone());
            ps.setBoolean(5, a.isDefault());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // Xóa địa chỉ
    public boolean deleteAddress(int id) {

        String sql = "DELETE FROM UserAddresses WHERE id=?";

        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // Đặt địa chỉ mặc định
    public void setDefault(int userId, int addressId) {

        String reset = "UPDATE UserAddresses SET isDefault=0 WHERE userId=?";
        String set = "UPDATE UserAddresses SET isDefault=1 WHERE id=?";

        try (Connection con = getConnection()) {

            PreparedStatement ps1 = con.prepareStatement(reset);
            ps1.setInt(1, userId);
            ps1.executeUpdate();

            PreparedStatement ps2 = con.prepareStatement(set);
            ps2.setInt(1, addressId);
            ps2.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Lấy địa chỉ mặc định
    public UserAddress getDefault(int userId) {

        String sql = "SELECT * FROM UserAddresses WHERE userId=? AND isDefault=1";

        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                return new UserAddress(
                        rs.getInt("id"),
                        rs.getInt("userId"),
                        rs.getString("fullAddress"),
                        rs.getString("receiverName"),
                        rs.getString("receiverPhone"),
                        rs.getBoolean("isDefault")
                );
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }
    public boolean updateAddress(int id, String fullAddress, String receiverName, String receiverPhone) {

    String sql = "UPDATE UserAddresses SET fullAddress=?, receiverName=?, receiverPhone=? WHERE id=?";

    try (Connection con = getConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {

        ps.setString(1, fullAddress);
        ps.setString(2, receiverName);
        ps.setString(3, receiverPhone);
        ps.setInt(4, id);

        return ps.executeUpdate() > 0;

    } catch (Exception e) {
        e.printStackTrace();
    }

    return false;
}
}