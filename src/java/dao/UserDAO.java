package dao;

import java.sql.*;
import java.util.*;
import model.User;

public class UserDAO extends DBContext {

    /** Đăng nhập - mật khẩu MD5 */
    public User login(String username, String password) {
        String sql = "SELECT * FROM Users WHERE username=? AND password=? AND status=1";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return extractUser(rs);
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

    /** Đăng ký tài khoản mới */
    public boolean register(User user) {
        String sql = "INSERT INTO Users(username,password,fullname,email,phone,role) VALUES(?,?,?,?,?,?)";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getFullname());
            ps.setString(4, user.getEmail());
            ps.setString(5, user.getPhone());
            ps.setString(6, "user");
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

    /** Kiểm tra username đã tồn tại */
    public boolean isUsernameExist(String username) {
        String sql = "SELECT COUNT(*) FROM Users WHERE username=?";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1) > 0;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

    /** Kiểm tra email đã tồn tại */
    public boolean isEmailExist(String email) {
        String sql = "SELECT COUNT(*) FROM Users WHERE email=?";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1) > 0;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

    /** Đổi mật khẩu */
    public boolean changePassword(int userId, String oldPassword, String newPassword) {
        String sql = "UPDATE Users SET password=? WHERE id=? AND password=?";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, newPassword);
            ps.setInt(2, userId);
            ps.setString(3, oldPassword);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

    /** Lấy user theo username + email (dùng cho forgot password) */
    public User checkUserByUsernameAndEmail(String username, String email) {
        String sql = "SELECT * FROM Users WHERE username=? AND email=?";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return extractUser(rs);
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

    /** Lấy tất cả users (Admin) */
    public List<User> getAllUsers() {
        List<User> list = new ArrayList<>();
        String sql = "SELECT * FROM Users ORDER BY createdDate DESC";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) list.add(extractUser(rs));
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    /** Lấy user theo ID */
    public User getUserById(int id) {
        String sql = "SELECT * FROM Users WHERE id=?";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return extractUser(rs);
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

    /** Cập nhật profile (fullname, email, phone) */
    public boolean updateUser(int id, String fullname, String email, String phone) {
        String sql = "UPDATE Users SET fullname=?, email=?, phone=? WHERE id=?";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, fullname);
            ps.setString(2, email);
            ps.setString(3, phone);
            ps.setInt(4, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

    /** Cập nhật user đầy đủ (Admin) */
    public boolean updateUserAdmin(User u) {
        String sql = "UPDATE Users SET fullname=?, email=?, phone=?, role=?, status=? WHERE id=?";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, u.getFullname());
            ps.setString(2, u.getEmail());
            ps.setString(3, u.getPhone());
            ps.setString(4, u.getRole());
            ps.setBoolean(5, u.isStatus());
            ps.setInt(6, u.getId());
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

    /** Khóa / Mở khóa tài khoản */
    public boolean lockUser(int id, boolean lock) {
        String sql = "UPDATE Users SET status=? WHERE id=?";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setBoolean(1, !lock);   // lock=true → status=false (khóa)
            ps.setInt(2, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

    /** Xóa user */
    public boolean deleteUser(int id) {
        String sql = "DELETE FROM Users WHERE id=?";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

    /** Đếm tổng số user */
    public int countAll() {
        String sql = "SELECT COUNT(*) FROM Users";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

    /** Đặt lại mật khẩu trực tiếp (dùng cho forgot password) */
    public boolean resetPassword(int userId, String newPassword) {
        String sql = "UPDATE Users SET password=? WHERE id=?";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, newPassword);
            ps.setInt(2, userId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

    private User extractUser(ResultSet rs) throws Exception {
        return new User(
                rs.getInt("id"),
                rs.getString("username"),
                rs.getString("password"),
                rs.getString("fullname"),
                rs.getString("email"),
                rs.getString("phone"),
                rs.getString("avatar"),
                rs.getString("role"),
                rs.getBoolean("status"),
                rs.getTimestamp("createdDate")
        );
    }
}