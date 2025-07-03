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
import java.sql.Types;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import model.ServiceTicket;
import mylib.DBUtils;

/**
 *
 * @author lengu
 */
public class ServiceTicketDAO {

    public List<Object[]> getServiceTickets(String mechanicID) {
        List<Object[]> list = new ArrayList<>();
        Connection cn = null;
        String query = "SELECT ST.serviceTicketID, \n"
                + "       ST.dateReceived, \n"
                + "       ST.dateReturned, \n"
                + "       C.custName, \n"
                + "       S.serviceName, \n"
                + "       M.mechanicName,  -- Đặt đúng vị trí trước Customer Id\n"
                + "       C.custID, \n"
                + "       ST.carID,  -- Đặt đúng vị trí sau Customer Id\n"
                + "       SM.hours, \n"
                + "       SM.rate, \n"
                + "       SM.comment, \n"
                + "       S.serviceID\n"
                + "FROM ServiceTicket ST\n"
                + "JOIN Customer C ON ST.custID = C.custID\n"
                + "JOIN ServiceMehanic SM ON ST.serviceTicketID = SM.serviceTicketID\n"
                + "JOIN Service S ON SM.serviceID = S.serviceID\n"
                + "JOIN Mechanic M ON SM.mechanicID = M.mechanicID\n"
                + "WHERE SM.mechanicID = ?;";
        try {
            cn = DBUtils.getConnection(); // Mở kết nối SQL
            PreparedStatement ps = cn.prepareStatement(query);
            ps.setString(1, mechanicID); // Sử dụng String vì mechanicID có thể lớn
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Object[] row = new Object[]{
                    rs.getInt("serviceTicketID"), //0
                    rs.getDate("dateReceived") != null ? rs.getDate("dateReceived").toLocalDate() : null, //1
                    rs.getDate("dateReturned") != null ? rs.getDate("dateReturned").toLocalDate() : null, //2
                    rs.getString("custName"), //3
                    rs.getString("serviceName"), //4
                    rs.getString("mechanicName"), //5
                    rs.getInt("custID"), //6
                    rs.getString("carID"), //7
                    rs.getDouble("hours"),//8
                    rs.getDouble("rate"),//9
                    rs.getString("comment"),//10
                    rs.getString("serviceID")//11
                };
                list.add(row);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return list;
    }

    public List<Object[]> searchServiceTicket(Integer custID, Integer carID, String dateReceived, String mechanicID) {
        List<Object[]> list = new ArrayList<>();
        Connection cn = null;
        String query = "SELECT ST.serviceTicketID, \n"
                + "       ST.dateReceived, \n"
                + "       ST.dateReturned, \n"
                + "       C.custName, \n"
                + "       S.serviceName, \n"
                + "       M.mechanicName, \n"
                + "       C.custID, \n"
                + "       ST.carID, \n"
                + "       SM.hours, \n"
                + "       SM.rate, \n"
                + "       SM.comment, \n"
                + "       S.serviceID\n"
                + "FROM [dbo].[ServiceTicket] ST\n"
                + "JOIN Customer C ON ST.custID = C.custID\n"
                + "LEFT JOIN ServiceMehanic SM ON ST.serviceTicketID = SM.serviceTicketID\n"
                + "LEFT JOIN Service S ON SM.serviceID = S.serviceID\n"
                + "LEFT JOIN Mechanic M ON SM.mechanicID = M.mechanicID\n"
                + "WHERE (? IS NULL OR ST.custID = ?) \n"
                + "AND (? IS NULL OR ST.carID = ?) \n"
                + "AND (? IS NULL OR CAST(ST.dateReceived AS DATE) = ?) \n"
                + "AND (? IS NULL OR SM.mechanicID = ?)";  

        try {
            cn = DBUtils.getConnection();
            PreparedStatement ps = cn.prepareStatement(query);

            ps.setObject(1, custID);
            ps.setObject(2, custID);
            ps.setObject(3, carID);
            ps.setObject(4, carID);

            // Chuyển đổi dateReceived thành kiểu java.sql.Date
            if (dateReceived != null && !dateReceived.trim().isEmpty()) {
                java.sql.Date sqlDate = java.sql.Date.valueOf(dateReceived);
                ps.setDate(5, sqlDate);
                ps.setDate(6, sqlDate);
            } else {
                ps.setNull(5, Types.DATE);
                ps.setNull(6, Types.DATE);
            }

            ps.setObject(7, mechanicID);
            ps.setObject(8, mechanicID);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Object[] row = new Object[]{
                    rs.getInt("serviceTicketID"),//0
                    rs.getDate("dateReceived") != null ? rs.getDate("dateReceived").toLocalDate() : null,//1
                    rs.getDate("dateReturned") != null ? rs.getDate("dateReturned").toLocalDate() : null,//2
                    rs.getString("custName"),//3
                    rs.getString("serviceName"),//4
                    rs.getString("mechanicName"),//5
                    rs.getInt("custID"),//6
                    rs.getString("carID"),//7
                    rs.getObject("hours") != null ? rs.getInt("hours") : null,//8
                    rs.getObject("rate") != null ? rs.getDouble("rate") : null,//9
                    rs.getString("comment"),//10
                    rs.getString("serviceID")//11
                };
                list.add(row);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return list;
    }

    public List<ServiceTicket> getServiceTicketByCusid(String custID) {
        List<ServiceTicket> list = new ArrayList<>();
        String query = "SELECT * FROM ServiceTicket WHERE custID = ?";
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();// mo ket noi sql 
            PreparedStatement ps = cn.prepareStatement(query);
            ps.setString(1, custID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new ServiceTicket(rs.getInt("serviceTicketID"),
                        rs.getDate("dateReceived") != null ? rs.getDate("dateReceived").toLocalDate() : null,
                        rs.getDate("dateReturned") != null ? rs.getDate("dateReturned").toLocalDate() : null,
                        rs.getString("custID"),
                        rs.getInt("carID")));
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return list;
    }

    public List<Object[]> getTicketDetailsByServiceTicketID(int serviceTicketID) {
        List<Object[]> list = new ArrayList<>();
        Connection cn = null;
        String query = "SELECT \n"
                + "    ST.serviceTicketID,\n"
                + "    ST.dateReceived,\n"
                + "    ST.dateReturned,\n"
                + "    C.custID,\n"
                + "    C.custName,\n"
                + "    S.serviceID,\n"
                + "    S.serviceName,\n"
                + "    S.hourlyRate,\n"
                + "    SM.mechanicID,\n"
                + "    M.mechanicName,\n"
                + "    SM.hours,\n"
                + "    SM.rate,\n"
                + "    SM.comment\n"
                + "FROM ServiceTicket ST\n"
                + "JOIN Customer C ON ST.custID = C.custID\n"
                + "JOIN ServiceMehanic SM ON ST.serviceTicketID = SM.serviceTicketID\n"
                + "JOIN Service S ON SM.serviceID = S.serviceID\n"
                + "JOIN Mechanic M ON SM.mechanicID = M.mechanicID\n"
                + "WHERE ST.serviceTicketID = ?";
        try {
            cn = DBUtils.getConnection();// mo ket noi sql 
            PreparedStatement ps = cn.prepareStatement(query);
            ps.setInt(1, serviceTicketID);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Object[] row = new Object[]{
                    rs.getInt("serviceTicketID"),
                    rs.getDate("dateReceived") != null ? rs.getDate("dateReceived").toLocalDate() : null,
                    rs.getDate("dateReturned") != null ? rs.getDate("dateReturned").toLocalDate() : null,
                    rs.getInt("custID"),
                    rs.getString("custName"),
                    rs.getString("serviceID"),
                    rs.getString("serviceName"),
                    rs.getDouble("hourlyRate"),
                    rs.getString("mechanicID"),
                    rs.getString("mechanicName"),
                    rs.getDouble("hours"),
                    rs.getDouble("rate"),
                    rs.getString("comment")
                };
                list.add(row);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return list;
    }

    //sale person
    public boolean createServiceTicket(ServiceTicket ticket) {
        String sql = "INSERT INTO ServiceTicket (serviceTicketID, dateReceived, dateReturned, custID, carID) VALUES (?, ?, ?, ?, ?)";
        try (Connection cn = DBUtils.getConnection();
                PreparedStatement st = cn.prepareStatement(sql)) {
            st.setInt(1, ticket.getServiceTicketID());
            st.setDate(2, Date.valueOf(ticket.getDateReceived()));
            st.setDate(3, Date.valueOf(ticket.getDateReturned()));
            st.setString(4, ticket.getCustID());
            st.setInt(5, ticket.getCarID());
            return st.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateServiceTicket(ServiceTicket ticket) {
        String sql = "UPDATE ServiceTicket SET dateReceived=?, dateReturned=?, custID=?, carID=? WHERE serviceTicketID=?";
        try (Connection cn = DBUtils.getConnection();
                PreparedStatement st = cn.prepareStatement(sql)) {
            st.setDate(1, Date.valueOf(ticket.getDateReceived()));
            st.setDate(2, Date.valueOf(ticket.getDateReturned()));
            st.setString(3, ticket.getCustID());
            st.setInt(4, ticket.getCarID());
            st.setInt(5, ticket.getServiceTicketID());
            return st.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteServiceTicket(int serviceTicketID) {
        String sql = "DELETE FROM ServiceTicket WHERE serviceTicketID = ?";
        try (Connection cn = DBUtils.getConnection();
                PreparedStatement st = cn.prepareStatement(sql)) {
            st.setInt(1, serviceTicketID);
            return st.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<ServiceTicket> getAllServiceTickets() {
        List<ServiceTicket> list = new ArrayList<>();
        String sql = "SELECT * FROM ServiceTicket";
        try (Connection cn = DBUtils.getConnection();
                PreparedStatement st = cn.prepareStatement(sql);
                ResultSet rs = st.executeQuery()) {
            while (rs.next()) {
                list.add(new ServiceTicket(
                        rs.getInt("serviceTicketID"),
                        LocalDate.parse(rs.getDate("dateReceived").toString()),
                        LocalDate.parse(rs.getDate("dateReturned").toString()),
                        rs.getString("custID"),
                        rs.getInt("carID")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public ServiceTicket getServiceTicketByID(int serviceTicketID) {
        String sql = "SELECT * FROM ServiceTicket WHERE serviceTicketID = ?";
        try (Connection cn = DBUtils.getConnection();
                PreparedStatement st = cn.prepareStatement(sql)) {
            st.setInt(1, serviceTicketID);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return new ServiceTicket(
                        rs.getInt("serviceTicketID"),
                        LocalDate.parse(rs.getDate("dateReceived").toString()),
                        LocalDate.parse(rs.getDate("dateReturned").toString()),
                        rs.getString("custID"),
                        rs.getInt("carID")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public ServiceTicket getServiceTicketNewest() {
        String sql = " SELECT top 1 * FROM ServiceTicket order  by [serviceTicketID] desc";
        try (Connection cn = DBUtils.getConnection();
                PreparedStatement st = cn.prepareStatement(sql)) {
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return new ServiceTicket(
                        rs.getInt("serviceTicketID"),
                        LocalDate.parse(rs.getDate("dateReceived").toString()),
                        LocalDate.parse(rs.getDate("dateReturned").toString()),
                        rs.getString("custID"),
                        rs.getInt("carID")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
