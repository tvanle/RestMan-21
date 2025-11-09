<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chọn nguyên liệu - RestMan</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
    <div class="container">
        <%
            // Check if invoice is created (success state)
            ImportInvoice invoice = (ImportInvoice) request.getAttribute("invoice");
            Float totalBeforeVAT = (Float) request.getAttribute("totalBeforeVAT");
            Float vat = (Float) request.getAttribute("vat");

            if (invoice != null) {
                // Display invoice success
                SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
        %>
        <div class="invoice-container">
            <div class="invoice-header">
                <h1>RestMan | Hóa đơn nhập hàng</h1>
                <p class="invoice-company">Nhà hàng RestMan</p>
                <p>Địa chỉ: Hà Nội | SĐT: 024-xxx-xxxx</p>
            </div>

            <div class="invoice-info">
                <div class="info-row">
                    <span>Số hóa đơn:</span>
                    <strong>HD<%= String.format("%08d", invoice.getId()) %></strong>
                </div>
                <div class="info-row">
                    <span>Ngày nhập:</span>
                    <strong><%= dateFormat.format(invoice.getDate()) %></strong>
                </div>
            </div>

            <div class="invoice-parties">
                <div class="party">
                    <h3>Nhà cung cấp:</h3>
                    <p><strong><%= invoice.getSupplier().getName() %></strong></p>
                    <p><%= invoice.getSupplier().getPhone() %></p>
                </div>
                <div class="party">
                    <h3>Nhân viên:</h3>
                    <p><strong>NV<%= String.format("%03d", invoice.getWarehouseStaff().getId()) %> - <%= invoice.getWarehouseStaff().getUsername() %></strong></p>
                </div>
            </div>

            <table class="invoice-table">
                <thead>
                    <tr>
                        <th>STT</th>
                        <th>Tên nguyên liệu</th>
                        <th>Đơn vị</th>
                        <th>Đơn giá</th>
                        <th>SL</th>
                        <th>Thành tiền</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        int index = 1;
                        for (ImportDetail detail : invoice.getImportDetails()) {
                    %>
                    <tr>
                        <td><%= index++ %></td>
                        <td><%= detail.getIngredient().getName() %></td>
                        <td><%= detail.getIngredient().getContent() %></td>
                        <td><%= String.format("%,d", (int)detail.getUnitPrice()) %>đ</td>
                        <td><%= detail.getQuantity() %></td>
                        <td><%= String.format("%,d", (int)detail.getTotalPrice()) %>đ</td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>

            <div class="invoice-summary">
                <div class="summary-row">
                    <span>Tạm tính:</span>
                    <span><%= String.format("%,d", totalBeforeVAT.intValue()) %>đ</span>
                </div>
                <div class="summary-row">
                    <span>VAT (10%):</span>
                    <span><%= String.format("%,d", vat.intValue()) %>đ</span>
                </div>
                <div class="summary-total">
                    <strong>Tổng cộng:</strong>
                    <strong><%= String.format("%,d", (int)invoice.getTotalAmount()) %>đ</strong>
                </div>
            </div>

            <div class="invoice-signatures">
                <div class="signature">
                    <p><strong>Người giao hàng</strong></p>
                    <p>(Ký và ghi rõ họ tên)</p>
                </div>
                <div class="signature">
                    <p><strong>Người nhận hàng</strong></p>
                    <p>(Ký và ghi rõ họ tên)</p>
                </div>
            </div>

            <div class="invoice-actions">
                <button type="button" class="btn-secondary" onclick="window.print()">In hóa đơn</button>
                <a href="<%= request.getContextPath() %>/warehousestaff/WarehouseStaff.jsp" class="btn-primary">Xác nhận và thanh toán</a>
            </div>
        </div>
        <%
            } else {
                // Display normal ingredient selection
                Supplier supplier = (Supplier) session.getAttribute("selectedSupplier");
                if (supplier == null) {
                    response.sendRedirect(request.getContextPath() + "/SupplierServlet");
                    return;
                }

                @SuppressWarnings("unchecked")
                List<ImportDetail> importDetails = (List<ImportDetail>) session.getAttribute("importDetails");
                List<Ingredient> ingredients = (List<Ingredient>) request.getAttribute("ingredients");
                String successMessage = (String) request.getAttribute("successMessage");
                String errorMessage = (String) request.getAttribute("errorMessage");
        %>

        <div class="header">
            <div class="header-left">
                <a href="<%= request.getContextPath() %>/SupplierServlet" class="back-btn">< Quay lại</a>
            </div>
            <h1 class="header-title">RestMan | Chọn nguyên liệu</h1>
            <div class="header-right">
                <a href="<%= request.getContextPath() %>/index.jsp" class="logout-btn">Thoát</a>
            </div>
        </div>

        <div class="supplier-info-bar">
            <strong>Nhà cung cấp:</strong> <%= supplier.getName() %><br>
            <strong>SĐT:</strong> <%= supplier.getPhone() %>
        </div>

        <div class="step-indicator">
            <div class="step completed">Bước 1: Chọn nhà cung cấp</div>
            <div class="step active">Bước 2: Chọn nguyên liệu</div>
        </div>

        <%
            if (successMessage != null) {
        %>
        <div class="success-message"><%= successMessage %></div>
        <%
            }
            if (errorMessage != null) {
        %>
        <div class="error-message"><%= errorMessage %></div>
        <%
            }
        %>

        <div class="import-container">
            <!-- Left side: Ingredient selection -->
            <div class="import-left">
                <div class="search-section">
                    <form action="<%= request.getContextPath() %>/IngredientServlet" method="get" class="search-form">
                        <input type="hidden" name="action" value="search">
                        <div class="search-box">
                            <input type="text" name="ingredientName" placeholder="Nhập tên nguyên liệu..."
                                   value="<%= request.getAttribute("searchKeyword") != null ? request.getAttribute("searchKeyword") : "" %>"
                                   class="search-input">
                        </div>
                        <button type="submit" class="btn-primary">Tìm</button>
                    </form>
                </div>

                <%
                    if (ingredients != null && !ingredients.isEmpty()) {
                        int itemsPerPage = 5;
                        int currentPage = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;
                        int totalItems = ingredients.size();
                        int totalPages = (int) Math.ceil((double) totalItems / itemsPerPage);
                        int startIndex = (currentPage - 1) * itemsPerPage;
                        int endIndex = Math.min(startIndex + itemsPerPage, totalItems);
                %>
                <div class="results-header">
                    <p>Tìm thấy <%= totalItems %> nguyên liệu (Trang <%= currentPage %>/<%= totalPages %>)</p>
                </div>

                <div class="ingredient-list">
                    <%
                        for (int i = startIndex; i < endIndex; i++) {
                            Ingredient ingredient = ingredients.get(i);
                    %>
                    <div class="ingredient-card">
                        <div class="ingredient-info">
                            <h3><%= ingredient.getName() %></h3>
                            <p><%= String.format("%,d", (int)ingredient.getUnitPrice()) %>đ/<%= ingredient.getContent() %></p>
                        </div>
                        <button type="button" class="btn-add" onclick="showAddModal(<%= ingredient.getId() %>, '<%= ingredient.getName() %>', <%= ingredient.getUnitPrice() %>)">+</button>
                    </div>
                    <%
                        }
                    %>
                </div>

                <!-- Pagination -->
                <% if (totalPages > 1) { %>
                <div class="pagination">
                    <% if (currentPage > 1) { %>
                    <a href="?page=<%= currentPage - 1 %>" class="page-btn">← Trước</a>
                    <% } %>

                    <% for (int i = 1; i <= totalPages; i++) { %>
                        <a href="?page=<%= i %>" class="page-btn <%= i == currentPage ? "active" : "" %>"><%= i %></a>
                    <% } %>

                    <% if (currentPage < totalPages) { %>
                    <a href="?page=<%= currentPage + 1 %>" class="page-btn">Sau →</a>
                    <% } %>
                </div>
                <% } %>
                <%
                    }
                %>

                <button type="button" class="btn-secondary btn-full" onclick="alert('Chức năng thêm nguyên liệu mới')">
                    + Thêm nguyên liệu mới
                </button>
            </div>

            <!-- Right side: Cart (sticky) -->
            <div class="import-right">
                <div class="cart-sticky">
                    <h2>Giỏ hàng</h2>
                    <%
                        if (importDetails != null && !importDetails.isEmpty()) {
                            float subtotal = 0;
                            for (ImportDetail detail : importDetails) {
                                subtotal += detail.getTotalPrice();
                    %>
                    <div class="cart-item-compact">
                        <div class="cart-item-info">
                            <strong><%= detail.getIngredient().getName() %></strong>
                            <span><%= detail.getQuantity() %> <%= detail.getIngredient().getContent() %> × <%= String.format("%,d", (int)detail.getUnitPrice()) %>đ</span>
                        </div>
                        <div class="cart-item-price">
                            <%= String.format("%,d", (int)detail.getTotalPrice()) %>đ
                        </div>
                    </div>
                    <%
                        }
                        float vat = subtotal * 0.1f;
                        float total = subtotal + vat;
                    %>

                    <div class="cart-summary">
                        <div class="summary-row">
                            <span>Tạm tính:</span>
                            <span><%= String.format("%,d", (int)subtotal) %>đ</span>
                        </div>
                        <div class="summary-row">
                            <span>VAT (10%):</span>
                            <span><%= String.format("%,d", (int)vat) %>đ</span>
                        </div>
                        <div class="summary-row summary-total">
                            <strong>Tổng:</strong>
                            <strong><%= String.format("%,d", (int)total) %>đ</strong>
                        </div>
                    </div>

                    <form action="<%= request.getContextPath() %>/ImportInvoiceServlet" method="post">
                        <button type="submit" class="btn-primary btn-full">Xác nhận</button>
                    </form>
                    <%
                        } else {
                    %>
                    <p class="cart-empty">Chưa có nguyên liệu nào</p>
                    <%
                        }
                    %>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal for adding ingredient -->
    <div id="addModal" class="modal" style="display:none;">
        <div class="modal-content">
            <h2>Thêm nguyên liệu</h2>
            <form action="<%= request.getContextPath() %>/IngredientServlet" method="post" id="addForm">
                <input type="hidden" name="action" value="addToCart">
                <input type="hidden" name="ingredientId" id="modalIngredientId">

                <div class="form-group">
                    <label>Tên nguyên liệu:</label>
                    <p id="modalIngredientName"></p>
                </div>

                <div class="form-group">
                    <label for="quantity">Số lượng:</label>
                    <input type="number" name="quantity" id="quantity" class="form-input" step="0.01" required>
                </div>

                <div class="form-group">
                    <label for="unitPrice">Đơn giá:</label>
                    <input type="number" name="unitPrice" id="unitPrice" class="form-input" step="0.01" required>
                </div>

                <div class="modal-actions">
                    <button type="button" class="btn-secondary" onclick="closeModal()">Hủy</button>
                    <button type="submit" class="btn-primary">Thêm</button>
                </div>
            </form>
        </div>
    </div>

    <script>
        function showAddModal(id, name, price) {
            document.getElementById('modalIngredientId').value = id;
            document.getElementById('modalIngredientName').textContent = name;
            document.getElementById('unitPrice').value = price;
            document.getElementById('addModal').style.display = 'flex';
        }

        function closeModal() {
            document.getElementById('addModal').style.display = 'none';
        }
    </script>
        <%
            } // End else block
        %>
</body>
</html>
