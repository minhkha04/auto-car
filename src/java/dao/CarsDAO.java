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
import model.Car;
import mylib.DBUtils;

/**
 *
 * @author lengu
 */
public class CarsDAO {

    public Car getCarByCarID(String id) {
        Car result = null;
        Connection connection = null;
        String query = "SELECT [serialNumber]\n"
                + "      ,[model]\n"
                + "      ,[colour]\n"
                + "      ,[year]\n"
                + "      ,[price]\n"
                + "  FROM [dbo].[Cars]\n"
                + "  WHERE [carID] = ?";
        try {
            connection = DBUtils.getConnection();
            if (connection != null) {
                PreparedStatement statement = connection.prepareStatement(query);
                statement.setString(1, id);

                ResultSet resultSet = statement.executeQuery();
                while (resultSet.next()) {
                    String serialNumber = resultSet.getString("serialNumber");
                    String model = resultSet.getString("model");
                    String colour = resultSet.getString("colour");
                    int year = resultSet.getInt("year");
                    double price = resultSet.getDouble("price");
                    result = new Car(id, serialNumber, model, colour, year, price);
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

    public List<String> getCarModelByYearSale(int year) {
        String query = "SELECT C.model\n"
                + "FROM SalesInvoice S\n"
                + "INNER JOIN Cars C\n"
                + "ON S.carID = C.carID\n"
                + "WHERE YEAR(S.invoiceDate) = ?\n"
                + "GROUP BY C.model";
        Connection connection = null;
        List<String> result = new ArrayList<>();
        try {
            connection = DBUtils.getConnection();
            if (connection != null) {
                PreparedStatement statement = connection.prepareStatement(query);
                statement.setInt(1, year);

                ResultSet resultSet = statement.executeQuery();
                while (resultSet.next()) {
                    String model = resultSet.getString("model");
                    result.add(model);
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

    public boolean createCar(Car car) {
        String sql = "INSERT INTO Cars (serialNumber, model, colour, year,price,carID) VALUES (?, ?, ?, ?,?,?)";
        try (Connection cn = DBUtils.getConnection(); PreparedStatement st = cn.prepareStatement(sql)) {
            st.setString(1, car.getSerialNumber());
            st.setString(2, car.getModel());
            st.setString(3, car.getColour());
            st.setInt(4, car.getYear());
            st.setDouble(5, car.getPrice());
            st.setString(6, car.getCarID());
            return st.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateCar(Car car) {
        String sql = "UPDATE Cars SET serialNumber=?, model=?, colour=?, year=?,price = ? WHERE carID=?";
        try (Connection cn = DBUtils.getConnection(); PreparedStatement st = cn.prepareStatement(sql)) {
            st.setString(1, car.getSerialNumber());
            st.setString(2, car.getModel());
            st.setString(3, car.getColour());
            st.setInt(4, car.getYear());
            st.setDouble(5, car.getPrice());
            st.setString(6, car.getCarID());
            return st.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteCar(String carID) {
        String sql = " DELETE FROM  SalesInvoice WHERE carID=  " + carID
                + "  DELETE FROM  PartsUsed WHERE serviceTicketID in ( select serviceTicketID from ServiceTicket WHERE carID=  "+carID+")\n"
                + "  DELETE FROM  ServiceMehanic WHERE serviceTicketID in ( select serviceTicketID from ServiceTicket WHERE carID= "+carID+")\n"
                + "  DELETE FROM  ServiceTicket WHERE carID=  " + carID
                + "DELETE FROM Cars WHERE carID= " + carID;
        try (Connection cn = DBUtils.getConnection(); PreparedStatement st = cn.prepareStatement(sql)) {
            return st.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public Car getCar(int id) {
        StringBuilder sql = new StringBuilder("SELECT * FROM Cars WHERE [carID] = " + id);
        try (Connection cn = DBUtils.getConnection(); PreparedStatement st = cn.prepareStatement(sql.toString())) {
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                return new Car(
                        rs.getString("carID"),
                        rs.getString("serialNumber"),
                        rs.getString("model"),
                        rs.getString("colour"),
                        rs.getInt("year"),
                        rs.getDouble("price"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Car> getCars(String serialNumber, String model, Integer year, int page, int pageSize) {
        List<Car> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM Cars WHERE 1=1");
        if (serialNumber != null && !serialNumber.isEmpty()) {
            sql.append(" AND serialNumber = ?");
        }
        if (model != null && !model.isEmpty()) {
            sql.append(" AND model LIKE ?");
        }
        if (year != null) {
            sql.append(" AND year = ?");
        }
        sql.append(" ORDER BY carID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        System.out.println("=====serialNumber  " + serialNumber);
        try (Connection cn = DBUtils.getConnection(); PreparedStatement st = cn.prepareStatement(sql.toString())) {
            int index = 1;
            if (serialNumber != null && !serialNumber.isEmpty()) {
                st.setString(index++, serialNumber.trim());
            }
            if (model != null && !model.isEmpty()) {
                st.setString(index++, "%" + model.trim() + "%");
            }
            if (year != null) {
                st.setInt(index++, year);
            }
            st.setInt(index++, (page - 1) * pageSize);
            st.setInt(index++, pageSize);

            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new Car(
                        rs.getString("carID"),
                        rs.getString("serialNumber"),
                        rs.getString("model"),
                        rs.getString("colour"),
                        rs.getInt("year"), rs.getDouble("price")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public int countCars(String serialNumber, String model, Integer year) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM Cars WHERE 1=1");
        if (serialNumber != null && !serialNumber.isEmpty()) {
            sql.append(" AND serialNumber LIKE ?");
        }
        if (model != null && !model.isEmpty()) {
            sql.append(" AND model LIKE ?");
        }
        if (year != null) {
            sql.append(" AND year = ?");
        }

        try (Connection cn = DBUtils.getConnection(); PreparedStatement st = cn.prepareStatement(sql.toString())) {
            int index = 1;
            if (serialNumber != null && !serialNumber.isEmpty()) {
                st.setString(index++, "%" + serialNumber + "%");
            }
            if (model != null && !model.isEmpty()) {
                st.setString(index++, "%" + model + "%");
            }
            if (year != null) {
                st.setInt(index++, year);
            }

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
