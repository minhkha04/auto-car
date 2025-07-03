/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import model.SalesPerson;
import mylib.DBUtils;

/**
 *
 * @author lengu
 */
public class SalesPersonDAO {

    public SalesPerson getSalesPersonBySalesPresonID(String id) {
        String query = "SELECT [salesName]\n"
                + "      ,[birthday]\n"
                + "      ,[sex]\n"
                + "      ,[salesAddress]\n"
                + "  FROM [dbo].[SalesPerson]\n"
                + "WHERE [salesID] = ?";
        Connection connection = null;
        SalesPerson result = null;
        try {
            connection = DBUtils.getConnection();
            if (connection != null) {
                PreparedStatement statement = connection.prepareStatement(query);
                statement.setString(1, id);

                ResultSet resultSet = statement.executeQuery();
                while (resultSet.next()) {
                    String salesName = resultSet.getString("salesName");
                    Date birthday = resultSet.getDate("birthday");
                    String sex = resultSet.getString("sex");
                    String saleAddress = resultSet.getString("salesAddress");

                    result = new SalesPerson(id, salesName, birthday, sex, saleAddress);

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

    public SalesPerson getSaslesPersonBySalesPersonName(String name) {
        String query = "SELECT [salesID]\n"
                + "      ,[birthday]\n"
                + "      ,[sex]\n"
                + "      ,[salesAddress]\n"
                + "FROM [dbo].[SalesPerson]\n"
                + "WHERE [salesName] = ?";
        Connection connection = null;
        SalesPerson result = null;
        try {
            connection = DBUtils.getConnection();
            if (connection != null) {
                PreparedStatement statement = connection.prepareStatement(query);
                statement.setString(1, name);

                ResultSet resultSet = statement.executeQuery();
                while (resultSet.next()) {

                    String id = resultSet.getString("salesID");
                    Date birthday = resultSet.getDate("birthday");
                    String sex = resultSet.getString("sex");
                    String saleAddress = resultSet.getString("salesAddress");

                    result = new SalesPerson(id, name, birthday, sex, saleAddress);
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
}
