<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width,initial-scale=1.0">
        <title>HomeElectro – Điện tử chính hãng, giá tốt nhất</title>
        <style>
            *{
                box-sizing:border-box;
                margin:0;
                padding:0
            }
            body{
                background:#f0f0f0;
                font-family:'Segoe UI',system-ui,sans-serif;
                color:#222;
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
            :root{
                --red:#d0021b;
                --red2:#a80115;
                --red-bg:#fff0f0;
                --border:#e8e8e8;
                --text:#222;
                --text2:#555;
                --text3:#999;
                --radius:10px;
            }
            .cnt{
                max-width:1200px;
                margin:0 auto;
                padding:0 16px
            }

            /* ── Header ──────────────────────────────────────────────────────── */
            #site-header{
                background:var(--red);
                position:sticky;
                top:0;
                z-index:999;
                box-shadow:0 2px 10px rgba(0,0,0,.25)
            }
            .hd-topbar{
                background:var(--red2);
                padding:4px 0;
                font-size:12px;
                color:rgba(255,255,255,.85)
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
                color:var(--red);
                letter-spacing:-.5px;
                flex-shrink:0
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
                gap:6px;
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
                white-space:nowrap
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
                color:var(--red);
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
                color:#333
            }
            .hd-dropdown a:hover{
                background:#f5f5f5;
                color:var(--red)
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
                transition:all .15s
            }
            .hd-catitem:hover,.hd-catitem.on{
                color:#fff;
                border-bottom-color:#fff;
                background:rgba(255,255,255,.12)
            }

            /* ── Layout ──────────────────────────────────────────────────────── */
            .page-main{
                padding:16px 0 40px
            }
            .section{
                background:#fff;
                border-radius:var(--radius);
                padding:18px 20px;
                margin-bottom:14px;
                border:1px solid var(--border)
            }
            .sec-hd{
                display:flex;
                align-items:center;
                justify-content:space-between;
                margin-bottom:16px
            }
            .sec-title{
                font-size:18px;
                font-weight:800;
                color:var(--text);
                display:flex;
                align-items:center;
                gap:8px
            }
            .sec-title .sub{
                font-size:13px;
                color:var(--text3);
                font-weight:400
            }
            .sec-more{
                padding:6px 16px;
                border:1.5px solid var(--red);
                border-radius:6px;
                color:var(--red);
                font-size:13px;
                font-weight:600;
                transition:all .15s;
                white-space:nowrap
            }
            .sec-more:hover{
                background:var(--red);
                color:#fff
            }

            /* ── Hero ────────────────────────────────────────────────────────── */
            .hero{
                display:grid;
                grid-template-columns:1fr 272px;
                gap:12px;
                margin-bottom:14px
            }
            .hero-main{
                border-radius:var(--radius);
                min-height:230px;
                padding:36px 44px;
                display:flex;
                align-items:center;
                justify-content:space-between;
                position:relative;
                overflow:hidden;
                cursor:pointer;
                transition:background .7s
            }
            .hero-deco{
                position:absolute;
                border-radius:50%;
                pointer-events:none;
                opacity:.06
            }
            .hero-content{
                z-index:1
            }
            .hero-badge{
                display:inline-block;
                background:var(--red);
                color:#fff;
                font-size:11px;
                font-weight:800;
                padding:3px 10px;
                border-radius:4px;
                margin-bottom:12px;
                letter-spacing:.8px
            }
            .hero-title{
                font-size:28px;
                font-weight:900;
                color:#fff;
                line-height:1.2;
                margin-bottom:8px
            }
            .hero-sub{
                font-size:14px;
                color:rgba(255,255,255,.72);
                margin-bottom:18px;
                line-height:1.5
            }
            .hero-actions{
                display:flex;
                align-items:center;
                gap:14px
            }
            .hero-price{
                font-size:22px;
                font-weight:800;
                color:#ffb3b3
            }
            .hero-btn{
                padding:10px 24px;
                background:var(--red);
                color:#fff;
                border:none;
                border-radius:8px;
                font-size:14px;
                font-weight:700;
                cursor:pointer;
                font-family:inherit
            }
            .hero-btn:hover{
                background:var(--red2)
            }
            .hero-emoji{
                font-size:96px;
                line-height:1;
                z-index:1;
                flex-shrink:0
            }
            .hero-dots{
                position:absolute;
                bottom:14px;
                left:50%;
                transform:translateX(-50%);
                display:flex;
                gap:6px
            }
            .hero-dot{
                height:7px;
                border-radius:4px;
                cursor:pointer;
                transition:all .3s
            }
            .hero-dot.on{
                background:#fff;
                width:22px
            }
            .hero-dot:not(.on){
                background:rgba(255,255,255,.4);
                width:7px
            }
            .hero-side{
                display:flex;
                flex-direction:column;
                gap:10px
            }
            .hero-side-card{
                border-radius:var(--radius);
                padding:16px 20px;
                flex:1;
                display:flex;
                flex-direction:column;
                justify-content:center
            }
            .hero-side-card:hover{
                filter:brightness(1.08)
            }
            .hero-side-card .sc-title{
                font-size:15px;
                font-weight:700;
                color:#fff
            }
            .hero-side-card .sc-sub{
                font-size:12px;
                color:rgba(255,255,255,.7);
                margin-top:4px
            }

            /* ── Promo ───────────────────────────────────────────────────────── */
            .promo-strip{
                display:grid;
                grid-template-columns:repeat(4,1fr);
                gap:10px;
                margin-bottom:14px
            }
            .promo-card{
                border-radius:var(--radius);
                padding:14px 16px;
                display:flex;
                align-items:center;
                gap:12px
            }
            .promo-card:hover{
                transform:translateY(-2px)
            }
            .promo-ico{
                font-size:28px;
                flex-shrink:0
            }
            .promo-title{
                font-size:14px;
                font-weight:700;
                color:#fff
            }
            .promo-sub{
                font-size:12px;
                color:rgba(255,255,255,.75);
                margin-top:3px
            }

            /* ── Flash Sale ──────────────────────────────────────────────────── */
            .flash-hd{
                display:flex;
                align-items:center;
                gap:14px;
                margin-bottom:16px;
                flex-wrap:wrap
            }
            .flash-title{
                font-size:20px;
                font-weight:900;
                color:var(--red);
                display:flex;
                align-items:center;
                gap:6px
            }
            .fire{
                display:inline-block;
                animation:pulse 1s infinite alternate
            }
            @keyframes pulse{
                from{
                    transform:scale(1)
                }
                to{
                    transform:scale(1.2)
                }
            }
            .countdown{
                display:flex;
                align-items:center;
                gap:5px
            }
            .cd-label{
                font-size:12px;
                color:var(--text2)
            }
            .cd-box{
                background:#111;
                color:#fff;
                border-radius:5px;
                padding:3px 8px;
                font-size:17px;
                font-weight:800;
                min-width:32px;
                text-align:center
            }
            .cd-sep{
                font-size:17px;
                font-weight:800;
                color:var(--red)
            }

            /* ── Brand bar ───────────────────────────────────────────────────── */
            .brand-bar{
                background:#fff;
                border-radius:var(--radius);
                padding:14px 20px;
                margin-bottom:14px;
                border:1px solid var(--border)
            }
            .brand-bar-title{
                font-size:12px;
                font-weight:700;
                color:var(--text3);
                text-transform:uppercase;
                letter-spacing:.06em;
                margin-bottom:12px
            }
            .brand-list{
                display:flex;
                gap:8px;
                flex-wrap:wrap
            }
            .brand-chip{
                padding:6px 18px;
                border-radius:20px;
                border:1.5px solid var(--border);
                font-size:13px;
                font-weight:600;
                color:#444;
                transition:all .15s
            }
            .brand-chip:hover{
                border-color:var(--red);
                color:var(--red);
                background:var(--red-bg)
            }

            /* ── Product grid ────────────────────────────────────────────────── */
            .pgrid{
                display:grid;
                gap:12px
            }
            .pgrid-4{
                grid-template-columns:repeat(4,1fr)
            }
            .pgrid-6{
                grid-template-columns:repeat(6,1fr);
                gap:10px
            }

            /* ── Product card ────────────────────────────────────────────────── */
            .pcard{
                background:#fff;
                border-radius:var(--radius);
                border:1.5px solid var(--border);
                padding:14px;
                cursor:pointer;
                transition:all .22s;
                position:relative;
                overflow:hidden
            }
            .pcard:hover{
                border-color:var(--red);
                transform:translateY(-3px);
                box-shadow:0 8px 24px rgba(208,2,27,.13)
            }
            .pcard.sm{
                padding:11px
            }
            .pc-discount{
                position:absolute;
                top:9px;
                right:9px;
                background:var(--red);
                color:#fff;
                font-size:11px;
                font-weight:700;
                border-radius:4px;
                padding:2px 7px;
                z-index:1
            }
            .pc-tag{
                position:absolute;
                top:9px;
                left:9px;
                color:#fff;
                font-size:10px;
                font-weight:700;
                border-radius:4px;
                padding:2px 7px;
                z-index:1
            }
            .pc-img-wrap{
                width:100%;
                aspect-ratio:1;
                border-radius:8px;
                background:#f8f8f8;
                margin-bottom:10px;
                overflow:hidden;
                display:flex;
                align-items:center;
                justify-content:center
            }
            .pc-img{
                width:100%;
                height:100%;
                object-fit:contain;
                transition:transform .3s
            }
            .pcard:hover .pc-img{
                transform:scale(1.05)
            }
            .pc-img-ph{
                font-size:52px;
                line-height:1
            }
            .pcard.sm .pc-img-ph{
                font-size:40px
            }
            .pc-brand{
                font-size:11px;
                color:var(--text3);
                margin-bottom:3px;
                font-weight:500
            }
            .pc-name{
                font-size:13.5px;
                font-weight:600;
                color:var(--text);
                line-height:1.4;
                display:-webkit-box;
                -webkit-line-clamp:2;
                -webkit-box-orient:vertical;
                overflow:hidden;
                min-height:38px;
                margin-bottom:8px
            }
            .pcard.sm .pc-name{
                font-size:13px;
                min-height:36px
            }
            .pc-price{
                font-size:17px;
                font-weight:800;
                color:var(--red);
                line-height:1
            }
            .pcard.sm .pc-price{
                font-size:15px
            }
            .pc-old{
                font-size:12px;
                color:var(--text3);
                text-decoration:line-through;
                margin-top:3px
            }
            .pc-warranty{
                font-size:11px;
                color:#16a34a;
                margin-top:5px;
                font-weight:500
            }
            .pc-soldbar{
                margin-top:9px
            }
            .pc-soldbar-info{
                display:flex;
                justify-content:space-between;
                font-size:11px;
                color:var(--text3);
                margin-bottom:3px
            }
            .pc-soldbar-track{
                height:5px;
                background:#f0f0f0;
                border-radius:3px;
                overflow:hidden
            }
            .pc-soldbar-fill{
                height:100%;
                border-radius:3px
            }
            .empty-state{
                text-align:center;
                padding:36px;
                color:var(--text3)
            }
            .empty-state .ico{
                font-size:44px;
                margin-bottom:12px
            }

            /* ── Footer ──────────────────────────────────────────────────────── */
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
                background:var(--red);
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
                margin-bottom:8px
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
        </style>
    </head>
    <body>

        <%-- HEADER --%>
        <jsp:include page="/header.jsp"/>

        <main class="page-main">
            <div class="cnt">

                <%-- ══ 1. HERO BANNER ════════════════════════════════════════════════ --%>
                <div class="hero">
                    <div class="hero-main" id="heroBanner">
                        <div class="hero-deco" style="width:320px;height:320px;background:#fff;right:-80px;top:-80px"></div>
                        <div class="hero-deco" style="width:200px;height:200px;background:#fff;right:60px;bottom:-100px"></div>
                        <div class="hero-content">
                            <div class="hero-badge" id="hBadge">MỚI NHẤT</div>
                            <div class="hero-title" id="hTitle">iPhone 16 Pro Max</div>
                            <div class="hero-sub"   id="hSub">Chip A18 Pro · Camera 48MP · Titanium cao cấp</div>
                            <div class="hero-actions">
                                <span class="hero-price" id="hPrice">34.990.000đ</span>
                                <a href="${pageContext.request.contextPath}/products" class="hero-btn" id="hLink">Mua ngay</a>
                            </div>
                        </div>
                        <div class="hero-emoji" id="hEmoji">📱</div>
                        <div class="hero-dots" id="hDots"></div>
                    </div>
                    <div class="hero-side">
                        <a href="${pageContext.request.contextPath}/products?sort=discount"
                           class="hero-side-card" style="background:linear-gradient(135deg,#1a0a2e,#c84b31)">
                            <div class="sc-title">⚡ Flash Sale hôm nay</div>
                            <div class="sc-sub">Giảm đến 25% – Số lượng có hạn</div>
                        </a>
                        <a href="${pageContext.request.contextPath}/products?sort=new"
                           class="hero-side-card" style="background:linear-gradient(135deg,#0a1628,#1e4d8c)">
                            <div class="sc-title">🆕 Hàng mới về</div>
                            <div class="sc-sub">Cập nhật mỗi ngày</div>
                        </a>
                        <a href="${pageContext.request.contextPath}/products?sort=sold"
                           class="hero-side-card" style="background:linear-gradient(135deg,#1a1a1a,#3a3a3a)">
                            <div class="sc-title">🏆 Bán chạy nhất</div>
                            <div class="sc-sub">Được tin dùng nhiều nhất</div>
                        </a>
                    </div>
                </div>

                <%-- ══ 2. PROMO STRIP ════════════════════════════════════════════════ --%>
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

                <%-- ══ 3. FLASH SALE ════════════════════════════════════════════════ --%>
                <c:if test="${not empty flashSaleProducts}">
                    <div class="section">
                        <div class="flash-hd">
                            <div class="flash-title"><span class="fire">⚡</span> FLASH SALE</div>
                            <div class="countdown">
                                <span class="cd-label">Kết thúc sau</span>
                                <span class="cd-box" id="cdH">00</span><span class="cd-sep">:</span>
                                <span class="cd-box" id="cdM">00</span><span class="cd-sep">:</span>
                                <span class="cd-box" id="cdS">00</span>
                            </div>
                            <a href="${pageContext.request.contextPath}/products?sort=discount"
                               class="sec-more" style="margin-left:auto">Xem tất cả →</a>
                        </div>
                        <div class="pgrid pgrid-6">
                            <c:forEach var="p" items="${flashSaleProducts}">
                                <div class="pcard sm" onclick="location.href = '${pageContext.request.contextPath}/productdetail?id=${p.id}'">
                                    <c:if test="${p.discount > 0}">
                                        <div class="pc-discount">
                                            -<fmt:formatNumber value="${p.discount}" maxFractionDigits="0"/>%
                                        </div>
                                    </c:if>
                                    <div class="pc-img-wrap">
                                        <c:choose>
                                            <c:when test="${not empty p.image}">
                                                <img src="https://source.unsplash.com/400x400/?${p.name}"
                                                     alt="${p.name}"
                                                     class="pc-img">
                                            </c:when>
                                            <c:otherwise><div class="pc-img-ph">📦</div></c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div class="pc-brand">${p.brandName}</div>
                                    <div class="pc-name">${p.name}</div>
                                    <div class="pc-price">
                                        <fmt:formatNumber value="${p.salePrice}" pattern="#,###"/>đ
                                    </div>
                                    <c:if test="${p.discount > 0}">
                                        <div class="pc-old"><fmt:formatNumber value="${p.price}" pattern="#,###"/>đ</div>
                                    </c:if>
                                    <c:if test="${p.stock + p.sold > 0}">
                                        <div class="pc-soldbar">
                                            <div class="pc-soldbar-info">
                                                <span>Đã bán ${p.soldPercent}%</span>
                                                <span>Còn ${p.stock}</span>
                                            </div>
                                            <div class="pc-soldbar-track">
                                                <c:choose>
                                                    <c:when test="${p.soldPercent >= 80}">
                                                        <div class="pc-soldbar-fill" style="width:${p.soldPercent}%;background:var(--red)"></div>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div class="pc-soldbar-fill" style="width:${p.soldPercent}%;background:#f97316"></div>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                    </c:if>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </c:if>

                <%-- ══ 4. BRAND BAR ════════════════════════════════════════════════ --%>
                <c:if test="${not empty brands}">
                    <div class="brand-bar">
                        <div class="brand-bar-title">Thương hiệu nổi bật</div>
                        <div class="brand-list">
                            <c:forEach var="b" items="${brands}">
                                <a href="${pageContext.request.contextPath}/products?brandId=${b.id}"
                                   class="brand-chip">${b.name}</a>
                            </c:forEach>
                        </div>
                    </div>
                </c:if>

                <%-- ══ 5. SẢN PHẨM NỔI BẬT ════════════════════════════════════════ --%>
                <div class="section">
                    <div class="sec-hd">
                        <div class="sec-title">
                            🔥 Sản phẩm nổi bật
                            <span class="sub">Được mua nhiều nhất</span>
                        </div>
                        <a href="${pageContext.request.contextPath}/products" class="sec-more">Xem tất cả →</a>
                    </div>
                    <c:choose>
                        <c:when test="${not empty featuredProducts}">
                            <div class="pgrid pgrid-4">
                                <c:forEach var="p" items="${featuredProducts}">
                                    <div class="pcard" onclick="location.href = '${pageContext.request.contextPath}/productdetail?id=${p.id}'">
                                        <c:if test="${p.discount > 0}">
                                            <div class="pc-discount">
                                                -<fmt:formatNumber value="${p.discount}" maxFractionDigits="0"/>%
                                            </div>
                                        </c:if>
                                        <c:if test="${p.isFeatured}">
                                            <div class="pc-tag" style="background:#f97316">Hot</div>
                                        </c:if>
                                        <div class="pc-img-wrap">
                                            <c:choose>
                                                <c:when test="${not empty p.image}">
                                                    <img src="https://source.unsplash.com/400x400/?${p.name}"
                                                         alt="${p.name}"
                                                         class="pc-img">
                                                </c:when>
                                                <c:otherwise><div class="pc-img-ph">📦</div></c:otherwise>
                                            </c:choose>
                                        </div>
                                        <div class="pc-brand">${p.brandName}</div>
                                        <div class="pc-name">${p.name}</div>
                                        <div class="pc-price">
                                            <fmt:formatNumber value="${p.salePrice}" pattern="#,###"/>đ
                                        </div>
                                        <c:if test="${p.discount > 0}">
                                            <div class="pc-old"><fmt:formatNumber value="${p.price}" pattern="#,###"/>đ</div>
                                        </c:if>
                                        <c:if test="${p.warranty > 0}">
                                            <div class="pc-warranty">✓ Bảo hành ${p.warranty} tháng</div>
                                        </c:if>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="empty-state"><div class="ico">🏷️</div><p>Chưa có sản phẩm nổi bật</p></div>
                        </c:otherwise>
                    </c:choose>
                </div>

                <%-- ══ 6. HÀNG MỚI VỀ ════════════════════════════════════════════ --%>
                <div class="section">
                    <div class="sec-hd">
                        <div class="sec-title">
                            🆕 Hàng mới về
                            <span class="sub">Cập nhật liên tục</span>
                        </div>
                        <a href="${pageContext.request.contextPath}/products?sort=new" class="sec-more">Xem tất cả →</a>
                    </div>
                    <c:choose>
                        <c:when test="${not empty newProducts}">
                            <div class="pgrid pgrid-4">
                                <c:forEach var="p" items="${newProducts}">
                                    <div class="pcard" onclick="location.href = '${pageContext.request.contextPath}/productdetail?id=${p.id}'">
                                        <c:if test="${p.discount > 0}">
                                            <div class="pc-discount">
                                                -<fmt:formatNumber value="${p.discount}" maxFractionDigits="0"/>%
                                            </div>
                                        </c:if>
                                        <div class="pc-tag" style="background:#2563eb">Mới</div>
                                        <div class="pc-img-wrap">
                                            <c:choose>
                                                <c:when test="${not empty p.image}">
