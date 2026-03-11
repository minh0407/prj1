<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Đăng nhập – HomeElectro</title>
        <style>
            *{
                box-sizing:border-box;
                margin:0;
                padding:0
            }
            body{
                min-height:100vh;
                display:flex;
                align-items:center;
                justify-content:center;
                background:#f0f0f0;
                font-family:'Segoe UI',system-ui,sans-serif;
                padding:24px 16px
            }
            .card{
                background:#fff;
                border-radius:10px;
                box-shadow:0 2px 12px rgba(0,0,0,.1);
                overflow:hidden;
                display:flex;
                width:860px;
                max-width:98vw
            }
            /* PROMO */
            .promo{
                flex:1;
                background:#f5f5f5;
                padding:48px 40px;
                display:flex;
                flex-direction:column;
                justify-content:center
            }
            .brand{
                display:flex;
                align-items:center;
                gap:10px;
                margin-bottom:22px
            }
            .brand-logo{
                background:#d0021b;
                border-radius:6px;
                padding:5px 11px;
                color:#fff;
                font-weight:900;
                font-size:17px
            }
            .brand-logo .e{
                background:rgba(0,0,0,.15);
                border-radius:3px;
                padding:0 3px;
                margin-left:2px
            }
            .promo h2{
                font-size:19px;
                font-weight:600;
                color:#222;
                line-height:1.5;
                margin-bottom:6px
            }
            .promo h2 span{
                color:#d0021b;
                font-weight:900
            }
            .promo p{
                font-size:13px;
                color:#555;
                margin-bottom:22px;
                line-height:1.6
            }
            .perks{
                border:1.5px solid #d0021b;
                border-radius:10px;
                padding:18px 20px;
                background:#fff;
                position:relative
            }
            .c{
                position:absolute;
                width:13px;
                height:13px
            }
            .c.tl{
                top:-2px;
                left:-2px;
                border-top:3px solid #d0021b;
                border-left:3px solid #d0021b;
                border-radius:4px 0 0 0
            }
            .c.tr{
                top:-2px;
                right:-2px;
                border-top:3px solid #d0021b;
                border-right:3px solid #d0021b;
                border-radius:0 4px 0 0
            }
            .c.bl{
                bottom:-2px;
                left:-2px;
                border-bottom:3px solid #d0021b;
                border-left:3px solid #d0021b;
                border-radius:0 0 0 4px
            }
            .c.br{
                bottom:-2px;
                right:-2px;
                border-bottom:3px solid #d0021b;
                border-right:3px solid #d0021b;
                border-radius:0 0 4px 0
            }
            .perk{
                display:flex;
                gap:9px;
                align-items:flex-start;
                margin-bottom:11px;
                font-size:12.5px;
                color:#333;
                line-height:1.5
            }
            .perk:last-child{
                margin-bottom:0
            }
            .promo-link{
                margin-top:14px;
                font-size:13px;
                color:#d0021b;
                font-weight:600;
                cursor:pointer
            }
            /* FORM */
            .fpanel{
                width:400px;
                flex-shrink:0;
                padding:52px 44px;
                display:flex;
                flex-direction:column;
                justify-content:center
            }
            h1{
                font-size:26px;
                font-weight:800;
                color:#d0021b;
                margin-bottom:28px
            }
            label{
                display:block;
                font-size:14px;
                color:#333;
                font-weight:500;
                margin-bottom:6px
            }
            .iw{
                position:relative;
                margin-bottom:16px
            }
            input[type=text],input[type=password],input[type=email],input[type=tel],input[type=date]{
                width:100%;
                padding:11px 14px;
                font-size:14px;
                border:1px solid #d1d5db;
                border-radius:6px;
                outline:none;
                font-family:inherit;
                color:#111;
                background:#fff;
                transition:border-color .2s
            }
            input:focus{
                border-color:#aaa
            }
            .iw input{
                padding-right:42px
            }
            .eye{
                position:absolute;
                right:12px;
                top:50%;
                transform:translateY(-50%);
                background:none;
                border:none;
                cursor:pointer;
                color:#9ca3af;
                display:flex;
                align-items:center;
                padding:0
            }
            .fl{
                text-align:right;
                margin-bottom:20px
            }
            .fl a,.rl a{
                color:#d0021b;
                font-weight:600;
                text-decoration:none;
                font-size:14px
            }
            .fl a:hover,.rl a:hover{
                text-decoration:underline
            }
            .btn-red{
                width:100%;
                padding:12px;
                border-radius:6px;
                background:#d0021b;
                color:#fff;
                border:none;
                font-size:15px;
                font-weight:700;
                cursor:pointer;
                font-family:inherit;
                transition:background .15s
            }
            .btn-red:hover{
                background:#a80115
            }
            .rl{
                text-align:center;
                margin-top:20px;
                font-size:14px;
                color:#555
            }
            .alert{
                border-radius:6px;
                padding:9px 13px;
                margin-bottom:16px;
                font-size:13px;
                line-height:1.5
            }
            .alert-e{
                background:#fef2f2;
                border:1px solid #fecaca;
                color:#dc2626
            }
            .alert-s{
                background:#f0fdf4;
                border:1px solid #bbf7d0;
                color:#16a34a
            }
        </style>
    </head>
    <body>
        <div class="card">
            <div class="promo">
                <div class="brand">
                    <div class="brand-logo">Home<span class="e">E</span></div>
                    <span style="font-size:13px;color:#666">Điện tử gia dụng</span>
                </div>
                <h2>Nhập hội khách hàng thành viên <span>HMEMBER</span></h2>
                <p>Để không bỏ lỡ các ưu đãi hấp dẫn từ HomeElectro</p>
                <div class="perks">
                    <div class="c tl"></div><div class="c tr"></div><div class="c bl"></div><div class="c br"></div>
                    <div class="perk">🎁 <span><b>Chiết khấu đến 5%</b> khi mua các sản phẩm tại HomeElectro</span></div>
                    <div class="perk">🎁 <span><b>Miễn phí giao hàng</b> cho thành viên và đơn hàng từ 500.000đ</span></div>
                    <div class="perk">🎁 <span><b>Tặng voucher sinh nhật đến 300.000đ</b> cho khách hàng thành viên</span></div>
                    <div class="perk">🎁 <span><b>Trợ giá thu cũ lên đến 1 triệu</b> khi đổi sản phẩm mới</span></div>
                    <div class="perk">🎁 <span><b>Thăng hạng nhận voucher đến 200.000đ</b> khi tích điểm mua sắm</span></div>
                    <div class="perk">🎁 <span><b>Ưu đãi riêng cho khách hàng doanh nghiệp</b> chiết khấu thêm lên đến 10%</span></div>
                </div>
                <div class="promo-link">Xem chi tiết chính sách ưu đãi HMEMBER →</div>
            </div>

            <div class="fpanel">
                <h1>Đăng nhập HMEMBER</h1>

                <% if (request.getAttribute("error") != null) { %><div class="alert alert-e">${error}</div><% } %>
                <% if ("true".equals(request.getParameter("registered"))) { %><div class="alert alert-s">Đăng ký thành công! Vui lòng đăng nhập.</div><% } %>
                <% if ("true".equals(request.getParameter("reset"))) { %><div class="alert alert-s">Đặt lại mật khẩu thành công!</div><% }%>

                <form action="login" method="post">
                    <label>Tên đăng nhập</label>
                    <div style="margin-bottom:16px">
                        <input type="text" name="username" placeholder="Nhập tên đăng nhập của bạn" required value="${param.username}">
                    </div>
                    <label>Mật khẩu</label>
                    <div class="iw" style="margin-bottom:6px">
                        <input type="password" name="password" id="pwd" placeholder="Nhập mật khẩu của bạn" required>
                        <button type="button" class="eye" onclick="togglePwd('pwd', 'e1')">
                            <svg id="e1" width="17" height="17" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                            <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/><circle cx="12" cy="12" r="3"/>
                            </svg>
                        </button>
                    </div>
                    <div class="fl"><a href="forgot">Quên mật khẩu?</a></div>
                    <button type="submit" class="btn-red">Đăng nhập</button>
                </form>
                <div class="rl">Bạn chưa có tài khoản? <a href="register">Đăng ký ngay</a></div>
            </div>
        </div>
        <script>
            function togglePwd(id, eid) {
                const i = document.getElementById(id), e = document.getElementById(eid);
                if (i.type === 'password') {
                    i.type = 'text';
                    e.innerHTML = '<path d="M17.94 17.94A10.07 10.07 0 0112 20c-7 0-11-8-11-8a18.45 18.45 0 015.06-5.94M9.9 4.24A9.12 9.12 0 0112 4c7 0 11 8 11 8a18.5 18.5 0 01-2.16 3.19m-6.72-1.07a3 3 0 11-4.24-4.24"/><line x1="1" y1="1" x2="23" y2="23"/>';
                } else {
                    i.type = 'password';
                    e.innerHTML = '<path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/><circle cx="12" cy="12" r="3"/>';
                }
            }
        </script>
    </body>
</html>
