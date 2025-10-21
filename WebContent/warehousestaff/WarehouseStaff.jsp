<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>RestMan - Kho</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
    <div class="container">
        <div class="header">
            <div class="logo">
                <span class="logo-icon">📦</span>
                <span class="logo-text">RestMan - Kho</span>
            </div>
            <div class="user-info">
                <span>Nhân viên kho</span>
                <a href="<%= request.getContextPath() %>/index.jsp" class="logout-btn">↪</a>
            </div>
        </div>

        <div class="welcome-section">
            <h1>Quản lý kho</h1>
        </div>

        <div class="menu-cards">
            <a href="<%= request.getContextPath() %>/SupplierServlet" class="menu-card">
                <div class="card-icon">📦</div>
                <div class="card-content">
                    <h2>Nhập nguyên liệu</h2>
                    <p>Nhập hàng từ nhà cung cấp</p>
                </div>
                <div class="card-arrow">›</div>
            </a>

            <a href="#" class="menu-card">
                <div class="card-icon">👥</div>
                <div class="card-content">
                    <h2>Quản lý NCC</h2>
                    <p>Quản lý nhà cung cấp</p>
                </div>
                <div class="card-arrow">›</div>
            </a>

            <a href="#" class="menu-card">
                <div class="card-icon">📄</div>
                <div class="card-content">
                    <h2>Lịch sử nhập</h2>
                    <p>Xem lịch sử nhập hàng</p>
                </div>
                <div class="card-arrow">›</div>
            </a>
        </div>
    </div>
</body>
</html>
