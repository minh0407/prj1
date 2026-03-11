package dao;

import model.Order;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.logging.LogRecord;

public class OrderDAO extends DBContext {

    private static final Logger LOGGER = Logger.getLogger(OrderDAO.class.getName());

    // INSERT
    public int insertOrder(Order order) {
        String sql = "INSERT INTO orders "
                + "(user_id, coupon_id, discount_amount, total_amount, "
                + "shipping_address, phone_receiver, receiver_name, note, "
                + "payment_method, payment_status, status, order_date) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, GETDATE())";

        try (Connection cn = getConnection();
             PreparedStatement ps = cn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, order.getUserId());

            if (order.getCouponId() != null) {
                ps.setInt(2, order.getCouponId());
            } else {
                ps.setNull(2, Types.INTEGER);
            }

            ps.setDouble(3, order.getDiscountAmount());
            ps.setDouble(4, order.getTotalAmount());
            ps.setString(5, order.getShippingAddress());
            ps.setString(6, order.getPhoneReceiver());
            ps.setString(7, order.getReceiverName());
            ps.setString(8, order.getNote());
            ps.setString(9, order.getPaymentMethod());
            ps.setString(10, order.getPaymentStatus());
            ps.setString(11, order.getStatus());

            int rows = ps.executeUpdate();
            if (rows > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        return rs.getInt(1);
                    }
                }
            }

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error inserting order", e);
        }

        return -1;
    }

    // SELECT ALL - dùng cho Admin
    public List<Order> getAllOrders() {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT id, user_id, coupon_id, discount_amount, order_date, total_amount, "
                + "shipping_address, phone_receiver, receiver_name, note, "
                + "payment_method, payment_status, status, updated_date "
                + "FROM orders ORDER BY order_date DESC";

        try (Connection cn = getConnection();
             PreparedStatement ps = cn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(map(rs));
            }

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error retrieving all orders", e);
        }

        return list;
    }

    // SELECT BY USER ID
    public List<Order> getOrdersByUserId(int userId) {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT id, user_id, coupon_id, discount_amount, order_date, total_amount, "
                + "shipping_address, phone_receiver, receiver_name, note, "
                + "payment_method, payment_status, status, updated_date "
                + "FROM orders WHERE user_id = ? ORDER BY order_date DESC";

        try (Connection cn = getConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(map(rs));
                }
            }

        } catch (SQLException e) {
            LogRecord lr = new LogRecord(Level.SEVERE, "Error retrieving orders for user: {0}");
            lr.setParameters(new Object[]{userId});
            lr.setThrown(e);
            LOGGER.log(lr);
        }

        return list;
    }

    // SELECT BY ORDER ID
    public Order getOrderById(int orderId) {
        String sql = "SELECT id, user_id, coupon_id, discount_amount, order_date, total_amount, "
                + "shipping_address, phone_receiver, receiver_name, note, "
                + "payment_method, payment_status, status, updated_date "
                + "FROM orders WHERE id = ?";

        try (Connection cn = getConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setInt(1, orderId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return map(rs);
                }
            }

        } catch (SQLException e) {
            LogRecord lr = new LogRecord(Level.SEVERE, "Error retrieving order by id: {0}");
            lr.setParameters(new Object[]{orderId});
            lr.setThrown(e);
            LOGGER.log(lr);
        }

        return null;
    }

    // UPDATE STATUS
    public boolean updateStatus(int orderId, String status) {
        String sql = "UPDATE orders SET status = ?, updated_date = GETDATE() WHERE id = ?";

        try (Connection cn = getConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setString(1, status);
            ps.setInt(2, orderId);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            LogRecord lr = new LogRecord(Level.SEVERE, "Error updating status for order: {0}");
            lr.setParameters(new Object[]{orderId});
            lr.setThrown(e);
            LOGGER.log(lr);
        }

        return false;
    }

    // UPDATE PAYMENT STATUS
    public boolean updatePaymentStatus(int orderId, String paymentStatus) {
        String sql = "UPDATE orders SET payment_status = ?, updated_date = GETDATE() WHERE id = ?";

        try (Connection cn = getConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setString(1, paymentStatus);
            ps.setInt(2, orderId);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            LogRecord lr = new LogRecord(Level.SEVERE, "Error updating payment status for order: {0}");
            lr.setParameters(new Object[]{orderId});
            lr.setThrown(e);
            LOGGER.log(lr);
        }

        return false;
    }

    // MAP RESULTSET TO ORDER
    private Order map(ResultSet rs) throws SQLException {
        Order o = new Order();

        o.setId(rs.getInt("id"));
        o.setUserId(rs.getInt("user_id"));

        int couponId = rs.getInt("coupon_id");
        o.setCouponId(rs.wasNull() ? null : couponId);

        o.setDiscountAmount(rs.getDouble("discount_amount"));
        o.setOrderDate(rs.getTimestamp("order_date"));
        o.setTotalAmount(rs.getDouble("total_amount"));
        o.setShippingAddress(rs.getString("shipping_address"));
        o.setPhoneReceiver(rs.getString("phone_receiver"));
        o.setReceiverName(rs.getString("receiver_name"));
        o.setNote(rs.getString("note"));
        o.setPaymentMethod(rs.getString("payment_method"));
        o.setPaymentStatus(rs.getString("payment_status"));
        o.setStatus(rs.getString("status"));
        o.setUpdatedDate(rs.getTimestamp("updated_date"));

        return o;
    }
}