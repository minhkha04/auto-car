/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.CarsDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Car;

/**
 *
 * @author ttrrang
 */
@WebServlet(name = "CarsServlet", urlPatterns = {"/cars"})
public class CarsServlet extends HttpServlet {
  private final CarsDAO carDAO = new CarsDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "search":
                searchCars(request, response);
                break;
            case "delete":
                deleteCar(request, response);
                break;
            case "update":
                int carID = Integer.parseInt(request.getParameter("carID"));
                request.setAttribute("car", carDAO.getCar(carID));
                request.setAttribute("isEdit", true);
                request.getRequestDispatcher("car_form.jsp").forward(request, response);
                break;
            default:
                searchCars(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String carIDStr = request.getParameter("carID");
        String action = request.getParameter("action");
        String serialNumber = request.getParameter("serialNumber");
        String model = request.getParameter("model");
        String colour = request.getParameter("colour");
        String price = request.getParameter("price");
        int year = Integer.parseInt(request.getParameter("year"));

        Car car = new Car(carIDStr, serialNumber, model, colour, year, Double.valueOf(price));
        boolean success;

        if (action.equals("create")) {
            success = carDAO.createCar(car);
        } else {
            success = carDAO.updateCar(car);
        }
        response.sendRedirect("cars?success=" + success);
    }

   private void searchCars(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    String serialNumber = request.getParameter("serialNumber");
    String model = request.getParameter("model");
    String yearStr = request.getParameter("year");
    Integer year = (yearStr != null && !yearStr.isEmpty()) ? Integer.parseInt(yearStr) : null;

    int page = 1;
    int recordsPerPage = 10000; // Adjust per requirement
    String pageStr = request.getParameter("page");
    if (pageStr != null && !pageStr.isEmpty()) {
        page = Integer.parseInt(pageStr);
    }

    List<Car> cars = carDAO.getCars(serialNumber, model, year, page, recordsPerPage);
    int totalRecords = carDAO.countCars(serialNumber, model, year);
    int totalPages = (int) Math.ceil(totalRecords * 1.0 / recordsPerPage);

    request.setAttribute("cars", cars);
    request.setAttribute("page", page);
    request.setAttribute("totalPages", totalPages);
    request.getRequestDispatcher("cars.jsp").forward(request, response);
}

    private void deleteCar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        boolean success = carDAO.deleteCar(request.getParameter("carID"));
        response.sendRedirect("cars?success=" + success);
    }

    private void listCars(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Car> cars = carDAO.getCars(null, null, null, 1, 5);
        request.setAttribute("cars", cars);
        request.getRequestDispatcher("cars.jsp").forward(request, response);
    }

}
