/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.CustomerDAO;
import dao.MechanicsDAO;
import dao.SalesPersonDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Customer;
import model.Mechanics;
import model.SalesPerson;

/**
 *
 * @author lengu
 */
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        response.sendRedirect("login.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        HttpSession httpSession = request.getSession();
        String role = request.getParameter("role");
        String name = request.getParameter("username");
        boolean isSuccess = false;
        String result = "";
        switch (role) {
            case "mechanic":
                MechanicsDAO mechanicsDAO = new MechanicsDAO();
                Mechanics mechanics = mechanicsDAO.getMechanicByMechanicName(name);
                if (mechanics != null) {
                    isSuccess = true;
                    httpSession.setAttribute("user", mechanics);
                    httpSession.setAttribute("role", "mechanics");
                    response.sendRedirect("dashboardMechanic.jsp");
                } else {
                    result = "Tài khoản thợ máy không tồn tại";
                }
                break;
            case "sales":
                SalesPersonDAO salesPersonDAO = new SalesPersonDAO();
                SalesPerson salesPerson = salesPersonDAO.getSaslesPersonBySalesPersonName(name);
                if (salesPerson != null) {
                    isSuccess = true;
                    httpSession.setAttribute("user", salesPerson);
                    httpSession.setAttribute("role", "salesPerson");
                    response.sendRedirect("dashboardSales.jsp");
                } else {
                    result = "Tài khoản nhân viên bán hàng không tồn tại";
                }
                break;
            case "customer":
                CustomerDAO customerDAO = new CustomerDAO();
                String phone = request.getParameter("phone");
                Customer customer = customerDAO.checkLoginCustomer(name, phone);
                if (customer != null) {
                    isSuccess = true;
                    httpSession.setAttribute("user", customer);
                    httpSession.setAttribute("role", "customer");
                    response.sendRedirect("dashboardCustomer.jsp");
                } else {
                    result = "Tài khoản khách hàng không tồn tại";
                }
                break;
        }

        if (!isSuccess) {
            request.setAttribute("result", result);
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
