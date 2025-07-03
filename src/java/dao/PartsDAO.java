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
import model.Parts;
import model.PartsUsed;
import mylib.DBUtils;

/**
 *
 * @author nphu1
 */
public class PartsDAO {

    Connection cn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public List<Parts> getParts() {
        List<Parts> list = new ArrayList();
        String query = "select *\n"
                + "from [dbo].[Parts]";
        try {
            cn = DBUtils.getConnection();// mo ket noi sql 
            ps = cn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Parts(rs.getInt(1), rs.getString(2), rs.getDouble(3), rs.getDouble(4)));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public int getLargestIdParts() {
        String query = "SELECT top 1 [partID]\n"
                + "FROM [dbo].[Parts]\n"
                + "ORDER BY [partID] desc";
        int result = -1;
        Connection connection = null;
        try {
            cn = DBUtils.getConnection();// mo ket noi sql 
            ps = cn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                result = rs.getInt("partID");
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

    public int createNewPart(String partName, double purchasePrice, double retailPrice) {
        int result = 0;

        String checkQuery = "SELECT COUNT(*) FROM [dbo].[Parts] WHERE [partName] = ?";
        try (Connection cn = new DBUtils().getConnection();
                PreparedStatement psCheck = cn.prepareStatement(checkQuery)) {

            psCheck.setString(1, partName);
            try (ResultSet rs = psCheck.executeQuery()) {
                if (rs.next()) {
                    int count = rs.getInt(1);
                    if (count > 0) {
                        System.out.println("Part đã tồn tại: " + partName);
                        return 0;
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            return result;
        }

        int id = getLargestIdParts();
        if (id < 0) {
            return result;
        } else {
            id++;
        }

        String query = "INSERT INTO [dbo].[Parts]\n"
                + "                          ([partID]\n"
                + "                          ,[partName]\n"
                + "                          ,[purchasePrice],\n"
                + "                             [retailPrice])\n"
                + "                VALUES (?,?,?,?)";
        try (Connection cn = new DBUtils().getConnection();
                PreparedStatement ps = cn.prepareStatement(query)) {

            ps.setInt(1, id);
            ps.setString(2, partName);
            ps.setDouble(3, purchasePrice);
            ps.setDouble(4, retailPrice);

            result = ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public int deleteServiceByID(String id) {
        int result = 0;
        String queryPartsUsed = "DELETE FROM [dbo].[PartsUsed] WHERE [partID] = ?";
        String queryParts = "DELETE FROM [dbo].[Parts]\n"
                + "     WHERE [partID] = ?";
        try (Connection cn = new DBUtils().getConnection();
                PreparedStatement psPartsUsed = cn.prepareStatement(queryPartsUsed);
                PreparedStatement psParts = cn.prepareStatement(queryParts)) {

            psPartsUsed.setString(1, id);
            psPartsUsed.executeUpdate();

            psParts.setString(1, id);

            result = psParts.executeUpdate();

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
        return result;
    }

    public int updateServiceByID(String id, String partName, double purchasePrice, double retailPrice) {
        int result = 0;
        String checkQuery = "SELECT COUNT(*) FROM [dbo].[Parts] WHERE [partName] = ? AND [partID] <> ?";
        try (Connection cn = new DBUtils().getConnection();
                PreparedStatement psCheck = cn.prepareStatement(checkQuery)) {

            psCheck.setString(1, partName);
            psCheck.setString(2, id);
            try (ResultSet rs = psCheck.executeQuery()) {
                if (rs.next()) {
                    int count = rs.getInt(1);
                    if (count > 0) {
                        return 0;
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            return result;
        }

        String query = "UPDATE [dbo].[Parts]\n"
                + "   SET [partName] = ?,\n"
                + "       [purchasePrice] = ?,\n"
                + "       [retailPrice] = ?\n"
                + " WHERE [partID] = ?";

        try (Connection cn = new DBUtils().getConnection();
                PreparedStatement ps = cn.prepareStatement(query)) {

            ps.setString(1, partName);
            ps.setDouble(2, purchasePrice);
            ps.setDouble(3, retailPrice);
            ps.setString(4, id);

            result = ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

    public Parts getPartByID(String id) {
        String query = "SELECT "
                + "      [partName]\n"
                + "      ,[purchasePrice]\n"
                + "      ,[retailPrice]\n"
                + "  FROM [dbo].[Parts]\n"
                + "  WHERE [partID] = ?";
        Parts result = null;
        Connection cn = null;
        System.out.println(id);
        try {
            cn = new DBUtils().getConnection();
            if (cn != null) {
                PreparedStatement statement = cn.prepareStatement(query);
                statement.setString(1, id);
                System.out.println("connect != null");
                ResultSet resultSet = statement.executeQuery();
                while (resultSet.next()) {
                    String partName = resultSet.getString("partName");
                    double purchasePrice = resultSet.getDouble("purchasePrice");
                    double retailPrice = resultSet.getDouble("retailPrice");
                    result = new Parts(Integer.parseInt(id), partName, purchasePrice, retailPrice);
                }
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
        return result;
    }

    public List<Parts> searchByName(String name) {
        List<Parts> list = new ArrayList<>();
        String query = "SELECT [partID], [partName], [purchasePrice], [retailPrice] "
                + "FROM [dbo].[Parts] "
                + "WHERE RTRIM([partName]) COLLATE SQL_Latin1_General_CP1_CI_AI LIKE ?";

        try (Connection cn = DBUtils.getConnection();
                PreparedStatement ps = cn.prepareStatement(query)) {

            ps.setString(1, "%" + name + "%");  // Đặt giá trị LIKE đúng cách
            System.out.println("key words: " + name);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(new Parts(
                            rs.getInt("partID"),
                            rs.getString("partName"),
                            rs.getDouble("purchasePrice"),
                            rs.getDouble("retailPrice")
                    ));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

            public List<Parts> getAllParts() {
        List<Parts> list = new ArrayList<>();
        String sql = "SELECT * FROM Parts";
        try (Connection cn = DBUtils.getConnection();
                PreparedStatement st = cn.prepareStatement(sql)) {
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new Parts(
                        rs.getInt("partID"),
                        rs.getString("partName"),
                        rs.getDouble("purchasePrice"),
                        rs.getDouble("retailPrice")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean insertPartsUsed(PartsUsed partsUsed) {
        String sql = "INSERT INTO PartsUsed (serviceTicketID, partID, numberUsed, price) VALUES (?, ?, ?, ?)";
        try (Connection cn = DBUtils.getConnection();
                PreparedStatement st = cn.prepareStatement(sql)) {
            st.setInt(1, partsUsed.getServiceTicketID());
            st.setInt(2, partsUsed.getPartID());
            st.setInt(3, partsUsed.getNumberUsed());
            st.setDouble(4, partsUsed.getPrice());
            return st.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean insertServiceMechanic(int serviceTicketID, int serviceID, String mechanicID, int hours, double rate) {
        String sql = "INSERT INTO ServiceMehanic (serviceTicketID, serviceID, mechanicID, hours, rate) VALUES (?, ?, ?, ?, ?)";

        try (Connection cn = DBUtils.getConnection();
                PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setInt(1, serviceTicketID);
            ps.setInt(2, serviceID);
            ps.setString(3, mechanicID);
            ps.setInt(4, hours);
            ps.setDouble(5, rate);

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

}
