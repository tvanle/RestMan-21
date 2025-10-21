package servlet;

import dao.DishDAO;
import model.Dish;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/SearchDishServlet")
public class SearchDishServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        String action = request.getParameter("action");
        DishDAO dishDAO = new DishDAO();

        if ("search".equals(action)) {
            // Search dishes by name
            String dishName = request.getParameter("dishName");
            List<Dish> dishes = dishDAO.searchDishesByName(dishName != null ? dishName : "");

            request.setAttribute("dishes", dishes);
            request.setAttribute("searchKeyword", dishName);
            request.getRequestDispatcher("/customer/SearchDish.jsp").forward(request, response);

        } else if ("viewDetail".equals(action)) {
            // View dish detail
            String dishIdStr = request.getParameter("dishId");
            if (dishIdStr != null) {
                try {
                    int dishId = Integer.parseInt(dishIdStr);
                    Dish dish = dishDAO.getDishById(dishId);

                    request.setAttribute("dish", dish);
                    request.getRequestDispatcher("/customer/DishDetail.jsp").forward(request, response);
                } catch (NumberFormatException e) {
                    response.sendRedirect(request.getContextPath() + "/customer/Customer.jsp");
                }
            }
        } else {
            // Default: show search page
            request.getRequestDispatcher("/customer/SearchDish.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
