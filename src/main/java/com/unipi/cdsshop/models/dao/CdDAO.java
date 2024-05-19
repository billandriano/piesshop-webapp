package com.unipi.cdsshop.models.dao;

import com.unipi.cdsshop.models.Cd;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CdDAO {

    public static Cd prepareCdObject(ResultSet resultSet) throws SQLException {
        Cd cd = new Cd();
        cd.setId(resultSet.getInt("id"));
        cd.setName(resultSet.getString("name"));
        cd.setPrice(resultSet.getDouble("price"));
        cd.setFileName(resultSet.getString("filename"));
        cd.setSinger(resultSet.getString("singer"));
        cd.setDescription(resultSet.getString("description"));

        return cd;
    }

    public static Cd getCdById(int id) {

        try {
            DataSource ds = (DataSource) new InitialContext().lookup("java:/comp/env/jdbc/cdsshopdb");
            Connection connection =  ds.getConnection();

            String query = "SELECT * FROM cd WHERE id = ?";
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setInt(1,id);
            ResultSet resultSet = statement.executeQuery();
            resultSet.next();

            Cd cd = prepareCdObject(resultSet);

            resultSet.close();
            statement.close();
            connection.close();

            return cd;

        } catch (SQLException | NamingException e) {
            throw new RuntimeException(e);
        }
    }

    public static List<Cd> getCds()  {
        try {
            DataSource ds = (DataSource) new InitialContext().lookup("java:/comp/env/jdbc/cdsshopdb");
            Connection connection =  ds.getConnection();

            String query = "SELECT * FROM cd";
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery(query);

            List<Cd> cds = new ArrayList<>();
            while(resultSet.next()) {
                Cd cd =  prepareCdObject(resultSet);
                cds.add(cd);
            }

            resultSet.close();
            statement.close();
            connection.close();

            return cds;

        } catch (SQLException | NamingException e) {
            throw new RuntimeException(e);
        }
    }

    public static List<Cd> searchCds(String searchQuery) {
        List<Cd> cds = new ArrayList<>();
        try {
            DataSource ds = (DataSource) new InitialContext().lookup("java:/comp/env/jdbc/cdsshopdb");
            try (Connection conn = ds.getConnection();
                 PreparedStatement stmt = conn.prepareStatement("SELECT * FROM cd WHERE name LIKE ? OR description LIKE ?")) {
                stmt.setString(1, "%" + searchQuery + "%");
                stmt.setString(2, "%" + searchQuery + "%");
                try (ResultSet rs = stmt.executeQuery()) {
                    while (rs.next()) {
                        cds.add(prepareCdObject(rs));
                    }
                }
            }
        } catch (SQLException | NamingException e) {
            throw new RuntimeException(e);
        }
        return cds;
    }
    
    
}
