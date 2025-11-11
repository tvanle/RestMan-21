package servlet;

import dao.IngredientDAO;
import dao.SupplierDAO;
import model.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
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

        // Bước 28-33: Nhận supplierId từ SearchSupplier.jsp và lưu vào session
        String supplierIdStr = request.getParameter("supplierId");
        if (supplierIdStr != null) {
            try {
                int supplierId = Integer.parseInt(supplierIdStr);
                SupplierDAO supplierDAO = new SupplierDAO();
                Supplier supplier = supplierDAO.getSupplierById(supplierId);
                if (supplier != null) {
                    session.setAttribute("selectedSupplier", supplier);
                }
            } catch (NumberFormatException e) {
                // Invalid supplier ID
            }
        }

        if ("search".equals(action)) {
            // Search ingredients
            String ingredientName = request.getParameter("ingredientName");
            List<Ingredient> ingredients = ingredientDAO.searchIngredientByName(ingredientName != null ? ingredientName : "");

            request.setAttribute("ingredients", ingredients);
            request.setAttribute("searchKeyword", ingredientName);
            request.getRequestDispatcher("/warehousestaff/ImportInvoice.jsp").forward(request, response);

        } else {
            // Default: load all ingredients and show import invoice page
            List<Ingredient> ingredients = ingredientDAO.searchIngredientByName("");
            request.setAttribute("ingredients", ingredients);
            request.setAttribute("searchKeyword", "");

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
