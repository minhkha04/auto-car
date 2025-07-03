<%-- 
    Document   : Part
    Created on : Mar 4, 2025, 11:15:09 PM
    Author     : nphu1
--%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Parts" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
    <head>
        <title>Parts List</title>
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
                        <a href="createServiceTicket"><li>Service Ticket</li></a>
                        <a href="PartAdminServlet"><li class="active">Parts Inventory</li></a>
                        <a href="ReportsServlet"><li>Reports</li></a>
                    </ul>
                </div>
                <div class="content">
                    <h1 class="page-title">Parts Inventory</h1>

                    <%
                        String errorMessage = (String) request.getAttribute("ERROR_MESSAGE");
                        if (errorMessage != null) {
                    %>
                    <div style="color: red; font-weight: bold;">
                        <%= errorMessage%>
                    </div>
                    <% }%>
                    <div class="form-card">
                        <h2 class="form-card-title">
                            <i class="bi bi-plus-circle me-2"></i>Add New Part
                        </h2>
                        <form action="PartAdminServlet" method="post">
                            <input type="hidden" name="action" value="add">
                            <div class="form-row">
                                <div class="form-group">
                                    <label for="partName" class="form-label">Part Name</label>
                                    <input type="text" name="partName" id="partName" class="form-control" required placeholder="Enter part name">
                                </div>
                                <div class="form-group">
                                    <label for="purchasePrice" class="form-label">Purchase Price</label>
                                    <div class="input-group">
                                        <span class="input-group-text">VNĐ</span>
                                        <input type="number" step="0.01" min="1" name="purchasePrice" id="purchasePrice" class="form-control" required placeholder="0.00">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="retailPrice" class="form-label">Retail Price</label>
                                    <div class="input-group">
                                        <span class="input-group-text">VNĐ</span>
                                        <input type="number" step="0.01" min="1" name="retailPrice" id="retailPrice" class="form-control" required placeholder="0.00">
                                    </div>
                                </div>
                            </div>
                            <div class="mt-3">
                                <button type="submit" class="btn btn-success">
                                    <i class="bi bi-save me-1"></i> Create Part
                                </button>
                                <button type="reset" class="btn btn-secondary ms-2">
                                    <i class="bi bi-x-circle me-1"></i> Reset
                                </button>
                            </div>
                        </form>
                    </div>

                    <div class="search-box my-4">
                        <h2>🔍 Tìm kiếm linh kiện</h2>

                        <form action="SearchSaleServlet" method="get">
                            <input type="text" name="keyword" placeholder="Nhập tên linh kiện..."
                                   value="<%= request.getAttribute("keyword") != null ? request.getAttribute("keyword") : ""%>">
                            <button type="submit">🔍 Tìm kiếm</button>
                        </form>
                    </div>
                    <div class="table-responsive">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Part Name</th>
                                    <th>Purchase Price</th>
                                    <th>Retail Price</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                           <tbody>
                                <%-- Check if filteredParts exists --%>
                                <c:forEach var="part" items="${searchResults != null ? searchResults : LIST_PART}">
                                    <tr id="displayRow_${part.partID}">
                                        <td>${part.partID}</td>
                                        <td>${part.partName}</td>
                                        <td>
                                            <fmt:formatNumber value="${part.purchasePrice}" pattern="#,##0 VNĐ" />
                                        </td>
                                        <td>
                                            <fmt:formatNumber value="${part.retailPrice}" pattern="#,##0 VNĐ" />
                                        </td>
                                        <td>
                                            <div class="action-buttons">
                                                <button type="button" class="btn btn-warning edit-btn" data-id="${part.partID}">
                                                    <i class="bi bi-pencil-square"></i> Edit
                                                </button>
                                                <a href="PartAdminServlet?action=delete&id=${part.partID}" 
                                                   class="btn btn-danger" 
                                                   onclick="return confirm('Are you sure you want to delete this part?')">
                                                    <i class="bi bi-trash"></i> Delete
                                                </a>
                                            </div>
                                        </td>
                                    </tr>

                                    <tr id="editRow_${part.partID}" style="display: none;">
                                <form action="PartAdminServlet" method="post">
                                    <input type="hidden" name="action" value="update">
                                    <input type="hidden" name="id" value="${part.partID}">
                                    <td>${part.partID}</td>
                                    <td>
                                        <input type="text" name="partName" value="${part.partName}" class="form-control" required>
                                    </td>
                                    <td>
                                        <div class="input-group">
                                            <span class="input-group-text">$</span>
                                            <input type="number" step="0.01" min="1" name="purchasePrice" value="${part.purchasePrice}" class="form-control" required>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="input-group">
                                            <span class="input-group-text">$</span>
                                            <input type="number" step="0.01" min="1" name="retailPrice" value="${part.retailPrice}" class="form-control" required>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="action-buttons">
                                            <button type="submit" class="btn btn-success">
                                                <i class="bi bi-check-circle"></i> Save
                                            </button>
                                            <button type="button" class="btn btn-secondary cancel-btn" data-id="${part.partID}">
                                                <i class="bi bi-x-circle"></i> Cancel
                                            </button>
                                        </div>
                                    </td>
                                </form>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <script>
            $(document).ready(function () {
                $('.edit-btn').click(function () {
                    var id = $(this).data('id');
                    $('#displayRow_' + id).hide();
                    $('#editRow_' + id).show();
                });

                $('.cancel-btn').click(function () {
                    var id = $(this).data('id');
                    $('#editRow_' + id).hide();
                    $('#displayRow_' + id).show();
                });
            });
        </script>
    </body>
</html>