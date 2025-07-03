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
import model.Service;
import mylib.DBUtils;

/**
 *
 * @author lengu
 */
public class ServiceDAO {

    public List<Service> getAllService() {
        String query = "SELECT [serviceID]\n"
                + "      ,[serviceName]\n"
                + "      ,[hourlyRate]\n"
                + "  FROM [dbo].[Service]";
        List<Service> result = new ArrayList<>();
        Connection connection = null;
        try {
            connection = DBUtils.getConnection();
            if (connection != null) {
                PreparedStatement statement = connection.prepareStatement(query);

                ResultSet resultSet = statement.executeQuery();
                while (resultSet.next()) {
                    String id = resultSet.getString("serviceID");
                    String name = resultSet.getString("serviceName");
                    double hourlyRate = resultSet.getDouble("hourlyRate");

                    Service service = new Service(id, name, hourlyRate);
                    result.add(service);
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

    public int getLargestIdService() {
        String query = "SELECT top 1 [serviceID]\n"
                + "FROM [dbo].[Service]\n"
                + "ORDER BY [serviceID] desc";
        int result = -1;
        Connection connection = null;
        try {
            connection = DBUtils.getConnection();
            if (connection != null) {
                PreparedStatement statement = connection.prepareStatement(query);
                ResultSet resultSet = statement.executeQuery();
                while (resultSet.next()) {
                    result = resultSet.getInt("serviceID");
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

    public int createNewService(String name, String hourlyRate) {
        int result = 0;
        String query = "INSERT INTO [dbo].[Service]\n"
                + "           ([serviceID]\n"
                + "           ,[serviceName]\n"
                + "           ,[hourlyRate])\n"
                + "VALUES (?,?,?)";
        int id = getLargestIdService();
        if (id < 0) {
            return result;
        } else {
            id++;
        }
        Connection connection = null;
        try {
            connection = DBUtils.getConnection();
            if (connection != null) {
                PreparedStatement statement = connection.prepareStatement(query);
                statement.setInt(1, id);
                statement.setString(2, name);
                statement.setString(3, hourlyRate);

                result = statement.executeUpdate();
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

    public int deleteServiceByID(String id) {
        int result = 0;
        String query = "DELETE FROM [dbo].[Service]\n"
                + "      WHERE [serviceID] = ?";
        Connection connection = null;
        try {
            connection = DBUtils.getConnection();
            if (connection != null) {
                PreparedStatement statement = connection.prepareStatement(query);
                statement.setString(1, id);

                result = statement.executeUpdate();
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

    public int updateServiceByID(String id, String name, String hourlyRate) {
        int result = 0;
        String query = "UPDATE [dbo].[Service]\n"
                + "   SET [serviceName] =? \n"
                + "      ,[hourlyRate] =?\n"
                + " WHERE [serviceID] =?";
        Connection connection = null;
        try {
            connection = DBUtils.getConnection();
            if (connection != null) {
                PreparedStatement statement = connection.prepareStatement(query);
                statement.setString(1, name);
                statement.setString(2, hourlyRate);
                statement.setString(3, id);

                result = statement.executeUpdate();
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

    public Service getServiceById(String id) {
        String query = "SELECT [serviceName]\n"
                + "      ,[hourlyRate]\n"
                + "  FROM [dbo].[Service]\n"
                + "WHERE [serviceID] = ?";
        Service result = null;
        Connection connection = null;
        try {
            connection = DBUtils.getConnection();
            if (connection != null) {
                PreparedStatement statement = connection.prepareStatement(query);
                statement.setString(1, id);

                ResultSet resultSet = statement.executeQuery();
                while (resultSet.next()) {
                    String name = resultSet.getString("serviceName");
                    double hourlyRate = resultSet.getDouble("hourlyRate");
                    
                    result = new Service(id, name, hourlyRate);
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

    public Service getServiceByName(String name) {
        String query = "SELECT [serviceID]\n"
                + "      ,[hourlyRate]\n"
                + "  FROM [dbo].[Service]\n"
                + "WHERE [serviceName] = ?";
        Service result = null;
        Connection connection = null;
        try {
            connection = DBUtils.getConnection();
            if (connection != null) {
                PreparedStatement statement = connection.prepareStatement(query);
                statement.setString(1, name);

                ResultSet resultSet = statement.executeQuery();
                while (resultSet.next()) {
                    String id = resultSet.getString("serviceID");
                    double hourlyRate = resultSet.getDouble("hourlyRate");
                    
                    result = new Service(id, name, hourlyRate);
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
