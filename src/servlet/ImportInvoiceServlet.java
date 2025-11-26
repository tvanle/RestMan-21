package servlet;

import dao.ImportInvoiceDAO;
import dao.IngredientDAO;
import model.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/ImportInvoiceServlet")
public class ImportInvoiceServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        HttpSession session = request.getSession();
        String action = request.getParameter("action");

        // Handle removeItem action - Xóa 1 nguyên liệu khỏi giỏ hàng
        if ("removeItem".equals(action)) {
            String itemIndexStr = request.getParameter("itemIndex");
            if (itemIndexStr != null) {
                try {
                    int itemIndex = Integer.parseInt(itemIndexStr);
                    @SuppressWarnings("unchecked")
                    List<ImportDetail> importDetails = (List<ImportDetail>) session.getAttribute("importDetails");
                    if (importDetails != null && itemIndex >= 0 && itemIndex < importDetails.size()) {
                        importDetails.remove(itemIndex);
                        session.setAttribute("importDetails", importDetails);
                    }
                } catch (NumberFormatException e) {
                    // Invalid index
                }
            }
            // Redirect về IngredientServlet để load lại trang
            response.sendRedirect(request.getContextPath() + "/IngredientServlet");
            return;
        }

        // Handle clearCart action - Xóa tất cả giỏ hàng
        if ("clearCart".equals(action)) {
            session.removeAttribute("importDetails");
            session.removeAttribute("importInvoice");
            response.sendRedirect(request.getContextPath() + "/SupplierServlet");
            return;
        }

        // Handle addToCart action (Bước 48-54 trong sequence diagram)
        if ("addToCart".equals(action)) {
            String ingredientIdStr = request.getParameter("ingredientId");
            String quantityStr = request.getParameter("quantity");
            String unitPriceStr = request.getParameter("unitPrice");

            if (ingredientIdStr != null && quantityStr != null && unitPriceStr != null) {
                try {
                    int ingredientId = Integer.parseInt(ingredientIdStr);
                    float quantity = Float.parseFloat(quantityStr);
                    float unitPrice = Float.parseFloat(unitPriceStr);

                    IngredientDAO ingredientDAO = new IngredientDAO();
                    Ingredient ingredient = ingredientDAO.getIngredientById(ingredientId);

                    if (ingredient != null) {
                        // Bước 50-52: Tạo ImportDetail object
                        ImportDetail detail = new ImportDetail();
                        detail.setIngredient(ingredient);
                        detail.setQuantity(quantity);
                        detail.setUnitPrice(unitPrice);

                        // Lấy hoặc tạo danh sách ImportDetail trong session
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

            // Bước 53-54: Load lại danh sách ingredients và forward về ImportInvoice.jsp
            IngredientDAO ingredientDAO = new IngredientDAO();
            List<Ingredient> ingredients = ingredientDAO.searchIngredientByName("");
            request.setAttribute("ingredients", ingredients);
            request.setAttribute("searchKeyword", "");
            request.getRequestDispatcher("/warehousestaff/ImportInvoice.jsp").forward(request, response);
            return;
        }

        // Get data from session
        Supplier supplier = (Supplier) session.getAttribute("selectedSupplier");
        @SuppressWarnings("unchecked")
        List<ImportDetail> importDetails = (List<ImportDetail>) session.getAttribute("importDetails");
        User user = (User) session.getAttribute("user");

        if (supplier == null || importDetails == null || importDetails.isEmpty() || user == null) {
            request.setAttribute("errorMessage", "Thiếu thông tin hóa đơn");
            request.getRequestDispatcher("/warehousestaff/ImportInvoice.jsp").forward(request, response);
            return;
        }

        // Calculate total amount
        float totalAmount = 0;
        for (ImportDetail detail : importDetails) {
            totalAmount += detail.getTotalPrice();
        }

        // Add VAT 10%
        float vat = totalAmount * 0.1f;
        float finalAmount = totalAmount + vat;

        // Create import invoice
        ImportInvoice invoice = new ImportInvoice();
        invoice.setDate(new Date(System.currentTimeMillis()));
        invoice.setTotalAmount(finalAmount);
        invoice.setSupplier(supplier);
        invoice.setWarehouseStaff((WarehouseStaff) user);
        invoice.setImportDetails(importDetails);

        // Save to database
        ImportInvoiceDAO invoiceDAO = new ImportInvoiceDAO();
        boolean success = invoiceDAO.addNewImportInvoice(invoice);

        if (success) {
            // Clear session data
            session.removeAttribute("selectedSupplier");
            session.removeAttribute("importDetails");
            session.removeAttribute("importInvoice");

            // Redirect to SupplierServlet with success message
            session.setAttribute("successMessage", "Tạo hóa đơn nhập hàng thành công! Mã HD: HD" + String.format("%08d", invoice.getId()));
            response.sendRedirect(request.getContextPath() + "/SupplierServlet");
        } else {
            request.setAttribute("errorMessage", "Lỗi khi lưu hóa đơn");
            request.getRequestDispatcher("/warehousestaff/ImportInvoice.jsp").forward(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}
