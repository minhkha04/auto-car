package controller;

import dao.CustomerDAO;
import model.Customer;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "CustomerServlet", urlPatterns = {"/CustomerServlet"})
public class CustomerServlet extends HttpServlet {

    private final CustomerDAO customerDAO = new CustomerDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "list"; // Default action
        }

        switch (action) {
            case "search":
                searchCustomersByName(request, response);
                break;
            case "delete":
                deleteCustomer(request, response);
                break;
            case "update":
                String cusID = request.getParameter("cusID");
                request.setAttribute("customer", new CustomerDAO().getCustomer(cusID));
                request.setAttribute("isEdit", true);
                request.getRequestDispatcher("customer_form.jsp").forward(request, response);
                break;
            default:
                listCustomers(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        if (action == null) {
            response.sendRedirect("customers.jsp");
            return;
        }

        switch (action) {
            case "create":
                createCustomer(request, response);
                break;
            case "update":
                updateCustomer(request, response);
                break;
            case "delete":
                deleteCustomer(request, response);
                break;

        }
    }

    private void listCustomers(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int page = Integer.parseInt(request.getParameter("page") != null ? request.getParameter("page") : "1");
        int pageSize = 10000; // Set a fixed page size
        List<Customer> customers = customerDAO.getCustomers(page, pageSize);
        int totalCustomers = customerDAO.countCustomers();
        int totalPages = (int) Math.ceil((double) totalCustomers / pageSize);

        request.setAttribute("customers", customers);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.getRequestDispatcher("customers.jsp").forward(request, response);
    }

    private void searchCustomersByName(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("name");
        int page = Integer.parseInt(request.getParameter("page") != null ? request.getParameter("page") : "1");
        int pageSize = 10000;

        List<Customer> customers = customerDAO.searchCustomersByName(name, page, pageSize);
        int totalCustomers = customerDAO.countSearchCustomersByName(name);
        int totalPages = (int) Math.ceil((double) totalCustomers / pageSize);

        request.setAttribute("customers", customers);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("searchName", name);
        request.getRequestDispatcher("customers.jsp").forward(request, response);
    }

    private void createCustomer(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String custID = request.getParameter("cusID");
            String custName = request.getParameter("cusName");
            String phone = request.getParameter("phone");
            String sex = request.getParameter("sex");
            String custAddress = request.getParameter("cusAddress");

            Customer customer = new Customer(custID, custName, phone, sex, custAddress);
            boolean success = customerDAO.createCustomer(customer);

            if (success) {
                response.sendRedirect("CustomerServlet?action=list");
            } else {
                request.setAttribute("error", "Failed to create customer.");
                request.getRequestDispatcher("customer_form.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Invalid input.");
            request.getRequestDispatcher("customer_form.jsp").forward(request, response);
        }
    }

    private void updateCustomer(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String custID = request.getParameter("cusID");
            String custName = request.getParameter("cusName");
            String phone = request.getParameter("phone");
            String sex = request.getParameter("sex");
            String custAddress = request.getParameter("cusAddress");

            Customer customer = new Customer(custID, custName, phone, sex, custAddress);
            boolean success = customerDAO.updateCustomer(customer);

            if (success) {
                response.sendRedirect("CustomerServlet?action=list");
            } else {
                request.setAttribute("error", "Failed to update customer.");
                request.getRequestDispatcher("customer_form.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Invalid input.");
            request.getRequestDispatcher("customer_form.jsp").forward(request, response);
        }
    }

    private void deleteCustomer(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        boolean success = customerDAO.deleteCustomer(request.getParameter("custID"));
        response.sendRedirect("CustomerServlet?action=list");

    }
}
