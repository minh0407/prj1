<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head><meta charset="UTF-8"><title>Báo cáo</title>
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
      <li><a href="${pageContext.request.contextPath}/admin/orders"    class="nav-link text-white">Đơn hàng</a></li>
      <li><a href="${pageContext.request.contextPath}/admin/reports"   class="nav-link text-warning">Báo cáo</a></li>
    </ul>
  </nav>
  <main class="col-md-10 p-4">
    <h3>Báo cáo thống kê</h3>
    <div class="row g-3 mt-2">
      <div class="col-md-4">
        <div class="card text-white bg-success">
          <div class="card-body">
            <h5 class="card-title">Tổng doanh thu</h5>
            <p class="card-text fs-4"><fmt:formatNumber value="${totalRevenue}" pattern="#,###"/> đ</p>
          </div>
        </div>
      </div>
      <div class="col-md-4">
        <div class="card text-white bg-primary">
          <div class="card-body">
            <h5 class="card-title">Tổng đơn hàng</h5>
            <p class="card-text fs-4">${orderCount}</p>
          </div>
        </div>
      </div>
      <div class="col-md-4">
        <div class="card text-white bg-info">
          <div class="card-body">
            <h5 class="card-title">Tổng sản phẩm</h5>
            <p class="card-text fs-4">${productCount}</p>
          </div>
        </div>
      </div>
      <div class="col-md-4">
        <div class="card text-white bg-secondary">
          <div class="card-body">
            <h5 class="card-title">Tổng khách hàng</h5>
            <p class="card-text fs-4">${userCount}</p>
          </div>
        </div>
      </div>
      <div class="col-md-4">
        <div class="card bg-light">
          <div class="card-body">
            <h5 class="card-title">Giá sản phẩm</h5>
            <p class="mb-1">Cao nhất: <fmt:formatNumber value="${maxPrice}" pattern="#,###"/> đ</p>
            <p class="mb-1">Thấp nhất: <fmt:formatNumber value="${minPrice}" pattern="#,###"/> đ</p>
            <p class="mb-0">Trung bình: <fmt:formatNumber value="${avgPrice}" pattern="#,###"/> đ</p>
          </div>
        </div>
      </div>
    </div>
  </main>
</div>
</div>
</body>
</html>
