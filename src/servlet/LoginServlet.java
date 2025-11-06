package servlet;

import dao.UserDAO;
import model.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
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

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (username == null || username.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập tên đăng nhập");
            request.getRequestDispatcher("/Login.jsp").forward(request, response);
            return;
        }

        if (password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập mật khẩu");
            request.getRequestDispatcher("/Login.jsp").forward(request, response);
            return;
        }

        UserDAO userDAO = new UserDAO();
        User user = null;

        try {
            // Check login with username and password (no role filter)
            user = userDAO.checkLogin(username, password, null);
        } catch (Exception e) {
            System.err.println("Error during login: " + e.getMessage());
            request.setAttribute("error", "Lỗi kết nối cơ sở dữ liệu. Vui lòng kiểm tra MySQL đã được khởi động.");
            request.getRequestDispatcher("/Login.jsp").forward(request, response);
            return;
        }

        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("username", username);
            session.setAttribute("role", user.getRole());

            // Redirect all authenticated users to WarehouseStaff page
            response.sendRedirect(request.getContextPath() + "/warehousestaff/WarehouseStaff.jsp");
        } else {
            request.setAttribute("error", "Tên đăng nhập hoặc mật khẩu không đúng.");
            request.getRequestDispatcher("/Login.jsp").forward(request, response);
        }
    }
}
