<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký – HomeElectro</title>
    <style>
        *{box-sizing:border-box;margin:0;padding:0}
        body{min-height:100vh;background:#f0f0f0;font-family:'Segoe UI',system-ui,sans-serif;display:flex;flex-direction:column;align-items:center;justify-content:flex-start;padding:24px 16px 60px}
        .card{background:#fff;border-radius:10px;box-shadow:0 2px 12px rgba(0,0,0,.1);overflow:hidden;width:760px;max-width:98vw}
        /* MASCOT HEADER */
        .mascot-header{background:#fff;border-bottom:1px solid #eee;padding:24px 20px 16px;display:flex;flex-direction:column;align-items:center;text-align:center}
        .mascot-header p{font-size:14px;color:#555;margin-top:8px}
        .mascot-header p b{color:#d0021b}
        /* FORM BODY */
        .fbody{padding:28px 60px 16px;max-width:760px;margin:0 auto;width:100%}
        .section-title{font-size:17px;font-weight:700;color:#111;margin-bottom:16px}
        .grid2{display:grid;grid-template-columns:1fr 1fr;gap:14px 24px;margin-bottom:20px}
        .span2{grid-column:1/-1}
        label{display:block;font-size:14px;color:#333;font-weight:500;margin-bottom:6px}
        .sublabel{font-size:12px;color:#888;font-weight:400}
        input[type=text],input[type=password],input[type=email],input[type=tel],input[type=date]{width:100%;padding:11px 14px;font-size:14px;border:1px solid #d1d5db;border-radius:6px;outline:none;font-family:inherit;color:#111;background:#fff;transition:border-color .2s}
        input:focus{border-color:#aaa}
        .iw{position:relative}
        .iw input{padding-right:42px}
        .eye{position:absolute;right:12px;top:50%;transform:translateY(-50%);background:none;border:none;cursor:pointer;color:#9ca3af;display:flex;align-items:center;padding:0}
        .hint{font-size:12px;color:#6b7280;margin-top:5px;display:flex;align-items:center;gap:4px}
        .hint.green{color:#16a34a}
        /* STRENGTH BAR */
        .sbar{margin-top:6px}
        .sbar-tracks{display:flex;gap:3px;margin-bottom:3px}
        .sbar-track{flex:1;height:3px;border-radius:2px;background:#e5e7eb;transition:background .3s}
        .sbar-label{font-size:11px;font-weight:600}
        /* DIVIDER */
        .divider{height:1px;background:#eee;margin:4px 0 20px}
        /* CHECKBOX */
        .check-row{display:flex;align-items:center;gap:10px;margin-top:20px;margin-bottom:10px}
        .check-row input{width:16px;height:16px;cursor:pointer;accent-color:#d0021b}
        .check-row label{font-size:14px;color:#333;cursor:pointer;margin:0}
        .terms{font-size:13px;color:#555;line-height:1.6}
        .terms a{color:#2563eb;font-weight:600;text-decoration:none}
        .terms a.red{color:#d0021b}
        /* ALERT */
        .alert{border-radius:6px;padding:9px 13px;margin-bottom:16px;font-size:13px;line-height:1.5}
        .alert-e{background:#fef2f2;border:1px solid #fecaca;color:#dc2626}
        .alert-s{background:#f0fdf4;border:1px solid #bbf7d0;color:#16a34a}
        /* BOTTOM BAR */
        .bottom-bar{border-top:1px dashed #e5e7eb;padding:14px 60px;display:flex;gap:16px;background:#fff;max-width:760px;width:100%;margin:0 auto}
        .btn-ghost{flex:1;padding:12px;border-radius:6px;background:#fff;color:#333;border:1.5px solid #d1d5db;font-size:15px;font-weight:600;cursor:pointer;font-family:inherit;transition:background .15s}
        .btn-ghost:hover{background:#f5f5f5}
        .btn-red{flex:1;padding:12px;border-radius:6px;background:#d0021b;color:#fff;border:none;font-size:15px;font-weight:700;cursor:pointer;font-family:inherit;transition:background .15s}
        .btn-red:hover{background:#a80115}
    </style>
</head>
<body>
<div class="card">
    <!-- Mascot Header -->
    <div class="mascot-header">
        <svg width="84" height="101" viewBox="0 0 90 108" fill="none">
            <rect x="20" y="48" width="50" height="42" rx="10" fill="#d0021b"/>
            <rect x="22" y="16" width="46" height="38" rx="12" fill="#d0021b"/>
            <rect x="28" y="26" width="34" height="22" rx="6" fill="#fff"/>
            <circle cx="37" cy="36" r="4" fill="#333"/><circle cx="53" cy="36" r="4" fill="#333"/>
            <circle cx="38.5" cy="34.5" r="1.5" fill="#fff"/><circle cx="54.5" cy="34.5" r="1.5" fill="#fff"/>
            <path d="M37 42 Q45 48 53 42" stroke="#333" stroke-width="1.5" stroke-linecap="round" fill="none"/>
            <line x1="45" y1="16" x2="45" y2="6" stroke="#d0021b" stroke-width="2.5" stroke-linecap="round"/>
            <circle cx="45" cy="4" r="4" fill="#d0021b"/><circle cx="45" cy="4" r="2" fill="#fff"/>
            <rect x="5" y="53" width="16" height="10" rx="5" fill="#d0021b"/>
            <rect x="69" y="53" width="16" height="10" rx="5" fill="#d0021b"/>
            <rect x="27" y="86" width="14" height="18" rx="6" fill="#d0021b"/>
            <rect x="49" y="86" width="14" height="18" rx="6" fill="#d0021b"/>
            <rect x="23" y="100" width="20" height="8" rx="4" fill="#222"/>
            <rect x="47" y="100" width="20" height="8" rx="4" fill="#222"/>
            <rect x="33" y="58" width="24" height="16" rx="4" fill="rgba(255,255,255,0.22)"/>
            <text x="45" y="70" text-anchor="middle" font-size="8" fill="#fff" font-weight="bold">H·E</text>
        </svg>
        <p>Hoàn tất đăng ký để trở thành thành viên <b>HMEMBER</b></p>
    </div>

    <!-- Form -->
    <form action="register" method="post" id="regForm">
        <div class="fbody">
            <% if(request.getAttribute("error")!=null){ %><div class="alert alert-e">${error}</div><% } %>

            <div class="section-title">Thông tin cá nhân</div>
            <div class="grid2">
                <div>
                    <label>Họ và tên</label>
                    <input type="text" name="fullname" placeholder="Nhập họ và tên" value="${param.fullname}">
                </div>
                <div>
                    <label>Ngày sinh</label>
                    <input type="date" name="dob" value="${param.dob}">
                </div>
                <div>
                    <label>Số điện thoại</label>
                    <input type="tel" name="phone" placeholder="Nhập số điện thoại" required value="${param.phone}">
                </div>
                <div>
                    <label>Email <span class="sublabel">(Không bắt buộc)</span></label>
                    <input type="email" name="email" placeholder="Nhập email" value="${param.email}">
                    <div class="hint green">✓ Hóa đơn VAT khi mua hàng sẽ được gửi qua email này</div>
                </div>
            </div>

            <div class="divider"></div>
            <div class="section-title">Tạo mật khẩu</div>
            <div class="grid2">
                <div class="span2">
                    <label>Tên đăng nhập</label>
                    <input type="text" name="username" placeholder="Tối thiểu 4 ký tự" required value="${param.username}">
                </div>
                <div>
                    <label>Mật khẩu</label>
                    <div class="iw">
                        <input type="password" name="password" id="pwd1" placeholder="Nhập mật khẩu của bạn" required oninput="checkStrength(this.value)">
                        <button type="button" class="eye" onclick="togglePwd('pwd1','e1')">
                            <svg id="e1" width="17" height="17" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/><circle cx="12" cy="12" r="3"/></svg>
                        </button>
                    </div>
                    <div class="hint">ℹ Mật khẩu tối thiểu 6 ký tự, có ít nhất 1 chữ và 1 số</div>
                    <div class="sbar">
                        <div class="sbar-tracks">
                            <div class="sbar-track" id="s1"></div><div class="sbar-track" id="s2"></div>
                            <div class="sbar-track" id="s3"></div><div class="sbar-track" id="s4"></div>
                            <div class="sbar-track" id="s5"></div>
                        </div>
                        <div class="sbar-label" id="slabel"></div>
                    </div>
                </div>
                <div>
                    <label>Nhập lại mật khẩu</label>
                    <div class="iw">
                        <input type="password" name="confirmPassword" id="pwd2" placeholder="Nhập lại mật khẩu của bạn" required>
                        <button type="button" class="eye" onclick="togglePwd('pwd2','e2')">
                            <svg id="e2" width="17" height="17" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/><circle cx="12" cy="12" r="3"/></svg>
                        </button>
                    </div>
                </div>
            </div>

            <div class="check-row">
                <input type="checkbox" id="news" name="newsletter">
                <label for="news">Đăng ký nhận tin khuyến mãi từ HomeElectro</label>
            </div>
            <div class="terms">
                Bằng việc Đăng ký, bạn đã đọc và đồng ý với
                <a href="#">Điều khoản sử dụng</a> và
                <a href="#" class="red">Chính sách bảo mật của HomeElectro</a>.
            </div>
        </div>

        <div class="bottom-bar">
            <button type="button" class="btn-ghost" onclick="location.href='login'">‹ Quay lại đăng nhập</button>
            <button type="submit" class="btn-red">Hoàn tất đăng ký</button>
        </div>
    </form>
</div>

<script>
function togglePwd(id,eid){
    const i=document.getElementById(id),e=document.getElementById(eid);
    if(i.type==='password'){i.type='text';e.innerHTML='<path d="M17.94 17.94A10.07 10.07 0 0112 20c-7 0-11-8-11-8a18.45 18.45 0 015.06-5.94M9.9 4.24A9.12 9.12 0 0112 4c7 0 11 8 11 8a18.5 18.5 0 01-2.16 3.19m-6.72-1.07a3 3 0 11-4.24-4.24"/><line x1="1" y1="1" x2="23" y2="23"/>';}
    else{i.type='password';e.innerHTML='<path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/><circle cx="12" cy="12" r="3"/>';}
}
function checkStrength(pwd){
    let s=0;
    if(pwd.length>=6)s++;if(pwd.length>=10)s++;
    if(/[A-Z]/.test(pwd))s++;if(/[0-9]/.test(pwd))s++;if(/[^A-Za-z0-9]/.test(pwd))s++;
    const lvls=[{c:'#ef4444',l:'Rất yếu'},{c:'#f97316',l:'Yếu'},{c:'#eab308',l:'Trung bình'},{c:'#22c55e',l:'Mạnh'},{c:'#10b981',l:'Rất mạnh'}];
    const lvl=s>0?lvls[Math.min(s-1,4)]:null;
    for(let i=1;i<=5;i++){document.getElementById('s'+i).style.background=i<=s&&lvl?lvl.c:'#e5e7eb';}
    document.getElementById('slabel').textContent=lvl?lvl.l:'';
    if(lvl)document.getElementById('slabel').style.color=lvl.c;
}
</script>
</body>
</html>
