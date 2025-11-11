package servlet;

import dao.SupplierDAO;
import model.Supplier;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/SupplierServlet")
public class SupplierServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        // Check for success message in session
        String successMessage = (String) request.getSession().getAttribute("successMessage");
        if (successMessage != null) {
            request.setAttribute("successMessage", successMessage);
            request.getSession().removeAttribute("successMessage");
        }

        String action = request.getParameter("action");
        SupplierDAO supplierDAO = new SupplierDAO();

        if ("search".equals(action)) {
            // Search suppliers
            String supplierName = request.getParameter("supplierName");
            List<Supplier> suppliers = supplierDAO.searchSupplierByName(supplierName != null ? supplierName : "");

            request.setAttribute("suppliers", suppliers);
            request.setAttribute("searchKeyword", supplierName);
            request.getRequestDispatcher("/warehousestaff/SearchSupplier.jsp").forward(request, response);

        } else if ("select".equals(action)) {
            // Select supplier and go to ingredient import
            String supplierIdStr = request.getParameter("supplierId");
            if (supplierIdStr != null) {
                try {
                    int supplierId = Integer.parseInt(supplierIdStr);
                    Supplier supplier = supplierDAO.getSupplierById(supplierId);

                    if (supplier != null) {
                        request.getSession().setAttribute("selectedSupplier", supplier);
                        response.sendRedirect(request.getContextPath() + "/IngredientServlet");
                    }
                } catch (NumberFormatException e) {
                    response.sendRedirect(request.getContextPath() + "/warehousestaff/SearchSupplier.jsp");
                }
            }
        } else {
            // Default: load all suppliers
            List<Supplier> suppliers = supplierDAO.searchSupplierByName("");
            request.setAttribute("suppliers", suppliers);
            request.getRequestDispatcher("/warehousestaff/SearchSupplier.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
