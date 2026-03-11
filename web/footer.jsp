<%@page pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<footer id="site-footer">
    <div class="cnt footer-inner">
        <div class="footer-grid">
            <%-- Cột 1: Giới thiệu --%>
            <div class="footer-about">
                <div class="footer-logo">HomeE</div>
                <p>Hệ thống bán lẻ điện tử gia dụng hàng đầu Việt Nam. Cam kết chính hãng 100%, bảo hành tận nơi.</p>
                <div class="footer-contact">
                    <div>📞 <strong>1800 2097</strong> (miễn phí, 8–22h)</div>
                    <div>✉️ support@homeelectro.vn</div>
                    <div>📍 123 Lý Thường Kiệt, Q.10, TP.HCM</div>
                </div>
            </div>

            <%-- Cột 2: Danh mục từ DB --%>
            <div>
                <div class="footer-col-title">Danh mục sản phẩm</div>
                <c:forEach var="cat" items="${categories}" end="6">
                    <a href="${pageContext.request.contextPath}/products?categoryId=${cat.id}">
                        <c:if test="${not empty cat.icon}">${cat.icon} </c:if>${cat.name}
                    </a>
                </c:forEach>
            </div>

            <%-- Cột 3: Hỗ trợ --%>
            <div>
                <div class="footer-col-title">Hỗ trợ khách hàng</div>
                <a href="#">Tra cứu đơn hàng</a>
                <a href="#">Chính sách đổi trả</a>
                <a href="#">Chính sách bảo hành</a>
                <a href="#">Hướng dẫn mua hàng</a>
                <a href="#">Câu hỏi thường gặp</a>
                <a href="#">Liên hệ hỗ trợ</a>
            </div>

            <%-- Cột 4: Về chúng tôi --%>
            <div>
                <div class="footer-col-title">Về HomeElectro</div>
                <a href="#">Giới thiệu công ty</a>
                <a href="#">Hệ thống cửa hàng</a>
                <a href="#">Tuyển dụng</a>
                <a href="#">Tin tức & Khuyến mãi</a>
                <a href="#">Chương trình đại lý</a>
            </div>
        </div>

        <div class="footer-bottom">
            <span>© 2026 HomeElectro. Tất cả quyền được bảo lưu.</span>
            <span>🔒 Thanh toán an toàn &nbsp;|&nbsp; 🚚 Giao hàng toàn quốc</span>
        </div>
    </div>
</footer>
