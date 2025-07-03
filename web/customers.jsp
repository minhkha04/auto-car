<%-- 
    Document   : customers
    Created on : 28/02/2025, 3:41:11 PM
    Author     : ttrrang
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Sales Dashboard</title>
         <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">

        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
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
            .sidebar-menu li:hover, .sidebar-menu li.active {
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
            .page-title {
                font-size: 1.5rem;
                margin-bottom: 1.5rem;
                color: #1e3a8a;
            }
            .actions {
                display: flex;
                gap: 1rem;
                margin-bottom: 2rem;
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
                border: none;
            }
            .button:hover {
                background-color: #2563eb;
            }
            .button-green {
                background-color: #10b981;
            }
            .button-green:hover {
                background-color: #059669;
            }
            .search-container {
                display: flex;
                align-items: center;
                gap: 1rem;
                margin-bottom: 2rem;
            }
            .search-input {
                flex: 1;
                padding: 0.5rem 1rem;
                border: 1px solid #d1d5db;
                border-radius: 4px;
                font-size: 0.875rem;
            }
            .cards {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
                gap: 1.5rem;
                margin-bottom: 2rem;
            }
            .card {
                background-color: white;
                border-radius: 8px;
                box-shadow: 0 2px 5px rgba(0,0,0,0.1);
                padding: 1.5rem;
            }
            .card-title {
                font-size: 1.1rem;
                font-weight: bold;
                margin-bottom: 1rem;
                color: #1e3a8a;
            }
            .stat-card {
                display: flex;
                flex-direction: column;
            }
            .stat-value {
                font-size: 2rem;
                font-weight: bold;
                color: #3b82f6;
                margin-bottom: 0.5rem;
            }
            .stat-label {
                font-size: 0.875rem;
                color: #6b7280;
            }
            .table-container {
                background-color: white;
                border-radius: 8px;
                box-shadow: 0 2px 5px rgba(0,0,0,0.1);
                padding: 1.5rem;
                overflow-x: auto;
                margin-bottom: 2rem;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                table-layout: fixed; /* Prevent content from expanding table */
            }
            th, td {
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
            .chart-container {
                width: 100%;
                height: 300px;
                background-color: #edf2f7;
                border-radius: 8px;
                display: flex;
                align-items: center;
                justify-content: center;
                margin-bottom: 2rem;
                font-style: italic;
                color: #64748b;
            }
            .tabs {
                display: flex;
                border-bottom: 1px solid #e5e7eb;
                margin-bottom: 1.5rem;
            }
            .tab {
                padding: 0.75rem 1.5rem;
                cursor: pointer;
            }
            .tab.active {
                border-bottom: 2px solid #3b82f6;
                color: #3b82f6;
                font-weight: 500;
            }
            .logout-button {
                background-color: #dc2626; /* Màu đỏ */
                color: white;
                padding: 0.5rem 1rem;
                border: none;
                border-radius: 4px;
                font-size: 0.875rem;
                cursor: pointer;
                transition: background-color 0.3s;
            }

            .logout-button:hover {
                background-color: #b91c1c; /* Màu đỏ đậm khi hover */
            }
            a {
                text-decoration: none;  /* Loại bỏ gạch chân */
                color: inherit;         /* Kế thừa màu chữ từ phần tử cha */
                font-weight: inherit;   /* Kế thừa độ đậm của chữ */
                font-size: inherit;     /* Kế thừa kích thước chữ */
                cursor: pointer;        /* Đảm bảo con trỏ chuột thay đổi khi hover */
                transition: color 0.3s; /* Hiệu ứng màu khi hover */
            }

            a:hover, a:focus {
                color: inherit; /* Giữ nguyên màu khi hover hoặc focus */
                text-decoration: none;
            }

            a:active {
                opacity: 0.8; /* Giảm nhẹ độ sáng khi click */
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
                        <a href="dashboardSales.jsp"><li>Dashboard</li></a>
                        <a href="CustomerServlet"><li  class="active">Customers</li></a>
                        <a href="cars"><li>Cars</li></a>
                        <a href="createServiceTicket"><li>Service Ticket</li></a>
                        <a href="PartAdminServlet"><li>Parts Inventory</li></a>
                        <a href="ReportsServlet"><li>Reports</li></a>
                    </ul>
                </div>
                <div class="content">
                    <div class="card">
                        <div class="card-body">
                            <a href="customer_form.jsp"  class="btn btn-success">Add New Customer</a>
                            <div class="card mb-0">

                                <h2>Customer List</h2>
                                <form action="CustomerServlet" method="get">
                                    <input type="hidden" name="action"   value="search">
                                    <input type="text" name="name" style=" width: 90%; display: inline-block;" class="form-control" placeholder="Search by Name" value="${searchName}">
                                    <input type="submit" class="btn btn-primary" value="Search">
                                </form>
                                <table class="table">
                                    <tr>
                                        <th>ID</th>
                                        <th>Name</th>
                                        <th>Phone</th>
                                        <th>Sex</th><th>Address</th>
                                        <th>Actions</th>
                                        <th>Actions</th>
                                        <th>Actions</th>
                                    </tr>
                                    <c:forEach var="cust" items="${customers}">
                                        <tr>
                                            <td>${cust.cusID}</td>
                                            <td>${cust.cusName}</td>
                                            <td>${cust.phone}</td>
                                            <td>${cust.sex}</td>
                                            <td>${cust.cusAddress}</td>
                                            <td>                          
                                                <a href="CustomerServlet?action=update&cusID=${cust.cusID}" class="btn btn-warning">Edit</a>
                                            </td>
                                            <td>
                                                <a  class="btn btn-danger" href="CustomerServlet?action=delete&custID=${cust.cusID}" onclick="return confirm('Are you sure?')">Delete</a>
                                            </td>
                                            <td>
                                                <a  class="btn btn-info" href="createInvoice.jsp?custID=${cust.cusID}" >Invoice</a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </table>

                                <c:if test="${totalPages > 1}">
                                    <nav aria-label="Page navigation example">
                                        <ul class="pagination">s
                                            <li class="page-item"><a class="page-link" href="#">Previous</a></li>
                                                <c:forEach var="i" begin="1" end="${totalPages}">
                                                <li class="page-item ${param.page == i?"active":""}" aria-current="page">
                                                    <a class="page-link" href="CustomerServlet?page=${i}&name=${param.name}">${i}</a>
                                                </li>
                                            </c:forEach>
                                            <li class="page-item"><a class="page-link" href="#">Next</a></li>
                                        </ul>
                                    </nav>
                                </c:if>
                            </div>

                        </div>
                    </div>






                </div>
            </div>
        </div>
    </body>
</html>