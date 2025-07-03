<%-- 
    Document   : dashboardSales
    Created on : 09-Mar-2025, 21:12:01
    Author     : lengu
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Sales Dashboard</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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
                display: flex;
                align-items: center;
            }
            .logo i {
                margin-right: 10px;
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
                display: flex;
                align-items: center;
            }
            .sidebar-menu li i {
                margin-right: 10px;
                width: 20px;
                text-align: center;
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
                display: flex;
                align-items: center;
            }
            .page-title i {
                margin-right: 10px;
                color: #3b82f6;
            }
            .actions {
                display: flex;
                gap: 1rem;
                margin-bottom: 2rem;
            }
            .button {
                display: inline-flex;
                align-items: center;
                padding: 0.5rem 1rem;
                background-color: #3b82f6;
                color: white;
                border-radius: 4px;
                text-decoration: none;
                font-size: 0.875rem;
                cursor: pointer;
                border: none;
                transition: all 0.2s;
            }
            .button i {
                margin-right: 8px;
            }
            .button:hover {
                background-color: #2563eb;
                transform: translateY(-1px);
                box-shadow: 0 2px 5px rgba(0,0,0,0.1);
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
                position: relative;
            }
            .search-input {
                flex: 1;
                padding: 0.5rem 1rem 0.5rem 2.5rem;
                border: 1px solid #d1d5db;
                border-radius: 4px;
                font-size: 0.875rem;
                transition: all 0.2s;
            }
            .search-input:focus {
                border-color: #3b82f6;
                outline: none;
                box-shadow: 0 0 0 2px rgba(59, 130, 246, 0.3);
            }
            .search-icon {
                position: absolute;
                left: 10px;
                color: #6b7280;
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
                transition: transform 0.2s, box-shadow 0.2s;
            }
            .card:hover {
                transform: translateY(-5px);
                box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            }
            .card-title {
                font-size: 1.1rem;
                font-weight: bold;
                margin-bottom: 1rem;
                color: #1e3a8a;
                display: flex;
                align-items: center;
            }
            .card-title i {
                margin-right: 8px;
                color: #3b82f6;
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
            .stat-change {
                display: flex;
                align-items: center;
                font-size: 0.875rem;
                margin-top: 8px;
            }
            .stat-change.positive {
                color: #10b981;
            }
            .stat-change.negative {
                color: #ef4444;
            }
            .stat-change i {
                margin-right: 4px;
            }
            .table-container {
                background-color: white;
                border-radius: 8px;
                box-shadow: 0 2px 5px rgba(0,0,0,0.1);
                padding: 1.5rem;
                overflow-x: auto;
                margin-bottom: 2rem;
            }
            .table-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 1rem;
            }
            .table-title {
                font-size: 1.1rem;
                font-weight: bold;
                color: #1e3a8a;
                display: flex;
                align-items: center;
            }
            .table-title i {
                margin-right: 8px;
                color: #3b82f6;
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
                background-color: white;
                border-radius: 8px;
                box-shadow: 0 2px 5px rgba(0,0,0,0.1);
                padding: 1.5rem;
                margin-bottom: 2rem;
            }
            .chart-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 1rem;
            }
            .chart-title {
                font-size: 1.1rem;
                font-weight: bold;
                color: #1e3a8a;
                display: flex;
                align-items: center;
            }
            .chart-title i {
                margin-right: 8px;
                color: #3b82f6;
            }
            .chart {
                width: 100%;
                height: 300px;
            }
            .tabs {
                display: flex;
                border-bottom: 1px solid #e5e7eb;
                margin-bottom: 1.5rem;
            }
            .tab {
                padding: 0.75rem 1.5rem;
                cursor: pointer;
                transition: all 0.2s;
            }
            .tab:hover {
                background-color: #f3f4f6;
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
                display: flex;
                align-items: center;
            }
            .logout-button i {
                margin-right: 6px;
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
            .grid-2 {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 1.5rem;
            }
            @media (max-width: 1024px) {
                .grid-2 {
                    grid-template-columns: 1fr;
                }
            }
            .recent-activity {
                margin-top: 1rem;
            }
            .activity-item {
                display: flex;
                align-items: flex-start;
                padding: 1rem 0;
                border-bottom: 1px solid #e5e7eb;
            }
            .activity-icon {
                width: 36px;
                height: 36px;
                border-radius: 50%;
                background-color: #dbeafe;
                color: #3b82f6;
                display: flex;
                align-items: center;
                justify-content: center;
                margin-right: 1rem;
                flex-shrink: 0;
            }
            .activity-content {
                flex-grow: 1;
            }
            .activity-title {
                font-weight: 500;
                margin-bottom: 0.25rem;
            }
            .activity-time {
                font-size: 0.75rem;
                color: #6b7280;
            }
            .dashboard-footer {
                margin-top: 2rem;
                padding-top: 1rem;
                border-top: 1px solid #e5e7eb;
                color: #6b7280;
                font-size: 0.875rem;
                text-align: center;
            }
        </style>
    </head>
    <body>
        <div class="my_container">
            <header>
                <div class="logo"><i class="fas fa-car"></i> AutoCare Garage</div>
                <div class="user-info">
                    <span>Welcome, ${sessionScope.user.name}</span>
                    <form action="LogoutServlet" method="">
                        <button type="submit" class="logout-button"><i class="fas fa-sign-out-alt"></i> Logout</button>
                    </form>
                </div>
            </header>
            <div class="main-content">
                <div class="sidebar">
                    <ul class="sidebar-menu">
                        <li class="active"> Dashboard</li>
                        <a href="CustomerServlet"><li> Customers</li></a>
                        <a href="cars"><li> Cars</li></a>
                        <a href="createServiceTicket"><li> Service Ticket</li></a>
                        <a href="PartAdminServlet"><li> Parts Inventory</li></a>
                        <a href="ReportsServlet"><li> Reports</li></a>
                    </ul>
                </div>
                <div class="content">
                    <h1 class="page-title"><i class="fas fa-tachometer-alt"></i> Sales Dashboard</h1>
                    
                    <!-- Quick Actions -->
                    <div class="actions">
                        <button class="button button-green"><i class="fas fa-plus"></i> New Customer</button>
                        <button class="button"><i class="fas fa-car"></i> Add Car</button>
                        <button class="button"><i class="fas fa-clipboard-list"></i> Create Service Ticket</button>
                        <button class="button"><i class="fas fa-file-invoice-dollar"></i> Generate Invoice</button>
                    </div>
                    
                    <!-- Statistics Cards -->
                    <div class="cards">
                        <div class="card stat-card">
                            <div class="card-title"><i class="fas fa-dollar-sign"></i> Total Revenue</div>
                            <div class="stat-value">$128,450</div>
                            <div class="stat-label">Current Month</div>
                            <div class="stat-change positive">
                                <i class="fas fa-arrow-up"></i> +8.5% from last month
                            </div>
                        </div>
                        
                        <div class="card stat-card">
                            <div class="card-title"><i class="fas fa-car"></i> Cars Sold</div>
                            <div class="stat-value">27</div>
                            <div class="stat-label">Current Month</div>
                            <div class="stat-change positive">
                                <i class="fas fa-arrow-up"></i> +12% from last month
                            </div>
                        </div>
                        
                        <div class="card stat-card">
                            <div class="card-title"><i class="fas fa-tools"></i> Service Revenue</div>
                            <div class="stat-value">$42,680</div>
                            <div class="stat-label">Current Month</div>
                            <div class="stat-change negative">
                                <i class="fas fa-arrow-down"></i> -3.2% from last month
                            </div>
                        </div>
                        
                        <div class="card stat-card">
                            <div class="card-title"><i class="fas fa-users"></i> New Customers</div>
                            <div class="stat-value">48</div>
                            <div class="stat-label">Current Month</div>
                            <div class="stat-change positive">
                                <i class="fas fa-arrow-up"></i> +5.8% from last month
                            </div>
                        </div>
                    </div>
                    
                   
                    
                    <!-- Recent Service Tickets Table -->
                    <div class="table-container">
                        <div class="table-header">
                            <div class="table-title"><i class="fas fa-clipboard-list"></i> Recent Service Tickets</div>
                            <div class="search-container">
                                <i class="fas fa-search search-icon"></i>
                                <input type="text" class="search-input" placeholder="Search tickets...">
                            </div>
                        </div>
                        <table>
                            <thead>
                                <tr>
                                    <th>Ticket #</th>
                                    <th>Customer</th>
                                    <th>Car</th>
                                    <th>Date Received</th>
                                    <th>Status</th>
                                    <th>Mechanic</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>ST-2025-0342</td>
                                    <td>John Smith</td>
                                    <td>Toyota Camry (2023)</td>
                                    <td>Mar 14, 2025</td>
                                    <td><span class="badge badge-yellow">In Progress</span></td>
                                    <td>Michael Chen</td>
                                    <td>
                                        <button class="button" style="padding: 0.25rem 0.5rem;"><i class="fas fa-eye"></i></button>
                                        <button class="button" style="padding: 0.25rem 0.5rem;"><i class="fas fa-edit"></i></button>
                                    </td>
                                </tr>
                                <tr>
                                    <td>ST-2025-0341</td>
                                    <td>Emma Johnson</td>
                                    <td>Honda Civic (2022)</td>
                                    <td>Mar 13, 2025</td>
                                    <td><span class="badge badge-green">Completed</span></td>
                                    <td>Sarah Williams</td>
                                    <td>
                                        <button class="button" style="padding: 0.25rem 0.5rem;"><i class="fas fa-eye"></i></button>
                                        <button class="button" style="padding: 0.25rem 0.5rem;"><i class="fas fa-edit"></i></button>
                                    </td>
                                </tr>
                                <tr>
                                    <td>ST-2025-0340</td>
                                    <td>Robert Brown</td>
                                    <td>Ford F-150 (2024)</td>
                                    <td>Mar 12, 2025</td>
                                    <td><span class="badge badge-blue">Awaiting Parts</span></td>
                                    <td>David Rodriguez</td>
                                    <td>
                                        <button class="button" style="padding: 0.25rem 0.5rem;"><i class="fas fa-eye"></i></button>
                                        <button class="button" style="padding: 0.25rem 0.5rem;"><i class="fas fa-edit"></i></button>
                                    </td>
                                </tr>
                                <tr>
                                    <td>ST-2025-0339</td>
                                    <td>Linda Davis</td>
                                    <td>Nissan Altima (2021)</td>
                                    <td>Mar 11, 2025</td>
                                    <td><span class="badge badge-red">Delayed</span></td>
                                    <td>James Wilson</td>
                                    <td>
                                        <button class="button" style="padding: 0.25rem 0.5rem;"><i class="fas fa-eye"></i></button>
                                        <button class="button" style="padding: 0.25rem 0.5rem;"><i class="fas fa-edit"></i></button>
                                    </td>
                                </tr>
                                <tr>
                                    <td>ST-2025-0338</td>
                                    <td>Thomas Miller</td>
                                    <td>Tesla Model 3 (2023)</td>
                                    <td>Mar 10, 2025</td>
                                    <td><span class="badge badge-green">Completed</span></td>
                                    <td>Michael Chen</td>
                                    <td>
                                        <button class="button" style="padding: 0.25rem 0.5rem;"><i class="fas fa-eye"></i></button>
                                        <button class="button" style="padding: 0.25rem 0.5rem;"><i class="fas fa-edit"></i></button>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    
                    <!-- Grid with Recent Invoices and Recent Activity -->
                    <div class="grid-2">
                        <!-- Recent Invoices -->
                        <div class="table-container">
                            <div class="table-header">
                                <div class="table-title"><i class="fas fa-file-invoice-dollar"></i> Recent Invoices</div>
                            </div>
                            <table>
                                <thead>
                                    <tr>
                                        <th>Invoice #</th>
                                        <th>Customer</th>
                                        <th>Date</th>
                                        <th>Amount</th>
                                        <th>Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>INV-2025-0156</td>
                                        <td>John Smith</td>
                                        <td>Mar 14, 2025</td>
                                        <td>$850.00</td>
                                        <td><span class="badge badge-yellow">Pending</span></td>
                                    </tr>
                                    <tr>
                                        <td>INV-2025-0155</td>
                                        <td>Emma Johnson</td>
                                        <td>Mar 13, 2025</td>
                                        <td>$1,250.00</td>
                                        <td><span class="badge badge-green">Paid</span></td>
                                    </tr>
                                    <tr>
                                        <td>INV-2025-0154</td>
                                        <td>Robert Brown</td>
                                        <td>Mar 12, 2025</td>
                                        <td>$650.00</td>
                                        <td><span class="badge badge-green">Paid</span></td>
                                    </tr>
                                    <tr>
                                        <td>INV-2025-0153</td>
                                        <td>Linda Davis</td>
                                        <td>Mar 11, 2025</td>
                                        <td>$2,150.00</td>
                                        <td><span class="badge badge-red">Overdue</span></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        
                        <!-- Recent Activity -->
                        <div class="card">
                            <div class="card-title"><i class="fas fa-history"></i> Recent Activity</div>
                            <div class="recent-activity">
                                <div class="activity-item">
                                    <div class="activity-icon">
                                        <i class="fas fa-file-invoice"></i>
                                    </div>
                                    <div class="activity-content">
                                        <div class="activity-title">New invoice #INV-2025-0156 created for John Smith</div>
                                        <div class="activity-time">15 minutes ago</div>
                                    </div>
                                </div>
                                <div class="activity-item">
                                    <div class="activity-icon">
                                        <i class="fas fa-car"></i>
                                    </div>
                                    <div class="activity-content">
                                        <div class="activity-title">New car added to inventory: 2024 Tesla Model Y</div>
                                        <div class="activity-time">1 hour ago</div>
                                    </div>
                                </div>
                                <div class="activity-item">
                                    <div class="activity-icon">
                                        <i class="fas fa-user"></i>
                                    </div>
                                    <div class="activity-content">
                                        <div class="activity-title">New customer registered: Patricia Garcia</div>
                                        <div class="activity-time">3 hours ago</div>
                                    </div>
                                </div>
                                <div class="activity-item">
                                    <div class="activity-icon">
                                        <i class="fas fa-clipboard"></i>
                                    </div>
                                    <div class="activity-content">
                                        <div class="activity-title">Service ticket #ST-2025-0338 marked as completed by Michael Chen</div>
                                        <div class="activity-time">6 hours ago</div>
                                    </div>
                                </div>
                                <div class="activity-item">
                                    <div class="activity-icon">
                                        <i class="fas fa-tools"></i>
                                    </div>
                                    <div class="activity-content">
                                        <div class="activity-title">Parts inventory updated: 15 new brake pads received</div>
                                        <div class="activity-time">Yesterday</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Dashboard Footer -->
                    <div class="dashboard-footer">
                        <p>© 2025 AutoCare Garage Management System | Version 2.3.1</p>
                    </div>
                    
                </div>
            </div>
        </div>
        
        <!-- Charts Initialization -->
        <script>
            // Add event listeners to tabs
            document.querySelectorAll('.tab').forEach(tab => {
                tab.addEventListener('click', function() {
                    // Remove active class from all tabs in the same container
                    const tabs = this.parentElement.querySelectorAll('.tab');
                    tabs.forEach(t => t.classList.remove('active'));
                    
                    // Add active class to clicked tab
                    this.classList.add('active');
                    
                    // Here you would typically update the chart data based on the selected tab
                    // For demonstration purposes, we'll leave the implementation empty
                });
            });
            
            // Add event listeners to buttons
            document.querySelectorAll('.button').forEach(button => {
                button.addEventListener('click', function(e) {
                    // Prevent default if it's a link
                    if (this.tagName === 'A') {
                        e.preventDefault();
                    }
                    
                    // Add a subtle animation
                    this.style.transform = 'scale(0.95)';
                    setTimeout(() => {
                        this.style.transform = '';
                    }, 100);
                    
                    // Here you would typically handle the button click action
                    // For demonstration purposes, we'll leave the implementation empty
                });
            });
        </script>
    </body>
</html>