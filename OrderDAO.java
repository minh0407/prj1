import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {
    private Connection connection;

    public OrderDAO(Connection connection) {
        this.connection = connection;
    }

    // Method to create a new order
    public void createOrder(int userId, List<Integer> productIds) throws SQLException {
        String sql = "INSERT INTO Orders (userId) VALUES (?)";
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setInt(1, userId);
        statement.executeUpdate();

        // Assume we get the generated orderId
        int orderId = getLastInsertedOrderId();
        for (int productId : productIds) {
            createOrderDetail(orderId, productId);
        }
    }

    private void createOrderDetail(int orderId, int productId) throws SQLException {
        String sql = "INSERT INTO OrderDetails (orderId, productId) VALUES (?, ?)";
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setInt(1, orderId);
        statement.setInt(2, productId);
        statement.executeUpdate();
    }

    // Method to update an order
    public void updateOrder(int orderId, List<Integer> productIds) throws SQLException {
        // Implementation for updating the order details
    }

    // Method to delete an order
    public void deleteOrder(int orderId) throws SQLException {
        String sql = "DELETE FROM OrderDetails WHERE orderId = ?";
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setInt(1, orderId);
        statement.executeUpdate();

        sql = "DELETE FROM Orders WHERE id = ?";
        statement = connection.prepareStatement(sql);
        statement.setInt(1, orderId);
        statement.executeUpdate();
    }

    // Method to get last inserted order ID
    private int getLastInsertedOrderId() throws SQLException {
        String sql = "SELECT LAST_INSERT_ID()";
        PreparedStatement statement = connection.prepareStatement(sql);
        ResultSet resultSet = statement.executeQuery();
        if (resultSet.next()) {
            return resultSet.getInt(1);
        }
        throw new SQLException("Failed to retrieve the last inserted order ID");
    }

    // Other methods to link with Users and Products as needed...
}