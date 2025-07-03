<%-- 
    Document   : login
    Created on : 09-Mar-2025, 17:27:02
    Author     : lengu
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
              crossorigin="anonymous" />
        <title>Hệ Thống Quản Lý Garage - Đăng Nhập</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }

            body {
                background-color: #f0f2f5;
                min-height: 100vh;
                display: flex;
                flex-direction: column;
            }

            .header {
                background-color: #1e3a8a;
                color: white;
                padding: 20px;
                text-align: center;
            }

            .header h1 {
                font-size: 28px;
                font-weight: bold;
            }

            .my_container {
                flex: 1;
                display: flex;
                justify-content: center;
                align-items: center;
                padding: 20px;
            }

            .login-card {
                background-color: white;
                border-radius: 8px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                width: 100%;
                max-width: 450px;
                padding: 30px;
            }

            .login-title {
                text-align: center;
                color: #1e3a8a;
                font-size: 24px;
                margin-bottom: 30px;
                font-weight: bold;
            }

            .form-group {
                margin-bottom: 20px;
            }

            .form-group label {
                display: block;
                margin-bottom: 8px;
                font-weight: 500;
            }

            .form-group input,
            .form-group select {
                width: 100%;
                padding: 12px;
                border: 1px solid #ddd;
                border-radius: 4px;
                font-size: 16px;
            }

            .form-group input:focus,
            .form-group select:focus {
                outline: none;
                border-color: #1e3a8a;
            }

            .phone-field {
                display: none;
            }

            .login-button {
                display: block;
                width: 100%;
                padding: 14px;
                background-color: #1e3a8a;
                color: white;
                border: none;
                border-radius: 4px;
                font-size: 16px;
                font-weight: 500;
                cursor: pointer;
                transition: background-color 0.3s;
            }

            .login-button:hover {
                background-color: #15296b;
            }

        </style>
    </head>
    <body>
        <div class="header">
            <h1>Hệ Thống Quản Lý Garage</h1>
        </div>

        <div class="my_container">
            <div class="login-card">
                <h2 class="login-title">Đăng Nhập</h2>

                <form id="loginForm" action="LoginServlet" method="post" accept-charset="utf8">
                    <div class="form-group">
                        <label for="username">Tên đăng nhập</label>
                        <input type="text" id="username" name="username" required>
                    </div>

                    <div class="form-group">
                        <label for="role">Vai trò</label>
                        <select id="role" name="role" onchange="togglePhoneField()">
                            <option value="sales">Nhân viên bán hàng</option>
                            <option value="mechanic">Thợ máy</option>
                            <option value="customer">Khách hàng</option>
                        </select>
                    </div>

                    <div class="form-group phone-field" id="phoneField">
                        <label for="phone">Số điện thoại</label>
                        <input type="tel" id="phone" name="phone" required="">
                    </div>
                    <button type="submit" class="login-button">Đăng Nhập</button>
                </form>
                <h4>${result}</h4>
            </div>

        </div>
            <div class="position-absolute bottom-0 end-0 p-4">
            <a href='<c:url value='/'></c:url>'>
                <button class="btn btn-danger" type="button">Return</button>
            </a>
            
        </div>

        <script>
            function togglePhoneField() {
                const role = document.getElementById('role').value;
                const phoneField = document.getElementById('phoneField');

                if (role === 'customer') {
                    phoneField.style.display = 'block';
                    document.getElementById('phone').required = true;
                } else {
                    phoneField.style.display = 'none';
                    document.getElementById('phone').required = false;
                }
            }

            // Initialize on page load
            document.addEventListener('DOMContentLoaded', function () {
                togglePhoneField();
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
