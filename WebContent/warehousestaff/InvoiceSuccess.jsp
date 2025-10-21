<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hóa đơn nhập hàng - RestMan</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
    <div class="container">
        <%
            ImportInvoice invoice = (ImportInvoice) request.getAttribute("invoice");
            Float totalBeforeVAT = (Float) request.getAttribute("totalBeforeVAT");
            Float vat = (Float) request.getAttribute("vat");
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");

            if (invoice != null) {
        %>
        <div class="invoice-container">
            <div class="invoice-header">
                <div class="logo-icon-large">🍴</div>
                <h1>HÓA ĐƠN NHẬP HÀNG</h1>
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
                <button type="button" class="btn-secondary" onclick="window.print()">📄 In hóa đơn</button>
                <a href="<%= request.getContextPath() %>/warehousestaff/WarehouseStaff.jsp" class="btn-primary">✓ Xác nhận và thanh toán</a>
            </div>
        </div>
        <%
            } else {
        %>
        <div class="error-message">
            <p>Không tìm thấy thông tin hóa đơn</p>
            <a href="<%= request.getContextPath() %>/warehousestaff/WarehouseStaff.jsp" class="btn-primary">Quay về trang chủ</a>
        </div>
        <%
            }
        %>
    </div>
</body>
</html>
