<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Sales Dashboard</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous" />
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }

            body {
                background-color: #f5f5f5;
            }

            .my_container {
                padding-top: 0;
                width: 100%;
                min-height: 100vh;
                display: block; /* Changed from flex to block */
            }

            header {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                z-index: 1000;
                background-color: #1e3a8a;
                color: white;
                padding: 1rem 2rem;
                display: flex;
                justify-content: space-between;
                align-items: center;
                box-shadow: 0 2px 5px rgba(0,0,0,0.1);
                height: 64px; /* Set explicit height */
            }

            .logo {
                font-size: 1.5rem;
                font-weight: bold;
            }

            .user-info {
                display: flex;
                align-items: center;
                gap: 1rem;
            }

            .user-info .avatar {
                width: 40px;
                height: 40px;
                border-radius: 50%;
                background-color: #6b7280;
                display: flex;
                align-items: center;
                justify-content: center;
                color: white;
                font-weight: bold;
            }

            .main-content {
                display: block; /* Changed from flex */
                padding-top: 64px; /* Make space for fixed header */
                min-height: 100vh;
            }

            .sidebar {
                position: fixed;
                top: 64px; /* Match header height */
                left: 0;
                width: 250px;
                height: calc(100vh - 64px);
                background-color: #1e293b;
                color: white;
                padding: 1rem 0;
                overflow-y: auto;
                z-index: 900;
            }

            .sidebar-menu {
                list-style: none;
            }

            .sidebar-menu li {
                padding: 0.75rem 1.5rem;
                cursor: pointer;
                transition: background-color 0.3s;
            }

            .sidebar-menu li:hover,
            .sidebar-menu li.active {
                background-color: #2c3e50;
            }

            .sidebar-menu li.active {
                border-left: 4px solid #3b82f6;
            }

            .content {
                margin-left: 250px; /* Same as sidebar width */
                padding: 2rem;
                min-height: calc(100vh - 64px);
            }

            .welcome-message {
                font-size: 1.8rem;
                margin-bottom: 2rem;
                color: #1e3a8a;
            }

            .page-title {
                font-size: 1.5rem;
                margin-bottom: 1.5rem;
                color: #1e3a8a;
            }

            .cards {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
                gap: 1.5rem;
                margin-bottom: 2rem;
            }

            .card {
                background-color: white;
                border-radius: 8px;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
                padding: 1.5rem;
            }

            .card-title {
                font-size: 1.1rem;
                font-weight: bold;
                margin-bottom: 1rem;
                color: #1e3a8a;
            }

            .table-container {
                background-color: white;
                border-radius: 8px;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
                padding: 1.5rem;
                overflow-x: auto;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                table-layout: fixed; /* Prevent content from expanding table */
            }

            th,
            td {
                padding: 0.75rem 1rem;
                text-align: left;
                border-bottom: 1px solid #e5e7eb;
            }

            th {
                background-color: #f3f4f6;
                font-weight: 600;
            }

            tr:hover {
                background-color: #f9fafb;
            }

            .badge {
                display: inline-block;
                padding: 0.25rem 0.5rem;
                border-radius: 9999px;
                font-size: 0.75rem;
                font-weight: 500;
            }

            .badge-blue {
                background-color: #dbeafe;
                color: #1e40af;
            }

            .badge-green {
                background-color: #dcfce7;
                color: #166534;
            }

            .badge-yellow {
                background-color: #fef3c7;
                color: #92400e;
            }

            .badge-red {
                background-color: #fee2e2;
                color: #b91c1c;
            }

            .button {
                display: inline-block;
                padding: 0.5rem 1rem;
                background-color: #3b82f6;
                color: white;
                border-radius: 4px;
                text-decoration: none;
                font-size: 0.875rem;
                cursor: pointer;
            }

            .button:hover {
                background-color: #2563eb;
            }

            .logout-button {
                background-color: #dc2626;
                /* Màu đỏ */
                color: white;
                padding: 0.5rem 1rem;
                border: none;
                border-radius: 4px;
                font-size: 0.875rem;
                cursor: pointer;
                transition: background-color 0.3s;
            }

            .logout-button:hover {
                background-color: #b91c1c;
                /* Màu đỏ đậm khi hover */
            }

            a {
                text-decoration: none;
                /* Loại bỏ gạch chân */
                color: inherit;
                /* Kế thừa màu chữ từ phần tử cha */
                font-weight: inherit;
                /* Kế thừa độ đậm của chữ */
                font-size: inherit;
                /* Kế thừa kích thước chữ */
                cursor: pointer;
                /* Đảm bảo con trỏ chuột thay đổi khi hover */
                transition: color 0.3s;
                /* Hiệu ứng màu khi hover */
            }

            a:hover,
            a:focus {
                color: inherit;
                /* Giữ nguyên màu khi hover hoặc focus */
                text-decoration: none;
            }

            a:active {
                opacity: 0.8;
                /* Giảm nhẹ độ sáng khi click */
            }
        </style>
    </head>
    <body>
        <div class="my_container">
            <header>
                <div class="logo">AutoCare Garage</div>
                <div class="user-info">
                    <span>Welcome, ${sessionScope.user.name}</span>
                    <form action="LogoutServlet" method="">
                        <button type="submit" class="logout-button">Logout</button>
                    </form>
                </div>
            </header>
            <div class="main-content">
                <div class="sidebar">
                    <ul class="sidebar-menu p-0">
                        <a href="dashboardMechanic.jsp"><li>Dashboard</li></a>
                        <a href="ServiceTicketServlet"><li  class="active">Service Tickets</li></a>
                        <a href="ServiceServlet"><li>Services</li></a>
                    </ul>
                </div>
                <div class="content">
                    <c:if test="${not empty mess  and mess ne ''}">
                        <div id="messageBox" class="alert alert-success col-2 d-flex justify-content-between align-items-center position-fixed z-3 end-0 me-2">
                            <p class="m-0">${mess}</p>
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>

                    </c:if>
                    <h1 class="page-title">Search Service Tickets</h1>
                    <form method="get" action="ServiceTicketServlet">
                        Customer ID: <input type="text" name="custID" value="<%= request.getParameter("custID") != null ? request.getParameter("custID") : ""%>">
                        Car ID: <input type="text" name="carID" value="<%= request.getParameter("carID") != null ? request.getParameter("carID") : ""%>">
                        Date Received: <input type="date" name="dateReceived" value="<%= request.getParameter("dateReceived") != null ? request.getParameter("dateReceived") : ""%>">
                        <button type="submit" class="btn btn-primary">Search</button>
                    </form>

                    <h1 class="page-title py-3">Service Tickets</h1>
                    <%
                        List<Object[]> tickets = (List<Object[]>) request.getAttribute("tickets");
                        if (tickets == null || tickets.isEmpty()) {
                    %>
                    <p>No service tickets found.</p>
                    <%
                    } else {
                    %>
                    <table class="table">
                        <tr>
                            <th>ID</th>
                            <th>Date Received</th>
                            <th>Date Returned</th>
                            <th>Customer Name</th>
                            <th>Service Name</th>
                            <th>Mechanic Name</th>
                            <th>Customer Id</th>
                            <th>Car Id</th>
                            <th>Hours</th>
                            <th>Hourly Rate</th>
                            <th>Comment</th>
                            <th>Action</th>
                        </tr>
                        <%
                            for (Object[] row : tickets) {
                        %>
                        <tr>
                            <td><%= row[0]%></td>
                            <td><%= row[1]%></td>
                            <td><%= row[2]%></td>
                            <td><%= row[3]%></td>    
                            <td><%= row[4]%></td>
                            <td><%= row[5]%></td>
                            <td><%= row[6]%></td>
                            <td><%= row[7]%></td>
                            <td><%= row[8]%></td>
                            <td><fmt:formatNumber value="<%= row[9]%>" pattern="#,##0 VNĐ" /></td>
                            <td><%= row[10]%></td>
                            <td>
                                <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modalUdpate<%= row[0]%><%= row[11]%>">
                                    Edit
                                </button>
                            </td>
                        </tr>
                        <div class="modal fade" id="modalUdpate<%= row[0]%><%= row[11]%>" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                            <div class="modal-dialog modal-dialog-centered">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h1 class="modal-title fs-5" id="exampleModalLabel">Edit Service Ticket</h1>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <form method="POST" action="ServiceTicketServlet">
                                        <input type="hidden" id="ticketId" name="txtIdTicket" value="<%= row[0]%>">
                                        <input type="hidden" id="serviceId" name="txtIdService" value="<%= row[11]%>">
                                        <div class="modal-body">
                                            <div class="mb-3">
                                                <label for="hours" class="form-label">Hours:</label>
                                                <input type="number" class="form-control" name="txtHours" id="hours" required value="<%= row[8]%>" min="1"/>
                                            </div>

                                            <div class="mb-3">
                                                <label for="rate" class="form-label">Hourly Rate:</label>
                                                <input type="number" class="form-control" name="txthourlyRate" id="rate" required min="1" value="<%= row[9]%>"/>
                                            </div>

                                            <div class="mb-3">
                                                <label for="comment" class="form-label">Comment:</label>
                                                <input type="text" class="form-control" name="txtComment" id="comment" required value="<%= row[10]%>"/>
                                            </div>
                                        </div>


                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                            <button class="btn btn-primary"type="submit" name="method" value="update">Save Changes</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                        <%
                            }
                        %>
                    </table>
                    <%
                        }
                    %>
                    <!-- Form Modal để chỉnh sửa -->

                </div>
            </div>
        </div>
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const hoursInput = document.getElementById("hours");
                const rateInput = document.getElementById("rate");
                const hourlyrateInput = document.getElementById("hourlyRate").value * 1;

                hoursInput.addEventListener("input", function () {
                    let hours = parseFloat(hoursInput.value) || 0; // Lấy giá trị của hours, mặc định là 0 nếu rỗng
                    rateInput.value = (hours * hourlyrateInput).toFixed(2); // Nhân với 5 và làm tròn 2 số thập phân
                });
            });
            document.addEventListener("DOMContentLoaded", function () {
                const messageBox = document.getElementById("messageBox");
                if (messageBox) {
                    setTimeout(() => {
                        messageBox.style.transition = "opacity 0.5s"; // Hiệu ứng mờ dần
                        messageBox.style.opacity = "0";
                        setTimeout(() => messageBox.remove(), 500); // Xóa hẳn sau khi mờ
                    }, 5000); // Ẩn sau 5 giây
                }
            });
        </script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"
                integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r"
        crossorigin="anonymous"></script>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js"
                integrity="sha384-BBtl+eGJRgqQAUMxJ7pMwbEyER4l1g+O15P+16Ep7Q9Q+zqX6gSbd85u4mG4QzX+"
        crossorigin="anonymous"></script>
    </body>
</html>