<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý Sản phẩm</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        .sidebar { min-height: 100vh; background: #212529; }
        .sidebar a { color: #adb5bd; text-decoration: none; display: block; padding: 10px 20px; }
        .sidebar a:hover, .sidebar a.active { background: #343a40; color: #fff; }
        .sidebar .brand { color: #fff; font-size: 1.2rem; font-weight: bold; padding: 20px; border-bottom: 1px solid #343a40; }
        .product-img { width: 50px; height: 50px; object-fit: cover; border-radius: 6px; }
    </style>
</head>
<body>
<div class="d-flex">
    <!-- Sidebar -->
    <div class="sidebar col-2">
        <div class="brand">⚙ Admin Panel</div>
        <a href="${pageContext.request.contextPath}/admin/dashboard">🏠 Dashboard</a>
        <a href="${pageContext.request.contextPath}/admin/products" class="active">📦 Sản phẩm</a>
        <a href="${pageContext.request.contextPath}/admin/customers">👥 Khách hàng</a>
        <hr class="border-secondary mx-3">
        <a href="${pageContext.request.contextPath}/logout">🚪 Đăng xuất</a>
    </div>

    <!-- Main content -->
    <div class="col-10 p-4">

        <!-- ═══════════════════ FORM THÊM / SỬA ═══════════════════ -->
        <c:if test="${not empty product || param.action == 'new'}">
            <div class="card mb-4">
                <div class="card-header fw-bold">
                    <c:choose>
                        <c:when test="${not empty product}">✏ Sửa sản phẩm: ${product.name}</c:when>
                        <c:otherwise>➕ Thêm sản phẩm mới</c:otherwise>
                    </c:choose>
                </div>
                <div class="card-body">
                    <form action="${pageContext.request.contextPath}/admin/products" method="post">
                        <c:if test="${not empty product}">
                            <input type="hidden" name="id" value="${product.id}"/>
                        </c:if>

                        <div class="row g-3">
                            <div class="col-md-6">
                                <label class="form-label">Tên sản phẩm <span class="text-danger">*</span></label>
                                <input type="text" name="name" class="form-control" required value="${product.name}"/>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Slug</label>
                                <input type="text" name="slug" class="form-control" value="${product.slug}"
                                       placeholder="vd: iphone-15-pro"/>
                            </div>
                            <div class="col-12">
                                <label class="form-label">Mô tả</label>
                                <textarea name="description" class="form-control" rows="3">${product.description}</textarea>
                            </div>
                            <div class="col-md-3">
                                <label class="form-label">Giá (VNĐ) <span class="text-danger">*</span></label>
                                <input type="number" name="price" class="form-control" required min="0" step="1000"
                                       value="${product.price}"/>
                            </div>
                            <div class="col-md-3">
                                <label class="form-label">Giảm giá (%)</label>
                                <input type="number" name="discount" class="form-control" min="0" max="100" step="0.1"
                                       value="${empty product ? '0' : product.discount}"/>
                            </div>
                            <div class="col-md-3">
                                <label class="form-label">Tồn kho <span class="text-danger">*</span></label>
                                <input type="number" name="stock" class="form-control" required min="0"
                                       value="${empty product ? '0' : product.stock}"/>
                            </div>
                            <div class="col-md-3">
                                <label class="form-label">Bảo hành (tháng)</label>
                                <input type="number" name="warranty" class="form-control" min="0"
                                       value="${empty product ? '12' : product.warranty}"/>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Ảnh (URL)</label>
                                <input type="text" name="image" class="form-control" value="${product.image}"
                                       placeholder="https://..."/>
                            </div>
                            <div class="col-md-3">
                                <label class="form-label">Category ID <span class="text-danger">*</span></label>
                                <input type="number" name="categoryId" class="form-control" required min="1"
                                       value="${product.categoryId}"/>
                            </div>
                            <div class="col-md-3">
                                <label class="form-label">Brand ID <span class="text-danger">*</span></label>
                                <input type="number" name="brandId" class="form-control" required min="1"
                                       value="${product.brandId}"/>
                            </div>
                            <div class="col-md-6 d-flex gap-4 align-items-center pt-2">
                                <div class="form-check form-switch">
                                    <input class="form-check-input" type="checkbox" name="isFeatured" id="isFeatured"
                                           ${product.isFeatured ? 'checked' : ''}/>
                                    <label class="form-check-label" for="isFeatured">Sản phẩm nổi bật</label>
                                </div>
                                <div class="form-check form-switch">
                                    <input class="form-check-input" type="checkbox" name="status" id="status"
                                           ${empty product || product.status ? 'checked' : ''}/>
                                    <label class="form-check-label" for="status">Hiển thị</label>
                                </div>
                            </div>
                        </div>

                        <div class="d-flex gap-2 mt-3">
                            <button type="submit" class="btn btn-primary">
                                <c:choose>
                                    <c:when test="${not empty product}">Cập nhật</c:when>
                                    <c:otherwise>Thêm sản phẩm</c:otherwise>
                                </c:choose>
                            </button>
                            <a href="${pageContext.request.contextPath}/admin/products" class="btn btn-secondary">Huỷ</a>
                        </div>
                    </form>
                </div>
            </div>
        </c:if>

        <!-- ═══════════════════ DANH SÁCH ═══════════════════ -->
        <div class="d-flex justify-content-between align-items-center mb-3">
            <h4 class="mb-0">📦 Danh sách sản phẩm</h4>
            <a href="${pageContext.request.contextPath}/admin/products?action=new" class="btn btn-success btn-sm">+ Thêm mới</a>
        </div>

        <div class="card">
            <div class="card-body p-0">
                <table class="table table-striped table-hover align-middle mb-0">
                    <thead class="table-dark">
                        <tr>
                            <th>#</th>
                            <th>Ảnh</th>
                            <th>Tên sản phẩm</th>
                            <th>Giá</th>
                            <th>Giảm</th>
                            <th>Kho</th>
                            <th>BH</th>
                            <th>Nổi bật</th>
                            <th>Trạng thái</th>
                            <th>Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${empty list}">
                                <tr><td colspan="10" class="text-center py-3 text-muted">Chưa có sản phẩm nào.</td></tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="p" items="${list}" varStatus="loop">
                                    <tr>
                                        <td>${loop.index + 1}</td>
                                        <td>
                                            <img src="${not empty p.image ? p.image : 'https://via.placeholder.com/50'}"
                                                 alt="${p.name}" class="product-img"
                                                 onerror="this.src='https://via.placeholder.com/50'"/>
                                        </td>
                                        <td>
                                            <strong>${p.name}</strong><br/>
                                            <small class="text-muted">${p.slug}</small>
                                        </td>
                                        <td><fmt:formatNumber value="${p.price}" type="number" groupingUsed="true"/>đ</td>
                                        <td>${p.discount}%</td>
                                        <td>${p.stock}</td>
                                        <td>${p.warranty}th</td>
                                        <td>
                                            <c:if test="${p.isFeatured}">
                                                <span class="badge bg-warning text-dark">★ Nổi bật</span>
                                            </c:if>
                                        </td>
                                        <td>
                                            <span class="badge ${p.status ? 'bg-success' : 'bg-secondary'}">
                                                ${p.status ? 'Hiển thị' : 'Ẩn'}
                                            </span>
                                        </td>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/admin/products?action=edit&id=${p.id}"
                                               class="btn btn-sm btn-warning">Sửa</a>
                                            <a href="${pageContext.request.contextPath}/admin/products?action=delete&id=${p.id}"
                                               class="btn btn-sm btn-danger"
                                               onclick="return confirm('Ẩn sản phẩm này?')">Xoá</a>
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
