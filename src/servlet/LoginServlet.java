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
        String role = request.getParameter("role");

        if (username == null || username.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập tên đăng nhập");
            request.getRequestDispatcher("/Login.jsp").forward(request, response);
            return;
        }

        UserDAO userDAO = new UserDAO();
        User user = userDAO.checkLogin(username, role);

        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("username", username);
            session.setAttribute("role", role);

            // Redirect based on role
            if ("WAREHOUSE_STAFF".equals(role)) {
                response.sendRedirect(request.getContextPath() + "/warehousestaff/WarehouseStaff.jsp");
            } else if ("MANAGER".equals(role)) {
                response.sendRedirect(request.getContextPath() + "/manager/Manager.jsp");
            } else if ("SALE_STAFF".equals(role)) {
                response.sendRedirect(request.getContextPath() + "/salestaff/SaleStaff.jsp");
            } else {
                response.sendRedirect(request.getContextPath() + "/index.jsp");
            }
        } else {
            request.setAttribute("error", "Tên đăng nhập không tồn tại");
            request.getRequestDispatcher("/Login.jsp").forward(request, response);
        }
    }
}
