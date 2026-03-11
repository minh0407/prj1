<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quên mật khẩu – HomeElectro</title>
    <style>
        *{box-sizing:border-box;margin:0;padding:0}
        body{min-height:100vh;background:#fff;font-family:'Segoe UI',system-ui,sans-serif;display:flex;flex-direction:column;align-items:center;justify-content:center;padding:40px 16px}
        .wrap{width:400px;max-width:96vw;display:flex;flex-direction:column;align-items:center;text-align:center}
        h1{font-size:26px;font-weight:800;color:#d0021b;margin:14px 0 8px}
        .sub{font-size:14px;color:#555;line-height:1.7;margin-bottom:28px}
        label{display:block;font-size:14px;color:#333;font-weight:500;margin-bottom:6px;text-align:left}
        input[type=text],input[type=password],input[type=tel]{width:100%;padding:11px 14px;font-size:14px;border:1px solid #d1d5db;border-radius:6px;outline:none;font-family:inherit;color:#111;background:#fff;transition:border-color .2s}
        input:focus{border-color:#aaa}
        .iw{position:relative}
        .iw input{padding-right:42px}
        .eye{position:absolute;right:12px;top:50%;transform:translateY(-50%);background:none;border:none;cursor:pointer;color:#9ca3af;display:flex;align-items:center;padding:0}
        .field{margin-bottom:16px;text-align:left;width:100%}
        .btns{display:flex;gap:14px;width:100%;margin-top:4px}
        .btn-ghost{flex:1;padding:12px;border-radius:6px;background:#fff;color:#333;border:1.5px solid #d1d5db;font-size:15px;font-weight:600;cursor:pointer;font-family:inherit}
        .btn-ghost:hover{background:#f5f5f5}
        .btn-red{flex:1;padding:12px;border-radius:6px;background:#d0021b;color:#fff;border:none;font-size:15px;font-weight:700;cursor:pointer;font-family:inherit}
        .btn-red:hover{background:#a80115}
        /* OTP */
        .otp-boxes{display:flex;gap:14px;margin-bottom:28px}
        .otp-box{width:52px;height:52px;text-align:center;font-size:22px;font-weight:700;color:#111;border:1.5px solid #d1d5db;border-radius:8px;outline:none;font-family:inherit}
        .otp-box:focus{border-color:#d0021b;box-shadow:0 0 0 3px rgba(208,2,27,.12)}
        .otp-box.filled{border-color:#d0021b;box-shadow:0 0 0 3px rgba(208,2,27,.12)}
        /* Resend */
        .resend-section{text-align:center;margin-top:4px}
        .resend-section .rtitle{font-size:14px;font-weight:600;color:#333;margin-bottom:2px}
        .resend-section .rsub{font-size:12px;color:#888;margin-bottom:12px}
        .radio-row{display:flex;justify-content:center;gap:24px;margin-bottom:14px}
        .radio-row label{font-size:14px;color:#333;cursor:pointer;display:flex;align-items:center;gap:6px;margin:0;font-weight:400}
        .radio-row input[type=radio]{width:16px;height:16px;accent-color:#2563eb;cursor:pointer}
        .btn-resend{padding:8px 24px;border-radius:6px;border:1px solid #d1d5db;background:#f5f5f5;color:#aaa;font-size:13px;font-family:inherit;cursor:default}
        .btn-resend.active{background:#fff;color:#333;cursor:pointer}
        /* Strength */
        .sbar{margin-top:6px}
        .sbar-tracks{display:flex;gap:3px;margin-bottom:3px}
        .sbar-track{flex:1;height:3px;border-radius:2px;background:#e5e7eb;transition:background .3s}
        .sbar-label{font-size:11px;font-weight:600;text-align:left}
        /* Alert */
        .alert{border-radius:6px;padding:9px 13px;margin-bottom:16px;font-size:13px;line-height:1.5;width:100%;text-align:left}
        .alert-e{background:#fef2f2;border:1px solid #fecaca;color:#dc2626}
        .alert-s{background:#f0fdf4;border:1px solid #bbf7d0;color:#16a34a}
        /* Stepper */
        .stepper{display:flex;align-items:center;gap:6px;margin-bottom:24px}
        .step-dot{width:22px;height:22px;border-radius:50%;font-size:11px;font-weight:700;display:flex;align-items:center;justify-content:center;flex-shrink:0}
        .step-dot.active{background:#d0021b;color:#fff}
        .step-dot.done{background:#22c55e;color:#fff}
        .step-dot.inactive{background:#e5e7eb;color:#9ca3af}
        .step-label{font-size:12px;white-space:nowrap}
        .step-label.active{color:#111;font-weight:600}
        .step-label.inactive{color:#9ca3af}
        .step-line{width:20px;height:1px;background:#e5e7eb;flex-shrink:0}
    </style>
</head>
<body>

<%
    String step = request.getParameter("step");
    if(step == null) step = "1";
    String phoneVal = request.getParameter("phoneVal");
    if(phoneVal == null) phoneVal = "";
%>

<div class="wrap">
    <!-- Mascot -->
    <svg width="90" height="108" viewBox="0 0 90 108" fill="none">
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

    <h1>Tạo mật khẩu mới</h1>

    <%-- STEP 1: Nhập SĐT --%>
    <% if("1".equals(step)){ %>
    <p class="sub">Hãy nhập số điện thoại của bạn vào bên dưới để bắt đầu<br>quá trình khôi phục mật khẩu.</p>
    <% if(request.getAttribute("error")!=null){ %><div class="alert alert-e">${error}</div><% } %>
    <form action="forgot" method="post" style="width:100%">
        <input type="hidden" name="step" value="1">
        <div class="field">
            <label>Số điện thoại</label>
            <input type="tel" name="phone" placeholder="Nhập số điện thoại" required>
        </div>
        <div class="btns">
            <button type="button" class="btn-ghost" onclick="location.href='login'">‹ Quay lại đăng nhập</button>
            <button type="submit" class="btn-red">Tiếp tục</button>
        </div>
    </form>
    <% } %>

    <%-- STEP 2: Nhập OTP --%>
    <% if("2".equals(step)){ %>
    <p class="sub">Vui lòng nhập OTP vừa được gửi qua <b>SMS</b><br>đến số điện thoại <b style="color:#111"><%=phoneVal%></b></p>
    <% if(request.getAttribute("error")!=null){ %><div class="alert alert-e">${error}</div><% } %>
    <form action="forgot" method="post" style="width:100%">
        <input type="hidden" name="step" value="2">
        <input type="hidden" name="phoneVal" value="<%=phoneVal%>">
        <div class="otp-boxes">
            <input type="text" name="otp1" class="otp-box" maxlength="1" inputmode="numeric" oninput="otpNext(this,1)" required>
            <input type="text" name="otp2" class="otp-box" maxlength="1" inputmode="numeric" oninput="otpNext(this,2)" required>
            <input type="text" name="otp3" class="otp-box" maxlength="1" inputmode="numeric" oninput="otpNext(this,3)" required>
            <input type="text" name="otp4" class="otp-box" maxlength="1" inputmode="numeric" oninput="otpNext(this,4)" required>
        </div>
        <div class="btns" style="margin-bottom:24px">
            <button type="button" class="btn-ghost" onclick="location.href='forgot'">‹ Quay lại</button>
            <button type="submit" class="btn-red">Xác nhận</button>
        </div>
    </form>
    <div class="resend-section">
        <div class="rtitle">Hoặc gửi lại OTP qua:</div>
        <div class="rsub">(Mã OTP có thời hạn 3 phút)</div>
        <div class="radio-row">
            <label><input type="radio" name="otpM" value="sms" checked> Sms</label>
            <label><input type="radio" name="otpM" value="zalo"> Zalo</label>
            <label><input type="radio" name="otpM" value="app"> App HMEMBER</label>
        </div>
        <button id="resendBtn" class="btn-resend" disabled onclick="resend()">Nhận mã sau <span id="countdown">25</span>s</button>
    </div>
    <script>
    let t=25;
    const timer=setInterval(()=>{t--;document.getElementById('countdown').textContent=t;if(t<=0){clearInterval(timer);const b=document.getElementById('resendBtn');b.disabled=false;b.className='btn-resend active';b.textContent='Gửi lại mã';}},1000);
    function resend(){alert('Đã gửi lại mã OTP!');}
    </script>
    <% } %>

    <%-- STEP 3: Nhập mật khẩu mới --%>
    <% if("3".equals(step)){ %>
    <p class="sub">Nhập mật khẩu mới cho số <b style="color:#111"><%=phoneVal%></b></p>
    <% if(request.getAttribute("error")!=null){ %><div class="alert alert-e">${error}</div><% } %>
    <% if(request.getAttribute("message")!=null){ %><div class="alert alert-s">${message}</div><% } %>
    <form action="forgot" method="post" style="width:100%">
        <input type="hidden" name="step" value="3">
        <input type="hidden" name="phoneVal" value="<%=phoneVal%>">
        <div class="field">
            <label>Mật khẩu mới</label>
            <div class="iw">
                <input type="password" name="newPassword" id="p1" placeholder="Tối thiểu 6 ký tự" required oninput="checkStrength(this.value)">
                <button type="button" class="eye" onclick="togglePwd('p1','ep1')">
                    <svg id="ep1" width="17" height="17" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/><circle cx="12" cy="12" r="3"/></svg>
                </button>
            </div>
            <div class="sbar"><div class="sbar-tracks"><div class="sbar-track" id="s1"></div><div class="sbar-track" id="s2"></div><div class="sbar-track" id="s3"></div><div class="sbar-track" id="s4"></div><div class="sbar-track" id="s5"></div></div><div class="sbar-label" id="slb"></div></div>
        </div>
        <div class="field">
            <label>Xác nhận mật khẩu</label>
            <div class="iw">
                <input type="password" name="confirmPassword" id="p2" placeholder="Nhập lại mật khẩu" required>
                <button type="button" class="eye" onclick="togglePwd('p2','ep2')">
                    <svg id="ep2" width="17" height="17" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/><circle cx="12" cy="12" r="3"/></svg>
                </button>
            </div>
        </div>
        <div class="btns">
            <button type="button" class="btn-ghost" onclick="history.back()">‹ Quay lại</button>
            <button type="submit" class="btn-red">Xác nhận</button>
        </div>
    </form>
    <% } %>
</div>

<script>
function togglePwd(id,eid){
    const i=document.getElementById(id),e=document.getElementById(eid);
    if(i.type==='password'){i.type='text';e.innerHTML='<path d="M17.94 17.94A10.07 10.07 0 0112 20c-7 0-11-8-11-8a18.45 18.45 0 015.06-5.94M9.9 4.24A9.12 9.12 0 0112 4c7 0 11 8 11 8a18.5 18.5 0 01-2.16 3.19m-6.72-1.07a3 3 0 11-4.24-4.24"/><line x1="1" y1="1" x2="23" y2="23"/>';}
    else{i.type='password';e.innerHTML='<path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/><circle cx="12" cy="12" r="3"/>';}
}
function otpNext(el,idx){
    el.value=el.value.replace(/\D/g,'');
    el.classList.toggle('filled',el.value!=='');
    if(el.value&&idx<4)document.querySelectorAll('.otp-box')[idx].focus();
}
function checkStrength(pwd){
    let s=0;
    if(pwd.length>=6)s++;if(pwd.length>=10)s++;
    if(/[A-Z]/.test(pwd))s++;if(/[0-9]/.test(pwd))s++;if(/[^A-Za-z0-9]/.test(pwd))s++;
    const lvls=[{c:'#ef4444',l:'Rất yếu'},{c:'#f97316',l:'Yếu'},{c:'#eab308',l:'Trung bình'},{c:'#22c55e',l:'Mạnh'},{c:'#10b981',l:'Rất mạnh'}];
    const lvl=s>0?lvls[Math.min(s-1,4)]:null;
    for(let i=1;i<=5;i++){document.getElementById('s'+i).style.background=i<=s&&lvl?lvl.c:'#e5e7eb';}
    const lb=document.getElementById('slb');if(lb){lb.textContent=lvl?lvl.l:'';if(lvl)lb.style.color=lvl.c;}
}
</script>
</body>
</html>
