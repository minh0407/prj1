<%@page pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<header id="site-header">
    <%-- ── Top bar ────────────────────────────────────────────────────────── --%>
    <div class="hd-topbar">
        <div class="cnt hd-topbar-inner">
            <span>🚚 Miễn phí giao hàng đơn từ 500.000đ &nbsp;|&nbsp; 🔄 Đổi trả 30 ngày</span>
            <span>📞 Hotline: <strong>1800 2097</strong></span>
        </div>
    </div>

    <%-- ── Main nav ───────────────────────────────────────────────────────── --%>
    <div class="hd-main">
        <div class="cnt hd-main-inner">

            <a href="${pageContext.request.contextPath}/home" class="hd-logo">
                Home<span>E</span>
            </a>

            <form action="${pageContext.request.contextPath}/products" method="get" class="hd-search">
                <input type="text" name="keyword" placeholder="Tìm điện thoại, laptop, tai nghe..."
                       value="${param.keyword}" autocomplete="off">
                <button type="submit">🔍</button>
            </form>

            <nav class="hd-icons">
                <a href="${pageContext.request.contextPath}/cart" class="hd-icon-btn">
                    <div class="hd-icon-ico">
                        🛒
                        <c:if test="${not empty sessionScope.cartCount and sessionScope.cartCount > 0}">
                            <span class="hd-badge">${sessionScope.cartCount}</span>
                        </c:if>
                    </div>
                    <span>Giỏ hàng</span>
                </a>
                <a href="${pageContext.request.contextPath}/wishlist" class="hd-icon-btn">
                    <div class="hd-icon-ico">❤️</div>
                    <span>Yêu thích</span>
                </a>
                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <div class="hd-icon-btn hd-account">
                            <div class="hd-icon-ico">👤</div>
                            <span class="hd-account-name">${sessionScope.user.fullname}</span>
                            <div class="hd-dropdown">
                                <a href="${pageContext.request.contextPath}/profile">👤 Tài khoản</a>
                                <c:choose>
                                    <c:when test="${sessionScope.user.role == 'admin'}">
                                        <a href="${pageContext.request.contextPath}/admin/orders">🧾 Đơn hàng (Admin)</a>
                                        <a href="${pageContext.request.contextPath}/admin/dashboard">⚙️ Quản trị</a>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="${pageContext.request.contextPath}/orders">📦 Đơn hàng</a>
                                    </c:otherwise>
                                </c:choose>
                                <hr>
                                <a href="${pageContext.request.contextPath}/logout" style="color:#d0021b">🚪 Đăng xuất</a>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/login" class="hd-icon-btn">
                            <div class="hd-icon-ico">👤</div>
                            <span>Đăng nhập</span>
                        </a>
                    </c:otherwise>
                </c:choose>
            </nav>
        </div>
    </div>

    <%-- ── Category nav từ DB ────────────────────────────────────────────── --%>
    <nav class="hd-catnav">
        <div class="cnt hd-catnav-inner">
            <a href="${pageContext.request.contextPath}/products"
               class="hd-catitem ${empty param.categoryId ? 'on':''}">Tất cả</a>
            <c:forEach var="cat" items="${categories}">
                <a href="${pageContext.request.contextPath}/products?categoryId=${cat.id}"
                   class="hd-catitem ${param.categoryId eq cat.id ? 'on':''}">
                    ${cat.name}
                </a>
            </c:forEach>
        </div>
    </nav>
</header>
