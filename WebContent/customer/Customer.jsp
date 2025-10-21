<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>RestMan - Khách hàng</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
    <div class="container">
        <div class="header">
            <div class="logo">
                <span class="logo-icon">🍴</span>
                <span class="logo-text">RestMan</span>
            </div>
            <div class="user-info">
                <span>Khách hàng</span>
                <a href="<%= request.getContextPath() %>/index.jsp" class="logout-btn">↪</a>
            </div>
        </div>

        <div class="welcome-section">
            <h1>Chào mừng đến với RestMan</h1>
        </div>

        <div class="menu-cards">
            <a href="<%= request.getContextPath() %>/SearchDishServlet" class="menu-card">
                <div class="card-icon">🔍</div>
                <div class="card-content">
                    <h2>Tìm kiếm món ăn</h2>
                    <p>Khám phá thực đơn và món ăn</p>
                </div>
                <div class="card-arrow">›</div>
            </a>

            <a href="#" class="menu-card">
                <div class="card-icon">👥</div>
                <div class="card-content">
                    <h2>Đặt bàn</h2>
                    <p>Đặt bàn trước trực tuyến</p>
                </div>
                <div class="card-arrow">›</div>
            </a>

            <a href="#" class="menu-card">
                <div class="card-icon">🛒</div>
                <div class="card-content">
                    <h2>Đặt món</h2>
                    <p>Đặt món ăn trực tuyến</p>
                </div>
                <div class="card-arrow">›</div>
            </a>
        </div>
    </div>
</body>
</html>
