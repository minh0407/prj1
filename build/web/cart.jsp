<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.CartItem"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
    List<CartItem> cart = (List<CartItem>) request.getAttribute("cart");
    if (cart == null) {
        cart = (List<CartItem>) session.getAttribute("cart");
    }

    Double total = (Double) request.getAttribute("cartTotal");
    if (total == null) total = 0.0;

    String context = request.getContextPath();
    int cartCount = 0;
    if (cart != null) {
        for (CartItem item : cart) {
            cartCount += item.getQuantity();
        }
    }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0">
    <title>Giỏ hàng – HomeElectro</title>
    <style>
        /* ═══════════════════════════════════════
           BASE (copy từ home.jsp)
        ═══════════════════════════════════════ */
        *{box-sizing:border-box;margin:0;padding:0}
        body{background:#f0f0f0;font-family:'Segoe UI',system-ui,sans-serif;color:#222;font-size:14px}
        a{text-decoration:none;color:inherit}
        img{display:block;max-width:100%}
        :root{
            --red:#d0021b;--red2:#a80115;--red-bg:#fff0f0;
            --border:#e8e8e8;--text:#222;--text2:#555;--text3:#999;--radius:10px;
        }
        .cnt{max-width:1200px;margin:0 auto;padding:0 16px}

        /* ═══════════════════════════════════════
           HEADER (copy từ home.jsp)
        ═══════════════════════════════════════ */
        #site-header{background:var(--red);position:sticky;top:0;z-index:999;box-shadow:0 2px 10px rgba(0,0,0,.25)}
        .hd-topbar{background:var(--red2);padding:4px 0;font-size:12px;color:rgba(255,255,255,.85)}
        .hd-topbar-inner{display:flex;justify-content:space-between;align-items:center}
        .hd-main{padding:10px 0}
        .hd-main-inner{display:flex;align-items:center;gap:14px}
        .hd-logo{background:#fff;border-radius:8px;padding:6px 14px;font-weight:900;font-size:19px;color:var(--red);letter-spacing:-.5px;flex-shrink:0}
        .hd-logo span{background:rgba(208,2,27,.12);border-radius:4px;padding:0 3px}
        .hd-search{flex:1;position:relative;min-width:0}
        .hd-search input{width:100%;padding:10px 48px 10px 16px;border-radius:8px;border:none;font-size:14px;font-family:inherit;outline:none}
        .hd-search button{position:absolute;right:0;top:0;bottom:0;width:44px;background:#111;border:none;border-radius:0 8px 8px 0;cursor:pointer;color:#fff;font-size:16px}
        .hd-icons{display:flex;gap:6px;flex-shrink:0}
        .hd-icon-btn{display:flex;flex-direction:column;align-items:center;gap:2px;color:#fff;padding:4px 10px;border-radius:6px;cursor:pointer;position:relative;white-space:nowrap}
        .hd-icon-btn:hover{background:rgba(255,255,255,.15)}
        .hd-icon-ico{font-size:20px;position:relative;line-height:1}
        .hd-icon-btn > span{font-size:11px;color:rgba(255,255,255,.9)}
        .hd-badge{position:absolute;top:-5px;right:-7px;background:#fff;color:var(--red);font-size:10px;font-weight:800;border-radius:50%;width:16px;height:16px;display:flex;align-items:center;justify-content:center}
        .hd-account{position:relative}
        .hd-dropdown{display:none;position:absolute;top:calc(100% + 10px);right:0;background:#fff;border-radius:10px;box-shadow:0 8px 28px rgba(0,0,0,.18);min-width:190px;padding:6px 0;z-index:1000}
        .hd-account:hover .hd-dropdown{display:block}
        .hd-dropdown a{display:block;padding:10px 16px;font-size:13px;color:#333}
        .hd-dropdown a:hover{background:#f5f5f5;color:var(--red)}
        .hd-dropdown hr{border:none;border-top:1px solid #f0f0f0;margin:4px 0}
        .hd-catnav{background:rgba(0,0,0,.18);border-top:1px solid rgba(255,255,255,.1);overflow-x:auto;scrollbar-width:none}
        .hd-catnav::-webkit-scrollbar{display:none}
        .hd-catnav-inner{display:flex}
        .hd-catitem{padding:9px 15px;color:rgba(255,255,255,.9);font-size:13px;font-weight:500;white-space:nowrap;border-bottom:2px solid transparent;transition:all .15s}
        .hd-catitem:hover,.hd-catitem.on{color:#fff;border-bottom-color:#fff;background:rgba(255,255,255,.12)}

        /* ═══════════════════════════════════════
           LAYOUT (copy từ home.jsp)
        ═══════════════════════════════════════ */
        .page-main{padding:16px 0 40px}
        .section{background:#fff;border-radius:var(--radius);padding:18px 20px;margin-bottom:14px;border:1px solid var(--border)}
        .sec-hd{display:flex;align-items:center;justify-content:space-between;margin-bottom:16px}
        .sec-title{font-size:18px;font-weight:800;color:var(--text);display:flex;align-items:center;gap:8px}
        .sec-title .sub{font-size:13px;color:var(--text3);font-weight:400}
        .sec-more{padding:6px 16px;border:1.5px solid var(--red);border-radius:6px;color:var(--red);font-size:13px;font-weight:600;transition:all .15s;white-space:nowrap}
        .sec-more:hover{background:var(--red);color:#fff}

        /* ═══════════════════════════════════════
           PROMO STRIP (copy từ home.jsp)
        ═══════════════════════════════════════ */
        .promo-strip{display:grid;grid-template-columns:repeat(4,1fr);gap:10px;margin-bottom:14px}
        .promo-card{border-radius:var(--radius);padding:14px 16px;display:flex;align-items:center;gap:12px;transition:transform .2s}
        .promo-card:hover{transform:translateY(-2px)}
        .promo-ico{font-size:28px;flex-shrink:0}
        .promo-title{font-size:14px;font-weight:700;color:#fff}
        .promo-sub{font-size:12px;color:rgba(255,255,255,.75);margin-top:3px}

        /* ═══════════════════════════════════════
           BREADCRUMB
        ═══════════════════════════════════════ */
        .breadcrumb-bar{display:flex;align-items:center;gap:6px;font-size:13px;color:var(--text3);margin-bottom:16px}
        .breadcrumb-bar a{color:var(--text3)}
        .breadcrumb-bar a:hover{color:var(--red)}
        .breadcrumb-bar .sep{color:#ccc}
        .breadcrumb-bar .current{color:var(--text);font-weight:600}

        /* ═══════════════════════════════════════
           CART GRID
        ═══════════════════════════════════════ */
        .cart-layout{display:grid;grid-template-columns:1fr 320px;gap:14px;align-items:start}

        /* Table */
        .cart-table-wrap{overflow-x:auto}
        .cart-table{width:100%;border-collapse:collapse}
        .cart-table thead tr{background:#f8f8f8;border-bottom:2px solid var(--border)}
        .cart-table thead th{padding:12px 14px;font-size:13px;font-weight:700;color:var(--text2);text-align:left;white-space:nowrap}
        .cart-table tbody tr{border-bottom:1px solid var(--border);transition:background .15s}
        .cart-table tbody tr:last-child{border-bottom:none}
        .cart-table tbody tr:hover{background:#fafafa}
        .cart-table td{padding:14px;vertical-align:middle}

        /* Cells */
        .pc-thumb{width:72px;height:72px;border-radius:8px;background:#f8f8f8;border:1px solid var(--border);object-fit:contain;flex-shrink:0}
        .pc-info-name{font-size:14px;font-weight:600;color:var(--text);line-height:1.4;margin-bottom:4px}
        .pc-info-id{font-size:12px;color:var(--text3)}
        .pc-price-val{font-size:15px;font-weight:700;color:var(--red)}
        .pc-stock-badge{display:inline-block;background:#e0f2fe;color:#0369a1;font-size:11px;font-weight:600;border-radius:4px;padding:3px 8px}
        .pc-subtotal{font-size:15px;font-weight:800;color:#16a34a}

        /* Qty form */
        .qty-form{display:flex;align-items:center;gap:6px}
        .qty-input{width:68px;padding:7px 8px;border:1.5px solid var(--border);border-radius:6px;font-size:14px;font-family:inherit;outline:none;transition:border-color .15s;text-align:center}
        .qty-input:focus{border-color:var(--red)}
        .btn-update{padding:7px 11px;background:var(--red);color:#fff;border:none;border-radius:6px;font-size:12px;font-weight:700;cursor:pointer;font-family:inherit;white-space:nowrap;transition:background .15s}
        .btn-update:hover{background:var(--red2)}
        .btn-remove{padding:7px 11px;background:#fff;color:var(--red);border:1.5px solid var(--red);border-radius:6px;font-size:12px;font-weight:700;cursor:pointer;font-family:inherit;white-space:nowrap;transition:all .15s}
        .btn-remove:hover{background:var(--red);color:#fff}

        /* Action links */
        .cart-actions{display:flex;gap:8px;flex-wrap:wrap;padding-top:16px;border-top:1px solid var(--border);margin-top:4px}
        .btn-action-link{padding:9px 16px;border-radius:6px;font-size:13px;font-weight:600;border:1.5px solid var(--border);color:var(--text2);transition:all .15s;display:inline-flex;align-items:center;gap:5px}
        .btn-action-link:hover{border-color:var(--red);color:var(--red);background:var(--red-bg)}

        /* Summary */
        .summary-box{position:sticky;top:80px}
        .summary-row{display:flex;justify-content:space-between;align-items:center;padding:10px 0;font-size:14px;color:var(--text2);border-bottom:1px solid #f5f5f5}
        .summary-row:last-of-type{border-bottom:none}
        .summary-row strong{color:var(--text);font-weight:600}
        .summary-total{display:flex;justify-content:space-between;align-items:center;padding:14px 0 0;margin-top:4px;border-top:2px solid var(--border)}
        .summary-total-label{font-size:16px;font-weight:800}
        .summary-total-val{font-size:22px;font-weight:900;color:var(--red)}
        .btn-checkout{display:block;width:100%;padding:14px;background:var(--red);color:#fff;border:none;border-radius:8px;font-size:15px;font-weight:800;cursor:pointer;font-family:inherit;text-align:center;transition:background .15s;margin-top:16px}
        .btn-checkout:hover{background:var(--red2)}
        .summary-links{display:flex;flex-direction:column;gap:8px;margin-top:10px}
        .summary-link{display:block;padding:10px 14px;background:#f8f8f8;border:1.5px solid var(--border);border-radius:8px;font-size:13px;font-weight:600;color:var(--text);text-align:center;transition:all .15s}
        .summary-link:hover{border-color:var(--red);color:var(--red);background:var(--red-bg)}
        .summary-tip{background:#f8f8f8;border-radius:8px;padding:12px 14px;margin-top:12px;font-size:12px;color:var(--text3);line-height:1.6;border:1px solid var(--border)}

        /* Empty cart */
        .empty-state-cart{text-align:center;padding:56px 20px}
        .empty-state-cart .ico{font-size:64px;margin-bottom:16px;opacity:.45}
        .empty-state-cart h3{font-size:20px;font-weight:800;margin-bottom:10px}
        .empty-state-cart p{font-size:14px;color:var(--text3);margin-bottom:24px;line-height:1.7}
        .empty-btns{display:flex;justify-content:center;gap:10px;flex-wrap:wrap}
        .btn-red{padding:12px 28px;background:var(--red);color:#fff;border:none;border-radius:8px;font-size:14px;font-weight:700;cursor:pointer;font-family:inherit;transition:background .15s;display:inline-block}
        .btn-red:hover{background:var(--red2)}
        .btn-outline{padding:12px 28px;background:#fff;color:#111;border:1.5px solid #ccc;border-radius:8px;font-size:14px;font-weight:700;display:inline-block;transition:all .15s}
        .btn-outline:hover{border-color:#111;background:#111;color:#fff}

        /* ═══════════════════════════════════════
           FOOTER (copy từ home.jsp)
        ═══════════════════════════════════════ */
        #site-footer{background:#111;color:#fff;padding:40px 0 0;margin-top:20px}
        .footer-grid{display:grid;grid-template-columns:2fr 1fr 1fr 1fr;gap:36px;padding-bottom:32px}
        .footer-logo{background:var(--red);border-radius:8px;padding:5px 14px;display:inline-block;font-weight:900;font-size:19px;color:#fff;margin-bottom:14px}
        .footer-about p{font-size:13px;color:#aaa;line-height:1.7;margin-bottom:14px}
        .footer-contact{display:flex;flex-direction:column;gap:6px;font-size:13px;color:#aaa}
        .footer-col-title{font-size:14px;font-weight:700;color:#fff;margin-bottom:14px}
        .footer-grid > div a{display:block;font-size:13px;color:#aaa;margin-bottom:8px}
        .footer-grid > div a:hover{color:#fff}
        .footer-bottom{border-top:1px solid #2a2a2a;padding:16px 0;display:flex;justify-content:space-between;font-size:12px;color:#666;flex-wrap:wrap;gap:8px}
    </style>
</head>
<body>

<!-- ══════════════════════════════════════════
     HEADER — giống hệt home.jsp
══════════════════════════════════════════ -->
<header id="site-header">

    <div class="hd-topbar">
        <div class="cnt">
            <div class="hd-topbar-inner">
                <span>🚚 Miễn phí giao hàng đơn từ 500.000đ &nbsp;|&nbsp; 📦 Đổi trả 30 ngày</span>
                <span>☎️ Hotline: <strong>1800 2097</strong></span>
            </div>
        </div>
    </div>

    <div class="hd-main">
        <div class="cnt">
            <div class="hd-main-inner">

                <a href="<%=context%>/home" class="hd-logo">Home<span>E</span></a>

                <form class="hd-search" action="<%=context%>/search" method="get">
                    <input type="text" name="keyword" placeholder="Tìm điện thoại, laptop, tai nghe...">
                    <button type="submit">🔍</button>
                </form>

                <div class="hd-icons">
                    <a href="<%=context%>/cart" class="hd-icon-btn">
                        <span class="hd-icon-ico">🛒
                            <% if (cartCount > 0) { %>
                            <span class="hd-badge"><%=cartCount%></span>
                            <% } %>
                        </span>
                        <span>Giỏ hàng</span>
                    </a>
                    <a href="<%=context%>/wishlist" class="hd-icon-btn">
                        <span class="hd-icon-ico">❤️</span>
                        <span>Yêu thích</span>
                    </a>
                    <div class="hd-account hd-icon-btn">
                        <span class="hd-icon-ico">👤</span>
                        <span>Tài khoản</span>
                        <div class="hd-dropdown">
                            <a href="<%=context%>/profile">👤 Tài khoản</a>
                            <a href="<%=context%>/orders">📦 Đơn hàng</a>
                            <hr>
                            <a href="<%=context%>/logout">🚪 Đăng xuất</a>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>

    <nav class="hd-catnav">
        <div class="cnt">
            <div class="hd-catnav-inner">
                <a href="<%=context%>/products"              class="hd-catitem">Tất cả</a>
                <a href="<%=context%>/products?categoryId=1" class="hd-catitem">Tivi</a>
                <a href="<%=context%>/products?categoryId=2" class="hd-catitem">Tủ lạnh</a>
                <a href="<%=context%>/products?categoryId=3" class="hd-catitem">Máy giặt</a>
                <a href="<%=context%>/products?categoryId=4" class="hd-catitem">Máy lạnh</a>
                <a href="<%=context%>/products?categoryId=5" class="hd-catitem">Nhà bếp</a>
                <a href="<%=context%>/products?categoryId=6" class="hd-catitem">Gia dụng</a>
                <a href="<%=context%>/products?categoryId=7" class="hd-catitem">Phụ kiện</a>
            </div>
        </div>
    </nav>

</header>

<!-- ══════════════════════════════════════════
     MAIN CONTENT
══════════════════════════════════════════ -->
<main class="page-main">
    <div class="cnt">

        <!-- Breadcrumb -->
        <div class="breadcrumb-bar">
            <a href="<%=context%>/home">🏠 Trang chủ</a>
            <span class="sep">›</span>
            <span class="current">🛒 Giỏ hàng</span>
        </div>

        <!-- Promo strip — giống hệt home.jsp -->
        <div class="promo-strip">
            <div class="promo-card" style="background:linear-gradient(135deg,#0f2460,#2563eb)">
                <span class="promo-ico">🎁</span>
                <div><div class="promo-title">Voucher 500K</div><div class="promo-sub">Cho đơn hàng đầu tiên</div></div>
            </div>
            <div class="promo-card" style="background:linear-gradient(135deg,#7c1520,var(--red))">
                <span class="promo-ico">🚚</span>
                <div><div class="promo-title">Giao trong 2 giờ</div><div class="promo-sub">Nội thành TP.HCM & HN</div></div>
            </div>
            <div class="promo-card" style="background:linear-gradient(135deg,#064e3b,#059669)">
                <span class="promo-ico">🔄</span>
                <div><div class="promo-title">Đổi trả 30 ngày</div><div class="promo-sub">Không cần lý do</div></div>
            </div>
            <div class="promo-card" style="background:linear-gradient(135deg,#3b0764,#7c3aed)">
                <span class="promo-ico">🛡️</span>
                <div><div class="promo-title">Bảo hành chính hãng</div><div class="promo-sub">Hỗ trợ kỹ thuật 24/7</div></div>
            </div>
        </div>

        <!-- Page heading — dùng đúng .section + .sec-hd pattern -->
        <div class="section">
            <div class="sec-hd" style="margin-bottom:0">
                <div class="sec-title">
                    🛒 Giỏ hàng của bạn
                    <span class="sub"><%=cartCount%> sản phẩm</span>
                </div>
                <a href="<%=context%>/products" class="sec-more">Tiếp tục mua hàng →</a>
            </div>
        </div>

        <%-- ══ EMPTY CART ══ --%>
        <%
            if (cart == null || cart.isEmpty()) {
        %>
        <div class="section">
            <div class="empty-state-cart">
                <div class="ico">🛒</div>
                <h3>Giỏ hàng đang trống</h3>
                <p>Bạn chưa thêm sản phẩm nào vào giỏ hàng.<br>Hãy quay lại cửa hàng để tiếp tục mua sắm.</p>
                <div class="empty-btns">
                    <a href="<%=context%>/products" class="btn-red">🛍️ Mua sắm ngay</a>
                    <a href="<%=context%>/home"     class="btn-outline">🏠 Về trang chủ</a>
                </div>
            </div>
        </div>
        <%
            } else {
        %>

        <%-- ══ CART + SUMMARY ══ --%>
        <div class="cart-layout">

            <!-- LEFT: bảng sản phẩm -->
            <div class="section">
                <div class="cart-table-wrap">
                    <table class="cart-table">
                        <thead>
                            <tr>
                                <th>Sản phẩm</th>
                                <th>Đơn giá</th>
                                <th>Tồn kho</th>
                                <th>Số lượng</th>
                                <th>Thành tiền</th>
                                <th style="text-align:center">Xóa</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                for (CartItem item : cart) {
                            %>
                            <tr>
                                <td>
                                    <div style="display:flex;align-items:center;gap:12px">
                                        <img src="<%=item.getImage()%>" alt="product" class="pc-thumb">
                                        <div>
                                            <div class="pc-info-name"><%=item.getProductName()%></div>
                                            <div class="pc-info-id">Mã SP: <%=item.getProductId()%></div>
                                        </div>
                                    </div>
                                </td>
                                <td><span class="pc-price-val"><%=String.format("%,.0f", item.getPrice())%>đ</span></td>
                                <td><span class="pc-stock-badge"><%=item.getStock()%> sp</span></td>
                                <td>
                                    <form action="<%=context%>/cart" method="post" class="qty-form">
                                        <input type="hidden" name="action" value="updateQuantity">
                                        <input type="hidden" name="productId" value="<%=item.getProductId()%>">
                                        <input type="number" name="quantity"
                                               value="<%=item.getQuantity()%>"
                                               min="1" max="<%=item.getStock()%>"
                                               class="qty-input" required>
                                        <button type="submit" class="btn-update">Cập nhật</button>
                                    </form>
                                </td>
                                <td><span class="pc-subtotal"><%=String.format("%,.0f", item.getSubtotal())%>đ</span></td>
                                <td style="text-align:center">
                                    <form action="<%=context%>/cart" method="post"
                                          onsubmit="return confirm('Bạn có chắc muốn xóa sản phẩm này?');">
                                        <input type="hidden" name="action" value="removeItem">
                                        <input type="hidden" name="productId" value="<%=item.getProductId()%>">
                                        <button type="submit" class="btn-remove">🗑️ Xóa</button>
                                    </form>
                                </td>
                            </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>
                </div>

                <div class="cart-actions">
                    <a href="<%=context%>/products" class="btn-action-link">← Tiếp tục mua hàng</a>
                    <a href="<%=context%>/home"     class="btn-action-link">🏠 Trang chủ</a>
                    <a href="<%=context%>/wishlist"  class="btn-action-link">❤️ Yêu thích</a>
                    <a href="<%=context%>/orders"    class="btn-action-link">📋 Đơn hàng</a>
                </div>
            </div>

            <!-- RIGHT: tóm tắt -->
            <div class="summary-box">
                <div class="section">
                    <div class="sec-title" style="font-size:16px;margin-bottom:14px">📋 Tóm tắt đơn hàng</div>

                    <div class="summary-row">
                        <span>Số sản phẩm</span>
                        <strong><%=cartCount%></strong>
                    </div>
                    <div class="summary-row">
                        <span>Tạm tính</span>
                        <strong><%=String.format("%,.0f", total)%>đ</strong>
                    </div>
                    <div class="summary-row">
                        <span>Phí vận chuyển</span>
                        <strong style="color:#16a34a">Miễn phí</strong>
                    </div>
                    <div class="summary-row">
                        <span>Giảm giá</span>
                        <strong style="color:#16a34a">0đ</strong>
                    </div>

                    <div class="summary-total">
                        <span class="summary-total-label">Tổng cộng</span>
                        <span class="summary-total-val"><%=String.format("%,.0f", total)%>đ</span>
                    </div>

                    <a href="<%=context%>/checkout" class="btn-checkout">💳 Thanh toán ngay</a>

                    <div class="summary-links">
                        <a href="<%=context%>/orders"  class="summary-link">🕐 Lịch sử đơn hàng</a>
                        <a href="<%=context%>/profile" class="summary-link">👤 Hồ sơ cá nhân</a>
                    </div>

                    <div class="summary-tip">
                        💡 Cập nhật số lượng trước khi thanh toán để tính lại tổng tiền chính xác.
                    </div>
                </div>
            </div>

        </div><%-- end cart-layout --%>

        <%
            }
        %>

    </div><%-- end cnt --%>
</main>

<!-- ══════════════════════════════════════════
     FOOTER — giống hệt home.jsp
══════════════════════════════════════════ -->
<footer id="site-footer">
    <div class="cnt">
        <div class="footer-grid">
            <div class="footer-about">
                <div class="footer-logo">HomeE</div>
                <p>Hệ thống điện máy chính hãng với hơn 200 showroom trên toàn quốc. Cam kết giá tốt, bảo hành đầy đủ.</p>
                <div class="footer-contact">
                    <span>📞 Hotline: 1800 2097 (miễn phí)</span>
                    <span>✉️ support@homeelectro.vn</span>
                    <span>🕐 8:00 – 22:00 tất cả các ngày</span>
                </div>
            </div>
            <div>
                <div class="footer-col-title">Sản phẩm</div>
                <a href="<%=context%>/products?categoryId=1">Tivi</a>
                <a href="<%=context%>/products?categoryId=2">Tủ lạnh</a>
                <a href="<%=context%>/products?categoryId=3">Máy giặt</a>
                <a href="<%=context%>/products?categoryId=4">Máy lạnh</a>
                <a href="<%=context%>/products?categoryId=5">Nhà bếp</a>
            </div>
            <div>
                <div class="footer-col-title">Hỗ trợ</div>
                <a href="#">Hướng dẫn mua hàng</a>
                <a href="#">Chính sách đổi trả</a>
                <a href="#">Tra cứu bảo hành</a>
                <a href="#">Thanh toán trả góp</a>
                <a href="#">Liên hệ chúng tôi</a>
            </div>
            <div>
                <div class="footer-col-title">Về chúng tôi</div>
                <a href="#">Giới thiệu</a>
                <a href="#">Tuyển dụng</a>
                <a href="#">Tin tức</a>
                <a href="#">Hệ thống cửa hàng</a>
                <a href="#">Chính sách bảo mật</a>
            </div>
        </div>
        <div class="footer-bottom">
            <span>© 2025 HomeElectro. All rights reserved.</span>
            <span>Được xây dựng với ❤️ tại Việt Nam</span>
        </div>
    </div>
</footer>

</body>
</html>
