/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Customer;
import mylib.DBUtils;

/**
 *
 * @author lengu
 */
public class CustomerDAO {

    public Customer checkLoginCustomer(String name, String phone) {
        Customer result = null;
        Connection connection = null;
        try {
            connection = DBUtils.getConnection();
            if (connection != null) {
                String query = "SELECT [custID]\n"
                        + "      ,[custName]\n"
                        + "      ,[phone]\n"
                        + "      ,[sex]\n"
                        + "      ,[cusAddress]\n"
                        + "FROM [dbo].[Customer]\n"
                        + "WHERE custName = ? and phone = ?";
                PreparedStatement statement = connection.prepareStatement(query);
                statement.setString(1, name);
                statement.setString(2, phone);
                ResultSet resultSet = statement.executeQuery();
                while (resultSet.next()) {
                    String cusID = resultSet.getString("custID");
                    String sex = resultSet.getString("sex");
                    String cusAddress = resultSet.getString("cusAddress");

                    result = new Customer(cusID, name, phone, sex, cusAddress);
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

    public int changeProfileCustomer(String id, String name, String phone, String address, String sex) {
        int result = 0;
        String query = "UPDATE [dbo].[Customer]\n"
                + "   SET [custName] = ?\n"
                + "      ,[phone] = ?\n"
                + "      ,[sex] = ?\n"
                + "      ,[cusAddress] = ?\n"
                + " WHERE [custID] = ?";
        Connection connection = null;
        try {
            connection = DBUtils.getConnection();
            if (connection != null) {
                PreparedStatement statement = connection.prepareStatement(query);
                statement.setString(1, name);
                statement.setString(2, phone);
                statement.setString(3, sex);
                statement.setString(4, address);
                statement.setString(5, id);

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

    public boolean createCustomer(Customer customer) throws ClassNotFoundException, SQLException {
        String sql = "INSERT INTO Customer (custID, custName, phone, sex, cusAddress,[isDeleted]) VALUES (?, ?, ?, ?, ?,0)";
        Connection cn = DBUtils.getConnection();
        PreparedStatement st = cn.prepareStatement(sql);
        st.setString(1, customer.getCusID());
        st.setString(2, customer.getCusName());
        st.setString(3, customer.getPhone());
        st.setString(4, customer.getSex());
        st.setString(5, customer.getCusAddress());
        return st.executeUpdate() > 0;
    }

    public boolean updateCustomer(Customer customer) throws Exception {
        String sql = " UPDATE Customer SET custName=?, phone=?, sex=?, cusAddress=? WHERE custID=?";
        Connection cn = DBUtils.getConnection();
        PreparedStatement st = cn.prepareStatement(sql);
        st.setString(1, customer.getCusName());
        st.setString(2, customer.getPhone());
        st.setString(3, customer.getSex());
        st.setString(4, customer.getCusAddress());
        st.setString(5, customer.getCusID());
        return st.executeUpdate() > 0;

    }

    public boolean deleteCustomer(String custID) {

        String sql = " UPDATE Customer SET  [isDeleted] = 1 where custID= " + custID;
        try (Connection cn = DBUtils.getConnection();
                PreparedStatement st = cn.prepareStatement(sql)) {
            System.out.println(sql);
            return st.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Customer> getCustomers(int page, int pageSize) {
        List<Customer> list = new ArrayList<>();
        String sql = "SELECT * FROM Customer where [isDeleted] = 0 ORDER BY custID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try (Connection cn = DBUtils.getConnection();
                PreparedStatement st = cn.prepareStatement(sql)) {
            st.setInt(1, (page - 1) * pageSize);
            st.setInt(2, pageSize);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new Customer(
                        rs.getString("custID"),
                        rs.getString("custName"),
                        rs.getString("phone"),
                        rs.getString("sex"),
                        rs.getString("cusAddress")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public Customer getCustomer(String id) {
        List<Customer> list = new ArrayList<>();
        String sql = "SELECT * FROM Customer where custID = ? ";
        try (Connection cn = DBUtils.getConnection();
                PreparedStatement st = cn.prepareStatement(sql)) {
            st.setString(1, id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                return new Customer(
                        rs.getString("custID"),
                        rs.getString("custName"),
                        rs.getString("phone"),
                        rs.getString("sex"),
                        rs.getString("cusAddress")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public int countCustomers() {
        String sql = "SELECT COUNT(*) FROM Customer where [isDeleted] = 0";
        try (Connection cn = DBUtils.getConnection();
                PreparedStatement st = cn.prepareStatement(sql);
                ResultSet rs = st.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<Customer> searchCustomersByName(String name, int page, int pageSize) {
        List<Customer> list = new ArrayList<>();
        String sql = "SELECT * FROM Customer WHERE custName LIKE ? and [isDeleted] = 0  ORDER BY custID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try (Connection cn = DBUtils.getConnection();
                PreparedStatement st = cn.prepareStatement(sql)) {
            st.setString(1, "%" + name + "%");
            st.setInt(2, (page - 1) * pageSize);
            st.setInt(3, pageSize);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new Customer(
                        rs.getString("custID"),
                        rs.getString("custName"),
                        rs.getString("phone"),
                        rs.getString("sex"),
                        rs.getString("cusAddress")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public int countSearchCustomersByName(String name) {
        String sql = "SELECT COUNT(*) FROM Customer WHERE custName LIKE ?  and [isDeleted] = 0 ";
        try (Connection cn = DBUtils.getConnection();
                PreparedStatement st = cn.prepareStatement(sql)) {
            st.setString(1, "%" + name + "%");
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

}
