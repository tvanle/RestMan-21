# Module "Nhập nguyên liệu từ nhà cung cấp"

## Kịch bản đầy đủ (65 bước)

### Phần A: Đăng nhập (Bước 1-11)

1. Nhân viên nhập và click "login" trên trang Login.jsp.
2. Trang Login.jsp gọi đến LoginServlet
3. LoginServlet kích hoạt phương thức doGet().
4. LoginServlet gọi phương thức checkLogin() từ UserDAO.
5. UserDAO thực hiện checkLogin() với truy vấn SQL
6. UserDAO gọi đến thực thể User để đóng gói đối tượng.
7. Thực thể User đóng gói đối tượng.
8. Đối tượng User trả về cho UserDAO.
9. UserDAO trả về cho LoginServlet.
10. LoginServlet gọi đến trang WarehouseStaff.jsp.
11. Trang WarehouseStaff.jsp hiển thị giao diện.

### Phần B: Chọn nhà cung cấp (Bước 12-27)

12. Nhân viên kho chọn "Nhập nguyên liệu" trên trang WarehouseStaff.jsp.
13. Trang WarehouseStaff.jsp gọi đến SupplierServlet.
14. SupplierServlet thực hiện phương thức doGet().
15. SupplierServlet gọi trang giao diện SearchSupplier.jsp.
16. Trang SearchSupplier.jsp hiển thị giao diện tìm kiếm nhà cung cấp.
17. Nhân viên kho nhập tên nhà cung cấp và click "Search".
18. Trang SearchSupplier.jsp gọi yêu cầu đến SupplierServlet.
19. SupplierServlet thực hiện phương thức doGet().
20. SupplierServlet gọi phương thức searchSupplierByName() trên SupplierDAO.
21. SupplierDAO thực hiện searchSupplierByName() với truy vấn SQL.
22. SupplierDAO gọi thực thể Supplier để đóng gói đối tượng.
23. Thực thể Supplier đóng gói đối tượng.
24. Đối tượng Supplier truyền ngược lên SupplierDAO.
25. SupplierDAO trả về danh sách Supplier lên SupplierServlet.
26. SupplierServlet trả về kết quả cho trang SearchSupplier.jsp.
27. Trang SearchSupplier.jsp hiển thị danh sách nhà cung cấp.

### Phần C: Khởi tạo hóa đơn (Bước 28-33)

28. Nhân viên kho chọn một nhà cung cấp từ danh sách.
29. Trang SearchSupplier.jsp gọi IngredientServlet để doGet() chuyển đến trang ImportInvoice.jsp.
30. IngredientServlet kích hoạt phương thức doGet().
31. IngredientServlet gọi thực thể ImportInvoice để khởi tạo đối tượng hóa đơn (có thể lưu trong session).
32. ImportInvoice gọi đối tượng.
33. Đối tượng ImportInvoice trả về IngredientServlet.
34. IngredientServlet gọi đến ImportInvoice.jsp.
35. Trang ImportInvoice.jsp hiển thị form nhập hóa đơn.

### Phần D: Thêm nguyên liệu vào hóa đơn (Bước 36-51 - lặp lại nhiều lần)

**<Lặp lại các bước 36-51 đến khi nhập hết nguyên liệu cần nhập>**

36. Nhân viên kho nhập tên nguyên liệu và click "Search" trên ImportInvoice.jsp.
37. Trang ImportInvoice.jsp gọi yêu cầu đến IngredientServlet.
38. IngredientServlet thực hiện phương thức doGet().
39. IngredientServlet gọi phương thức searchIngredientByName() trên IngredientDAO.
40. IngredientDAO thực hiện searchIngredientByName() với truy vấn SQL.
41. IngredientDAO gọi đến thực thể Ingredient để đóng gói.
42. Thực thể Ingredient đóng gói đối tượng.
43. Đối tượng Ingredient trả về IngredientDAO.
44. IngredientDAO trả về danh sách Ingredient lên IngredientServlet.
45. IngredientServlet trả về danh sách nguyên liệu cho ImportInvoice.jsp
46. Trang ImportInvoice.jsp hiển thị danh sách nguyên liệu.
47. Nhân viên kho chọn nguyên liệu, nhập số lượng và đơn giá.
48. Nhân viên kho gửi yêu cầu submit chi tiết nhập hàng và gọi đến ImportInvoiceServlet.
49. ImportInvoiceServlet kích hoạt phương thức doPost().
50. ImportInvoiceServlet gọi đối tượng ImportDetail.
51. Thực thể ImportDetail gọi đối tượng.
52. ImportDetail trả về cho ImportInvoiceServlet.
53. ImportInvoiceServlet trả về xác nhận thêm chi tiết cho ImportInvoice.jsp
54. Trang ImportInvoice.jsp hiển thị form cập nhật hóa đơn (với danh sách chi tiết đã chọn).

### Phần E: Xác nhận và lưu hóa đơn (Bước 55-65)

55. Nhân viên kho xác nhận, (nhập thông tin thanh toán) và click "Xác nhận và thanh toán" (hoặc "In hóa đơn") trên ImportInvoice.jsp.
56. Trang ImportInvoice.jsp gọi yêu cầu submit toàn bộ hóa đơn đến ImportInvoiceServlet (kích hoạt doPost()).
57. ImportInvoiceServlet thực hiện phương thức doPost().
58. ImportInvoiceServlet gọi ImportInvoiceDAO.
59. ImportInvoiceDAO thực hiện addNewImportInvoice().
60. ImportInvoiceDAO.addNewImportInvoice() gọi phương thức addListNewImportDetail() trên ImportingDetailDAO để lưu danh sách chi tiết vào CSDL.
61. ImportingDetailDAO thực hiện addListNewImportDetail() với truy vấn SQL.
62. ImportingDetailDAO trả về ImportInvoiceDAO kết quả thêm danh sách chi tiết.
63. ImportInvoiceDAO trả về ImportInvoiceServlet kết quả thêm hóa đơn.
64. ImportInvoiceServlet trả về xác nhận hoàn tất.
65. Trang ImportInvoice.jsp (hoặc chuyển hướng đến trang hóa đơn ) hiển thị thông báo thành công
