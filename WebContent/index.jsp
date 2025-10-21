<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>RestMan - Hệ thống Quản lý Nhà hàng</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
    <style>
        .index-container {
            text-align: center;
            padding: 60px 30px;
        }

        .index-logo {
            font-size: 120px;
            margin-bottom: 20px;
        }

        .index-title {
            font-size: 48px;
            color: #333;
            margin-bottom: 15px;
        }

        .index-subtitle {
            font-size: 20px;
            color: #666;
            margin-bottom: 50px;
        }

        .index-buttons {
            display: flex;
            flex-direction: column;
            gap: 20px;
            max-width: 400px;
            margin: 0 auto;
        }

        .index-button {
            padding: 25px;
            border-radius: 12px;
            text-decoration: none;
            font-size: 20px;
            font-weight: 600;
            transition: all 0.3s;
            border: 3px solid;
        }

        .index-button.customer {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-color: transparent;
        }

        .index-button.staff {
            background: white;
            color: #667eea;
            border-color: #667eea;
        }

        .index-button:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 30px rgba(102, 126, 234, 0.3);
        }

        .features {
            margin-top: 60px;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 30px;
        }

        .feature {
            padding: 30px;
            background: white;
            border-radius: 12px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.05);
        }

        .feature-icon {
            font-size: 50px;
            margin-bottom: 15px;
        }

        .feature h3 {
            color: #333;
            margin-bottom: 10px;
        }

        .feature p {
            color: #666;
            line-height: 1.6;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="index-container">
            <div class="index-logo">🍴</div>
            <h1 class="index-title">RestMan</h1>
            <p class="index-subtitle">Hệ thống Quản lý Nhà hàng</p>

            <div class="index-buttons">
                <a href="<%= request.getContextPath() %>/customer/Customer.jsp" class="index-button customer">
                    👤 Khách hàng
                </a>
                <a href="<%= request.getContextPath() %>/Login.jsp" class="index-button staff">
                    🔐 Đăng nhập - Nhân viên
                </a>
            </div>

            <div class="features">
                <div class="feature">
                    <div class="feature-icon">🔍</div>
                    <h3>Tìm kiếm món ăn</h3>
                    <p>Khám phá thực đơn đa dạng với hệ thống tìm kiếm thông minh</p>
                </div>

                <div class="feature">
                    <div class="feature-icon">📦</div>
                    <h3>Quản lý kho</h3>
                    <p>Nhập nguyên liệu từ nhà cung cấp, quản lý tồn kho hiệu quả</p>
                </div>

                <div class="feature">
                    <div class="feature-icon">📊</div>
                    <h3>Thống kê báo cáo</h3>
                    <p>Theo dõi doanh thu, món ăn bán chạy và xu hướng khách hàng</p>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
