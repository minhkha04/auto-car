/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.ServiceMechanicDAO;
import dao.ServiceTicketDAO;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Mechanics;

/**
 *
 * @author lengu
 */
@WebServlet(name = "ServiceTicketServlet", urlPatterns = {"/ServiceTicketServlet"})
public class ServiceTicketServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        ServiceTicketDAO dao = new ServiceTicketDAO();

        // Lấy tham số từ request
        String custIDParam = request.getParameter("custID");
        String carIDParam = request.getParameter("carID");
        String dateReceivedParam = request.getParameter("dateReceived");

        // Chuyển đổi giá trị từ String sang kiểu dữ liệu phù hợp
        Integer custID = (custIDParam != null && !custIDParam.isEmpty()) ? Integer.parseInt(custIDParam) : null;
        Integer carID = (carIDParam != null && !carIDParam.isEmpty()) ? Integer.parseInt(carIDParam) : null;

        String dateReceived = null;
        if (dateReceivedParam != null && !dateReceivedParam.trim().isEmpty()) {
            try {
                dateReceived = LocalDate.parse(dateReceivedParam).toString(); // Định dạng đúng
            } catch (Exception e) {
                dateReceived = null; // Nếu sai định dạng, bỏ qua
            }
        }

        // Giữ nguyên cơ chế mechanicID mặc định
        HttpSession httpSession = request.getSession();
        Mechanics user = (Mechanics) httpSession.getAttribute("user");
        String mechanicID = user.getId();

        // Gọi DAO để lấy dữ liệu
        List<Object[]> list;
        if (custID != null || carID != null || dateReceived != null) {
            list = dao.searchServiceTicket(custID, carID, dateReceived, mechanicID);
        } else {
            list = dao.getServiceTickets(mechanicID);
        }

        // Gửi dữ liệu tới JSP
        request.setAttribute("tickets", list);

        request.getRequestDispatcher("serviceTicket.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("mess", "Welcome");
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String method = request.getParameter("method");

        ServiceMechanicDAO serviceMechanicDAO = new ServiceMechanicDAO();
        boolean result = false;
        String mess = "";
        switch (method) {
            case "update":
                String idTicket = request.getParameter("txtIdTicket");
                String hours = request.getParameter("txtHours");
                String comment = request.getParameter("txtComment");
                String rate = request.getParameter("txthourlyRate");
                String idService = request.getParameter("txtIdService");
                hours = String.valueOf((int)Double.parseDouble(hours));
                System.out.println(hours);
                System.out.println(idTicket + hours + " " + comment + " " + rate + " " + idService);
                result = serviceMechanicDAO.updateServiceMechanic(idTicket, idService, hours, comment, rate) > 0;
                mess = result ? "Update success" : "Update fail";

                break;
        }
        request.setAttribute("mess", mess);
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
