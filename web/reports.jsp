<%-- 
    Document   : reports
    Created on : 10-Mar-2025, 22:38:19
    Author     : lengu
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Sales Dashboard</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
              crossorigin="anonymous" />
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
           x <header>
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
                        <a href="CustomerServlet"><li>Customers</li></a>
                        <a href="cars"><li>Cars</li></a>
                        <a href="createServiceTicket"><li>Service Ticket</li></a>
                        <a href="PartAdminServlet"><li>Parts Inventory</li></a>
                        <li class="active">Reports</li>
                    </ul>
                </div>
                <div class="content">
                    <h1 class="page-title">Report</h1>
                    <div class="mt-2">
                        <c:if test="${not empty carSoldByYear}">
                            <div class="row">
                                <div class="col-4">
                                    <h4>Statistics of cars sold by year</h4>
                                </div>
                                <div class="col-3">
                                    <p class="d-inline-flex gap-1">
                                        <button class="btn btn-primary" type="button" data-bs-toggle="collapse" data-bs-target="#collapseCarSoldByYear" aria-expanded="false" aria-controls="collapseCarSoldByYear">
                                            Show
                                        </button>
                                    </p>
                                </div>
                            </div>
                            <div class="collapse" id="collapseCarSoldByYear">
                                <div class="card card-body">
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th>Year</th>
                                                <th>Number of cars sold</th>
                                                <th>Model</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="entry" items="${carSoldByYear}">
                                                <tr>
                                                    <td>${entry.key.year}</td>
                                                    <td>${entry.key.totalSales}</td>
                                                    <td>
                                                        <c:forEach var="model" items="${entry.value}" varStatus="status">
                                                            ${model}<c:if test="${!status.last}">, </c:if>
                                                        </c:forEach>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>

                        </c:if>
                    </div>
                    <div class="mt-2">
                        <c:if test="${not empty bestSellingCar}">
                            <div class="row">
                                <div class="col-4">
                                    <h4>Statistics of best-selling car models</h4>
                                </div>
                                <div class="col-3">
                                    <p class="d-inline-flex gap-1">
                                        <button class="btn btn-primary" type="button" data-bs-toggle="collapse" data-bs-target="#collapseBestSelling" aria-expanded="false" aria-controls="collapseBestSelling">
                                            Show
                                        </button>
                                    </p>
                                </div>
                            </div>
                            <div class="collapse" id="collapseBestSelling">
                                <div class="card card-body">
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th>Model</th>
                                                <th>Number of cars sold</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="item" items="${bestSellingCar}">
                                                <tr> 
                                                    <td>${item.model}</td>
                                                    <td>${item.total}</td>
                                                </tr>
                                            </c:forEach>

                                        </tbody>
                                    </table>
                                </div>
                            </div>

                        </c:if>
                    </div>
                    <div class="mt-2">
                        <c:if test="${not empty bestUsedPart}">
                            <div class="row">
                                <div class="col-4">
                                    <h4>Statistics of best used parts</h4>
                                </div>
                                <div class="col-3">
                                    <p class="d-inline-flex gap-1">
                                        <button class="btn btn-primary" type="button" data-bs-toggle="collapse" data-bs-target="#collapseBestUsed" aria-expanded="false" aria-controls="collapseBestUsed">
                                            Show
                                        </button>
                                    </p>
                                </div>
                            </div>
                            <div class="collapse" id="collapseBestUsed">
                                <div class="card card-body">
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th>Name</th>
                                                <th>Quantity</th>
                                                <th>Revenue</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="item" items="${bestUsedPart}">
                                                <tr> 
                                                    <td>${item.name}</td>
                                                    <td>${item.quantity}</td>
                                                    <td>
                                                        <fmt:formatNumber value="${item.price}" pattern="#,##0 VNĐ" />
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>

                        </c:if>
                    </div>
                    <div class="mt-2">
                        <c:if test="${not empty mechanicMostRepairs}">
                            <div class="row">
                                <div class="col-4">
                                    <h4>The 3 mechanics assigned to the most repairs</h4>
                                </div>
                                <div class="col-3">
                                    <p class="d-inline-flex gap-1">
                                        <button class="btn btn-primary" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTheMostRepair" aria-expanded="false" aria-controls="collapseTheMostRepair">
                                            Show
                                        </button>
                                    </p>
                                </div>
                            </div>
                            <div class="collapse" id="collapseTheMostRepair">
                                <div class="card card-body">
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th>Name</th>
                                                <th>Quantity</th>
                                                <th>Service</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="item" items="${mechanicMostRepairs}">
                                                <tr> 
                                                    <td>${item.name}</td>
                                                    <td>${item.total}</td>
                                                    <td>
                                                        <c:forEach var="service" items="${item.service}" varStatus="status">
                                                            ${service}<c:if test="${!status.last}">, </c:if>
                                                        </c:forEach>
                                                    </td>
                                                </tr>
                                            </c:forEach>

                                        </tbody>
                                    </table>
                                </div>
                            </div>

                        </c:if>
                    </div>
                    <div class="mt-2">
                        <c:if test="${not empty carSalesRevenue}">
                            <div class="row">
                                <div class="col-4">
                                    <h4>Statistics of car sales revenue by year</h4>
                                </div>
                                <div class="col-3">
                                    <p class="d-inline-flex gap-1">
                                        <button class="btn btn-primary" type="button" data-bs-toggle="collapse" data-bs-target="#collapseRevenueByYear" aria-expanded="false" aria-controls="collapseRevenueByYear">
                                            Show
                                        </button>
                                    </p>
                                </div>
                            </div>
                            <div class="collapse" id="collapseRevenueByYear">
                                <div class="card card-body">
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th>Year</th>
                                                <th>Revenue</th>
                                                <th>Model</th>

                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="item" items="${carSalesRevenue}">
                                                <tr> 
                                                    <td>${item.year}</td>
                                                    <td>
                                                        <fmt:formatNumber value="${item.revenue}" pattern="#,##0 VNĐ" />
                                                    </td>
                                                    <td>
                                                        <c:forEach var="model" items="${item.model}" varStatus="status">
                                                            ${model}<c:if test="${!status.last}">, </c:if>
                                                        </c:forEach>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </c:if>
                    </div>





                </div>
            </div>
        </div>
    </body>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"
            integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r"
    crossorigin="anonymous"></script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js"
            integrity="sha384-BBtl+eGJRgqQAUMxJ7pMwbEyER4l1g+O15P+16Ep7Q9Q+zqX6gSbd85u4mG4QzX+"
    crossorigin="anonymous"></script>
</html>
