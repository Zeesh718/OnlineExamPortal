<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Forgot Password | Online Exam Portal</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
</head>
<body>

<div class="auth-wrapper">
  <div class="auth-card">

    <div class="auth-logo"><i class="bi bi-key-fill"></i></div>
    <h3 class="auth-title">Forgot Password?</h3>
    <p class="auth-sub">Enter your registered email. We'll send you an OTP to reset your password.</p>

    <c:if test="${not empty emailNotFoundMsg}">
      <p class="text-danger text-center">${emailNotFoundMsg}</p>
    </c:if>

    <form action="${pageContext.request.contextPath}/forgotPassword" method="post">
      <div class="mb-4">
        <label class="form-label">Email Address</label>
        <input type="email" name="email" class="form-control" placeholder="you@example.com" required autofocus>
      </div>

      <button type="submit" class="btn btn-primary w-100 py-2">
        <i class="bi bi-send-fill me-1"></i> Send OTP
      </button>
    </form>

    <div class="auth-links">
      <a href="${pageContext.request.contextPath}/login"><i class="bi bi-arrow-left"></i> Back to Login</a>
    </div>

  </div>
</div>

</body>
</html>
