<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Online Exam Portal | Smart Online Examination System</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">

</head>
<body>

<!-- ================= NAVBAR ================= -->
<nav class="navbar navbar-expand-lg navbar-dark fixed-top" style="background:rgba(30,20,70,.55); backdrop-filter:blur(8px);">
  <div class="container">
    <a class="navbar-brand" href="${pageContext.request.contextPath}/"><i class="bi bi-mortarboard-fill me-2"></i>Online Exam Portal</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navMain">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse justify-content-end" id="navMain">
      <ul class="navbar-nav align-items-lg-center gap-lg-2">
        <li class="nav-item"><a class="nav-link" href="#features">Features</a></li>
        <li class="nav-item"><a class="nav-link" href="#how">How it works</a></li>
        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/about">About</a></li>
        <li class="nav-item"><a class="btn btn-outline-light btn-sm ms-lg-2" href="${pageContext.request.contextPath}/login">Login</a></li>
        <li class="nav-item"><a class="btn btn-light btn-sm ms-lg-2" href="${pageContext.request.contextPath}/register">Register</a></li>
      </ul>
    </div>
  </div>
</nav>

<!-- ================= HERO ================= -->
<section class="hero-section">
  <div class="container">
    <div class="row align-items-center g-5">
      <div class="col-lg-6">
        <span class="badge rounded-pill" style="background:rgba(255,255,255,.15); padding:8px 16px;">🎓 Built for Students &amp; Institutions</span>
        <h1 class="hero-title mt-3">Take exams online. <br>Get results instantly.</h1>
        <p class="hero-sub mt-3">
          A complete online examination platform — students register, attempt timed exams
          in a distraction-free full-screen mode, and get instant, downloadable results.
          Admins manage subjects, questions and exams from one clean dashboard.
        </p>
        <div class="mt-4 d-flex gap-3 flex-wrap">
          <a href="${pageContext.request.contextPath}/register" class="btn btn-light btn-lg px-4">
            <i class="bi bi-person-plus-fill me-1"></i> Get Started Free
          </a>
          <a href="${pageContext.request.contextPath}/login" class="btn btn-outline-light btn-lg px-4">
            <i class="bi bi-box-arrow-in-right me-1"></i> Login
          </a>
        </div>

        <div class="row mt-5 g-3">
          <div class="col-4 stat-box">
            <div class="num">100%</div>
            <div class="label">Online &amp; Secure</div>
          </div>
          <div class="col-4 stat-box">
            <div class="num">Instant</div>
            <div class="label">Result Generation</div>
          </div>
          <div class="col-4 stat-box">
            <div class="num">PDF</div>
            <div class="label">Downloadable Reports</div>
          </div>
        </div>
      </div>

      <div class="col-lg-6 d-none d-lg-block text-center">
        <div style="background:rgba(255,255,255,.08); border:1px solid rgba(255,255,255,.18); border-radius:20px; padding:30px;">
          <i class="bi bi-laptop" style="font-size:180px; color:rgba(255,255,255,.85);"></i>
        </div>
      </div>
    </div>
  </div>
</section>

