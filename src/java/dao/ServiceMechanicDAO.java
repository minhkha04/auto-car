/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import dto.MechanicMostRepairsDTO;
import dto.ServiceMechanicDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.Mechanics;
import model.Service;
import model.ServiceMechanic;
import mylib.DBUtils;

/**
 *
 * @author lengu
 */
public class ServiceMechanicDAO {

    private Map<String, Integer> getTop3IdMechanicAndTotal() {
        Map<String, Integer> result = new HashMap<>();
        String query = "  SELECT TOP 3 WITH TIES [mechanicID], count([serviceID]) AS total\n"
                + "  FROM [dbo].[ServiceMehanic]\n"
                + "  GROUP BY [mechanicID]\n"
                + "  ORDER BY count([serviceID]) desc";
        Connection connection = null;

        try {
            connection = DBUtils.getConnection();
            if (connection != null) {
                PreparedStatement statement = connection.prepareStatement(query);

                ResultSet resultSet = statement.executeQuery();
                while (resultSet.next()) {
                    String name = resultSet.getString("mechanicID");
                    int total = resultSet.getInt("total");
                    result.putIfAbsent(name, total);
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

    private List<String> getServiceNameByIdMechanic(String id) {
        String query = "SELECT s.serviceName\n"
                + "FROM ServiceMehanic AS sm\n"
                + "INNER JOIN Service AS s\n"
                + "ON sm.serviceID = s.serviceID\n"
                + "WHERE sm.mechanicID = ?";
        List<String> result = new ArrayList<>();
        Connection connection = null;
        try {
            connection = DBUtils.getConnection();
            if (connection != null) {
                PreparedStatement statement = connection.prepareStatement(query);
                statement.setString(1, id);

                ResultSet resultSet = statement.executeQuery();
                while (resultSet.next()) {
                    String name = resultSet.getString("serviceName");

                    result.add(name);
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

    public List<ServiceMechanicDTO> getServiceMechanicByIdMechanic(String id) {
        String query = "SELECT [serviceTicketID]\n"
                + "      ,[serviceID]\n"
                + "      ,[hours]\n"
                + "      ,[comment]\n"
                + "      ,[rate]\n"
                + "  FROM [dbo].[ServiceMehanic]\n"
                + "  WHERE [mechanicID] = ?";
        List<ServiceMechanicDTO> result = new ArrayList<>();
        Connection connection = null;
        try {
            connection = DBUtils.getConnection();
            if (connection != null) {
                PreparedStatement statement = connection.prepareStatement(query);
                statement.setString(1, id);

                ResultSet resultSet = statement.executeQuery();
                ServiceDAO serviceDAO = new ServiceDAO();
                while (resultSet.next()) {
                    String idService = resultSet.getString("serviceID");
                    Service service = serviceDAO.getServiceById(idService);
                    String name = service.getName();
                    String idServiceTicket = resultSet.getString("serviceTicketID");
                    String hours = resultSet.getString("hours");
                    String comment = resultSet.getString("comment");
                    double rate = resultSet.getDouble("rate");
                    ServiceMechanicDTO serviceMechanicDTO = new ServiceMechanicDTO(idServiceTicket, name, hours, comment, rate, idService);
                    result.add(serviceMechanicDTO);

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

    public int updateServiceMechanic(String id, String idService, String hours, String comment, String rate) {
        int result = 0;
        String query = "UPDATE [dbo].[ServiceMehanic]\n"
                + "   SET [hours] = ?\n"
                + "      ,[comment] = ?\n"
                + "      ,[rate] = ?\n"
                + "  WHERE [serviceTicketID] = ? and [serviceID] = ?";
        Connection connection = null;
        try {
            connection = DBUtils.getConnection();
            if (connection != null) {
                PreparedStatement statement = connection.prepareStatement(query);
                statement.setString(1, hours);
                statement.setString(2, comment);
                statement.setString(3, rate);
                statement.setString(4, id);
                statement.setString(5, idService);

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

    public List<MechanicMostRepairsDTO> getTop3Mechanic() {
        List<MechanicMostRepairsDTO> result = new ArrayList<>();
        Map<String, Integer> top3IdMechanicAndTotal = getTop3IdMechanicAndTotal();

        top3IdMechanicAndTotal.forEach((key, value) -> {
            MechanicsDAO mechanicsDAO = new MechanicsDAO();
            Mechanics mechanics = mechanicsDAO.getMechanicsById(key);
            String name = mechanics.getName();
            List<String> service = getServiceNameByIdMechanic(key);
            MechanicMostRepairsDTO mechanicMostRepairsDTO = new MechanicMostRepairsDTO(name, value, service);
            result.add(mechanicMostRepairsDTO);
        });
        return result;
    }

    

    public List<ServiceMechanic> getServiceMechanicByServiceId(String id) {
        String query = "SELECT [serviceTicketID]\n"
                + "      ,[serviceID]\n"
                + "      ,[mechanicID]\n"
                + "      ,[hours]\n"
                + "      ,[comment]\n"
                + "      ,[rate]\n"
                + "  FROM [dbo].[ServiceMehanic]\n"
                + "  WHERE serviceID = ?";
        List<ServiceMechanic> result = new ArrayList<>();
        Connection connection = null;
        try {
            connection = DBUtils.getConnection();
            if (connection != null) {
                PreparedStatement statement = connection.prepareStatement(query);
                statement.setString(1, id);
                
                ResultSet resultSet = statement.executeQuery();
                while (resultSet.next()) {
                    String serviceTicketID = resultSet.getString("serviceTicketID");
                    String serviceID = resultSet.getString("serviceID");
                    String mechanicID = resultSet.getString("mechanicID");
                    String hours = resultSet.getString("hours");
                    String comment = resultSet.getString("comment");
                    double rate = resultSet.getDouble("rate");


                    ServiceMechanic serviceMechanic = new ServiceMechanic(serviceTicketID, serviceID, mechanicID, hours, comment, rate);
                    result.add(serviceMechanic);
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
