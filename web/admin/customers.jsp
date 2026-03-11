<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý Khách hàng</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        .sidebar { min-height: 100vh; background: #212529; }
        .sidebar a { color: #adb5bd; text-decoration: none; display: block; padding: 10px 20px; }
        .sidebar a:hover, .sidebar a.active { background: #343a40; color: #fff; }
        .sidebar .brand { color: #fff; font-size: 1.2rem; font-weight: bold; padding: 20px; border-bottom: 1px solid #343a40; }
        .avatar-img { width: 38px; height: 38px; object-fit: cover; border-radius: 50%; }
    </style>
</head>
<body>
<div class="d-flex">
    <!-- Sidebar -->
    <div class="sidebar col-2">
        <div class="brand">⚙ Admin Panel</div>
        <a href="${pageContext.request.contextPath}/admin/dashboard">🏠 Dashboard</a>
        <a href="${pageContext.request.contextPath}/admin/products">📦 Sản phẩm</a>
        <a href="${pageContext.request.contextPath}/admin/customers" class="active">👥 Khách hàng</a>
        <hr class="border-secondary mx-3">
        <a href="${pageContext.request.contextPath}/logout">🚪 Đăng xuất</a>
    </div>

    <!-- Main content -->
    <div class="col-10 p-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h4 class="mb-0">👥 Danh sách khách hàng</h4>
            <span class="badge bg-secondary fs-6">Tổng: ${empty users ? 0 : users.size()} người dùng</span>
        </div>

        <div class="card">
            <div class="card-body p-0">
                <table class="table table-striped table-hover align-middle mb-0">
                    <thead class="table-dark">
                        <tr>
                            <th>#</th>
                            <th>Avatar</th>
                            <th>Username</th>
                            <th>Họ tên</th>
                            <th>Email</th>
                            <th>Điện thoại</th>
                            <th>Vai trò</th>
                            <th>Trạng thái</th>
                            <th>Ngày tạo</th>
                            <th>Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${empty users}">
                                <tr><td colspan="10" class="text-center py-3 text-muted">Chưa có người dùng nào.</td></tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="u" items="${users}" varStatus="loop">
                                    <tr>
                                        <td>${loop.index + 1}</td>
                                        <td>
                                            <img src="${not empty u.avatar ? u.avatar : 'https://via.placeholder.com/38'}"
                                                 alt="${u.fullname}" class="avatar-img"
                                                 onerror="this.src='https://via.placeholder.com/38'"/>
                                        </td>
                                        <td><strong>${u.username}</strong></td>
                                        <td>${u.fullname}</td>
                                        <td>${u.email}</td>
                                        <td>${u.phone}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${u.role == 'admin'}">
                                                    <span class="badge bg-danger">Admin</span>
                                                </c:when>
                                                <c:when test="${u.role == 'staff'}">
                                                    <span class="badge bg-info text-dark">Staff</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-primary">User</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <span class="badge ${u.status ? 'bg-success' : 'bg-secondary'}">
                                                ${u.status ? 'Hoạt động' : 'Đã khoá'}
                                            </span>
                                        </td>
                                        <td>
                                            <fmt:formatDate value="${u.createdDate}" pattern="dd/MM/yyyy"/>
                                        </td>
                                        <td>
                                            <%-- Không cho khóa chính tài khoản admin đang đăng nhập --%>
                                            <c:choose>
                                                <c:when test="${u.id == sessionScope.user.id}">
                                                    <span class="text-muted small">Tài khoản của bạn</span>
                                                </c:when>
                                                <c:when test="${u.status}">
                                                    <a href="${pageContext.request.contextPath}/admin/customers?action=lock&id=${u.id}"
                                                       class="btn btn-sm btn-warning"
                                                       onclick="return confirm('Khoá tài khoản ${u.username}?')">🔒 Khoá</a>
                                                </c:when>
                                                <c:otherwise>
                                                    <a href="${pageContext.request.contextPath}/admin/customers?action=unlock&id=${u.id}"
                                                       class="btn btn-sm btn-success"
                                                       onclick="return confirm('Mở khoá tài khoản ${u.username}?')">🔓 Mở khoá</a>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </div>
    </div><!-- /main -->
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