<!--                                                    <img src="https://source.unsplash.com/400x400/?${p.name}"
                                                         alt="${p.name}"
                                                         class="pc-img">-->
                                                    <img 
src="https://picsum.photos/400/400?random=${p.id}" 
alt="${p.name}" 
class="pc-img">
                                                </c:when>
                                                <c:otherwise><div class="pc-img-ph">📦</div></c:otherwise>
                                            </c:choose>
                                        </div>
                                        <div class="pc-brand">${p.brandName}</div>
                                        <div class="pc-name">${p.name}</div>
                                        <div class="pc-price">
                                            <fmt:formatNumber value="${p.salePrice}" pattern="#,###"/>đ
                                        </div>
                                        <c:if test="${p.discount > 0}">
                                            <div class="pc-old"><fmt:formatNumber value="${p.price}" pattern="#,###"/>đ</div>
                                        </c:if>
                                        <c:if test="${p.warranty > 0}">
                                            <div class="pc-warranty">✓ Bảo hành ${p.warranty} tháng</div>
                                        </c:if>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="empty-state"><div class="ico">📦</div><p>Chưa có sản phẩm nào</p></div>
                        </c:otherwise>
                    </c:choose>
                </div>

                <%-- ══ 7. BÁN CHẠY NHẤT ════════════════════════════════════════════ --%>
                <div class="section">
                    <div class="sec-hd">
                        <div class="sec-title">
                            📈 Bán chạy nhất
                            <span class="sub">Được tin dùng nhiều nhất</span>
                        </div>
                        <a href="${pageContext.request.contextPath}/products?sort=sold" class="sec-more">Xem tất cả →</a>
                    </div>
                    <c:choose>
                        <c:when test="${not empty bestSellerProducts}">
                            <div class="pgrid pgrid-4">
                                <c:forEach var="p" items="${bestSellerProducts}">
                                    <div class="pcard" onclick="location.href = '${pageContext.request.contextPath}/productdetail?id=${p.id}'">
                                        <c:if test="${p.discount > 0}">
                                            <div class="pc-discount">
                                                -<fmt:formatNumber value="${p.discount}" maxFractionDigits="0"/>%
                                            </div>
                                        </c:if>
                                        <div class="pc-tag" style="background:#f97316">Hot</div>
                                        <div class="pc-img-wrap">
                                            <c:choose>
                                                <c:when test="${not empty p.image}">
                                                    <img src="https://source.unsplash.com/400x400/?${p.name}"
                                                         alt="${p.name}"
                                                         class="pc-img">
                                                </c:when>
                                                <c:otherwise><div class="pc-img-ph">📦</div></c:otherwise>
                                            </c:choose>
                                        </div>
                                        <div class="pc-brand">${p.brandName}</div>
                                        <div class="pc-name">${p.name}</div>
                                        <div class="pc-price">
                                            <fmt:formatNumber value="${p.salePrice}" pattern="#,###"/>đ
                                        </div>
                                        <c:if test="${p.discount > 0}">
                                            <div class="pc-old"><fmt:formatNumber value="${p.price}" pattern="#,###"/>đ</div>
                                        </c:if>
                                        <c:if test="${p.warranty > 0}">
                                            <div class="pc-warranty">✓ Bảo hành ${p.warranty} tháng</div>
                                        </c:if>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="empty-state"><div class="ico">📊</div><p>Chưa có dữ liệu bán hàng</p></div>
                        </c:otherwise>
                    </c:choose>
                </div>

            </div><%-- end cnt --%>
        </main>

        <%-- FOOTER --%>
        <jsp:include page="/footer.jsp"/>

        <script>
            /* ── Banner slider ──────────────────────────────────────────────── */
            (function () {
                var ctx = '${pageContext.request.contextPath}';
                var slides = [
                    {bg: 'linear-gradient(135deg,#0f0c29,#302b63,#24243e)',
                        badge: 'MỚI NHẤT', title: 'iPhone 16 Pro Max',
                        sub: 'Chip A18 Pro · Camera 48MP · Titanium cao cấp',
                        price: '34.990.000đ', emoji: '📱', link: ctx + '/products?categoryId=1'},
                    {bg: 'linear-gradient(135deg,#0a0a0a,#1a1a2e,#16213e)',
                        badge: 'HOT DEAL', title: 'Samsung Galaxy S25 Ultra',
                        sub: 'AI Camera 200MP · S-Pen · Snapdragon 8 Elite',
                        price: '31.990.000đ', emoji: '📱', link: ctx + '/products?categoryId=1'},
                    {bg: 'linear-gradient(135deg,#003d6b,#005fa3,#0077cc)',
                        badge: 'GIẢM 15%', title: 'Laptop Dell XPS 15',
                        sub: 'Intel Core i9 · RTX 4060 · Màn hình OLED 3.5K',
                        price: '42.990.000đ', emoji: '💻', link: ctx + '/products?categoryId=2'},
                    {bg: 'linear-gradient(135deg,#1a0533,#3b0d6e,#6b21a8)',
                        badge: 'CHÍNH HÃNG', title: 'MacBook Air M3',
                        sub: 'Chip Apple M3 · Pin 18 giờ · Nhẹ chỉ 1.24kg',
                        price: '28.990.000đ', emoji: '💻', link: ctx + '/products?categoryId=2'}
                ];
                var cur = 0;
                var wrap = document.getElementById('heroBanner');
                var badge = document.getElementById('hBadge');
                var title = document.getElementById('hTitle');
                var sub = document.getElementById('hSub');
                var price = document.getElementById('hPrice');
                var emoji = document.getElementById('hEmoji');
                var link = document.getElementById('hLink');
                var dots = document.getElementById('hDots');

                slides.forEach(function (_, i) {
                    var d = document.createElement('div');
                    d.className = 'hero-dot' + (i === 0 ? ' on' : '');
                    d.onclick = function () {
                        go(i);
                    };
                    dots.appendChild(d);
                });

                function go(i) {
                    cur = i;
                    var s = slides[i];
                    wrap.style.background = s.bg;
                    badge.textContent = s.badge;
                    title.textContent = s.title;
                    sub.textContent = s.sub;
                    price.textContent = s.price;
                    //emoji.textContent = s.emoji;
                    link.href = s.link;
                    dots.querySelectorAll('.hero-dot').forEach(function (d, j) {
                        d.className = 'hero-dot' + (j === i ? ' on' : '');
                    });
                }
                go(0);
                var timer = setInterval(function () {
                    go((cur + 1) % slides.length);
                }, 4200);
                wrap.addEventListener('mouseenter', function () {
                    clearInterval(timer);
                });
                wrap.addEventListener('mouseleave', function () {
                    timer = setInterval(function () {
                        go((cur + 1) % slides.length);
                    }, 4200);
                });
            })();

            /* ── Countdown ─────────────────────────────────────────────────── */
            (function () {
                var end = Date.now() + 5 * 3600000;
                function tick() {
                    var d = Math.max(0, end - Date.now());
                    document.getElementById('cdH').textContent = String(Math.floor(d / 3600000) % 24).padStart(2, '0');
                    document.getElementById('cdM').textContent = String(Math.floor(d / 60000) % 60).padStart(2, '0');
                    document.getElementById('cdS').textContent = String(Math.floor(d / 1000) % 60).padStart(2, '0');
                }
                tick();
                setInterval(tick, 1000);
            })();
        </script>
    </body>
</html>