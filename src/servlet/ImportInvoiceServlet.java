package servlet;

import dao.ImportInvoiceDAO;
import model.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Date;
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
