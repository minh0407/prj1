<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head><meta charset="UTF-8"><title>Quản lý đơn hàng</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
<div class="container-fluid">
<div class="row">
  <nav class="col-md-2 bg-dark text-white min-vh-100 p-3">
    <h5 class="text-white">HomeElectro Admin</h5>
    <ul class="nav flex-column">
      <li><a href="${pageContext.request.contextPath}/admin/dashboard" class="nav-link text-white">Dashboard</a></li>
      <li><a href="${pageContext.request.contextPath}/admin/products"  class="nav-link text-white">Sản phẩm</a></li>
      <li><a href="${pageContext.request.contextPath}/admin/customers" class="nav-link text-white">Khách hàng</a></li>
      <li><a href="${pageContext.request.contextPath}/admin/orders"    class="nav-link text-warning">Đơn hàng</a></li>
      <li><a href="${pageContext.request.contextPath}/admin/reports"   class="nav-link text-white">Báo cáo</a></li>
    </ul>
  </nav>
  <main class="col-md-10 p-4">
    <h3>Quản lý đơn hàng</h3>
    <table class="table table-striped table-bordered">
      <thead class="table-dark">
        <tr><th>#</th><th>User ID</th><th>Ngày đặt</th><th>Người nhận</th><th>SĐT</th><th>Tổng tiền</th><th>Thanh toán</th><th>Trạng thái</th><th>Hành động</th></tr>
      </thead>
      <tbody>
      <c:forEach var="o" items="${orders}">
        <tr>
          <td>${o.id}</td>
          <td>${o.userId}</td>
          <td>${o.orderDate}</td>
          <td>${o.receiverName}</td>
          <td>${o.phoneReceiver}</td>
          <td><fmt:formatNumber value="${o.totalAmount}" pattern="#,###"/> đ</td>
          <td>${o.paymentMethod}</td>
          <td><span class="badge bg-info text-dark">${o.status}</span></td>
          <td>
            <form action="${pageContext.request.contextPath}/admin/orders" method="post" class="d-flex gap-1">
              <input type="hidden" name="id" value="${o.id}">
              <select name="status" class="form-select form-select-sm" style="width:130px">
                <option value="Pending"   ${o.status=='Pending'   ? 'selected':''}>Chờ xử lý</option>
                <option value="Confirmed" ${o.status=='Confirmed' ? 'selected':''}>Đã xác nhận</option>
                <option value="Shipping"  ${o.status=='Shipping'  ? 'selected':''}>Đang giao</option>
                <option value="Completed" ${o.status=='Completed' ? 'selected':''}>Hoàn thành</option>
                <option value="Cancelled" ${o.status=='Cancelled' ? 'selected':''}>Đã hủy</option>
              </select>
              <button class="btn btn-sm btn-primary">Lưu</button>
            </form>
          </td>
        </tr>
      </c:forEach>
      </tbody>
    </table>
  </main>
</div>
</div>
</body>
</html>
