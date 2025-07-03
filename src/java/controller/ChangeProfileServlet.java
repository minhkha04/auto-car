/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.CustomerDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Customer;

/**
 *
 * @author lengu
 */
public class ChangeProfileServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        request.setAttribute("mess", "Welcome");
        request.getRequestDispatcher("changeProfile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String id = request.getParameter("txtID");
        String name = request.getParameter("txtName");
        String phone = request.getParameter("txtPhone");
        String address = request.getParameter("txtAddress");
        String sex = request.getParameter("txtSex");
        String result = "";
        HttpSession session = request.getSession();
        CustomerDAO customerDAO = new CustomerDAO();
        Customer oldCustomer = (Customer) session.getAttribute("user");
        String oldName = oldCustomer.getCusName();
        String oldPhone = oldCustomer.getPhone();
        boolean flag = true;

        if (sex.isEmpty()) {
            result = "Change profile fail: Please select gender";
            flag = false;
        } else {
            boolean isNameChange = !oldName.equals(name);
            boolean isPhoneChange = !oldPhone.equals(phone);
            if (isNameChange && isPhoneChange) {
                boolean tmp = customerDAO.checkLoginCustomer(name, phone) != null;
                if (tmp) {
                    result = "Change profile fail: Name and phone already exist";
                    flag = false;
                }
            }
        }

        if (flag) {
            boolean res = customerDAO.changeProfileCustomer(id, name, phone, address, sex) > 0;
            if (res) {
                result = "Change profile success";
                Customer customer = new Customer(id, name, phone, sex, address);
                session.setAttribute("user", customer);

            } else {
                result = "Change profile fail";
            }
        }
        request.setAttribute("mess", result);
        request.getRequestDispatcher("changeProfile.jsp").forward(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
