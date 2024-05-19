package com.unipi.cdsshop.models.dao;

import com.unipi.cdsshop.forms.FormOrder;
import com.unipi.cdsshop.models.OrderItem;
import com.unipi.cdsshop.models.User;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.sql.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.sql.PreparedStatement;
public class OrderDAO {


    // Nested Class
    public static class RecentOrderHistoryItem {
        private String stamp; // stamp of Order page
        private Map<String, Integer> orderItems = new HashMap<>(); // a map of order items (orderItems), where the keys are cd names and the values are quantities.

        public RecentOrderHistoryItem() {
        }

        public RecentOrderHistoryItem(String stamp, Map<String, Integer> orderItems) {
            this.stamp = stamp;
            this.orderItems = orderItems;
        }

        public String getStamp() {
            return stamp;
        }

        public void setStamp(String stamp) {
            this.stamp = stamp;
        }

        public Map<String, Integer> getOrderItems() {
            return orderItems;
        }

        public void setOrderItems(Map<String, Integer> orderItems) {
            this.orderItems = orderItems;
        }



        @Override
        public String toString() {
            return "RecentOrderHistoryItem{" +
                    "stamp=" + stamp +
                    ", orderItems=" + orderItems +
                    '}';
        }
    }

    /*
    I dont need a wrapper for Order. This is the use of FormOrder
     */

    public static void storeOrder(FormOrder formOrder, User user) {

        try {
            DataSource ds = (DataSource) new InitialContext().lookup("java:/comp/env/jdbc/cdsshopdb");
            Connection connection = ds.getConnection();

            String query = "INSERT INTO cdsshopdb.order (fullname, address, area_id, email, tel, comments, user_id, stamp)" +
                    " VALUES (?,?,?,?,?,?,?,?)";



            PreparedStatement statement = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);

            statement.setString(1, formOrder.getFullName());
            statement.setString(2, formOrder.getAddress());
            statement.setInt(3, formOrder.getAreaId());
            statement.setString(4, formOrder.getEmail());
            statement.setString(5, formOrder.getTel());
            statement.setString(6, formOrder.getComments());
            statement.setInt(7, user.getId());
            LocalDateTime timestamp = LocalDateTime.now();
            statement.setObject(8, timestamp);
            statement.executeUpdate();

            // Get the id, to use it later
            ResultSet genKeys = statement.getGeneratedKeys();

            int orderId = -1;

            if (genKeys.next()) {
                orderId = genKeys.getInt(1);
            }

            System.out.println("key: " + orderId);

            statement.close();
            genKeys.close();
            connection.close();

            // Updating OrderItems Table
            // relation of the order id with the order_id from order_items
            if (orderId != -1) {
                for (OrderItem orderItem : formOrder.getOrderItems()) {
                    orderItem.setOrderId(orderId);
                    OrderItemDAO.storeOrderItem(orderItem);
                }
            }
        } catch (NamingException | SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public static int getNumberOfCds() {
        try {
            DataSource ds = (DataSource) new InitialContext().lookup("java:/comp/env/jdbc/cdsshopdb");
            Connection connection = ds.getConnection();

            String query = "SELECT COUNT(*) AS cd_counter FROM cd";

            PreparedStatement statement = connection.prepareStatement(query);
            ResultSet resultSet = statement.executeQuery();

            int numberOfCds = 0;
            if (resultSet.next()) {
                numberOfCds = resultSet.getInt("cd_counter");
            }

            resultSet.close();
            statement.close();
            connection.close();

            return numberOfCds;

        } catch (SQLException | NamingException e) {
            throw new RuntimeException(e);
        }
    }
}
