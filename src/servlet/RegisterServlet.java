package servlet;

import dao.UserDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        // Get form parameters
        String fullname = request.getParameter("fullname");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirm_password");

        // Validate inputs
        if (fullname == null || fullname.trim().isEmpty() ||
            email == null || email.trim().isEmpty() ||
            phone == null || phone.trim().isEmpty() ||
            username == null || username.trim().isEmpty() ||
            password == null || password.trim().isEmpty()) {
            
            request.setAttribute("error", "Vui lòng điền đầy đủ thông tin");
            request.getRequestDispatcher("/Register.jsp").forward(request, response);
            return;
        }

        // Check password match
        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Mật khẩu xác nhận không khớp");
            request.getRequestDispatcher("/Register.jsp").forward(request, response);
            return;
        }

        // Try to register user
        UserDAO userDAO = new UserDAO();
        Boolean result = userDAO.registerUser(username, fullname, email, phone, password);

        if (result == null) {
            // Database connection not available
            request.setAttribute("error", "Không thể kết nối cơ sở dữ liệu. Vui lòng kiểm tra MySQL đã được khởi động.");
            request.getRequestDispatcher("/Register.jsp").forward(request, response);
        } else if (result) {
            // Registration successful
            request.setAttribute("success", "Đăng ký thành công! Bạn có thể đăng nhập ngay.");
            request.getRequestDispatcher("/Login.jsp").forward(request, response);
        } else {
            // Registration failed (username exists)
            request.setAttribute("error", "Tên đăng nhập đã tồn tại. Vui lòng chọn tên khác.");
            request.getRequestDispatcher("/Register.jsp").forward(request, response);
        }
    }
}
