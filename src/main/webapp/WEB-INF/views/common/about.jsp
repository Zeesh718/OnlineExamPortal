<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>About | Online Exam Portal</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
</head>
<body>

<nav class="navbar navbar-dark" style="background:linear-gradient(135deg,#4361ee,#3a0ca3);">
  <div class="container">
    <a class="navbar-brand" href="${pageContext.request.contextPath}/"><i class="bi bi-mortarboard-fill me-2"></i>Online Exam Portal</a>
    <a class="btn btn-light btn-sm" href="${pageContext.request.contextPath}/"><i class="bi bi-arrow-left"></i> Back to Home</a>
  </div>
</nav>

<div class="container py-5">
  <div class="card p-4 p-md-5">
    <h2 class="section-heading">About Online Exam Portal</h2>
    <p class="text-muted">
      Online Exam Portal is a web-based examination platform built with Spring MVC, Hibernate and MySQL.
      It lets students register, log in securely and attempt timed exams in a full-screen,
      distraction-free environment, while administrators manage subjects, questions, exams and
      student accounts from a single dashboard.
    </p>

    <div class="row g-4 mt-3">
      <div class="col-md-4">
        <div class="feature-icon"><i class="bi bi-mortarboard-fill"></i></div>
        <h6 class="mt-2">For Students</h6>
        <p class="text-muted small mb-0">Register, attempt exams, and download PDF result reports instantly.</p>
      </div>
      <div class="col-md-4">
        <div class="feature-icon"><i class="bi bi-speedometer2"></i></div>
        <h6 class="mt-2">For Admins</h6>
        <p class="text-muted small mb-0">Full control over students, subjects, questions and exams.</p>
      </div>
      <div class="col-md-4">
        <div class="feature-icon"><i class="bi bi-shield-check"></i></div>
        <h6 class="mt-2">Secure by Design</h6>
        <p class="text-muted small mb-0">BCrypt-encrypted passwords and email-OTP based password recovery.</p>
      </div>
    </div>
  </div>
</div>

<footer class="site-footer">
  <div class="container text-center">&copy; 2026 Online Exam Portal. All rights reserved.</div>
</footer>

</body>
</html>
