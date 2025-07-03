/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.ServiceDAO;
import dao.ServiceMechanicDAO;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Service;
import model.ServiceMechanic;

/**
 *
 * @author lengu
 */
public class ServiceServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        ServiceDAO serviceDAO = new ServiceDAO();
        List<Service> list = serviceDAO.getAllService();
        request.setAttribute("list", list);
        request.setAttribute("mess", "Welcome");
        request.getRequestDispatcher("service.jsp").forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String method = request.getParameter("txtMethod");
        ServiceDAO serviceDAO = new ServiceDAO();
        ServiceMechanicDAO serviceMechanicDAO = new ServiceMechanicDAO();
        boolean result = false;
        String mess = "";
        String id = "";
        String name = "";
        String hourlyRate = "";
        boolean isExisted = false;
        switch (method) {
            case "create":
                name = request.getParameter("txtName");
                isExisted = serviceDAO.getServiceByName(name) != null;
                if (isExisted) {
                    mess = "Service has been existed";
                    break;
                }
                hourlyRate = request.getParameter("txtHourlyRate");
                result = serviceDAO.createNewService(name, hourlyRate) > 0;
                mess = result ? "Create success" : "Create fail";
                break;
            case "delete":
                id = request.getParameter("txtId");
                result = serviceDAO.deleteServiceByID(id) > 0;
                mess = result ? "Delete succsess" : "Delete fail";
                break;
            case "update":
                name = request.getParameter("txtName");
                String oldName = request.getParameter("txtOldName");
                if (!oldName.equalsIgnoreCase(name)) {
                    isExisted = serviceDAO.getServiceByName(name) != null;
                    if (isExisted) {
                        mess = "Service has been existed";
                        break;
                    }
                }
                hourlyRate = request.getParameter("txtHourlyRate");
                id = request.getParameter("txtId");
                List<ServiceMechanic> listServiceMechanic = serviceMechanicDAO.getServiceMechanicByServiceId(id);
                
                result = serviceDAO.updateServiceByID(id, name, hourlyRate) > 0;
                mess = result ? "Update succsess" : "Update fail";
                break;
        }

        List<Service> list = serviceDAO.getAllService();
        request.setAttribute("list", list);
        request.setAttribute("mess", mess);
        request.getRequestDispatcher("service.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
