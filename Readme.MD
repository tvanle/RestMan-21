# Hệ thống Quản lý Đăng ký Tín chỉ - Môn Phân tích Thiết kế Hệ thống

## Giới thiệu

[cite_start]Đây là dự án ví dụ cho môn học **Phân tích Thiết kế Hệ thống Thông tin**, chuyên ngành Công nghệ Phần mềm[cite: 1]. [cite_start]Dự án mô phỏng một hệ thống web quản lý đăng ký tín chỉ cho sinh viên tại một trường đại học[cite: 1483, 1811]. Hệ thống bao gồm các chức năng chính cho sinh viên, giảng viên, nhân viên giáo vụ, và quản lý.

Mục tiêu chính của dự án là áp dụng các kiến thức về:
* [cite_start]Quy trình phát triển phần mềm hướng đối tượng[cite: 107].
* [cite_start]Phân tích và thu thập yêu cầu (Use Case, Kịch bản)[cite: 1455].
* [cite_start]Thiết kế hệ thống sử dụng UML (Biểu đồ lớp, tuần tự, hoạt động,...)[cite: 536, 2727].
* [cite_start]Thiết kế cơ sở dữ liệu quan hệ[cite: 2872].
* [cite_start]Cài đặt hệ thống (Java Web)[cite: 3435].
* [cite_start]Đảm bảo chất lượng phần mềm (Rà soát, Kiểm thử)[cite: 945].

---

## Công nghệ sử dụng

* **Ngôn ngữ lập trình:** Java
* **Web Technologies:** JSP, Servlets (ngầm định khi dùng JSP/Tomcat)
* [cite_start]**Database:** MySQL [cite: 3449]
* [cite_start]**Database Connectivity:** JDBC [cite: 3449]
* [cite_start]**Web Server/Servlet Container:** Apache Tomcat 
* [cite_start]**IDE:** Eclipse (được minh họa trong tài liệu) 
* [cite_start]**Testing Framework:** JUnit [cite: 3437, 3725]

---

## Tổ chức Thư mục và Code

[cite_start]Dự án được tổ chức theo cấu trúc dự án Web động trong Eclipse[cite: 3436, 3438].

. ├── Java Resources/ # Chứa mã nguồn Java và thư viện │ └── src/ # Thư mục gốc cho mã nguồn Java │ ├── dao/ # Data Access Objects - Lớp truy cập cơ sở dữ liệu │ │ ├── DAO.java # Lớp cơ sở, quản lý kết nối CSDL  │ │ ├── DangkihocDAO.java │ │ ├── KihocDAO.java │ │ ├── LichhocDAO.java │ │ ├── LophocphanDAO.java │ │ ├── MonhocKihocDAO.java │ │ ├── SinhvienKhoaDAO.java │ │ ├── ThanhvienDAO.java │ │ ├── TKHoclucDAO.java # DAO cho thống kê học lực │ │ ├── TKSinhvienDAO.java # DAO cho thống kê sinh viên  │ │ └── ... # Các lớp DAO khác │ ├── model/ # Lớp thực thể (Entities/POJOs)  │ │ ├── Thanhvien.java │ │ ├── Sinhvien.java │ │ ├── Giangvien.java │ │ ├── Dangkihoc.java │ │ ├── Kihoc.java │ │ ├── Khoa.java │ │ ├── Monhoc.java │ │ ├── Lophocphan.java │ │ ├── Lichhoc.java │ │ ├── Ketqua.java │ │ ├── Hoten.java │ │ ├── Diachi.java │ │ └── ... # Các lớp model khác │ └── unittest/ # Chứa các lớp kiểm thử đơn vị JUnit  │ └── TestDangkihocDAO.java │ └── ... # Các lớp Test khác │ └── Libraries/ # Thư viện ngoài (JAR files)  │ └── ... ├── WebContent/ # Chứa các tài nguyên web (JSP, HTML, CSS, JS) │ ├── gddangnhap.jsp # Trang đăng nhập │ ├── doDangnhap.jsp # Xử lý logic đăng nhập  │ ├── header.jsp # Phần header chung (ví dụ) │ ├── sv/ # Các trang JSP dành cho Sinh viên │ │ ├── gdchinhsv.jsp # Trang chính sinh viên │ │ ├── gdchonnganh.jsp # Chọn ngành/kỳ học để đăng ký │ │ ├── gddangki.jsp # Giao diện đăng ký chính │ │ ├── gdchonmh.jsp # Chọn môn học │ │ ├── gdchonlhp.jsp # Chọn lớp học phần │ │ ├── gdxemlich.jsp # Xem lịch học của lớp │ │ ├── doluudk.jsp # Xử lý lưu đăng ký  │ │ └── ... │ ├── gv/ # Các trang JSP dành cho Giảng viên (ví dụ: nhập điểm)  │ │ ├── gdchinhgv.jsp │ │ ├── gdMonhoc.jsp # Chọn môn học (cho nhập điểm) │ │ ├── gdLophocphan.jsp # Chọn lớp học phần (cho nhập điểm) │ │ ├── gdDiem.jsp # Nhập điểm chi tiết │ │ ├── doLuudiem.jsp # Xử lý lưu điểm  │ │ └── ... │ ├── ql/ # Các trang JSP dành cho Quản lý (ví dụ: thống kê)  │ │ ├── gdChinhQL.jsp │ │ ├── gdChonTK.jsp # Chọn loại thống kê & kỳ học │ │ ├── gdTKHocluc.jsp # Xem thống kê học lực │ │ ├── gdTKHLSinhvien.jsp # Xem danh sách SV theo học lực │ │ ├── gdTKDiemSV.jsp # Xem điểm các môn của SV │ │ ├── gdDiemMHSV.jsp # Xem điểm chi tiết môn của SV  │ │ └── ... │ ├── css/ # (Nên có) Chứa các file CSS │ ├── js/ # (Nên có) Chứa các file JavaScript │ ├── images/ # (Nên có) Chứa hình ảnh │ ├── META-INF/ │ │ └── MANIFEST.MF │ └── WEB-INF/ │ ├── lib/ # Thư viện JAR cần thiết khi deploy  │ │ └── mysql-connector-java-XYZ.jar # Driver MySQL │ │ └── junit-XYZ.jar # Thư viện JUnit (nếu cần khi deploy) │ │ └── ... │ └── web.xml # Deployment Descriptor (Cấu hình Servlet, Filter,...) ├── build/ # Thư mục chứa các file đã biên dịch (.class) ├── .classpath # File cấu hình classpath của Eclipse ├── .project # File cấu hình dự án của Eclipse