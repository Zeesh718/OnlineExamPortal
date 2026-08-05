<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Reset Password | Online Exam Portal</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
</head>
<body>

<div class="auth-wrapper">
  <div class="auth-card">

    <div class="auth-logo"><i class="bi bi-lock-fill"></i></div>
    <h3 class="auth-title">Set a New Password</h3>
    <p class="auth-sub">for <b>${email}</b></p>

    <c:if test="${not empty resetErrorMsg}">
      <p class="text-danger text-center">${resetErrorMsg}</p>
    </c:if>

    <form action="${pageContext.request.contextPath}/resetPassword" method="post">
      <input type="hidden" name="email" value="${email}">

      <div class="mb-3">
        <label class="form-label">New Password</label>
        <input type="password" name="password" class="form-control" placeholder="Min 6 characters" required minlength="6">
      </div>

      <div class="mb-4">
        <label class="form-label">Confirm New Password</label>
        <input type="password" name="confirmPassword" class="form-control" placeholder="Re-enter new password" required minlength="6">
      </div>

      <button type="submit" class="btn btn-primary w-100 py-2">
        <i class="bi bi-check-circle-fill me-1"></i> Reset Password
      </button>
    </form>

    <div class="auth-links">
      <a href="${pageContext.request.contextPath}/login"><i class="bi bi-arrow-left"></i> Back to Login</a>
    </div>

  </div>
</div>

</body>
</html>
