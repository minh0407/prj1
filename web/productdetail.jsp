<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0">
<title>${product.name} – HomeElectro</title>
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

/* ── Image panel ── */
.pd-img{padding:20px;border-right:1px solid var(--border);position:sticky;top:70px;align-self:start}
.pd-img-main{
  width:100%;aspect-ratio:1;
  border-radius:var(--radius);
  overflow:hidden;background:#fafafa;
  display:flex;align-items:center;justify-content:center;
  margin-bottom:12px;border:1px solid var(--border);
  cursor:zoom-in;
}
.pd-img-main img{max-width:80%;max-height:320px;object-fit:contain;transition:transform .3s}
.pd-img-main:hover img{transform:scale(1.07)}
.pd-thumbs{display:flex;gap:8px;flex-wrap:wrap}
.pd-thumb{
  width:68px;height:68px;border-radius:6px;
  border:2px solid var(--border);background:#fafafa;
  overflow:hidden;cursor:pointer;
  display:flex;align-items:center;justify-content:center;
  transition:border-color .15s;
}
.pd-thumb.on{border-color:var(--red)}
.pd-thumb:hover{border-color:var(--red)}
.pd-thumb img{width:85%;height:85%;object-fit:contain}

/* ── Info panel ── */
.pd-info{padding:24px 28px}
.pd-badge-row{display:flex;gap:8px;flex-wrap:wrap;margin-bottom:10px}
.pd-badge{
  font-size:11px;font-weight:600;padding:3px 10px;border-radius:20px;
}
.badge-brand{background:#fff0f0;color:var(--red);border:1px solid #ffc5c5}
.badge-cat{background:#f0f4ff;color:#2563eb;border:1px solid #c7d7ff}
.badge-new{background:#f0fdf4;color:#16a34a;border:1px solid #bbf7d0}

.pd-name{font-size:22px;font-weight:800;line-height:1.35;margin-bottom:6px;color:#111}

.pd-rating{display:flex;align-items:center;gap:8px;margin-bottom:16px;font-size:13px;color:var(--muted)}
.pd-stars{color:#f59e0b;letter-spacing:1px}

/* Price block */
.pd-price-block{
  background:var(--red-bg);border-radius:var(--radius);
  padding:16px 18px;margin-bottom:16px;
  border:1px solid #ffd6d6;
}
.pd-price{font-size:32px;font-weight:900;color:var(--red);line-height:1}
.pd-price-row{display:flex;align-items:center;gap:12px;flex-wrap:wrap;margin-top:8px}
.pd-old{font-size:15px;color:var(--muted);text-decoration:line-through}
.pd-save{
  background:var(--red);color:#fff;
  font-size:12px;font-weight:700;
  padding:2px 10px;border-radius:20px;
}
.pd-installment{font-size:12px;color:#2563eb;margin-top:6px}

/* Highlight specs */
.pd-specs{
  display:grid;grid-template-columns:1fr 1fr;
  gap:8px;margin-bottom:18px;
}
.pd-spec{
  background:#fafafa;border:1px solid var(--border);
  border-radius:6px;padding:10px 14px;
}
.pd-spec-label{font-size:11px;color:var(--muted);margin-bottom:3px;font-weight:500}
.pd-spec-val{font-size:13px;font-weight:600;color:var(--text)}
.pd-spec-val.ok{color:#16a34a}
.pd-spec-val.no{color:#dc2626}

/* Promotion box */
.pd-promo{
  border:1.5px dashed #ffc0c0;border-radius:var(--radius);
  padding:12px 16px;margin-bottom:18px;background:#fffbfb;
}
.pd-promo-title{font-size:13px;font-weight:700;color:var(--red);margin-bottom:8px}
.pd-promo-item{display:flex;align-items:flex-start;gap:6px;font-size:13px;color:#444;margin-bottom:4px}
.pd-promo-dot{width:6px;height:6px;border-radius:50%;background:var(--red);flex-shrink:0;margin-top:6px}

/* Qty + Cart */
.pd-buy{display:flex;gap:10px;margin-bottom:14px;align-items:center}
.qty-box{
  display:flex;align-items:center;
  border:1.5px solid var(--border);border-radius:var(--radius);overflow:hidden;
}
.qty-btn{
  width:38px;height:46px;border:none;background:#fff;
  font-size:18px;cursor:pointer;color:var(--text);
  transition:background .15s;
}
.qty-btn:hover{background:#f5f5f5}
.qty-inp{
  width:50px;height:46px;border:none;
  border-left:1.5px solid var(--border);border-right:1.5px solid var(--border);
  text-align:center;font-size:15px;font-weight:600;outline:none;
}
.btn-cart{
  flex:1;height:46px;
  background:var(--red);color:#fff;border:none;
  border-radius:var(--radius);font-size:15px;font-weight:700;
  cursor:pointer;transition:all .18s;
  display:flex;align-items:center;justify-content:center;gap:6px;
}
.btn-cart:hover{background:var(--red2);box-shadow:0 4px 14px rgba(208,2,27,.35)}
.btn-cart:disabled{background:#bbb;cursor:not-allowed;box-shadow:none}
.btn-wish{
  width:46px;height:46px;border:1.5px solid var(--border);
  background:#fff;border-radius:var(--radius);
  cursor:pointer;font-size:20px;transition:all .18s;
  display:flex;align-items:center;justify-content:center;
}
.btn-wish:hover{border-color:var(--red);color:var(--red)}

/* Perks */
.pd-perks{display:grid;grid-template-columns:repeat(4,1fr);gap:8px;padding-top:14px;border-top:1px solid var(--border)}
.perk{display:flex;align-items:center;gap:6px;font-size:12px;color:var(--muted)}
.perk-ico{font-size:18px}

/* ── Below: tabs ── */
.pd-tabs-wrap{background:#fff;border-radius:var(--radius);border:1px solid var(--border);margin-bottom:12px;overflow:hidden}
.pd-tabs{display:flex;border-bottom:2px solid var(--border)}
.pd-tab{
  padding:13px 22px;font-size:14px;font-weight:600;color:var(--muted);
  cursor:pointer;border-bottom:2px solid transparent;margin-bottom:-2px;
  transition:all .15s;white-space:nowrap;
}
.pd-tab.on{color:var(--red);border-bottom-color:var(--red)}
.pd-tab:hover{color:var(--red)}
.pd-tab-body{padding:24px 28px;display:none;font-size:14px;color:#444;line-height:1.8}
.pd-tab-body.on{display:block}

/* Spec table */
.spec-table{width:100%;border-collapse:collapse}
.spec-table tr:nth-child(odd) td{background:#fafafa}
.spec-table td{padding:10px 14px;border:1px solid var(--border);font-size:13px}
.spec-table td:first-child{font-weight:600;color:#555;width:180px;background:#f5f5f5}

/* ── Related ── */
.rel-wrap{background:#fff;border-radius:var(--radius);border:1px solid var(--border);padding:20px}
.rel-title{font-size:18px;font-weight:800;margin-bottom:16px;display:flex;align-items:center;gap:8px}
.rel-title::after{content:'';flex:1;height:2px;background:linear-gradient(90deg,var(--red),transparent);border-radius:2px}
.rel-grid{display:grid;grid-template-columns:repeat(5,1fr);gap:12px}
.rel-card{
  border:1.5px solid var(--border);border-radius:6px;
  padding:12px;display:block;transition:all .2s;
}
.rel-card:hover{border-color:var(--red);transform:translateY(-2px);box-shadow:0 6px 18px rgba(208,2,27,.1)}
.rel-img{width:100%;aspect-ratio:1;background:#f8f8f8;border-radius:6px;overflow:hidden;margin-bottom:8px;display:flex;align-items:center;justify-content:center}
.rel-img img{width:80%;height:80%;object-fit:contain}
.rel-name{font-size:12px;font-weight:600;line-height:1.4;display:-webkit-box;-webkit-line-clamp:2;-webkit-box-orient:vertical;overflow:hidden;min-height:34px;margin-bottom:6px}
.rel-price{font-size:14px;font-weight:800;color:var(--red)}

/* ── Error ── */
.err{background:#fff;border-radius:var(--radius);padding:60px;text-align:center;border:1px solid var(--border)}
.err h2{font-size:24px;font-weight:800;margin-bottom:8px}
.err p{color:var(--muted);margin-bottom:20px}
.err a{display:inline-block;padding:10px 24px;background:var(--red);color:#fff;border-radius:var(--radius);font-weight:700}
</style>
</head>
<body>

<jsp:include page="/header.jsp"/>

<main class="page-main">
<div class="cnt">

  <%-- Breadcrumb --%>
  <div class="bc">
    <a href="${pageContext.request.contextPath}/home">Trang chủ</a>
    <span class="bc-sep">›</span>
    <a href="${pageContext.request.contextPath}/products">Sản phẩm</a>
    <c:if test="${not empty product}">
      <span class="bc-sep">›</span>
      <a href="${pageContext.request.contextPath}/products?categoryId=${product.categoryId}">${product.categoryName}</a>
      <span class="bc-sep">›</span>
      <span class="bc-cur">${product.name}</span>
    </c:if>
  </div>

  <c:choose>
  <c:when test="${not empty product}">

  <%-- ══ Main block ══ --%>
  <div class="pd-wrap">

    <%-- Images --%>
    <div class="pd-img">
      <div class="pd-img-main" id="imgMain">
        <img id="mainImg" src="https://picsum.photos/500/500?random=${product.id}" alt="${product.name}">
      </div>
      <div class="pd-thumbs">
        <div class="pd-thumb on" onclick="switchImg(this,'https://picsum.photos/500/500?random=${product.id}')">
          <img src="https://picsum.photos/100/100?random=${product.id}" alt="">
        </div>
        <div class="pd-thumb" onclick="switchImg(this,'https://picsum.photos/500/500?random=${product.id+10}')">
          <img src="https://picsum.photos/100/100?random=${product.id+10}" alt="">
        </div>
        <div class="pd-thumb" onclick="switchImg(this,'https://picsum.photos/500/500?random=${product.id+20}')">
          <img src="https://picsum.photos/100/100?random=${product.id+20}" alt="">
        </div>
        <div class="pd-thumb" onclick="switchImg(this,'https://picsum.photos/500/500?random=${product.id+30}')">
          <img src="https://picsum.photos/100/100?random=${product.id+30}" alt="">
        </div>
      </div>
    </div>

    <%-- Info --%>
    <div class="pd-info">
      <div class="pd-badge-row">
        <span class="pd-badge badge-brand">${product.brandName}</span>
        <span class="pd-badge badge-cat">${product.categoryName}</span>
        <c:if test="${product.isFeatured}"><span class="pd-badge badge-new">Nổi bật</span></c:if>
      </div>

      <h1 class="pd-name">${product.name}</h1>

      <div class="pd-rating">
        <span class="pd-stars">★★★★★</span>
        <span>4.9 · ${product.sold} đánh giá</span>
        <span>|</span>
        <span>Đã bán <strong>${product.sold}</strong></span>
      </div>

      <%-- Price --%>
      <div class="pd-price-block">
        <div class="pd-price">
          <fmt:formatNumber value="${product.salePrice}" pattern="#,###"/>đ
        </div>
        <c:if test="${product.discount > 0}">
          <div class="pd-price-row">
            <span class="pd-old"><fmt:formatNumber value="${product.price}" pattern="#,###"/>đ</span>
            <span class="pd-save">-<fmt:formatNumber value="${product.discount}" maxFractionDigits="0"/>%</span>
            <span style="font-size:12px;color:#dc2626;font-weight:600">
              Tiết kiệm <fmt:formatNumber value="${product.price - product.salePrice}" pattern="#,###"/>đ
            </span>
          </div>
        </c:if>
        <div class="pd-installment">💳 Trả góp 0% từ <fmt:formatNumber value="${product.salePrice / 12}" pattern="#,###"/>đ/tháng</div>
      </div>

      <%-- Specs --%>
      <div class="pd-specs">
        <div class="pd-spec">
          <div class="pd-spec-label">Tình trạng kho</div>
          <c:choose>
            <c:when test="${product.stock > 0}">
              <div class="pd-spec-val ok">✓ Còn ${product.stock} sp</div>
            </c:when>
            <c:otherwise>
              <div class="pd-spec-val no">✗ Hết hàng</div>
            </c:otherwise>
          </c:choose>
        </div>
        <div class="pd-spec">
          <div class="pd-spec-label">Bảo hành</div>
          <div class="pd-spec-val">${product.warranty} tháng chính hãng</div>
        </div>
        <div class="pd-spec">
          <div class="pd-spec-label">Đã bán</div>
          <div class="pd-spec-val">${product.sold} sản phẩm</div>
        </div>
        <div class="pd-spec">
          <div class="pd-spec-label">Thương hiệu</div>
          <div class="pd-spec-val">${product.brandName}</div>
        </div>
      </div>

      <%-- Promotions --%>
      <div class="pd-promo">
        <div class="pd-promo-title">🎁 Khuyến mãi áp dụng</div>
        <div class="pd-promo-item"><span class="pd-promo-dot"></span>Tặng voucher 200K cho đơn từ 10 triệu</div>
        <div class="pd-promo-item"><span class="pd-promo-dot"></span>Freeship toàn quốc khi mua online</div>
        <div class="pd-promo-item"><span class="pd-promo-dot"></span>Bảo hành 1 đổi 1 trong 30 ngày</div>
      </div>

      <%-- Qty + Cart --%>
      <%-- Hidden form để POST add to cart --%>
      <form id="formCart" action="${pageContext.request.contextPath}/cart" method="post" style="display:none">
        <input type="hidden" name="action"      value="addToCart">
        <input type="hidden" name="productId"   value="${product.id}">
        <input type="hidden" name="productName" value="${product.name}">
        <input type="hidden" name="image"       id="fCartImage" value="${product.image}">
        <input type="hidden" name="price"       value="${product.salePrice}">
        <input type="hidden" name="quantity"    id="fCartQty" value="1">
        <input type="hidden" name="stock"       value="${product.stock}">
      </form>

      <%-- Hidden form để POST toggle wishlist --%>
      <form id="formWish" action="${pageContext.request.contextPath}/wishlist" method="post" style="display:none">
        <input type="hidden" name="action"    value="toggle">
        <input type="hidden" name="productId" value="${product.id}">
      </form>

      <div class="pd-buy">
        <div class="qty-box">
          <button class="qty-btn" onclick="decQty()">−</button>
          <input type="number" id="qty" class="qty-inp" value="1" min="1" max="${product.stock}">
          <button class="qty-btn" onclick="incQty()">+</button>
        </div>
        <c:choose>
          <c:when test="${product.stock > 0}">
            <button class="btn-cart" id="btnCart" onclick="addToCart()">
              🛒 Thêm vào giỏ hàng
            </button>
          </c:when>
          <c:otherwise>
            <button class="btn-cart" disabled>Hết hàng</button>
          </c:otherwise>
        </c:choose>
        <button class="btn-wish" id="btnWish" title="Yêu thích"
                style="${wishlisted ? 'color:var(--red)' : ''}">
          ${wishlisted ? '♥' : '♡'}
        </button>
      </div>

      <%-- Perks --%>
      <div class="pd-perks">
        <div class="perk"><span class="perk-ico">🚚</span>Giao trong 2h</div>
        <div class="perk"><span class="perk-ico">🔄</span>Đổi trả 30 ngày</div>
        <div class="perk"><span class="perk-ico">🛡️</span>Chính hãng 100%</div>
        <div class="perk"><span class="perk-ico">💳</span>Trả góp 0%</div>
      </div>
    </div>
  </div>

  <%-- ══ Tabs: Mô tả / Thông số ══ --%>
  <div class="pd-tabs-wrap">
    <div class="pd-tabs">
      <div class="pd-tab on" onclick="showTab('desc',this)">📋 Mô tả sản phẩm</div>
      <div class="pd-tab" onclick="showTab('spec',this)">📐 Thông số kỹ thuật</div>
    </div>
    <div class="pd-tab-body on" id="tab-desc">
      <c:choose>
        <c:when test="${not empty product.description}">${product.description}</c:when>
        <c:otherwise>Chưa có mô tả chi tiết cho sản phẩm này.</c:otherwise>
      </c:choose>
    </div>
    <div class="pd-tab-body" id="tab-spec">
      <table class="spec-table">
        <tr><td>Thương hiệu</td><td>${product.brandName}</td></tr>
        <tr><td>Danh mục</td><td>${product.categoryName}</td></tr>
        <tr><td>Bảo hành</td><td>${product.warranty} tháng</td></tr>
        <tr><td>Tồn kho</td><td>${product.stock} sản phẩm</td></tr>
        <tr><td>Đã bán</td><td>${product.sold} sản phẩm</td></tr>
        <tr><td>Giá gốc</td><td><fmt:formatNumber value="${product.price}" pattern="#,###"/>đ</td></tr>
        <c:if test="${product.discount > 0}">
          <tr><td>Giảm giá</td><td><fmt:formatNumber value="${product.discount}" maxFractionDigits="0"/>%</td></tr>
          <tr><td>Giá bán</td><td><strong style="color:var(--red)"><fmt:formatNumber value="${product.salePrice}" pattern="#,###"/>đ</strong></td></tr>
        </c:if>
      </table>
    </div>
  </div>

  <%-- ══ Related ══ --%>
  <c:if test="${not empty relatedProducts}">
  <div class="rel-wrap">
    <div class="rel-title">📦 Sản phẩm tương tự</div>
    <div class="rel-grid">
      <c:forEach var="p" items="${relatedProducts}">
      <a href="${pageContext.request.contextPath}/productdetail?id=${p.id}" class="rel-card">
        <div class="rel-img">
          <img src="https://picsum.photos/200/200?random=${p.id}" alt="${p.name}">
        </div>
        <div class="rel-name">${p.name}</div>
        <div class="rel-price"><fmt:formatNumber value="${p.salePrice}" pattern="#,###"/>đ</div>
      </a>
      </c:forEach>
    </div>
  </div>
  </c:if>

  </c:when>
  <c:otherwise>
    <div class="err">
      <h2>Sản phẩm không tồn tại 😕</h2>
      <p>Sản phẩm này có thể đã bị xóa hoặc không còn được bán.</p>
      <a href="${pageContext.request.contextPath}/home">← Về trang chủ</a>
    </div>
  </c:otherwise>
  </c:choose>

</div>
</main>

<jsp:include page="/footer.jsp"/>

<script>
function incQty(){var q=document.getElementById('qty');if(parseInt(q.value)<parseInt(q.max||999))q.value=parseInt(q.value)+1;}
function decQty(){var q=document.getElementById('qty');if(parseInt(q.value)>1)q.value=parseInt(q.value)-1;}
function addToCart(){
  // Đồng bộ số lượng từ input vào hidden form rồi submit
  document.getElementById('fCartQty').value = document.getElementById('qty').value;
  document.getElementById('formCart').submit();
}
function switchImg(el,src){
  document.getElementById('mainImg').src=src;
  document.querySelectorAll('.pd-thumb').forEach(function(t){t.classList.remove('on');});
  el.classList.add('on');
}
function showTab(id,el){
  document.querySelectorAll('.pd-tab-body').forEach(function(b){b.classList.remove('on');});
  document.querySelectorAll('.pd-tab').forEach(function(t){t.classList.remove('on');});
  document.getElementById('tab-'+id).classList.add('on');
  el.classList.add('on');
}
document.getElementById('btnWish').addEventListener('click',function(){
  document.getElementById('formWish').submit();
});
</script>
</body>
</html>
