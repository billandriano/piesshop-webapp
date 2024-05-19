package com.unipi.cdsshop.models.dao;

import com.unipi.cdsshop.models.OrderItem;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class OrderItemDAO {
    public static void storeOrderItem(OrderItem orderItem) {
        try {
            DataSource ds = (DataSource) new InitialContext().lookup("java:/comp/env/jdbc/cdsshopdb");
            Connection connection = ds.getConnection();

            String query = "INSERT INTO cdsshopdb.order_item (order_id, cd_id, quantity)"+
                    " VALUES (?,?,?)";

            PreparedStatement statement = connection.prepareStatement(query);

            statement.setInt(1,orderItem.getOrderId());
            statement.setInt(2,orderItem.getCdId());
            statement.setInt(3,orderItem.getQuantity());
            statement.executeUpdate();

            statement.close();
            connection.close();
        } catch (NamingException | SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
