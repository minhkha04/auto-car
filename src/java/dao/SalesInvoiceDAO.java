/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import dto.BestSellingCarDTO;
import dto.CarSalesRevenueDTO;
import dto.InvoiceDetailsDTO;
import dto.YearSalesDTO;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.Car;
import model.SalesInvoice;
import model.SalesPerson;
import mylib.DBUtils;

/**
 *
 * @author lengu
 */
public class SalesInvoiceDAO {

    Connection cn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    private List<YearSalesDTO> getAllYearSales() {
        String query = "  SELECT YEAR(invoiceDate) 'year',count([carID]) as 'total'\n"
                + "  FROM [dbo].[SalesInvoice]\n"
                + "  GROUP BY YEAR(invoiceDate)";
        Connection connection = null;
        List<YearSalesDTO> result = new ArrayList<>();
        try {
            connection = DBUtils.getConnection();
            if (connection != null) {
                PreparedStatement statement = connection.prepareStatement(query);

                ResultSet resultSet = statement.executeQuery();
                while (resultSet.next()) {
                    int year = resultSet.getInt("year");
                    int total = resultSet.getInt("total");

                    result.add(new YearSalesDTO(year, total));
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

    public List<SalesInvoice> getSalesInvoiceByCusID(String cusID) {
        List<SalesInvoice> result = new ArrayList<>();
        Connection connection = null;
        String query = "SELECT [invoiceID]\n"
                + "      ,[invoiceDate]\n"
                + "      ,[salesID]\n"
                + "      ,[carID]\n"
                + "  FROM [dbo].[SalesInvoice]\n"
                + "  WHERE [custID] = ?";
        try {
            connection = DBUtils.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, cusID);

            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()) {
                int invoiceID = resultSet.getInt("invoiceID");
                Date invoiceDate = resultSet.getDate("invoiceDate");
                String salesID = resultSet.getString("salesID");
                String carID = resultSet.getString("carID");

                SalesInvoice salesInvoice = new SalesInvoice(invoiceID, invoiceDate, salesID, carID, cusID);
                result.add(salesInvoice);

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

    public List<InvoiceDetailsDTO> getInvoiceDetailsByCusID(String cusID) {
        List<InvoiceDetailsDTO> result = new ArrayList<>();
        String query = "SELECT [invoiceID]\n"
                + "      ,[invoiceDate]\n"
                + "      ,[salesID]\n"
                + "      ,[carID]\n"
                + "  FROM [dbo].[SalesInvoice]\n"
                + "  WHERE [custID] = ?";
        Connection connection = null;
        try {
            connection = DBUtils.getConnection();
            if (connection != null) {
                PreparedStatement statement = connection.prepareStatement(query);
                statement.setString(1, cusID);

                ResultSet resultSet = statement.executeQuery();

                while (resultSet.next()) {

                    Date invoiceDate = resultSet.getDate("invoiceDate");
                    String salesID = resultSet.getString("salesID");
                    String carID = resultSet.getString("carID");
                    String invoiceID = resultSet.getString("invoiceID");
                    CarsDAO carsDAO = new CarsDAO();
                    SalesPersonDAO salesPersonDAO = new SalesPersonDAO();

                    Car car = carsDAO.getCarByCarID(carID);
                    SalesPerson salesPerson = salesPersonDAO.getSalesPersonBySalesPresonID(salesID);

                    String carModel = car.getModel();
                    String carColour = car.getColour();
                    String salesName = salesPerson.getName();
                    InvoiceDetailsDTO invoiceDetailsDTO = new InvoiceDetailsDTO(invoiceID, invoiceDate, carModel, carColour, salesName, car.getPrice());
                    result.add(invoiceDetailsDTO);
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

    public Map<YearSalesDTO, List<String>> getCarsSoldByYear() {
        Map<YearSalesDTO, List<String>> reults = new HashMap<>();
        List<YearSalesDTO> listYearSales = getAllYearSales();
        CarsDAO carsDAO = new CarsDAO();
        for (YearSalesDTO listYearSale : listYearSales) {
            List<String> model = carsDAO.getCarModelByYearSale(listYearSale.getYear());
            reults.putIfAbsent(listYearSale, model);
        }
        return reults;
    }

    public List<BestSellingCarDTO> getbeBestSellingCar() {
        String query = "  SELECT TOP 1 WITH TIES count(s.carID) as 'total', c.model\n"
                + "  FROM [dbo].[SalesInvoice] as s\n"
                + "  INNER JOIN [dbo].[Cars] as c\n"
                + "  ON s.carID = c.carID\n"
                + "  GROUP BY c.model\n"
                + "  ORDER BY count(s.carID) desc";
        Connection connection = null;
        List<BestSellingCarDTO> result = new ArrayList<>();
        try {
            connection = DBUtils.getConnection();
            if (connection != null) {
                PreparedStatement statement = connection.prepareStatement(query);

                ResultSet resultSet = statement.executeQuery();
                while (resultSet.next()) {
                    int total = resultSet.getInt("total");
                    String model = resultSet.getString("model");

                    result.add(new BestSellingCarDTO(total, model));
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

    public Map<Integer, String> getYearAndRevenue() {
        String query = " SELECT YEAR(sl.invoiceDate) as 'year', SUM(c.price) as 'total'\n"
                + " FROM Cars AS c\n"
                + " INNER JOIN SalesInvoice AS sl\n"
                + " ON c.carID = sl.carID\n"
                + " GROUP BY YEAR(sl.invoiceDate)\n";
        Connection connection = null;
        Map<Integer, String> result = new HashMap<>();
        try {
            connection = DBUtils.getConnection();
            if (connection != null) {
                PreparedStatement statement = connection.prepareStatement(query);
                ResultSet resultSet = statement.executeQuery();
                while (resultSet.next()) {
                    int year = resultSet.getInt("year");
                    String revenue = resultSet.getString("total");
                    result.putIfAbsent(year, revenue);
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

    public List<CarSalesRevenueDTO> getCarSalesRevenueByYear() {
        List<CarSalesRevenueDTO> result = new ArrayList<>();
        Map<Integer, String> yearAndRevenue = getYearAndRevenue();
        yearAndRevenue.forEach((key, value) -> {
            CarsDAO carsDAO = new CarsDAO();
            List<String> models = carsDAO.getCarModelByYearSale(key);
            CarSalesRevenueDTO carSalesRevenueDTO = new CarSalesRevenueDTO(key, value, models);
            result.add(carSalesRevenueDTO);
        });
        return result;
    }

    public int getLargestIdParts() {
        String query = "SELECT top 1 [invoiceID]\n"
                + "FROM [dbo].[SalesInvoice]\n"
                + "ORDER BY [invoiceID] desc";
        int result = -1;
        Connection connection = null;
        try {
            cn = new DBUtils().getConnection();// mo ket noi sql 
            ps = cn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                result = rs.getInt("invoiceID");
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

    public int createSalesInvoice(String invoiceDate, String salesID, String carID, String custID) {
        int result = 0;
        String query = "INSERT INTO [dbo].[SalesInvoice]\n"
                + "                          ([invoiceID]\n"
                + "                          ,[invoiceDate]\n"
                + "                          ,[salesID],\n"
                + "                             [carID],"
                + "                             [custID])\n"
                + "                VALUES (?,?,?,?,?)";
        int id = getLargestIdParts();
        if (id < 0) {
            return result;
        } else {
            id++;
        }
        try (Connection cn = new DBUtils().getConnection();
                PreparedStatement ps = cn.prepareStatement(query)) {

            // Thiết lập tham số cho SQL
            ps.setInt(1, id);
            ps.setString(2, invoiceDate);
            ps.setString(3, salesID);
            ps.setString(4, carID);
            ps.setString(5, custID);

            // Thực thi câu lệnh INSERT
            result = ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

}