<!-- ================= FEATURES ================= -->
<section id="features" class="py-5" style="margin-top:-40px;">
  <div class="container py-5">
    <h2 class="section-heading text-center">Everything you need to run exams online</h2>
    <p class="section-sub text-center">A simple but complete workflow for both students and administrators.</p>

    <div class="row g-4">
      <div class="col-md-4">
        <div class="feature-card">
          <div class="feature-icon"><i class="bi bi-person-check-fill"></i></div>
          <h5>Easy Registration &amp; Login</h5>
          <p class="text-muted mb-0">Quick sign-up with instant welcome email, and secure BCrypt-encrypted password storage.</p>
        </div>
      </div>
      <div class="col-md-4">
        <div class="feature-card">
          <div class="feature-icon"><i class="bi bi-shield-lock-fill"></i></div>
          <h5>Forgot Password? No Problem</h5>
          <p class="text-muted mb-0">Email OTP based password reset — verify your identity in seconds and set a new password.</p>
        </div>
      </div>
      <div class="col-md-4">
        <div class="feature-card">
          <div class="feature-icon"><i class="bi bi-arrows-fullscreen"></i></div>
          <h5>Distraction-free Exams</h5>
          <p class="text-muted mb-0">Exams open in full-screen mode with a live countdown timer and auto-submit on time up.</p>
        </div>
      </div>
      <div class="col-md-4">
        <div class="feature-card">
          <div class="feature-icon"><i class="bi bi-speedometer2"></i></div>
          <h5>Admin Control Panel</h5>
          <p class="text-muted mb-0">Manage students, subjects, questions and exams — activate, deactivate or remove anything in one click.</p>
        </div>
      </div>
      <div class="col-md-4">
        <div class="feature-card">
          <div class="feature-icon"><i class="bi bi-file-earmark-pdf-fill"></i></div>
          <h5>Downloadable PDF Results</h5>
          <p class="text-muted mb-0">Every result can be downloaded as a clean PDF report with a full score breakdown.</p>
        </div>
      </div>
      <div class="col-md-4">
        <div class="feature-card">
          <div class="feature-icon"><i class="bi bi-lightning-charge-fill"></i></div>
          <h5>Fast &amp; Responsive</h5>
          <p class="text-muted mb-0">AJAX-powered actions mean no clunky full-page reloads for common admin tasks.</p>
        </div>
      </div>
    </div>
  </div>
</section>

<!-- ================= HOW IT WORKS ================= -->
<section id="how" class="py-5" style="background:#fff;">
  <div class="container py-4">
    <h2 class="section-heading text-center">How it works</h2>
    <p class="section-sub text-center">Three simple steps to your result.</p>
    <div class="row g-4 text-center">
      <div class="col-md-4">
        <div class="feature-icon mx-auto" style="background:linear-gradient(135deg,#4361ee,#3a0ca3);">1</div>
        <h5 class="mt-3">Register &amp; Login</h5>
        <p class="text-muted">Create your account in seconds and receive a welcome email.</p>
      </div>
      <div class="col-md-4">
        <div class="feature-icon mx-auto" style="background:linear-gradient(135deg,#4361ee,#3a0ca3);">2</div>
        <h5 class="mt-3">Attempt the Exam</h5>
        <p class="text-muted">Pick an available exam and answer questions in full-screen mode within the time limit.</p>
      </div>
      <div class="col-md-4">
        <div class="feature-icon mx-auto" style="background:linear-gradient(135deg,#4361ee,#3a0ca3);">3</div>
        <h5 class="mt-3">Get Your Result</h5>
        <p class="text-muted">See your score instantly and download a PDF report anytime from "My Results".</p>
      </div>
    </div>
  </div>
</section>

<!-- ================= CTA ================= -->
<section class="py-5" style="background:linear-gradient(135deg,#4361ee,#3a0ca3); color:#fff;">
  <div class="container text-center py-4">
    <h2 class="fw-bold">Ready to get started?</h2>
    <p class="mb-4" style="color:#e6e9ff;">Join now and attempt your first exam in minutes.</p>
    <a href="${pageContext.request.contextPath}/register" class="btn btn-light btn-lg px-5">Create Free Account</a>
  </div>
</section>

<!-- ================= FOOTER ================= -->
<footer class="site-footer">
  <div class="container d-flex flex-wrap justify-content-between align-items-center">
    <div>&copy; 2026 Online Exam Portal. All rights reserved.</div>
    <div class="d-flex gap-3">
      <a href="${pageContext.request.contextPath}/about">About</a>
      <a href="${pageContext.request.contextPath}/login">Login</a>
      <a href="${pageContext.request.contextPath}/register">Register</a>
    </div>
  </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
