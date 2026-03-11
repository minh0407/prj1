package dao;

import java.security.MessageDigest;
import java.sql.Connection;
import java.sql.DriverManager;

public class DBContext {

    private static final String URL      = "jdbc:sqlserver://localhost:1433;databaseName=HomeElectroDB;encrypt=true;trustServerCertificate=true;";
    private static final String USER_DB  = "sa";
    private static final String PASSWORD = "123";

    public Connection getConnection() {
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            return DriverManager.getConnection(URL, USER_DB, PASSWORD);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    /** MD5 hash dùng chung cho toàn bộ DAO */
    public static String md5(String input) {
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            byte[] hash = md.digest(input.getBytes("UTF-8"));
            StringBuilder sb = new StringBuilder();
            for (byte b : hash) sb.append(String.format("%02x", b));
            return sb.toString();
        } catch (Exception e) {
            throw new RuntimeException("MD5 error", e);
        }
    }
}
