<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký - RestMan</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
    <div class="login-container">
        <div class="login-box">
            <div class="login-logo">
                <div class="logo-icon-large">🍴</div>
            </div>

            <h1 class="login-title">Đăng ký tài khoản</h1>
            <p class="login-subtitle">RestMan - Hệ thống Quản lý Nhà hàng</p>

            <!-- Info message always shown -->
            <div style="background-color: #e7f3ff; color: #004085; padding: 12px; border-radius: 8px; margin-bottom: 20px; border-left: 4px solid #0066cc;">
                <strong>ℹ️ Lưu ý:</strong> Để đăng ký tài khoản, cần có MySQL đang chạy.
                Nếu chưa cài đặt, bạn có thể <a href="<%= request.getContextPath() %>/customer/Customer.jsp" style="color: #667eea; font-weight: 600;">tiếp tục với tư cách khách</a>.
            </div>

            <%
                String error = (String) request.getAttribute("error");
                String success = (String) request.getAttribute("success");
                if (error != null) {
            %>
            <div class="error-message">
                <%= error %>
            </div>
            <%
                }
                if (success != null) {
            %>
            <div class="success-message" style="background-color: #d4edda; color: #155724; padding: 12px; border-radius: 8px; margin-bottom: 20px;">
                <%= success %>
            </div>
            <%
                }
            %>

            <form action="<%= request.getContextPath() %>/RegisterServlet" method="post" class="login-form">
                <div class="form-group">
                    <label for="fullname">Họ và tên</label>
                    <input type="text" id="fullname" name="fullname" class="form-input"
                           placeholder="Nhập họ và tên" required>
                </div>

                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="email" id="email" name="email" class="form-input"
                           placeholder="Nhập email" required>
                </div>

                <div class="form-group">
                    <label for="phone">Số điện thoại</label>
                    <input type="tel" id="phone" name="phone" class="form-input"
                           placeholder="Nhập số điện thoại" required>
                </div>

                <div class="form-group">
                    <label for="username">Tên đăng nhập</label>
                    <input type="text" id="username" name="username" class="form-input"
                           placeholder="Nhập tên đăng nhập" required>
                </div>

                <div class="form-group">
                    <label for="password">Mật khẩu</label>
                    <input type="password" id="password" name="password" class="form-input"
                           placeholder="Nhập mật khẩu" required>
                </div>

                <div class="form-group">
                    <label for="confirm_password">Xác nhận mật khẩu</label>
                    <input type="password" id="confirm_password" name="confirm_password" class="form-input"
                           placeholder="Nhập lại mật khẩu" required>
                </div>

                <button type="submit" class="btn-primary btn-full">
                    Đăng ký
                </button>

                <div style="text-align: center; margin-top: 20px;">
                    <span style="color: #666;">Đã có tài khoản? </span>
                    <a href="<%= request.getContextPath() %>/Login.jsp" style="color: #667eea; text-decoration: none; font-weight: 600;">
                        Đăng nhập
                    </a>
                </div>

                <div style="text-align: center; margin-top: 15px;">
                    <a href="<%= request.getContextPath() %>/customer/Customer.jsp" style="color: #667eea; text-decoration: none; font-size: 14px;">
                        Tiếp tục với tư cách khách
                    </a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
