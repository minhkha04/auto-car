<%-- 
    Document   : dashboardCustomer
    Created on : 09-Mar-2025, 21:15:58
    Author     : lengu
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Customer Dashboard</title>
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
            .container {
                width: 100%;
                min-height: 100vh;
                display: flex;
                flex-direction: column;
            }
            header {
                background-color: #1e3a8a;
                color: white;
                padding: 1rem 2rem;
                display: flex;
                justify-content: space-between;
                align-items: center;
                box-shadow: 0 2px 5px rgba(0,0,0,0.1);
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
                display: flex;
                flex: 1;
            }
            .sidebar {
                width: 250px;
                background-color: #1e293b;
                color: white;
                padding: 1rem 0;
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
                flex: 1;
                padding: 2rem;
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
                box-shadow: 0 2px 5px rgba(0,0,0,0.1);
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
                box-shadow: 0 2px 5px rgba(0,0,0,0.1);
                padding: 1.5rem;
                overflow-x: auto;
            }
            table {
                width: 100%;
                border-collapse: collapse;
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
        <div class="container">
            <header>
                <div class="logo">AutoCare Garage</div>
                <div class="user-info">
                    <span>Welcome, ${sessionScope.user.cusName}</span>
                    <form action="LogoutServlet" method="">
                        <button type="submit" class="logout-button">Logout</button>
                    </form>
                </div>
            </header>
            <div class="main-content">
                <div class="sidebar">
                    <ul class="sidebar-menu">
                        <li class="active">Dashboard</li>
                        <a href="ServiceTicketCusServlet"><li>My Service Ticket</li></a>
                        <a href="InvoiceServlet"><li>My Invoices</li></a>
                        <a href="PartServlet"><li>Parts Catalog</li></a>


                        <a href="ChangeProfileServlet"><li>Edit Profile</li></a>

                    </ul>
                </div>
                <div class="content">
                    <h1 class="welcome-message">Xin chào, ${sessionScope.user.cusName}!</h1>
                    <div class="cards">
                        <div class="card">
                            <div class="card-title">Active Service Tickets</div>
                            <div style="font-size: 2rem; font-weight: bold; color: #3b82f6;">2</div>
                        </div>
                        <div class="card">
                            <div class="card-title">Completed Services</div>
                            <div style="font-size: 2rem; font-weight: bold; color: #10b981;">5</div>
                        </div>
                        <div class="card">
                            <div class="card-title">Pending Payments</div>
                            <div style="font-size: 2rem; font-weight: bold; color: #f59e0b;">1</div>
                        </div>
                    </div>

                    <div class="table-container">
                        <div class="card-title">Recent Service Tickets</div>
                        <table>
                            <thead>
                                <tr>
                                    <th>Ticket ID</th>
                                    <th>Service Date</th>
                                    <th>Car</th>
                                    <th>Service Type</th>
                                    <th>Status</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>#ST1234</td>
                                    <td>Mar 05, 2025</td>
                                    <td>Toyota Camry (2023)</td>
                                    <td>Oil Change</td>
                                    <td><span class="badge badge-yellow">In Progress</span></td>
                                    <td><a href="#" class="button">View Details</a></td>
                                </tr>
                                <tr>
                                    <td>#ST1233</td>
                                    <td>Feb 28, 2025</td>
                                    <td>Toyota Camry (2023)</td>
                                    <td>Brake Inspection</td>
                                    <td><span class="badge badge-green">Completed</span></td>
                                    <td><a href="#" class="button">View Details</a></td>
                                </tr>
                                <tr>
                                    <td>#ST1228</td>
                                    <td>Feb 15, 2025</td>
                                    <td>Toyota Camry (2023)</td>
                                    <td>Tire Rotation</td>
                                    <td><span class="badge badge-green">Completed</span></td>
                                    <td><a href="#" class="button">View Details</a></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>

                </div>
            </div>
        </div>
    </body>
</html>