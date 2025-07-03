/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.SalesInvoiceDAO;
import dto.InvoiceDetailsDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Customer;

/**
 *
 * @author lengu
 */
@WebServlet(name = "InvocieServlet", urlPatterns = {"/InvoiceServlet"})
public class InvoiceServlet extends HttpServlet {


   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession httpSession = request.getSession();
        
        Customer user = (Customer) httpSession.getAttribute("user");
        SalesInvoiceDAO salesInvoiceDAO = new SalesInvoiceDAO();
        List<InvoiceDetailsDTO> listInvoice = salesInvoiceDAO.getInvoiceDetailsByCusID(user.getCusID());
        request.setAttribute("listInvoice", listInvoice);
        request.getRequestDispatcher("invoice.jsp").forward(request, response);
    }

   
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }

  
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
