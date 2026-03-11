# PRJ301 - HomeElectro (Web Đồ Gia Dụng) - FIXED

## Những lỗi đã được sửa

### Model
- **CartItem**: Viết lại với `productId, productName, image, price, quantity, stock`, thêm `getSubtotal()` và `getTotal()`

### DAO
- **UserDAO**: Thêm `isUsernameExist()`, `isEmailExist()`, `changePassword()`, `resetPassword()`, `updateUser(int, String, String, String)`, `lockUser()`, `countAll()`
- **ProductDAO**: Thêm `getFlashSaleProducts()`, `getFeaturedProducts()`, `getNewProducts()`, `getBestSellerProducts()`, `getProducts()` (filter+phân trang), `countProducts()`, `getRelatedProducts()`, `updateStock()`
- **OrderDAO**: Thêm `getAllOrders()`, `getOrdersByUser()`, `getById()`, `updateStatus()`, `countAll()`
- **OrderDetailDAO**: Fix `insert()` → đổi thành `insertOrderDetail()` trả về `boolean`
- **ReportDAO**: Thêm `getMaxPrice()`, `getMinPrice()`, `getAvgPrice()`, `getProductCount()`, `getProductCount()`
- **DBContext**: Đổi `USER` → `USER_DB` để tránh conflict với SQL keyword

### Controller
- **CartServlet**: Bỏ `import com.sun.jdi`, dùng `CartItem` mới, fix `getSubtotal()`
- **CheckoutServlet**: Bỏ `import com.sun.jdi.connect.spi.Connection` và `utils.DBContext`, fix session user, forward đúng path
- **OrdersServlet**: Fix lấy `userId` từ `User` object trong session thay vì `session.getAttribute("userId")`
- **AdminOrdersServlet**: Bỏ `@WebServlet` annotation xung đột, thêm `doPost()` đúng, forward đúng path
- **AdminReportsServlet**: Bỏ `@WebServlet` annotation xung đột, bỏ `processRequest()` thừa
- **ForgotPasswordServlet**: Fix logic POST - dùng `username+email` để xác minh thay vì `session user`
- **ProfileServlet**: Fix gọi `dao.updateUser(int, String, String, String)` đúng signature
- **HomeServlet**: Gọi đúng các method mới của `ProductDAO`
- **ProductsServlet**: Gọi đúng `countProducts()` và `getProducts()`
- **ProductDetailServlet**: Gọi đúng `getRelatedProducts()`

### web.xml
- Bỏ mapping `/forgot-password` → đổi thành `/forgot`
- Bỏ mapping `/product-detail` → đổi thành `/productdetail`
- Tất cả servlet map đúng với `@WebServlet` annotation

### JSP mới thêm
- `cart.jsp` - Trang giỏ hàng
- `checkout.jsp` - Trang thanh toán
- `orders.jsp` - Trang lịch sử đơn hàng
- `admin/orders.jsp` - Quản lý đơn hàng (Admin)
- `admin/reports.jsp` - Báo cáo thống kê (Admin)

## Cài đặt
1. Import `PRJ.sql` vào SQL Server
2. Sửa thông tin kết nối trong `web/WEB-INF/ConnectDB.properties` (mặc định: sa/123)
3. Mở project bằng **NetBeans IDE**
4. Chạy với **Apache Tomcat 10+**

## Yêu cầu
- JDK 11+, Apache Tomcat 10.x, SQL Server 2019+, NetBeans IDE
