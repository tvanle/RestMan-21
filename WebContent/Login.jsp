<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập - RestMan</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
    <div class="login-container">
        <div class="login-box">
            <div class="system-header">
                <h1>RestMan</h1>
                <p>Đăng nhập</p>
            </div>

            <%
                String error = (String) request.getAttribute("error");
                String success = (String) request.getAttribute("success");
                if (success != null) {
            %>
            <div style="background-color: #d4edda; color: #155724; padding: 12px; border-radius: 8px; margin-bottom: 20px; border: 1px solid #c3e6cb;">
                <%= success %>
            </div>
            <%
                }
                if (error != null) {
            %>
            <div class="error-message">
                <%= error %>
            </div>
            <%
                }
            %>

            <form action="<%= request.getContextPath() %>/LoginServlet" method="post" class="login-form">
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

                <button type="submit" class="btn-primary btn-full">
                    Đăng nhập
                </button>

                <div style="text-align: center; margin-top: 25px;">
                    <a href="<%= request.getContextPath() %>/customer/Customer.jsp" style="color: #667eea; text-decoration: none; font-size: 16px;">
                        Tiếp tục với tư cách khách
                    </a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
