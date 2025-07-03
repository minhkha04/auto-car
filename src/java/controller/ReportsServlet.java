/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.PartUsedDAO;
import dao.SalesInvoiceDAO;
import dao.ServiceMechanicDAO;
import dto.BestSellingCarDTO;
import dto.BestUsedPartDTO;
import dto.CarSalesRevenueDTO;
import dto.MechanicMostRepairsDTO;
import dto.YearSalesDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author lengu
 */
@WebServlet(name = "ReportsServlet", urlPatterns = {"/ReportsServlet"})
public class ReportsServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        SalesInvoiceDAO salesInvoiceDAO = new SalesInvoiceDAO();
        PartUsedDAO partUsedDAO = new PartUsedDAO();
        ServiceMechanicDAO serviceMechanicDAO = new ServiceMechanicDAO();
        Map<YearSalesDTO, List<String>> carSoldByYear = salesInvoiceDAO.getCarsSoldByYear();
        List<BestSellingCarDTO> bestSellingCar = salesInvoiceDAO.getbeBestSellingCar();
        List<BestUsedPartDTO> bestUsedPart = partUsedDAO.getBestUsedPartDTOs();
        List<MechanicMostRepairsDTO> mechanicMostRepairs = serviceMechanicDAO.getTop3Mechanic();
        List<CarSalesRevenueDTO> carSalesRevenue = salesInvoiceDAO.getCarSalesRevenueByYear();

        request.setAttribute("bestUsedPart", bestUsedPart);
        request.setAttribute("mechanicMostRepairs", mechanicMostRepairs);
        request.setAttribute("bestSellingCar", bestSellingCar);
        request.setAttribute("carSoldByYear", carSoldByYear);
        request.setAttribute("carSalesRevenue", carSalesRevenue);
        
        request.getRequestDispatcher("reports.jsp").forward(request, response);
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
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
