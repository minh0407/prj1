<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Hồ sơ cá nhân - HomeElectro</title>
        <style>
            /* ── Header ── */
            #site-header{
                background:#d0021b;
                position:sticky;
                top:0;
                z-index:999;
                box-shadow:0 2px 10px rgba(0,0,0,.25)
            }
            .hd-topbar{
                background:#a80115;
                padding:4px 0;
                font-size:12px;
                color:rgba(255,255,255,.9)
            }
            .hd-topbar-inner{
                display:flex;
                justify-content:space-between;
                align-items:center
            }
            .hd-main{
                padding:10px 0
            }
            .hd-main-inner{
                display:flex;
                align-items:center;
                gap:14px
            }
            .hd-logo{
                background:#fff;
                border-radius:8px;
                padding:6px 14px;
                font-weight:900;
                font-size:19px;
                color:#d0021b;
                letter-spacing:-.5px;
                flex-shrink:0;
                text-decoration:none
            }
            .hd-logo span{
                background:rgba(208,2,27,.12);
                border-radius:4px;
                padding:0 3px
            }
            .hd-search{
                flex:1;
                position:relative;
                min-width:0
            }
            .hd-search input{
                width:100%;
                padding:10px 48px 10px 16px;
                border-radius:8px;
                border:none;
                font-size:14px;
                font-family:inherit;
                outline:none
            }
            .hd-search button{
                position:absolute;
                right:0;
                top:0;
                bottom:0;
                width:44px;
                background:#111;
                border:none;
                border-radius:0 8px 8px 0;
                cursor:pointer;
                color:#fff;
                font-size:16px
            }
            .hd-icons{
                display:flex;
                gap:4px;
                flex-shrink:0
            }
            .hd-icon-btn{
                display:flex;
                flex-direction:column;
                align-items:center;
                gap:2px;
                color:#fff;
                padding:4px 10px;
                border-radius:6px;
                cursor:pointer;
                position:relative;
                white-space:nowrap;
                text-decoration:none
            }
            .hd-icon-btn:hover{
                background:rgba(255,255,255,.15)
            }
            .hd-icon-ico{
                font-size:20px;
                position:relative;
                line-height:1
            }
            .hd-icon-btn > span{
                font-size:11px;
                color:rgba(255,255,255,.9)
            }
            .hd-badge{
                position:absolute;
                top:-5px;
                right:-7px;
                background:#fff;
                color:#d0021b;
                font-size:10px;
                font-weight:800;
                border-radius:50%;
                width:16px;
                height:16px;
                display:flex;
                align-items:center;
                justify-content:center
            }
            .hd-account{
                position:relative
            }
            .hd-account-name{
                font-size:11px;
                color:rgba(255,255,255,.9);
                max-width:72px;
                overflow:hidden;
                text-overflow:ellipsis;
                white-space:nowrap
            }
            .hd-dropdown{
                display:none;
                position:absolute;
                top:calc(100% + 10px);
                right:0;
                background:#fff;
                border-radius:10px;
                box-shadow:0 8px 28px rgba(0,0,0,.18);
                min-width:190px;
                padding:6px 0;
                z-index:1000
            }
            .hd-account:hover .hd-dropdown{
                display:block
            }
            .hd-dropdown a{
                display:block;
                padding:10px 16px;
                font-size:13px;
                color:#333;
                text-decoration:none
            }
            .hd-dropdown a:hover{
                background:#f5f5f5;
                color:#d0021b
            }
            .hd-dropdown hr{
                border:none;
                border-top:1px solid #f0f0f0;
                margin:4px 0
            }
            .hd-catnav{
                background:rgba(0,0,0,.18);
                border-top:1px solid rgba(255,255,255,.1);
                overflow-x:auto;
                scrollbar-width:none
            }
            .hd-catnav::-webkit-scrollbar{
                display:none
            }
            .hd-catnav-inner{
                display:flex
            }
            .hd-catitem{
                padding:9px 15px;
                color:rgba(255,255,255,.9);
                font-size:13px;
                font-weight:500;
                white-space:nowrap;
                border-bottom:2px solid transparent;
                transition:all .15s;
                text-decoration:none;
                display:block
            }
            .hd-catitem:hover,.hd-catitem.on{
                color:#fff;
                border-bottom-color:#fff;
                background:rgba(255,255,255,.12)
            }
            /* ── Footer ── */
            #site-footer{
                background:#111;
                color:#fff;
                padding:40px 0 0;
                margin-top:20px
            }
            .footer-grid{
                display:grid;
                grid-template-columns:2fr 1fr 1fr 1fr;
                gap:36px;
                padding-bottom:32px
            }
            .footer-logo{
                background:#d0021b;
                border-radius:8px;
                padding:5px 14px;
                display:inline-block;
                font-weight:900;
                font-size:19px;
                color:#fff;
                margin-bottom:14px
            }
            .footer-about p{
                font-size:13px;
                color:#aaa;
                line-height:1.7;
                margin-bottom:14px
            }
            .footer-contact{
                display:flex;
                flex-direction:column;
                gap:6px;
                font-size:13px;
                color:#aaa
            }
            .footer-contact strong{
                color:#fff
            }
            .footer-col-title{
                font-size:14px;
                font-weight:700;
                color:#fff;
                margin-bottom:14px
            }
            .footer-grid > div a{
                display:block;
                font-size:13px;
                color:#aaa;
                margin-bottom:8px;
                text-decoration:none
            }
            .footer-grid > div a:hover{
                color:#fff
            }
            .footer-bottom{
                border-top:1px solid #2a2a2a;
                padding:16px 0;
                display:flex;
                justify-content:space-between;
                font-size:12px;
                color:#666;
                flex-wrap:wrap;
                gap:8px
            }

            *{
                box-sizing:border-box;
                margin:0;
                padding:0
            }
            :root{
                --red:#d0021b;
                --red2:#a80115;
                --red-bg:#fff5f5;
                --border:#e8e8e8;
                --text:#1a1a1a;
                --muted:#777;
                --bg:#f5f5f5;
                --radius:8px;
            }
            body{
                background:var(--bg);
                font-family:'Segoe UI',Arial,sans-serif;
                color:var(--text);
                font-size:14px
            }
            a{
                text-decoration:none;
                color:inherit
            }
            img{
                display:block;
                max-width:100%
            }
            .cnt{
                max-width:1200px;
                margin:0 auto;
                padding:0 16px
            }
            .page-main{
                padding:16px 0 48px
            }

            /* ── Breadcrumb ── */
            .bc{
                display:flex;
                align-items:center;
                gap:6px;
                font-size:13px;
                color:var(--muted);
                margin-bottom:14px;
                flex-wrap:wrap
            }
            .bc a:hover{
                color:var(--red)
            }
            .bc-sep{
                color:#ccc
            }
            .bc-cur{
                color:var(--text);
                font-weight:500
            }

            /* ── Product layout ── */
            .pd-wrap{
                background:#fff;
                border-radius:var(--radius);
                display:grid;
                grid-template-columns:400px 1fr;
                gap:0;
                margin-bottom:12px;
                border:1px solid var(--border);
                overflow:hidden;
            }

            * {
                box-sizing: border-box;
                margin: 0;
                padding: 0
            }
            body {
                background: #f0f0f0;
                font-family: 'Segoe UI', system-ui, sans-serif
            }
            .cnt {
                max-width: 1200px;
                margin: 0 auto;
                padding: 0 16px
            }
            .page-header {
                background: #d0021b;
                color: white;
                padding: 20px 0;
                margin-bottom: 30px
            }
            .page-header h1 {
                font-size: 32px
            }

            .profile-container {
                display: grid;
                grid-template-columns: 300px 1fr;
                gap: 20px;
                margin-bottom: 40px
            }

            .sidebar {
                background: white;
                padding: 20px;
                border-radius: 8px;
                height: fit-content
            }
            .sidebar h3 {
                margin-bottom: 15px;
                border-bottom: 2px solid #d0021b;
                padding-bottom: 10px
            }
            .sidebar a {
                display: block;
                padding: 12px 0;
                text-decoration: none;
                color: #333;
                border-bottom: 1px solid #eee
            }
            .sidebar a:hover {
                color: #d0021b;
                font-weight: 700
            }

            .profile-content {
                background: white;
                padding: 30px;
                border-radius: 8px
            }
            .profile-content h2 {
                margin-bottom: 20px;
                color: #d0021b
            }

            .form-group {
                margin-bottom: 20px
            }
            .form-group label {
                display: block;
                margin-bottom: 8px;
                font-weight: 600
            }
            .form-group input {
                width: 100%;
                padding: 10px;
                border: 1px solid #ddd;
                border-radius: 4px;
                font-family: inherit
            }

            .btn-save {
                padding: 12px 24px;
                background: #d0021b;
                color: white;
                border: none;
                border-radius: 4px;
                font-weight: 700;
                cursor: pointer
            }
            .btn-save:hover {
                background: #a80115
            }

            .info-grid {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 20px;
                margin-bottom: 30px
            }
            .info-box {
                background: #f9f9f9;
                padding: 20px;
                border-radius: 8px
            }
            .info-box strong {
                display: block;
                color: #666;
                margin-bottom: 5px
            }

            @media (max-width: 768px) {
                .profile-container {
                    grid-template-columns: 1fr
                }
                .sidebar {
                    display: none
                }
                .info-grid {
                    grid-template-columns: 1fr
                }
            }
        </style>
    </head>
    <body>
        <%@ include file="/header.jsp" %>

        <div class="page-header">
            <div class="cnt">
                <h1>👤 Hồ sơ cá nhân</h1>
            </div>
        </div>

        <div class="cnt">
            <div class="profile-container">
                <!-- SIDEBAR -->
                <aside class="sidebar">
                    <h3>📋 Menu</h3>
                    <a href="${pageContext.request.contextPath}/profile">👤 Hồ sơ</a>
                    <a href="${pageContext.request.contextPath}/profile?tab=addresses">📍 Địa chỉ</a>
                    <a href="${pageContext.request.contextPath}/orders">📦 Đơn hàng</a>
                    <a href="${pageContext.request.contextPath}/wishlist">❤️ Yêu thích</a>
                    <a href="${pageContext.request.contextPath}/logout">🚪 Đăng xuất</a>
                </aside>

                <!-- PROFILE CONTENT -->
                <section class="profile-content">
                    <h2>Thông tin cá nhân</h2>
                    <c:if test="${not empty message}">
                        <div style="color:green; margin-bottom:15px;">
                            ${message}
                        </div>
                    </c:if>

                    <c:if test="${not empty error}">
                        <div style="color:red; margin-bottom:15px;">
                            ${error}
                        </div>
                    </c:if>
                    
                    <div class="info-grid">
                        <div class="info-box">
                            <strong>Tên người dùng:</strong>
                            ${user.username}
                        </div>
                        <div class="info-box">
                            <strong>Họ tên:</strong>
                            ${user.fullname}
                        </div>
                        <div class="info-box">
                            <strong>Email:</strong>
                            ${user.email}
                        </div>
                        <div class="info-box">
                            <strong>Số điện thoại:</strong>
                            ${user.phone}
                        </div>
                    </div>

                    <h3 style="margin-top: 30px; margin-bottom: 20px; color: #d0021b">Chỉnh sửa thông tin</h3>

                    <form method="post" action="${pageContext.request.contextPath}/profile">
                        <div class="form-group">
                            <label>Họ tên</label>
                            <input type="text" name="fullname" value="${user.fullname}">
                        </div>

                        <div class="form-group">
                            <label>Email</label>
                            <input type="email" name="email" value="${user.email}">
                        </div>

                        <div class="form-group">
                            <label>Số điện thoại</label>
                            <input type="tel" name="phone" value="${user.phone}">
                        </div>

                        <button type="submit" class="btn-save">💾 Lưu thay đổi</button>
                    </form>

                    <hr style="margin: 30px 0; border: none; border-top: 1px solid #eee;">

                    <h3 style="margin-bottom: 20px; color: #d0021b">Đổi mật khẩu</h3>

                    <form method="post" action="${pageContext.request.contextPath}/change-password">
                        <div class="form-group">
                            <label>Mật khẩu cũ</label>
                            <input type="password" name="oldPassword" required>
                        </div>

                        <div class="form-group">
                            <label>Mật khẩu mới</label>
                            <input type="password" name="newPassword" required>
                        </div>

                        <div class="form-group">
                            <label>Xác nhận mật khẩu mới</label>
                            <input type="password" name="confirmPassword" required>
                        </div>

                        <button type="submit" class="btn-save">🔐 Đổi mật khẩu</button>
                    </form>
                </section>
            </div>
        </div>

        <%@ include file="/footer.jsp" %>
    </body>
</html>