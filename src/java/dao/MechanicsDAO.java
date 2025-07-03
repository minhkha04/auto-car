/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.Mechanics;
import mylib.DBUtils;

/**
 *
 * @author lengu
 */
public class MechanicsDAO {

    public Mechanics getMechanicByMechanicName(String name) {
        String query = "SELECT [mechanicID]\n"
                + "  FROM [dbo].[Mechanic]\n"
                + "  WHERE [mechanicName] = ?";
        Mechanics result = null;
        Connection connection = null;

        try {
            connection = DBUtils.getConnection();
            if (connection != null) {
                PreparedStatement statement = connection.prepareStatement(query);
                statement.setString(1, name);

                ResultSet resultSet = statement.executeQuery();
                while (resultSet.next()) {

                    String mechanicID = resultSet.getString("mechanicID");

                    result = new Mechanics(mechanicID, name);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return result;
    }

    public Mechanics getMechanicsById(String id) {
        Mechanics result = null;
        String query = "SELECT [mechanicName]\n"
                + "  FROM [dbo].[Mechanic]\n"
                + "  WHERE mechanicID = ?";
        Connection connection = null;
        try {
            connection = DBUtils.getConnection();
            if (connection != null) {
                PreparedStatement statement = connection.prepareStatement(query);
                statement.setString(1, id);
                ResultSet resultSet = statement.executeQuery();
                while (resultSet.next()) {
                    String name = resultSet.getString("mechanicName");
                    result = new Mechanics(id, name);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return result;
    }
    
    public List<Mechanics> getAllMechanics() {
        List<Mechanics> mechanics = new ArrayList<>();
        String sql = "SELECT mechanicID, mechanicName FROM Mechanic";

        try (Connection cn = DBUtils.getConnection();
                PreparedStatement ps = cn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Mechanics mechanic = new Mechanics();
                mechanic.setId(rs.getString("mechanicID"));
                mechanic.setName(rs.getString("mechanicName"));
                mechanics.add(mechanic);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return mechanics;
    }
}
