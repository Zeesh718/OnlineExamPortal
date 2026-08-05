<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Login | Online Exam Portal</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">

</head>

<body>

<div class="auth-wrapper">
  <div class="auth-card">

    <div class="auth-logo"><i class="bi bi-mortarboard-fill"></i></div>
    <h3 class="auth-title">Welcome Back</h3>
    <p class="auth-sub">Login to continue to Online Exam Portal</p>

    <form action="login" method="post">

      <div class="mb-3">
        <label class="form-label">Student ID / Email</label>
        <input type="text" name="loginId" class="form-control" placeholder="e.g. STD202600001" required autofocus>
      </div>

      <div class="mb-2">
        <label class="form-label">Password</label>
        <input type="password" name="password" class="form-control" placeholder="Enter your password" required>
      </div>

      <div class="text-end mb-3">
        <a href="${pageContext.request.contextPath}/forgotPassword" style="font-size:13px; color:var(--brand-primary); text-decoration:none; font-weight:600;">
          Forgot Password?
        </a>
      </div>

      <c:if test="${not empty inValidMsg}">
        <p class="text-danger text-center">${inValidMsg}</p>
      </c:if>
      <c:if test="${not empty inActiveMsg}">
        <p class="text-danger text-center">${inActiveMsg}</p>
      </c:if>
      <c:if test="${not empty logOutMsg}">
        <p class="text-success text-center">${logOutMsg}</p>
      </c:if>
      <c:if test="${not empty registerMsg}">
        <p class="text-success text-center">${registerMsg}</p>
      </c:if>
      <c:if test="${not empty generatedStudentId}">
        <div class="text-center mb-3" style="background:#f4f6fb;border-radius:8px;padding:10px;">
          Your Student ID: <b style="color:var(--brand-primary);font-size:16px;">${generatedStudentId}</b>
        </div>
      </c:if>

      <button type="submit" class="btn btn-primary w-100 py-2 mt-2">
        <i class="bi bi-box-arrow-in-right me-1"></i> Login
      </button>

    </form>

    <div class="auth-links">
      New here? <a href="${pageContext.request.contextPath}/register">Create an account</a>
    </div>
    <div class="auth-links mt-1">
      <a href="${pageContext.request.contextPath}/"><i class="bi bi-arrow-left"></i> Back to Home</a>
    </div>

  </div>
</div>

</body>
</html>
