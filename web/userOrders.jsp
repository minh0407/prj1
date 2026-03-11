<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="model.Order"%>
<%@page import="model.OrderDetail"%>
<%@page import="model.CartItem"%>
<%@page import="model.User"%>
<%
    User user      = (User) session.getAttribute("user");
    String context = request.getContextPath();

    List<Order> orders = (List<Order>) request.getAttribute("orders");
    Order selectedOrder        = (Order)       request.getAttribute("selectedOrder");
    List<OrderDetail> details  = (List<OrderDetail>) request.getAttribute("orderDetails");
    String successMsg          = (String) request.getAttribute("successMsg");

    // cart count for header badge
    java.util.List<CartItem> cart = (java.util.List<CartItem>) session.getAttribute("cart");
    int cartCount = 0;
    if (cart != null) for (CartItem ci : cart) cartCount += ci.getQuantity();

    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0">
    <title>Đơn hàng của tôi – HomeElectro</title>
    <style>
        *{box-sizing:border-box;margin:0;padding:0}
        body{background:#f0f0f0;font-family:'Segoe UI',system-ui,sans-serif;color:#222;font-size:14px}
        a{text-decoration:none;color:inherit}
        img{display:block;max-width:100%}
        :root{--red:#d0021b;--red2:#a80115;--red-bg:#fff0f0;--border:#e8e8e8;--text:#222;--text2:#555;--text3:#999;--radius:10px}
        .cnt{max-width:1200px;margin:0 auto;padding:0 16px}

        /* HEADER */
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

        /* PAGE */
        .page-main{padding:16px 0 40px}
        .section{background:#fff;border-radius:var(--radius);padding:18px 20px;margin-bottom:14px;border:1px solid var(--border)}
        .sec-hd{display:flex;align-items:center;justify-content:space-between;margin-bottom:16px}
        .sec-title{font-size:18px;font-weight:800;color:var(--text);display:flex;align-items:center;gap:8px}
        .sec-title .sub{font-size:13px;color:var(--text3);font-weight:400}

        /* ALERTS */
        .alert-success{background:#f0fdf4;border:1px solid #bbf7d0;border-radius:8px;padding:12px 16px;color:#15803d;font-size:13px;margin-bottom:14px;display:flex;align-items:center;gap:8px}

        /* BREADCRUMB */
        .breadcrumb-bar{display:flex;align-items:center;gap:6px;font-size:13px;color:var(--text3);margin-bottom:16px}
        .breadcrumb-bar a{color:var(--text3)}
        .breadcrumb-bar a:hover{color:var(--red)}
        .breadcrumb-bar .sep{color:#ccc}
        .breadcrumb-bar .current{color:var(--text);font-weight:600}

        /* STATUS BADGES */
        .badge{display:inline-block;padding:3px 10px;border-radius:20px;font-size:11px;font-weight:700;white-space:nowrap}
        .badge-pending   {background:#fef3c7;color:#92400e}
        .badge-processing{background:#dbeafe;color:#1e40af}
        .badge-shipping  {background:#e0f2fe;color:#0369a1}
        .badge-delivered {background:#dcfce7;color:#166534}
        .badge-cancelled {background:#fee2e2;color:#991b1b}
        .badge-unpaid    {background:#fef9c3;color:#854d0e}
        .badge-paid      {background:#dcfce7;color:#166534}

        /* ORDERS TABLE */
        .order-table{width:100%;border-collapse:collapse}
        .order-table thead tr{background:#f8f8f8;border-bottom:2px solid var(--border)}
        .order-table thead th{padding:11px 14px;font-size:13px;font-weight:700;color:var(--text2);text-align:left;white-space:nowrap}
        .order-table tbody tr{border-bottom:1px solid var(--border);transition:background .15s}
        .order-table tbody tr:last-child{border-bottom:none}
        .order-table tbody tr:hover{background:#fafafa}
        .order-table td{padding:12px 14px;vertical-align:middle}
        .order-id{font-weight:800;color:var(--red)}
        .order-date{font-size:12px;color:var(--text3)}
        .order-total{font-weight:800;color:#16a34a}

        /* ACTION BTNS */
        .btn-view{padding:6px 12px;background:var(--red);color:#fff;border:none;border-radius:6px;font-size:12px;font-weight:700;cursor:pointer;font-family:inherit;transition:background .15s;text-decoration:none;display:inline-block}
        .btn-view:hover{background:var(--red2)}
        .btn-cancel{padding:6px 12px;background:#fff;color:#ef4444;border:1.5px solid #ef4444;border-radius:6px;font-size:12px;font-weight:700;cursor:pointer;font-family:inherit;transition:all .15s}
        .btn-cancel:hover{background:#ef4444;color:#fff}

        /* ORDER DETAIL PANEL */
        .detail-panel{background:#f8faff;border-radius:var(--radius);border:1.5px solid #dbeafe;padding:20px;margin-top:14px}
        .detail-header{display:flex;justify-content:space-between;align-items:flex-start;margin-bottom:16px;flex-wrap:wrap;gap:10px}
        .detail-title{font-size:16px;font-weight:800;color:var(--text)}
        .detail-meta{display:grid;grid-template-columns:repeat(auto-fill,minmax(200px,1fr));gap:10px;margin-bottom:16px}
        .meta-item{background:#fff;border-radius:8px;padding:10px 14px;border:1px solid var(--border)}
        .meta-label{font-size:11px;color:var(--text3);font-weight:600;text-transform:uppercase;letter-spacing:.5px;margin-bottom:4px}
        .meta-value{font-size:14px;font-weight:700;color:var(--text)}
        .detail-table{width:100%;border-collapse:collapse;margin-top:14px}
        .detail-table thead tr{background:#eff6ff}
        .detail-table thead th{padding:10px 12px;font-size:12px;font-weight:700;color:#1e40af;text-align:left}
        .detail-table tbody tr{border-bottom:1px solid #e0e7ff}
        .detail-table tbody tr:last-child{border-bottom:none}
        .detail-table td{padding:10px 12px;font-size:13px;vertical-align:middle}
        .detail-total-row{background:#eff6ff;font-weight:800}

        /* EMPTY */
        .empty-state{text-align:center;padding:48px 20px}
        .empty-state .ico{font-size:56px;opacity:.4;margin-bottom:14px}
        .empty-state h3{font-size:18px;font-weight:800;margin-bottom:8px}
        .empty-state p{font-size:13px;color:var(--text3);margin-bottom:20px}
        .btn-red{padding:12px 28px;background:var(--red);color:#fff;border:none;border-radius:8px;font-size:14px;font-weight:700;cursor:pointer;font-family:inherit;transition:background .15s;display:inline-block}
        .btn-red:hover{background:var(--red2)}

        /* FOOTER */
        #site-footer{background:#111;color:#fff;padding:40px 0 0;margin-top:20px}
        .footer-grid{display:grid;grid-template-columns:2fr 1fr 1fr 1fr;gap:36px;padding-bottom:32px}
        .footer-logo{background:var(--red);border-radius:8px;padding:5px 14px;display:inline-block;font-weight:900;font-size:19px;color:#fff;margin-bottom:14px}
        .footer-about p{font-size:13px;color:#aaa;line-height:1.7;margin-bottom:14px}
        .footer-contact{display:flex;flex-direction:column;gap:6px;font-size:13px;color:#aaa}
        .footer-col-title{font-size:14px;font-weight:700;color:#fff;margin-bottom:14px}
        .footer-grid > div a{display:block;font-size:13px;color:#aaa;margin-bottom:8px}
        .footer-grid > div a:hover{color:#fff}
        .footer-bottom{border-top:1px solid #2a2a2a;padding:16px 0;display:flex;justify-content:space-between;font-size:12px;color:#666;flex-wrap:wrap;gap:8px}

        @media(max-width:768px){
            .detail-meta{grid-template-columns:1fr 1fr}
            .order-table thead th:nth-child(3),
            .order-table tbody td:nth-child(3){display:none}
        }
    </style>
</head>
<body>

<!-- HEADER -->
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

<!-- MAIN -->
<main class="page-main">
    <div class="cnt">

        <!-- Breadcrumb -->
        <div class="breadcrumb-bar">
            <a href="<%=context%>/home">🏠 Trang chủ</a>
            <span class="sep">›</span>
            <span class="current">📦 Đơn hàng của tôi</span>
        </div>

        <!-- Success message -->
        <% if (successMsg != null) { %>
        <div class="alert-success">✅ <%=successMsg%></div>
        <% } %>

        <!-- Heading -->
        <div class="section">
            <div class="sec-hd" style="margin-bottom:0">
                <div class="sec-title">
                    📦 Đơn hàng của tôi
                    <span class="sub"><%=orders != null ? orders.size() : 0%> đơn hàng</span>
                </div>
                <a href="<%=context%>/products" style="padding:6px 16px;border:1.5px solid var(--red);border-radius:6px;color:var(--red);font-size:13px;font-weight:600">🛍️ Tiếp tục mua hàng</a>
            </div>
        </div>

        <%-- ══ ORDERS LIST ══ --%>
        <% if (orders == null || orders.isEmpty()) { %>
        <div class="section">
            <div class="empty-state">
                <div class="ico">📦</div>
                <h3>Bạn chưa có đơn hàng nào</h3>
                <p>Hãy mua sắm và quay lại đây để theo dõi đơn hàng nhé!</p>
                <a href="<%=context%>/products" class="btn-red">🛍️ Mua sắm ngay</a>
            </div>
        </div>
        <% } else { %>
        <div class="section">
            <div style="overflow-x:auto">
                <table class="order-table">
                    <thead>
                        <tr>
                            <th>Mã đơn</th>
                            <th>Ngày đặt</th>
                            <th>Địa chỉ</th>
                            <th>Thanh toán</th>
                            <th>Tổng tiền</th>
                            <th>Trạng thái</th>
                            <th>Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Order o : orders) {
                            String statusClass;
                            switch (o.getStatus().toLowerCase()) {
                                case "processing": statusClass = "badge-processing"; break;
                                case "shipping":   statusClass = "badge-shipping";   break;
                                case "delivered":  statusClass = "badge-delivered";  break;
                                case "cancelled":  statusClass = "badge-cancelled";  break;
                                default:           statusClass = "badge-pending";
                            }
                            String payClass = "Paid".equalsIgnoreCase(o.getPaymentStatus())
                                             ? "badge-paid" : "badge-unpaid";
                            boolean canCancel = "Pending".equalsIgnoreCase(o.getStatus());
                        %>
                        <tr>
                            <td><span class="order-id">#<%=o.getId()%></span></td>
                            <td><span class="order-date"><%=o.getOrderDate() != null ? sdf.format(o.getOrderDate()) : "—"%></span></td>
                            <td style="max-width:180px;white-space:nowrap;overflow:hidden;text-overflow:ellipsis" title="<%=o.getShippingAddress()%>"><%=o.getShippingAddress()%></td>
                            <td><span class="badge <%=payClass%>"><%=o.getPaymentMethod()%> / <%=o.getPaymentStatus()%></span></td>
                            <td><span class="order-total"><%=String.format("%,.0f", o.getTotalAmount())%>đ</span></td>
                            <td><span class="badge <%=statusClass%>"><%=o.getStatus()%></span></td>
                            <td style="white-space:nowrap;display:flex;gap:6px">
                                <a href="<%=context%>/orders?orderId=<%=o.getId()%>" class="btn-view">🔍 Chi tiết</a>
                                <% if (canCancel) { %>
                                <form action="<%=context%>/orders" method="post" style="display:inline"
                                      onsubmit="return confirm('Bạn có chắc muốn hủy đơn hàng #<%=o.getId()%>?')">
                                    <input type="hidden" name="action"  value="cancel">
                                    <input type="hidden" name="orderId" value="<%=o.getId()%>">
                                    <button type="submit" class="btn-cancel">✖ Hủy</button>
                                </form>
                                <% } %>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>

        <%-- ══ ORDER DETAIL PANEL ══ --%>
        <% if (selectedOrder != null) { %>
        <div class="detail-panel">
            <div class="detail-header">
                <div class="detail-title">📋 Chi tiết đơn hàng #<%=selectedOrder.getId()%></div>
                <a href="<%=context%>/orders" style="font-size:13px;color:var(--red);font-weight:600">✖ Đóng</a>
            </div>

            <div class="detail-meta">
                <div class="meta-item">
                    <div class="meta-label">Người nhận</div>
                    <div class="meta-value"><%=selectedOrder.getReceiverName()%></div>
                </div>
                <div class="meta-item">
                    <div class="meta-label">Số điện thoại</div>
                    <div class="meta-value"><%=selectedOrder.getPhoneReceiver()%></div>
                </div>
                <div class="meta-item">
                    <div class="meta-label">Địa chỉ giao</div>
                    <div class="meta-value" style="font-size:12px"><%=selectedOrder.getShippingAddress()%></div>
                </div>
                <div class="meta-item">
                    <div class="meta-label">Phương thức thanh toán</div>
                    <div class="meta-value"><%=selectedOrder.getPaymentMethod()%></div>
                </div>
                <div class="meta-item">
                    <div class="meta-label">Trạng thái thanh toán</div>
                    <div class="meta-value"><%=selectedOrder.getPaymentStatus()%></div>
                </div>
                <div class="meta-item">
                    <div class="meta-label">Ngày đặt hàng</div>
                    <div class="meta-value"><%=selectedOrder.getOrderDate() != null ? sdf.format(selectedOrder.getOrderDate()) : "—"%></div>
                </div>
                <% if (selectedOrder.getNote() != null && !selectedOrder.getNote().isEmpty()) { %>
                <div class="meta-item">
                    <div class="meta-label">Ghi chú</div>
                    <div class="meta-value" style="font-size:12px"><%=selectedOrder.getNote()%></div>
                </div>
                <% } %>
                <% if (selectedOrder.getDiscountAmount() > 0) { %>
                <div class="meta-item">
                    <div class="meta-label">Giảm giá</div>
                    <div class="meta-value" style="color:#16a34a">-<%=String.format("%,.0f", selectedOrder.getDiscountAmount())%>đ</div>
                </div>
                <% } %>
            </div>

            <% if (details != null && !details.isEmpty()) { %>
            <table class="detail-table">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Mã SP</th>
                        <th>Đơn giá</th>
                        <th>SL</th>
                        <th>Giảm giá</th>
                        <th>Thành tiền</th>
                    </tr>
                </thead>
                <tbody>
                    <% int idx = 1;
                       double subtotal = 0;
                       for (OrderDetail d : details) {
                           double lineTotal = d.getPrice() * d.getQuantity() * (1 - d.getDiscount()/100.0);
                           subtotal += lineTotal;
                    %>
                    <tr>
                        <td><%=idx++%></td>
                        <td>SP #<%=d.getProductId()%></td>
                        <td><%=String.format("%,.0f", d.getPrice())%>đ</td>
                        <td><%=d.getQuantity()%></td>
                        <td><%=d.getDiscount()%>%</td>
                        <td style="font-weight:700;color:#16a34a"><%=String.format("%,.0f", lineTotal)%>đ</td>
                    </tr>
                    <% } %>
                    <tr class="detail-total-row">
                        <td colspan="5" style="text-align:right;font-size:14px">Tổng cộng:</td>
                        <td style="color:var(--red);font-size:16px"><%=String.format("%,.0f", selectedOrder.getTotalAmount())%>đ</td>
                    </tr>
                </tbody>
            </table>
            <% } %>
        </div>
        <% } %>
        <% } %>

    </div>
</main>

<!-- FOOTER -->
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
