<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0">
    <title>Yêu thích - HomeElectro</title>
    <style>
        /* ── Reset & Base ── */
        *{box-sizing:border-box;margin:0;padding:0}
        :root{--red:#d0021b;--red2:#a80115;--border:#e8e8e8;--text:#1a1a1a;--muted:#777;--bg:#f5f5f5;--radius:8px}
        body{background:var(--bg);font-family:'Segoe UI',Arial,sans-serif;color:var(--text);font-size:14px}
        a{text-decoration:none;color:inherit}
        img{display:block;max-width:100%}
        .cnt{max-width:1200px;margin:0 auto;padding:0 16px}

        /* ── Header (copy từ products.jsp) ── */
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
        #site-footer{background:#111;color:#fff;padding:40px 0 0;margin-top:48px}
        .footer-grid{display:grid;grid-template-columns:2fr 1fr 1fr 1fr;gap:36px;padding-bottom:32px}
        .footer-logo{background:#d0021b;border-radius:8px;padding:5px 14px;display:inline-block;font-weight:900;font-size:19px;color:#fff;margin-bottom:14px}
        .footer-about p{font-size:13px;color:#aaa;line-height:1.7;margin-bottom:14px}
        .footer-col-title{font-size:14px;font-weight:700;color:#fff;margin-bottom:14px}
        .footer-grid > div a{display:block;font-size:13px;color:#aaa;margin-bottom:8px;text-decoration:none}
        .footer-grid > div a:hover{color:#fff}
        .footer-bottom{border-top:1px solid #2a2a2a;padding:16px 0;display:flex;justify-content:space-between;font-size:12px;color:#666;flex-wrap:wrap;gap:8px}

        /* ── Page layout ── */
        .page-main{padding:20px 0 48px}

        /* ── Breadcrumb ── */
        .bc{display:flex;align-items:center;gap:6px;font-size:13px;color:var(--muted);margin-bottom:18px;flex-wrap:wrap}
        .bc a:hover{color:var(--red)}
        .bc-sep{color:#ccc}
        .bc-cur{color:var(--text);font-weight:500}

        /* ── Page title ── */
        .page-title{display:flex;align-items:center;justify-content:space-between;margin-bottom:20px;flex-wrap:wrap;gap:10px}
        .page-title h1{font-size:22px;font-weight:700;display:flex;align-items:center;gap:8px}
        .page-title h1 span.count{font-size:14px;font-weight:500;color:var(--muted);background:#f0f0f0;border-radius:20px;padding:2px 10px}
        .btn-continue{padding:9px 18px;background:var(--red);color:#fff;border-radius:6px;font-weight:600;font-size:13px;transition:.15s}
        .btn-continue:hover{background:var(--red2)}

        /* ── Wishlist grid ── */
        .wl-grid{display:grid;grid-template-columns:repeat(auto-fill,minmax(220px,1fr));gap:16px}

        /* ── Product card ── */
        .pcard{background:#fff;border-radius:var(--radius);border:1px solid var(--border);overflow:hidden;transition:box-shadow .2s,transform .2s;display:flex;flex-direction:column}
        .pcard:hover{box-shadow:0 6px 24px rgba(0,0,0,.1);transform:translateY(-3px)}
        .pcard-img{position:relative;overflow:hidden;aspect-ratio:1;background:#fafafa}
        .pcard-img img{width:100%;height:100%;object-fit:contain;padding:8px;transition:transform .3s}
        .pcard:hover .pcard-img img{transform:scale(1.05)}
        .pcard-badge{position:absolute;top:8px;left:8px;background:var(--red);color:#fff;font-size:11px;font-weight:700;border-radius:4px;padding:2px 7px}
        .pcard-remove{position:absolute;top:8px;right:8px;background:rgba(255,255,255,.9);border:none;border-radius:50%;width:30px;height:30px;display:flex;align-items:center;justify-content:center;cursor:pointer;font-size:15px;color:#d0021b;transition:.2s;box-shadow:0 1px 4px rgba(0,0,0,.15)}
        .pcard-remove:hover{background:#d0021b;color:#fff}
        .pcard-body{padding:12px;flex:1;display:flex;flex-direction:column;gap:6px}
        .pcard-name{font-size:13px;font-weight:600;line-height:1.4;color:var(--text);display:-webkit-box;-webkit-line-clamp:2;-webkit-box-orient:vertical;overflow:hidden}
        .pcard-price-row{display:flex;align-items:center;gap:6px;margin-top:auto}
        .pcard-price{font-size:15px;font-weight:700;color:var(--red)}
        .pcard-old{font-size:12px;color:var(--muted);text-decoration:line-through}
        .pcard-footer{padding:0 12px 12px;display:flex;gap:8px}
        .btn-detail{flex:1;padding:8px;border-radius:6px;border:1px solid var(--border);background:#fff;color:var(--text);font-size:13px;font-weight:500;cursor:pointer;transition:.15s;text-align:center}
        .btn-detail:hover{border-color:var(--red);color:var(--red)}
        .btn-cart{flex:1;padding:8px;border-radius:6px;border:none;background:var(--red);color:#fff;font-size:13px;font-weight:600;cursor:pointer;transition:.15s;text-align:center}
        .btn-cart:hover{background:var(--red2)}

        /* ── Empty state ── */
        .wl-empty{text-align:center;padding:80px 20px;background:#fff;border-radius:var(--radius);border:1px solid var(--border)}
        .wl-empty-icon{font-size:64px;margin-bottom:16px;opacity:.5}
        .wl-empty h2{font-size:20px;font-weight:600;margin-bottom:8px;color:#444}
        .wl-empty p{color:var(--muted);margin-bottom:24px}
        .btn-shop{display:inline-block;padding:12px 28px;background:var(--red);color:#fff;border-radius:6px;font-weight:600;font-size:14px;transition:.15s}
        .btn-shop:hover{background:var(--red2)}

        /* ── Toast ── */
        .toast{position:fixed;bottom:28px;left:50%;transform:translateX(-50%);background:#333;color:#fff;padding:12px 24px;border-radius:8px;font-size:14px;font-weight:500;z-index:9999;opacity:0;transition:opacity .3s;pointer-events:none}
        .toast.show{opacity:1}
    </style>
</head>
<body>

<%-- ══ HEADER ══ --%>
<jsp:include page="/header.jsp"/>

<%-- ══ MAIN ══ --%>
<main class="page-main">
    <div class="cnt">

        <%-- Breadcrumb --%>
        <nav class="bc">
            <a href="${pageContext.request.contextPath}/home">🏠 Trang chủ</a>
            <span class="bc-sep">›</span>
            <span class="bc-cur">Sản phẩm yêu thích</span>
        </nav>

        <%-- Title + nút tiếp tục mua --%>
        <div class="page-title">
            <h1>
                ❤️ Yêu thích
                <span class="count">${wishlistCount} sản phẩm</span>
            </h1>
            <a href="${pageContext.request.contextPath}/products" class="btn-continue">
                🛍 Tiếp tục mua sắm
            </a>
        </div>

        <c:choose>
            <c:when test="${empty wishlist}">
                <%-- Empty state --%>
                <div class="wl-empty">
                    <div class="wl-empty-icon">💔</div>
                    <h2>Chưa có sản phẩm yêu thích</h2>
                    <p>Hãy thêm sản phẩm bạn yêu thích vào đây để dễ dàng tìm lại sau nhé!</p>
                    <a href="${pageContext.request.contextPath}/products" class="btn-shop">
                        Khám phá sản phẩm
                    </a>
                </div>
            </c:when>
            <c:otherwise>
                <%-- Grid sản phẩm --%>
                <div class="wl-grid">
                    <c:forEach var="p" items="${wishlist}">
                        <div class="pcard">
                            <a href="${pageContext.request.contextPath}/productdetail?id=${p.id}" class="pcard-img">
                                <img src="${not empty p.image ? p.image : 'https://via.placeholder.com/300x300?text=No+Image'}"
                                     alt="${p.name}" loading="lazy">

                                <c:if test="${p.discount > 0}">
                                    <span class="pcard-badge">-<fmt:formatNumber value="${p.discount}" maxFractionDigits="0"/>%</span>
                                </c:if>

                                <%-- Nút xóa khỏi wishlist --%>
                                <form action="${pageContext.request.contextPath}/wishlist" method="post"
                                      onsubmit="event.stopPropagation();" style="display:contents">
                                    <input type="hidden" name="action" value="remove"/>
                                    <input type="hidden" name="productId" value="${p.id}"/>
                                    <button type="submit" class="pcard-remove"
                                            title="Xóa khỏi yêu thích"
                                            onclick="event.preventDefault(); removeItem(this, ${p.id});">🗑</button>
                                </form>
                            </a>

                            <div class="pcard-body">
                                <div class="pcard-name">${p.name}</div>
                                <div class="pcard-price-row">
                                    <c:choose>
                                        <c:when test="${p.discount > 0}">
                                            <span class="pcard-price">
                                                <fmt:formatNumber value="${p.price * (1 - p.discount/100)}"
                                                                  maxFractionDigits="0"/>đ
                                            </span>
                                            <span class="pcard-old">
                                                <fmt:formatNumber value="${p.price}" maxFractionDigits="0"/>đ
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="pcard-price">
                                                <fmt:formatNumber value="${p.price}" maxFractionDigits="0"/>đ
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>

                            <div class="pcard-footer">
                                <a href="${pageContext.request.contextPath}/productdetail?id=${p.id}"
                                   class="btn-detail">Chi tiết</a>

                                <form action="${pageContext.request.contextPath}/cart" method="post" style="flex:1">
                                    <input type="hidden" name="action" value="addToCart"/>
                                    <input type="hidden" name="productId" value="${p.id}"/>
                                    <input type="hidden" name="productName" value="${p.name}"/>
                                    <input type="hidden" name="image" value="${p.image}"/>
                                    <input type="hidden" name="price"
                                           value="${p.discount > 0 ? p.price * (1 - p.discount/100) : p.price}"/>
                                    <input type="hidden" name="quantity" value="1"/>
                                    <input type="hidden" name="stock" value="${p.stock}"/>
                                    <button type="submit" class="btn-cart" style="width:100%"
                                            ${p.stock == 0 ? 'disabled' : ''}>
                                        ${p.stock == 0 ? 'Hết hàng' : '🛒 Thêm vào giỏ'}
                                    </button>
                                </form>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>

    </div><%-- /cnt --%>
</main>

<%-- ══ FOOTER ══ --%>
<jsp:include page="/footer.jsp"/>

<%-- Toast thông báo --%>
<div class="toast" id="toast"></div>

<script>
function showToast(msg) {
    const t = document.getElementById('toast');
    t.textContent = msg;
    t.classList.add('show');
    setTimeout(() => t.classList.remove('show'), 2500);
}

function removeItem(btn, productId) {
    // AJAX remove để không reload trang (UX tốt hơn)
    const card = btn.closest('.pcard');
    const formData = new FormData();
    formData.append('action', 'remove');
    formData.append('productId', productId);

    fetch('${pageContext.request.contextPath}/wishlist', {
        method: 'POST',
        body: formData
    }).then(res => {
        if (res.ok || res.redirected) {
            card.style.transition = 'opacity .3s, transform .3s';
            card.style.opacity = '0';
            card.style.transform = 'scale(.9)';
            setTimeout(() => {
                card.remove();
                // Cập nhật count
                const grid = document.querySelector('.wl-grid');
                const remaining = document.querySelectorAll('.pcard').length;
                document.querySelector('.page-title h1 .count').textContent = remaining + ' sản phẩm';
                if (remaining === 0) {
                    grid.outerHTML = `<div class="wl-empty">
                        <div class="wl-empty-icon">💔</div>
                        <h2>Chưa có sản phẩm yêu thích</h2>
                        <p>Hãy thêm sản phẩm bạn yêu thích vào đây để dễ dàng tìm lại sau nhé!</p>
                        <a href="${pageContext.request.contextPath}/products" class="btn-shop">Khám phá sản phẩm</a>
                    </div>`;
                }
            }, 300);
            showToast('Đã xóa khỏi danh sách yêu thích');
        }
    }).catch(() => {
        // fallback: submit form bình thường
        btn.closest('form').submit();
    });
}
</script>

</body>
</html>
