<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Supplier" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nhập nguyên liệu - RestMan</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
    <div class="container">
        <div class="header">
            <div class="header-left">
                <a href="<%= request.getContextPath() %>/warehousestaff/WarehouseStaff.jsp" class="back-btn">< Quay lại</a>
            </div>
            <h1 class="header-title">RestMan | Nhập nguyên liệu</h1>
            <div class="header-right">
                <a href="<%= request.getContextPath() %>/index.jsp" class="logout-btn">Thoát</a>
            </div>
        </div>

        <div class="step-indicator">
            <div class="step active">Bước 1: Chọn nhà cung cấp</div>
        </div>

        <%
            String successMessage = (String) request.getAttribute("successMessage");
            if (successMessage != null) {
        %>
        <div class="success-message"><%= successMessage %></div>
        <%
            }
        %>

        <div class="search-section">
            <form action="<%= request.getContextPath() %>/SupplierServlet" method="get" class="search-form">
                <input type="hidden" name="action" value="search">
                <div class="search-box">
                    <input type="text" name="supplierName" placeholder="Nhập tên nhà cung cấp..."
                           value="<%= request.getAttribute("searchKeyword") != null ? request.getAttribute("searchKeyword") : "" %>"
                           class="search-input">
                </div>
                <button type="submit" class="btn-primary">Tìm kiếm</button>
            </form>
        </div>

        <%
            List<Supplier> suppliers = (List<Supplier>) request.getAttribute("suppliers");
            String searchKeyword = (String) request.getAttribute("searchKeyword");

            if (suppliers != null && !suppliers.isEmpty()) {
                int itemsPerPage = 3;
                int currentPage = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;
                int totalItems = suppliers.size();
                int totalPages = (int) Math.ceil((double) totalItems / itemsPerPage);
                int startIndex = (currentPage - 1) * itemsPerPage;
                int endIndex = Math.min(startIndex + itemsPerPage, totalItems);
        %>
        <div class="results-header">
            <p>Tìm thấy <%= totalItems %> nhà cung cấp (Trang <%= currentPage %>/<%= totalPages %>)</p>
        </div>

        <div class="supplier-list">
            <%
                for (int i = startIndex; i < endIndex; i++) {
                    Supplier supplier = suppliers.get(i);
            %>
            <a href="<%= request.getContextPath() %>/IngredientServlet?supplierId=<%= supplier.getId() %>" class="supplier-card">
                <div class="supplier-info">
                    <h3 class="supplier-name"><%= supplier.getName() %></h3>
                    <p class="supplier-contact">SĐT: <%= supplier.getPhone() %></p>
                    <p class="supplier-address">Địa chỉ: <%= supplier.getAddress() %></p>
                </div>
                <div class="card-arrow">></div>
            </a>
            <%
                }
            %>
        </div>

        <!-- Pagination -->
        <% if (totalPages > 1) { %>
        <div class="pagination">
            <% if (currentPage > 1) { %>
            <a href="?<%= searchKeyword != null ? "action=search&supplierName=" + searchKeyword + "&" : "" %>page=<%= currentPage - 1 %>" class="page-btn">← Trước</a>
            <% } %>

            <% for (int i = 1; i <= totalPages; i++) { %>
                <a href="?<%= searchKeyword != null ? "action=search&supplierName=" + searchKeyword + "&" : "" %>page=<%= i %>" class="page-btn <%= i == currentPage ? "active" : "" %>"><%= i %></a>
            <% } %>

            <% if (currentPage < totalPages) { %>
            <a href="?<%= searchKeyword != null ? "action=search&supplierName=" + searchKeyword + "&" : "" %>page=<%= currentPage + 1 %>" class="page-btn">Sau →</a>
            <% } %>
        </div>
        <% } %>
        <%
            } else if (searchKeyword != null && !searchKeyword.isEmpty()) {
        %>
        <div class="no-results">
            <p>Không tìm thấy nhà cung cấp nào</p>
        </div>
        <%
            }
        %>

        <div class="action-footer">
            <button type="button" class="btn-secondary btn-full" onclick="alert('Chức năng thêm nhà cung cấp mới')">
                + Thêm nhà cung cấp mới
            </button>
        </div>
    </div>

    <script>
        // Show success notification if exists
        <%
            if (successMessage != null) {
        %>
        window.onload = function() {
            alert('<%= successMessage %>');
        };
        <%
            }
        %>
    </script>
</body>
</html>
