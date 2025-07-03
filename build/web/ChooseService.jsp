<%@page import="model.Parts"%>
<%@page import="model.Service"%>
<%@page import="java.util.List"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : createServiceTicket
    Created on : 8/03/2025, 9:45:13 AM
    Author     : ttrrang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Select Purchase</title>

        <!-- Bootstrap 5 CDN -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">

        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            function showParts() {
                document.getElementById("partsList").style.display = "block";
                document.getElementById("servicesList").style.display = "none";
            }

            function showServices() {
                document.getElementById("partsList").style.display = "none";
                document.getElementById("servicesList").style.display = "block";
            }
        </script>
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
                    <form action="LogoutServlet" method="post">
                        <button type="submit" class="logout-button">Logout</button>
                    </form>
                </div>
            </header>
            <div class="main-content">
                <div class="sidebar">
                    <ul class="sidebar-menu p-0">
                        <a href="dashboardSales.jsp"><li>Dashboard</li></a>
                        <a href="CustomerServlet"><li>Customers</li></a>
                        <a href="cars"><li>Cars</li></a>
                        <a href="createServiceTicket"><li class="active">Service Ticket</li></a>
                        <a href="PartAdminServlet"><li >Parts Inventory</li></a>
                        <a href="ReportsServlet"><li>Reports</li></a>
                    </ul>                </div>
                <div class="content">
                    <div class="content-area">
                        <!-- Nội dung cho Nhân viên bán hàng -->
                        <div id="salesperson-content">
                            <!-- Quản lý khách hàng -->
                            <div id="customers-content">
                                <h2 class="content-title">Quản lý Khách hàng</h2>
                                <c:if test="${param.mess!=null}">
                                    <div class="alert alert-info">${param.mess}</div>
                                </c:if>

                                <div class="card">
                                    <h2 class="text-center mb-4">Chọn Loại Mua Hàng</h2>

                                    <!-- Nút chọn -->
                                    <div class="d-flex justify-content-center mb-4">
                                        <button class="btn btn-primary mx-2" onclick="showParts()">Mua Parts</button>
                                        <button class="btn btn-success mx-2" onclick="showServices()">Mua Service</button>
                                        <button class="btn btn-danger"> <a href="createServiceTicket" >Go back</a></button>

                                    </div>

                                    <!-- Danh sách Parts -->
                                    <div id="partsList" class="card shadow-lg" style="display: none;">
                                        <div class="card-header bg-primary text-white">
                                            <h4>Danh Sách Parts</h4>
                                        </div>
                                        <div class="card-body">
                                            <table class="table table-striped">
                                                <thead>
                                                    <tr>
                                                        <th>ID</th>
                                                        <th>Tên Parts</th>
                                                        <th>Giá Mua</th>
                                                        <th>Giá Bán</th>
                                                        <th>Số lượng</th>
                                                        <th>Mua</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <%
                                                        List<Parts> parts = (List<Parts>) request.getAttribute("parts");
                                                        if (parts != null) {
                                                            for (Parts p : parts) {
                                                    %>
                                                <form action="BuyPart">
                                                    <input type="hidden" name="seviceTicketId" value="${param.seviceTicketId}">
                                                    <input type="hidden" name="partId" value="<%= p.getPartID()%>">
                                                    <input type="hidden" name="price" value="<%= p.getPurchasePrice()%>">

                                                    <tr>
                                                        <td><%= p.getPartID()%></td>
                                                        <td><%= p.getPartName()%></td>
                                                        <td><%= p.getPurchasePrice()%>đ</td>
                                                        <td><%= p.getRetailPrice()%>đ</td>
                                                        <td><input type="number" class="form-control" style="display: inline-block; width: 100px; " name="quantity"/></td>
                                                        <td><button type="submit" class="btn btn-success">Mua</button></td>
                                                    </tr>
                                                </form>
                                                <%
                                                        }
                                                    }
                                                %>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>

                                    <!-- Danh sách Services -->
                                    <div id="servicesList" class="card shadow-lg" style="display: none;">
                                        <div class="card-header bg-success text-white">
                                            <h4>Danh Sách Services</h4>
                                        </div>
                                        <div class="card-body">
                                            <table class="table table-striped">
                                                <thead>
                                                    <tr>
                                                        <th>ID</th>
                                                        <th>Tên Dịch Vụ</th>
                                                        <th>Giá Theo Giờ</th>
                                                        <th>Thợ sửa</th>
                                                        <th>Số lượng</th>
                                                        <th>Mua</th>

                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <%
                                                        List<Service> services = (List<Service>) request.getAttribute("services");
                                                        if (services != null) {
                                                            for (Service s : services) {
                                                    %>
                                                <form action="BuyService">
                                                    <input type="hidden" name="seviceTicketId" value="${param.seviceTicketId}">
                                                    <input type="hidden" name="serivceId" value="<%= s.getId()%>">
                                                    <input type="hidden" name="rate" value="<%= s.getHourlyRate()%>">
                                                    <tr>

                                                        <td><%= s.getId()%></td>
                                                        <td><%= s.getName()%></td>
                                                        <td><%= s.getHourlyRate()%>đ / giờ</td>
                                                        <td>
                                                            <select class="form-select" style="display: inline-block; width: 100px; " name="mechanicId">
                                                                <c:forEach  var="m" items="${Mechanics}">
                                                                    <option value="${m.id}">${m.name}</option>

                                                                </c:forEach>
                                                            </select>
                                                        </td>
                                                        <td><input type="number" class="form-control" style="display: inline-block; width: 100px; " name="quantity"/></td>
                                                        <td><button type="submit" class="btn btn-success">Mua</button></td>
                                                    </tr>
                                                </form>

                                                <%
                                                        }
                                                    }
                                                %>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>     









                </div>
            </div>
        </div>




        <!-- JavaScript -->
        <script>

            // Hàm hiển thị nội dung theo menu
            function showContent(contentId) {
                // Danh sách tất cả các content
                const contentList = [
                    'customers-content', 'cars-content', 'service-tickets-content', 'parts-content',
                    'invoices-content', 'reports-content', 'service-tickets-mechanic-content',
                    'services-content', 'car-catalog-content', 'service-tickets-customer-content',
                    'invoices-customer-content', 'profile-content'
                ];

                // Ẩn tất cả content
                contentList.forEach(id => {
                    const element = document.getElementById(id);
                    if (element) {
                        element.style.display = 'none';
                    }
                });

                // Hiển thị content được chọn
                const selectedContent = document.getElementById(contentId + '-content');
                if (selectedContent) {
                    selectedContent.style.display = 'block';
                }

                // Xác định menu cha để cập nhật trạng thái active
                let parentMenu;
                const role = document.getElementById('role').value;

                if (role === 'salesperson' || contentId.startsWith('customers') || contentId.startsWith('cars') ||
                        contentId.startsWith('service-tickets') && !contentId.includes('customer') && !contentId.includes('mechanic') ||
                        contentId.startsWith('parts') || contentId.startsWith('invoices') && !contentId.includes('customer') ||
                        contentId.startsWith('reports')) {
                    parentMenu = document.getElementById('salesperson-menu');
                } else if (role === 'mechanic' || contentId.startsWith('service-tickets-mechanic') || contentId.startsWith('services')) {
                    parentMenu = document.getElementById('mechanic-menu');
                } else if (role === 'customer' || contentId.startsWith('car-catalog') || contentId.startsWith('service-tickets-customer') ||
                        contentId.startsWith('invoices-customer') || contentId.startsWith('profile')) {
                    parentMenu = document.getElementById('customer-menu');
                }

                // Cập nhật trạng thái active cho menu
                if (parentMenu) {
                    const menuItems = parentMenu.querySelectorAll('.menu-item');
                    menuItems.forEach(item => {
                        item.classList.remove('active');
                        if (item.getAttribute('onclick').includes(contentId)) {
                            item.classList.add('active');
                        }
                    });
                }
            }

            // Event listener cho việc thay đổi vai trò
            document.getElementById('role').addEventListener('change', function () {
                const phoneContainer = document.getElementById('phone-container');
                if (this.value === 'customer') {
                    phoneContainer.style.display = 'block';
                } else {
                    phoneContainer.style.display = 'none';
                }
            });

            // Khởi tạo: ẩn trường số điện thoại nếu không phải khách hàng
            document.addEventListener('DOMContentLoaded', function () {
                const role = document.getElementById('role').value;
                const phoneContainer = document.getElementById('phone-container');

                if (role !== 'customer') {
                    phoneContainer.style.display = 'none';
                }
            });
        </script>
    </body>
</html>