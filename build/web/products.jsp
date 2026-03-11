<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0">
    <title>Danh sách sản phẩm - HomeElectro</title>
    <style>
        /* ── Header ── */
#site-header{background:#d0021b;position:sticky;top:0;z-index:999;box-shadow:0 2px 10px rgba(0,0,0,.25)}
.hd-topbar{background:#a80115;padding:4px 0;font-size:12px;color:rgba(255,255,255,.9)}
.hd-topbar-inner{display:flex;justify-content:space-between;align-items:center}
.hd-main{padding:10px 0}
.hd-main-inner{display:flex;align-items:center;gap:14px}
.hd-logo{background:#fff;border-radius:8px;padding:6px 14px;font-weight:900;font-size:19px;color:#d0021b;letter-spacing:-.5px;flex-shrink:0;text-decoration:none}
.hd-logo span{background:rgba(208,2,27,.12);border-radius:4px;padding:0 3px}
.hd-search{flex:1;position:relative;min-width:0}
.hd-search input{width:100%;padding:10px 48px 10px 16px;border-radius:8px;border:none;font-size:14px;font-family:inherit;outline:none}
.hd-search button{position:absolute;right:0;top:0;bottom:0;width:44px;background:#111;border:none;border-radius:0 8px 8px 0;cursor:pointer;color:#fff;font-size:16px}
.hd-icons{display:flex;gap:4px;flex-shrink:0}
.hd-icon-btn{display:flex;flex-direction:column;align-items:center;gap:2px;color:#fff;padding:4px 10px;border-radius:6px;cursor:pointer;position:relative;white-space:nowrap;text-decoration:none}
.hd-icon-btn:hover{background:rgba(255,255,255,.15)}
.hd-icon-ico{font-size:20px;position:relative;line-height:1}
.hd-icon-btn > span{font-size:11px;color:rgba(255,255,255,.9)}
.hd-badge{position:absolute;top:-5px;right:-7px;background:#fff;color:#d0021b;font-size:10px;font-weight:800;border-radius:50%;width:16px;height:16px;display:flex;align-items:center;justify-content:center}
.hd-account{position:relative}
.hd-account-name{font-size:11px;color:rgba(255,255,255,.9);max-width:72px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap}
.hd-dropdown{display:none;position:absolute;top:calc(100% + 10px);right:0;background:#fff;border-radius:10px;box-shadow:0 8px 28px rgba(0,0,0,.18);min-width:190px;padding:6px 0;z-index:1000}
.hd-account:hover .hd-dropdown{display:block}
.hd-dropdown a{display:block;padding:10px 16px;font-size:13px;color:#333;text-decoration:none}
.hd-dropdown a:hover{background:#f5f5f5;color:#d0021b}
.hd-dropdown hr{border:none;border-top:1px solid #f0f0f0;margin:4px 0}
.hd-catnav{background:rgba(0,0,0,.18);border-top:1px solid rgba(255,255,255,.1);overflow-x:auto;scrollbar-width:none}
.hd-catnav::-webkit-scrollbar{display:none}
.hd-catnav-inner{display:flex}
.hd-catitem{padding:9px 15px;color:rgba(255,255,255,.9);font-size:13px;font-weight:500;white-space:nowrap;border-bottom:2px solid transparent;transition:all .15s;text-decoration:none;display:block}
.hd-catitem:hover,.hd-catitem.on{color:#fff;border-bottom-color:#fff;background:rgba(255,255,255,.12)}
/* ── Footer ── */
#site-footer{background:#111;color:#fff;padding:40px 0 0;margin-top:20px}
.footer-grid{display:grid;grid-template-columns:2fr 1fr 1fr 1fr;gap:36px;padding-bottom:32px}
.footer-logo{background:#d0021b;border-radius:8px;padding:5px 14px;display:inline-block;font-weight:900;font-size:19px;color:#fff;margin-bottom:14px}
.footer-about p{font-size:13px;color:#aaa;line-height:1.7;margin-bottom:14px}
.footer-contact{display:flex;flex-direction:column;gap:6px;font-size:13px;color:#aaa}
.footer-contact strong{color:#fff}
.footer-col-title{font-size:14px;font-weight:700;color:#fff;margin-bottom:14px}
.footer-grid > div a{display:block;font-size:13px;color:#aaa;margin-bottom:8px;text-decoration:none}
.footer-grid > div a:hover{color:#fff}
.footer-bottom{border-top:1px solid #2a2a2a;padding:16px 0;display:flex;justify-content:space-between;font-size:12px;color:#666;flex-wrap:wrap;gap:8px}

*{box-sizing:border-box;margin:0;padding:0}
:root{
  --red:#d0021b;--red2:#a80115;--red-bg:#fff5f5;
  --border:#e8e8e8;--text:#1a1a1a;--muted:#777;--bg:#f5f5f5;
  --radius:8px;
}
body{background:var(--bg);font-family:'Segoe UI',Arial,sans-serif;color:var(--text);font-size:14px}
a{text-decoration:none;color:inherit}
img{display:block;max-width:100%}
.cnt{max-width:1200px;margin:0 auto;padding:0 16px}
.page-main{padding:16px 0 48px}

/* ── Breadcrumb ── */
.bc{display:flex;align-items:center;gap:6px;font-size:13px;color:var(--muted);margin-bottom:14px;flex-wrap:wrap}
.bc a:hover{color:var(--red)}
.bc-sep{color:#ccc}
.bc-cur{color:var(--text);font-weight:500}

/* ── Product layout ── */
.pd-wrap{
  background:#fff;border-radius:var(--radius);
  display:grid;grid-template-columns:400px 1fr;
  gap:0;margin-bottom:12px;
  border:1px solid var(--border);
  overflow:hidden;
}

        * { box-sizing: border-box; margin: 0; padding: 0 }
        body { background: #f0f0f0; font-family: 'Segoe UI', system-ui, sans-serif; color: #222 }
        .cnt { max-width: 1400px; margin: 0 auto; padding: 0 16px }
        .page-header { background: #d0021b; color: white; padding: 20px 0; margin-bottom: 30px }
        .page-header h1 { font-size: 32px; margin-bottom: 5px }
        .page-header p { font-size: 14px; opacity: 0.9 }
        
        .main-content { display: grid; grid-template-columns: 250px 1fr; gap: 20px; margin-bottom: 40px }
        
        /* SIDEBAR FILTER */
        .sidebar { background: white; padding: 20px; border-radius: 8px; height: fit-content }
        .filter-title { font-size: 18px; font-weight: 700; margin-bottom: 20px; border-bottom: 2px solid #d0021b; padding-bottom: 10px }
        .filter-group { margin-bottom: 20px }
        .filter-group label { display: block; margin-bottom: 8px; font-size: 14px }
        .filter-group input, .filter-group select { width: 100%; padding: 8px; border: 1px solid #ddd; border-radius: 4px; font-family: inherit }
        .btn-filter { width: 100%; padding: 12px; background: #d0021b; color: white; border: none; border-radius: 4px; font-weight: 700; cursor: pointer; margin-top: 15px }
        .btn-filter:hover { background: #a80115 }
        
        /* PRODUCTS SECTION */
        .products-section { background: white; padding: 20px; border-radius: 8px }
        
        .sort-bar { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; padding-bottom: 15px; border-bottom: 1px solid #eee }
        .sort-bar select { padding: 8px; border: 1px solid #ddd; border-radius: 4px }
        .results-count { font-size: 14px; color: #666 }
        
        .products-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(200px, 1fr)); gap: 15px; margin-bottom: 30px }
        
        .product-card { background: #f9f9f9; border: 1px solid #eee; border-radius: 8px; overflow: hidden; transition: all .3s; text-decoration: none; color: inherit }
        .product-card:hover { transform: translateY(-5px); box-shadow: 0 5px 15px rgba(0,0,0,.1) }
        
        .product-image { width: 100%; height: 180px; background: #f5f5f5; overflow: hidden; position: relative }
        .product-image img { width: 100%; height: 100%; object-fit: cover }
        .product-discount { position: absolute; top: 10px; right: 10px; background: #d0021b; color: white; padding: 5px 10px; border-radius: 4px; font-size: 12px; font-weight: 700 }
        
        .product-info { padding: 12px }
        .product-brand { font-size: 11px; color: #999; margin-bottom: 5px }
        .product-name { font-size: 13px; font-weight: 600; color: #333; margin-bottom: 8px; min-height: 26px; overflow: hidden; text-overflow: ellipsis; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical }
        .product-price { font-size: 16px; font-weight: 900; color: #d0021b; margin-bottom: 8px }
        .product-old-price { font-size: 12px; text-decoration: line-through; color: #999 }
        .product-sold { font-size: 11px; color: #999 }
        
        /* PAGINATION */
        .pagination { display: flex; justify-content: center; gap: 8px; margin-top: 30px }
        .pagination a, .pagination span { padding: 10px 12px; border: 1px solid #ddd; border-radius: 4px; text-decoration: none; color: #d0021b; font-weight: 600 }
        .pagination a:hover { background: #d0021b; color: white }
        .pagination .active { background: #d0021b; color: white }
        
        .empty-state { text-align: center; padding: 60px 20px }
        .empty-state .ico { font-size: 64px; margin-bottom: 20px }
        
        @media (max-width: 768px) {
            .main-content { grid-template-columns: 1fr }
            .sidebar { display: none }
            .products-grid { grid-template-columns: repeat(auto-fill, minmax(150px, 1fr)) }
        }
    </style>
</head>
<body>
    <%@ include file="/header.jsp" %>

    <div class="page-header">
        <div class="cnt">
            <h1>🛍️ Danh sách sản phẩm</h1>
            <p>Tìm thấy ${totalProducts} sản phẩm</p>
        </div>
    </div>

    <div class="cnt">
        <div class="main-content">
            <!-- SIDEBAR FILTER -->
            <aside class="sidebar">
                <form action="${pageContext.request.contextPath}/products" method="get">
                    <div class="filter-title">🔍 Bộ lọc</div>

                    <!-- Keyword -->
                    <div class="filter-group">
                        <label>Tìm kiếm</label>
                        <input type="text" name="keyword" placeholder="Tên sản phẩm..." value="${keyword}">
                    </div>

                    <!-- Category -->
                    <div class="filter-group">
                        <label>Danh mục</label>
                        <select name="categoryId">
                            <option value="0">Tất cả</option>
                            <c:forEach var="cat" items="${categories}">
                                <option value="${cat.id}" ${categoryId == cat.id ? 'selected' : ''}>${cat.name}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <!-- Brand -->
                    <div class="filter-group">
                        <label>Hãng sản xuất</label>
                        <select name="brandId">
                            <option value="0">Tất cả</option>
                            <c:forEach var="brand" items="${brands}">
                                <option value="${brand.id}" ${brandId == brand.id ? 'selected' : ''}>${brand.name}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <!-- Price -->
                    <div class="filter-group">
                        <label>Giá từ</label>
                        <input type="number" name="minPrice" placeholder="Tối thiểu" value="${minPrice > 0 ? minPrice : ''}">
                    </div>

                    <div class="filter-group">
                        <label>Giá đến</label>
                        <input type="number" name="maxPrice" placeholder="Tối đa" value="${maxPrice > 0 ? maxPrice : ''}">
                    </div>

                    <button type="submit" class="btn-filter">Áp dụng lọc</button>
                </form>
            </aside>

            <!-- PRODUCTS -->
            <section class="products-section">
                <!-- SORT BAR -->
                <div class="sort-bar">
                    <span class="results-count">Hiển thị: <strong>${products.size()}</strong> / <strong>${totalProducts}</strong> sản phẩm</span>
                    <form action="${pageContext.request.contextPath}/products" method="get" style="display: inline">
                        <input type="hidden" name="keyword" value="${keyword}">
                        <input type="hidden" name="categoryId" value="${categoryId}">
                        <input type="hidden" name="brandId" value="${brandId}">
                        <input type="hidden" name="minPrice" value="${minPrice}">
                        <input type="hidden" name="maxPrice" value="${maxPrice}">
                        <select name="sort" onchange="this.form.submit()" style="padding: 8px; border: 1px solid #ddd; border-radius: 4px">
                            <option value="">Mặc định</option>
                            <option value="price_asc" ${sort == 'price_asc' ? 'selected' : ''}>Giá thấp → cao</option>
                            <option value="price_desc" ${sort == 'price_desc' ? 'selected' : ''}>Giá cao → thấp</option>
                            <option value="new" ${sort == 'new' ? 'selected' : ''}>Mới nhất</option>
                            <option value="sold" ${sort == 'sold' ? 'selected' : ''}>Bán chạy nhất</option>
                        </select>
                    </form>
                </div>

                <!-- PRODUCTS GRID -->
                <c:if test="${totalProducts > 0}">
                    <div class="products-grid">
                        <c:forEach var="p" items="${products}">
                            <a href="${pageContext.request.contextPath}/productdetail?id=${p.id}" class="product-card">
                                <div class="product-image">
                                    <img src="https://picsum.photos/400/400?random=${p.id}" alt="${p.name}">
                                    <c:if test="${p.discount > 0}">
                                        <div class="product-discount">-${p.discount}%</div>
                                    </c:if>
                                </div>
                                <div class="product-info">
                                    <div class="product-brand">${p.brandName}</div>
                                    <div class="product-name">${p.name}</div>
                                    <div class="product-price">
                                        <fmt:formatNumber value="${p.salePrice}" pattern="#,###"/>đ
                                    </div>
                                    <c:if test="${p.discount > 0}">
                                        <div class="product-old-price">
                                            <fmt:formatNumber value="${p.price}" pattern="#,###"/>đ
                                        </div>
                                    </c:if>
                                    <div class="product-sold">Đã bán: ${p.sold}</div>
                                </div>
                            </a>
                        </c:forEach>
                    </div>

                    <!-- PAGINATION -->
                    <div class="pagination">
                        <c:if test="${page > 1}">
                            <a href="${pageContext.request.contextPath}/products?keyword=${keyword}&categoryId=${categoryId}&brandId=${brandId}&minPrice=${minPrice}&maxPrice=${maxPrice}&sort=${sort}&page=1">« Đầu</a>
                            <a href="${pageContext.request.contextPath}/products?keyword=${keyword}&categoryId=${categoryId}&brandId=${brandId}&minPrice=${minPrice}&maxPrice=${maxPrice}&sort=${sort}&page=${page - 1}">‹ Trước</a>
                        </c:if>

                        <c:forEach var="p" begin="1" end="${totalPages}">
                            <c:if test="${p == page}">
                                <span class="active">${p}</span>
                            </c:if>
                            <c:if test="${p != page}">
                                <a href="${pageContext.request.contextPath}/products?keyword=${keyword}&categoryId=${categoryId}&brandId=${brandId}&minPrice=${minPrice}&maxPrice=${maxPrice}&sort=${sort}&page=${p}">${p}</a>
                            </c:if>
                        </c:forEach>

                        <c:if test="${page < totalPages}">
                            <a href="${pageContext.request.contextPath}/products?keyword=${keyword}&categoryId=${categoryId}&brandId=${brandId}&minPrice=${minPrice}&maxPrice=${maxPrice}&sort=${sort}&page=${page + 1}">Tiếp ›</a>
                            <a href="${pageContext.request.contextPath}/products?keyword=${keyword}&categoryId=${categoryId}&brandId=${brandId}&minPrice=${minPrice}&maxPrice=${maxPrice}&sort=${sort}&page=${totalPages}">Cuối »</a>
                        </c:if>
                    </div>
                </c:if>

                <c:if test="${totalProducts == 0}">
                    <div class="empty-state">
                        <div class="ico">🔍</div>
                        <h3>Không tìm thấy sản phẩm</h3>
                        <p>Vui lòng thử lại với tiêu chí khác</p>
                    </div>
                </c:if>
            </section>
        </div>
    </div>

    <%@ include file="/footer.jsp" %>
</body>
</html>