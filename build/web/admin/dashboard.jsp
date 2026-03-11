<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        .sidebar { min-height: 100vh; background: #212529; }
        .sidebar a { color: #adb5bd; text-decoration: none; display: block; padding: 10px 20px; }
        .sidebar a:hover, .sidebar a.active { background: #343a40; color: #fff; }
        .sidebar .brand { color: #fff; font-size: 1.2rem; font-weight: bold; padding: 20px; border-bottom: 1px solid #343a40; }
        .stat-card { border-radius: 12px; padding: 24px; color: #fff; }
    </style>
</head>
<body>
<div class="d-flex">
    <!-- Sidebar -->
    <div class="sidebar col-2">
        <div class="brand">⚙ Admin Panel</div>
        <a href="${pageContext.request.contextPath}/admin/dashboard" class="active">🏠 Dashboard</a>
        <a href="${pageContext.request.contextPath}/admin/products">📦 Sản phẩm</a>
        <a href="${pageContext.request.contextPath}/admin/customers">👥 Khách hàng</a>
        <hr class="border-secondary mx-3">
        <a href="${pageContext.request.contextPath}/logout">🚪 Đăng xuất</a>
    </div>

    <!-- Main content -->
    <div class="col-10 p-4">
        <h3 class="mb-1">Dashboard</h3>
        <p class="text-muted mb-4">Xin chào, <strong>${sessionScope.user.fullname}</strong>!</p>

        <!-- Stat cards -->
        <div class="row g-4 mb-5">
            <div class="col-md-4">
                <div class="stat-card" style="background: linear-gradient(135deg,#667eea,#764ba2);">
                    <div class="fs-2 fw-bold">${totalProducts}</div>
                    <div class="mt-1">📦 Tổng sản phẩm đang hiển thị</div>
                    <a href="${pageContext.request.contextPath}/admin/products"
                       class="btn btn-sm btn-light mt-3">Xem chi tiết →</a>
                </div>
            </div>
            <div class="col-md-4">
                <div class="stat-card" style="background: linear-gradient(135deg,#f093fb,#f5576c);">
                    <div class="fs-2 fw-bold">${totalUsers}</div>
                    <div class="mt-1">👥 Tổng người dùng</div>
                    <a href="${pageContext.request.contextPath}/admin/customers"
                       class="btn btn-sm btn-light mt-3">Xem chi tiết →</a>
                </div>
            </div>
        </div>

        <!-- Quick links -->
        <h5 class="mb-3">Thao tác nhanh</h5>
        <div class="d-flex gap-3">
            <a href="${pageContext.request.contextPath}/admin/products?action=new"
               class="btn btn-primary">+ Thêm sản phẩm mới</a>
            <a href="${pageContext.request.contextPath}/admin/customers"
               class="btn btn-outline-secondary">Xem danh sách khách hàng</a>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
