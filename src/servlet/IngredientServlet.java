package servlet;

import dao.IngredientDAO;
import model.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/IngredientServlet")
public class IngredientServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        HttpSession session = request.getSession();
        String action = request.getParameter("action");
        IngredientDAO ingredientDAO = new IngredientDAO();

        if ("search".equals(action)) {
            // Search ingredients
            String ingredientName = request.getParameter("ingredientName");
            List<Ingredient> ingredients = ingredientDAO.searchIngredientByName(ingredientName != null ? ingredientName : "");

            request.setAttribute("ingredients", ingredients);
            request.setAttribute("searchKeyword", ingredientName);
            request.getRequestDispatcher("/warehousestaff/ImportInvoice.jsp").forward(request, response);

        } else if ("addToCart".equals(action)) {
            // Add ingredient to import cart
            String ingredientIdStr = request.getParameter("ingredientId");
            String quantityStr = request.getParameter("quantity");
            String unitPriceStr = request.getParameter("unitPrice");

            if (ingredientIdStr != null && quantityStr != null && unitPriceStr != null) {
                try {
                    int ingredientId = Integer.parseInt(ingredientIdStr);
                    float quantity = Float.parseFloat(quantityStr);
                    float unitPrice = Float.parseFloat(unitPriceStr);

                    Ingredient ingredient = ingredientDAO.getIngredientById(ingredientId);
                    if (ingredient != null) {
                        ImportDetail detail = new ImportDetail();
                        detail.setIngredient(ingredient);
                        detail.setQuantity(quantity);
                        detail.setUnitPrice(unitPrice);

                        // Get or create import details list in session
                        @SuppressWarnings("unchecked")
                        List<ImportDetail> importDetails = (List<ImportDetail>) session.getAttribute("importDetails");
                        if (importDetails == null) {
                            importDetails = new ArrayList<>();
                        }
                        importDetails.add(detail);
                        session.setAttribute("importDetails", importDetails);

                        request.setAttribute("successMessage", "Đã thêm nguyên liệu vào danh sách");
                    }
                } catch (NumberFormatException e) {
                    request.setAttribute("errorMessage", "Dữ liệu không hợp lệ");
                }
            }

            request.getRequestDispatcher("/warehousestaff/ImportInvoice.jsp").forward(request, response);

        } else {
            // Default: load all ingredients and show import invoice page
            List<Ingredient> ingredients = ingredientDAO.searchIngredientByName("");
            request.setAttribute("ingredients", ingredients);

            // Initialize import invoice if needed
            ImportInvoice invoice = (ImportInvoice) session.getAttribute("importInvoice");
            if (invoice == null) {
                invoice = new ImportInvoice();
                session.setAttribute("importInvoice", invoice);
            }

            request.getRequestDispatcher("/warehousestaff/ImportInvoice.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
