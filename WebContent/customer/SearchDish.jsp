<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Dish" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tìm kiếm món ăn - RestMan</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
    <div class="container">
        <div class="header">
            <div class="header-left">
                <a href="<%= request.getContextPath() %>/customer/Customer.jsp" class="back-btn">< Quay lại</a>
            </div>
            <h1 class="header-title">RestMan | Tìm kiếm món ăn</h1>
            <div class="header-right">
                <a href="<%= request.getContextPath() %>/index.jsp" class="logout-btn">Thoát</a>
            </div>
        </div>

        <div class="search-section">
            <form action="<%= request.getContextPath() %>/SearchDishServlet" method="get" class="search-form">
                <input type="hidden" name="action" value="search">
                <div class="search-box">
                    <input type="text" name="dishName" placeholder="Nhập tên món ăn..."
                           value="<%= request.getAttribute("searchKeyword") != null ? request.getAttribute("searchKeyword") : "" %>"
                           class="search-input">
                </div>
                <button type="submit" class="btn-primary">Tìm kiếm</button>
            </form>
        </div>

        <%
            String error = (String) request.getAttribute("error");
            if (error != null) {
        %>
        <div class="error-message" style="margin: 20px 0;">
            <%= error %>
        </div>
        <%
            }
        %>

        <%
            List<Dish> dishes = (List<Dish>) request.getAttribute("dishes");
            String searchKeyword = (String) request.getAttribute("searchKeyword");

            if (dishes != null && !dishes.isEmpty()) {
                int itemsPerPage = 5;
                int currentPage = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;
                int totalItems = dishes.size();
                int totalPages = (int) Math.ceil((double) totalItems / itemsPerPage);
                int startIndex = (currentPage - 1) * itemsPerPage;
                int endIndex = Math.min(startIndex + itemsPerPage, totalItems);
        %>
        <div class="results-header">
            <p>Tìm thấy <%= totalItems %> kết quả (Trang <%= currentPage %>/<%= totalPages %>)</p>
        </div>

        <div class="dish-list">
            <%
                for (int i = startIndex; i < endIndex; i++) {
                    Dish dish = dishes.get(i);
            %>
            <a href="<%= request.getContextPath() %>/SearchDishServlet?action=viewDetail&dishId=<%= dish.getId() %>" class="dish-card">
                <div class="dish-info">
                    <h3 class="dish-name"><%= dish.getName() %></h3>
                    <p class="dish-description"><%= dish.getDescription() %></p>
                    <div class="dish-footer">
                        <span class="dish-price"><%= String.format("%,d", (int)dish.getPrice()) %>đ</span>
                        <span class="dish-category">Món chính</span>
                    </div>
                </div>
            </a>
            <%
                }
            %>
        </div>

        <!-- Pagination -->
        <% if (totalPages > 1) { %>
        <div class="pagination">
            <% if (currentPage > 1) { %>
            <a href="?<%= searchKeyword != null ? "action=search&dishName=" + searchKeyword + "&" : "" %>page=<%= currentPage - 1 %>" class="page-btn">← Trước</a>
            <% } %>

            <% for (int i = 1; i <= totalPages; i++) { %>
                <a href="?<%= searchKeyword != null ? "action=search&dishName=" + searchKeyword + "&" : "" %>page=<%= i %>" class="page-btn <%= i == currentPage ? "active" : "" %>"><%= i %></a>
            <% } %>

            <% if (currentPage < totalPages) { %>
            <a href="?<%= searchKeyword != null ? "action=search&dishName=" + searchKeyword + "&" : "" %>page=<%= currentPage + 1 %>" class="page-btn">Sau →</a>
            <% } %>
        </div>
        <% } %>
        <%
            } else if (searchKeyword != null && !searchKeyword.isEmpty()) {
        %>
        <div class="no-results">
            <p>Không tìm thấy món ăn nào với từ khóa "<%= searchKeyword %>"</p>
        </div>
        <%
            }
        %>
    </div>
</body>
</html>
