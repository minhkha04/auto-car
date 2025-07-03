<%@page contentType="text/html" pageEncoding="UTF-8"%>

<div class="sidebar">
    <!-- Menu cho Nhân viên bán hàng -->
    <div id="salesperson-menu">
        <div class="menu-item active" onclick="showContent('customers')">Quản lý khách hàng</div>
        <div class="menu-item" onclick="showContent('cars')">Quản lý xe</div>
        <div class="menu-item" > <a href="createServiceTicket">Phiếu dịch vụ</a></div>
        <div class="menu-item" onclick="showContent('parts')">Quản lý phụ tùng</div>
        <div class="menu-item" onclick="showContent('invoices')">Hóa đơn</div>
        <div class="menu-item" onclick="showContent('reports')">Báo cáo thống kê</div>
    </div>

    <!-- Menu cho Thợ sửa chữa -->
    <div id="mechanic-menu" style="display: none;">
        <div class="menu-item active" onclick="showContent('service-tickets-mechanic')">Phiếu dịch vụ</div>
        <div class="menu-item" onclick="showContent('services')">Quản lý dịch vụ</div>
    </div>

    <!-- Menu cho Khách hàng -->
    <div id="customer-menu" style="display: none;">
        <div class="menu-item active" onclick="showContent('car-catalog')">Danh mục xe</div>
        <div class="menu-item" onclick="showContent('service-tickets-customer')">Phiếu dịch vụ của tôi</div>
        <div class="menu-item" onclick="showContent('invoices-customer')">Hóa đơn của tôi</div>
        <div class="menu-item" onclick="showContent('profile')">Thông tin cá nhân</div>
    </div>
</div>

<style>
    /* CSS Chung */
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    body {
        background-color: #f5f5f5;
        color: #333;
    }

    .container {
        width: 100%;
        max-width: 1200px;
        margin: 0 auto;
        padding: 20px;
    }

    .header {
        background-color: #1e3a8a;
        color: white;
        padding: 15px 0;
        text-align: center;
    }

    /* CSS Đăng nhập */
    .login-container {
        width: 100%;
        max-width: 400px;
        margin: 50px auto;
        padding: 30px;
        background-color: white;
        border-radius: 8px;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
    }

    .login-title {
        text-align: center;
        margin-bottom: 20px;
        color: #1e3a8a;
    }

    .form-group {
        margin-bottom: 20px;
    }

    .form-group label {
        display: block;
        margin-bottom: 8px;
        font-weight: 500;
    }

    .form-group input, .form-group select {
        width: 100%;
        padding: 12px;
        border: 1px solid #ddd;
        border-radius: 4px;
        font-size: 16px;
        transition: border-color 0.3s;
    }

    .form-group input:focus, .form-group select:focus {
        border-color: #1e3a8a;
        outline: none;
    }

    .btn {
        display: block;
        width: 100%;
        padding: 12px;
        background-color: #1e3a8a;
        color: white;
        border: none;
        border-radius: 4px;
        font-size: 16px;
        cursor: pointer;
        transition: background-color 0.3s;
    }

    .btn:hover {
        background-color: #152a5f;
    }

    /* CSS Dashboard */
    .dashboard {
        display: none; /* Ẩn mặc định, sẽ hiện khi đăng nhập */
    }

    .dashboard-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 30px;
    }

    .user-info {
        display: flex;
        align-items: center;
    }

    .user-avatar {
        width: 50px;
        height: 50px;
        border-radius: 50%;
        background-color: #ddd;
        margin-right: 15px;
        text-align: center;
        line-height: 50px;
        font-size: 20px;
        font-weight: bold;
    }

    .sidebar {
        width: 250px;
        background-color: white;
        border-radius: 8px;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        padding: 20px;
    }

    .menu-item {
        padding: 12px 15px;
        cursor: pointer;
        border-radius: 4px;
        margin-bottom: 5px;
        transition: background-color 0.3s;
    }

    .menu-item:hover {
        background-color: #f0f4ff;
    }

    .menu-item.active {
        background-color: #1e3a8a;
        color: white;
    }

    .dashboard-content {
        display: flex;
        gap: 30px;
    }

    .content-area {
        flex: 1;
        background-color: white;
        border-radius: 8px;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        padding: 20px;
    }

    .content-title {
        margin-bottom: 20px;
        padding-bottom: 10px;
        border-bottom: 1px solid #eee;
    }

    .card {
        background-color: white;
        border-radius: 8px;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        padding: 20px;
        margin-bottom: 20px;
    }

    .card-title {
        margin-bottom: 15px;
        color: #1e3a8a;
    }

    .search-form {
        display: flex;
        margin-bottom: 20px;
    }

    .search-form input {
        flex: 1;
        padding: 10px;
        border: 1px solid #ddd;
        border-radius: 4px 0 0 4px;
        font-size: 16px;
    }

    .search-form button {
        padding: 10px 15px;
        background-color: #1e3a8a;
        color: white;
        border: none;
        border-radius: 0 4px 4px 0;
        cursor: pointer;
    }

    .table {
        width: 100%;
        border-collapse: collapse;
    }

    .table th, .table td {
        padding: 12px 15px;
        text-align: left;
        border-bottom: 1px solid #eee;
    }

    .table th {
        background-color: #f8f9fa;
        font-weight: 600;
    }

    .table tr:hover {
        background-color: #f5f8ff;
    }

    .action-btn {
        padding: 6px 12px;
        border-radius: 4px;
        cursor: pointer;
        font-size: 14px;
        margin-right: 5px;
        border: none;
    }

    .view-btn {
        background-color: #e3f2fd;
        color: #0d47a1;
    }

    .edit-btn {
        background-color: #e8f5e9;
        color: #2e7d32;
    }

    .delete-btn {
        background-color: #ffebee;
        color: #c62828;
    }

    .buy-btn {
        background-color: #fff8e1;
        color: #ff6f00;
    }

    /* Form elements */
    .form-row {
        display: flex;
        gap: 15px;
        margin-bottom: 15px;
    }

    .form-col {
        flex: 1;
    }

    /* Car catalog styling */
    .car-catalog {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
        gap: 20px;
        margin-top: 20px;
    }

    .car-item {
        background: white;
        border-radius: 8px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        overflow: hidden;
        transition: transform 0.3s ease;
    }

    .car-item:hover {
        transform: translateY(-5px);
        box-shadow: 0 5px 15px rgba(0,0,0,0.1);
    }

    .car-image {
        height: 180px;
        background-color: #f0f4ff;
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .car-image img {
        max-width: 100%;
        max-height: 100%;
    }

    .car-info {
        padding: 15px;
    }

    .car-name {
        font-weight: 600;
        font-size: 18px;
        margin-bottom: 8px;
        color: #1e3a8a;
    }

    .car-details {
        color: #666;
        margin-bottom: 15px;
        font-size: 14px;
    }

    .car-price {
        font-weight: bold;
        font-size: 20px;
        color: #1e3a8a;
        margin-bottom: 15px;
    }

    .car-buttons {
        display: flex;
        gap: 10px;
    }

    .car-buttons button {
        flex: 1;
        padding: 8px 0;
        border: none;
        border-radius: 4px;
        cursor: pointer;
    }

    .filters {
        display: flex;
        flex-wrap: wrap;
        gap: 15px;
        margin-bottom: 20px;
    }

    .filter-group {
        flex: 1;
        min-width: 200px;
    }

    .filter-group label {
        display: block;
        margin-bottom: 5px;
        font-weight: 500;
    }

    .filter-group select {
        width: 100%;
        padding: 8px;
        border: 1px solid #ddd;
        border-radius: 4px;
    }
</style>