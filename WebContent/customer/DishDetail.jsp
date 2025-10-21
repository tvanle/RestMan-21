<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Dish" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết món ăn - RestMan</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
    <div class="container">
        <%
            Dish dish = (Dish) request.getAttribute("dish");
            if (dish != null) {
        %>
        <div class="header">
            <div class="header-left">
                <a href="javascript:history.back()" class="back-btn">← Quay lại</a>
            </div>
            <h1 class="header-title">Chi tiết món ăn</h1>
            <div class="header-right">
                <a href="<%= request.getContextPath() %>/index.jsp" class="logout-btn">↪</a>
            </div>
        </div>

        <div class="dish-detail">
            <div class="dish-detail-image">
                <div class="dish-icon-large">🍜</div>
            </div>

            <div class="dish-detail-content">
                <div class="dish-detail-header">
                    <h1 class="dish-detail-name"><%= dish.getName() %></h1>
                    <span class="dish-detail-badge">Món chính</span>
                </div>

                <div class="dish-detail-price">
                    <span class="price-label">Giá</span>
                    <span class="price-value"><%= String.format("%,d", (int)dish.getPrice()) %>đ</span>
                </div>

                <div class="dish-detail-section">
                    <h3>Mô tả</h3>
                    <p><%= dish.getDescription() %></p>
                </div>

                <div class="dish-detail-section">
                    <h3>Nguyên liệu</h3>
                    <p>Bánh phở, thịt bò, hành, ngò</p>
                </div>

                <div class="dish-detail-actions">
                    <button class="btn-primary btn-large">Đặt món ngay</button>
                    <button class="btn-secondary btn-large">Thêm vào giỏ</button>
                </div>
            </div>
        </div>
        <%
            } else {
        %>
        <div class="error-message">
            <p>Không tìm thấy thông tin món ăn</p>
            <a href="<%= request.getContextPath() %>/customer/Customer.jsp" class="btn-primary">Quay về trang chủ</a>
        </div>
        <%
            }
        %>
    </div>
</body>
</html>
