/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.PartsDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Parts;

/**
 *
 * @author nphu1
 */
@WebServlet(name = "PartAdminServlet", urlPatterns = {"/PartAdminServlet"})
public class PartAdminServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */

        }
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
//        sprocessRequest(request, response);
        PartsDAO dao = new PartsDAO();
        String action = request.getParameter("action");

        if (action == null || action.equals("list")) {
            List<Parts> list = dao.getParts();
            request.setAttribute("LIST_PART", list);
            request.getRequestDispatcher("Parts.jsp").forward(request, response);
        } else if (action.equals("delete")) {
            String id = request.getParameter("id");
            dao.deleteServiceByID(id);
            response.sendRedirect("PartAdminServlet?action=list");
        }

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
//        processRequest(request, response);
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        PartsDAO dao = new PartsDAO();
        String action = request.getParameter("action");

        if (action.equals("add")) {
            String partName = request.getParameter("partName");
            double purchasePrice = Double.parseDouble(request.getParameter("purchasePrice"));
            double retailPrice = Double.parseDouble(request.getParameter("retailPrice"));
            int result = dao.createNewPart(partName, purchasePrice, retailPrice);
            if (result == 0) {
                request.setAttribute("ERROR_MESSAGE", "Create Failed!");
                List<Parts> list = dao.getParts();
                request.setAttribute("LIST_PART", list);
                request.getRequestDispatcher("Parts.jsp").forward(request, response);
            } else {
                response.sendRedirect("PartAdminServlet?action=list");
            }
        } else if (action.equals("update")) {
            String id = request.getParameter("id");
            String partName = request.getParameter("partName");
            double purchasePrice = Double.parseDouble(request.getParameter("purchasePrice"));
            double retailPrice = Double.parseDouble(request.getParameter("retailPrice"));
            int result = dao.updateServiceByID(id, partName, purchasePrice, retailPrice);
            if (result == 0) {
                request.setAttribute("ERROR_MESSAGE", "Update Failed!");
                List<Parts> list = dao.getParts();
                request.setAttribute("LIST_PART", list);
                request.getRequestDispatcher("Parts.jsp").forward(request, response);
            } else {
                response.sendRedirect("PartAdminServlet?action=list");
            }
        }
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
