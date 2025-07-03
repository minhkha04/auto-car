<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Mechanic Dashboard</title>
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
                background-color: #dc2626;
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
            }
            a {
                text-decoration: none;
                color: inherit;
                font-weight: inherit;
                font-size: inherit;
                cursor: pointer;
                transition: color 0.3s;
            }
            a:hover, a:focus {
                color: inherit;
                text-decoration: none;
            }
            a:active {
                opacity: 0.8;
            }
            .progress-bar {
                height: 8px;
                background-color: #e5e7eb;
                border-radius: 4px;
                overflow: hidden;
                margin-top: 0.5rem;
            }
            .progress {
                height: 100%;
                background-color: #3b82f6;
            }
            .status-pending {
                color: #f59e0b;
            }
            .status-inprogress {
                color: #3b82f6;
            }
            .status-completed {
                color: #10b981;
            }
            .filter-section {
                margin-bottom: 1.5rem;
                display: flex;
                gap: 1rem;
                flex-wrap: wrap;
            }
            .filter-chip {
                padding: 0.5rem 1rem;
                background-color: #e5e7eb;
                border-radius: 9999px;
                font-size: 0.875rem;
                cursor: pointer;
            }
            .filter-chip.active {
                background-color: #3b82f6;
                color: white;
            }
            .service-pill {
                display: inline-block;
                padding: 0.25rem 0.5rem;
                background-color: #e5e7eb;
                border-radius: 4px;
                font-size: 0.75rem;
                margin-right: 0.5rem;
                margin-bottom: 0.5rem;
            }
            .action-icon {
                cursor: pointer;
                color: #6b7280;
                margin-right: 0.5rem;
            }
            .action-icon:hover {
                color: #3b82f6;
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
                    <ul class="sidebar-menu">
                        <li class="active">Dashboard</li>
                        <a href="ServiceTicketServlet"><li>Service Tickets</li></a>
                        <a href="ServiceServlet"><li>Services</li></a>
                    </ul>
                </div>
                <div class="content">
                    <h1 class="page-title">Mechanic Dashboard</h1>

                    <!-- Overview Cards -->
                    <div class="cards">
                        <div class="card stat-card">
                            <div class="stat-value">12</div>
                            <div class="stat-label">Assigned Tickets</div>
                        </div>
                        <div class="card stat-card">
                            <div class="stat-value">5</div>
                            <div class="stat-label">In Progress</div>
                        </div>
                        <div class="card stat-card">
                            <div class="stat-value">7</div>
                            <div class="stat-label">Completed Today</div>
                        </div>
                        <div class="card stat-card">
                            <div class="stat-value">45</div>
                            <div class="stat-label">This Month</div>
                        </div>
                    </div>



                    <div class="filter-section">
                        <div class="filter-chip active">All Tickets</div>
                        <div class="filter-chip">Pending</div>
                        <div class="filter-chip">In Progress</div>
                        <div class="filter-chip">Completed</div>
                    </div>

                    <!-- Recent Service Tickets -->
                    <div class="table-container">
                        <h2 class="card-title">Recent Service Tickets</h2>
                        <table>
                            <thead>
                                <tr>
                                    <th>Ticket ID</th>
                                    <th>Customer</th>
                                    <th>Car Details</th>
                                    <th>Date Received</th>
                                    <th>Services</th>
                                    <th>Status</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>ST-1023</td>
                                    <td>John Smith</td>
                                    <td>Toyota Camry (2020)</td>
                                    <td>2025-03-14</td>
                                    <td>
                                        <span class="service-pill">Oil Change</span>
                                        <span class="service-pill">Brake Check</span>
                                    </td>
                                    <td><span class="status-inprogress">In Progress</span></td>

                                </tr>
                                <tr>
                                    <td>ST-1022</td>
                                    <td>Emma Johnson</td>
                                    <td>Honda Civic (2018)</td>
                                    <td>2025-03-15</td>
                                    <td>
                                        <span class="service-pill">AC Repair</span>
                                    </td>
                                    <td><span class="status-pending">Pending</span></td>

                                </tr>
                                <tr>
                                    <td>ST-1021</td>
                                    <td>Michael Brown</td>
                                    <td>Ford F-150 (2022)</td>
                                    <td>2025-03-13</td>
                                    <td>
                                        <span class="service-pill">Tire Rotation</span>
                                        <span class="service-pill">Alignment</span>
                                    </td>
                                    <td><span class="status-completed">Completed</span></td>

                                </tr>

                                <tr>
                                    <td>ST-1019</td>
                                    <td>Robert Wilson</td>
                                    <td>Chevrolet Malibu (2019)</td>
                                    <td>2025-03-11</td>
                                    <td>
                                        <span class="service-pill">Engine Diagnosis</span>
                                        <span class="service-pill">Spark Plugs</span>
                                    </td>
                                    <td><span class="status-inprogress">In Progress</span></td>

                                </tr>
                            </tbody>
                        </table>
                    </div>

                    <!-- My Services Section -->
                    <div class="table-container">
                        <h2 class="card-title">My Services</h2>

                        <table>
                            <thead>
                                <tr>
                                    <th>Service ID</th>
                                    <th>Service Name</th>
                                    <th>Description</th>
                                    <th>Standard Hours</th>
                                    <th>Rate ($/hour)</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>SV-001</td>
                                    <td>Oil Change</td>
                                    <td>Standard oil change service with filter replacement</td>
                                    <td>1.0</td>
                                    <td>65.00</td>

                                </tr>
                                <tr>
                                    <td>SV-002</td>
                                    <td>Brake Service</td>
                                    <td>Inspection and replacement of brake pads if needed</td>
                                    <td>2.5</td>
                                    <td>85.00</td>

                                </tr>
                                <tr>
                                    <td>SV-003</td>
                                    <td>Tire Rotation</td>
                                    <td>Rotating tires to ensure even wear</td>
                                    <td>1.0</td>
                                    <td>45.00</td>

                                </tr>
                                <tr>
                                    <td>SV-004</td>
                                    <td>AC System Check</td>
                                    <td>Diagnostic and performance check of A/C system</td>
                                    <td>1.5</td>
                                    <td>95.00</td>

                                </tr>
                            </tbody>
                        </table>
                    </div>

                    <!-- Performance Card -->
                    <div class="card">
                        <h2 class="card-title">Your Performance This Month</h2>
                        <div class="stat-label">Completed Tickets</div>
                        <div class="progress-bar">
                            <div class="progress" style="width: 78%"></div>
                        </div>
                        <div style="display: flex; justify-content: space-between; font-size: 0.75rem; color: #6b7280; margin-top: 0.25rem;">
                            <span>0</span>
                            <span>45 / 60 Target</span>
                        </div>

                        <div class="stat-label" style="margin-top: 1rem;">Average Completion Time</div>
                        <div class="progress-bar">
                            <div class="progress" style="width: 85%; background-color: #10b981;"></div>
                        </div>
                        <div style="display: flex; justify-content: space-between; font-size: 0.75rem; color: #6b7280; margin-top: 0.25rem;">
                            <span>Excellent: 1.2 days avg.</span>
                            <span>Target: 2 days</span>
                        </div>

                        <div class="stat-label" style="margin-top: 1rem;">Customer Satisfaction</div>
                        <div class="progress-bar">
                            <div class="progress" style="width: 92%; background-color: #3b82f6;"></div>
                        </div>
                        <div style="display: flex; justify-content: space-between; font-size: 0.75rem; color: #6b7280; margin-top: 0.25rem;">
                            <span>0</span>
                            <span>4.6/5.0</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script>
            // JavaScript for interactive elements
            document.addEventListener('DOMContentLoaded', function () {
                // Filter chips functionality
                const filterChips = document.querySelectorAll('.filter-chip');
                filterChips.forEach(chip => {
                    chip.addEventListener('click', function () {
                        filterChips.forEach(c => c.classList.remove('active'));
                        this.classList.add('active');
                        // Here you would typically filter the table based on the selected status
                        console.log('Filter selected:', this.textContent);
                    });
                });

                // Search functionality
                const searchInput = document.querySelector('.search-input');
                const searchButton = searchInput.nextElementSibling;
                searchButton.addEventListener('click', function () {
                    const searchTerm = searchInput.value.trim();
                    if (searchTerm) {
                        console.log('Searching for:', searchTerm);
                        // Here you would implement the search functionality
                        // Example: window.location.href = `ServiceTicketServlet?search=${searchTerm}`;
                    }
                });

                // Enter key for search
                searchInput.addEventListener('keypress', function (event) {
                    if (event.key === 'Enter') {
                        searchButton.click();
                    }
                });
            });
        </script>
    </body>
</html>