<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Verify OTP | Online Exam Portal</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
</head>
<body>

<div class="auth-wrapper">
  <div class="auth-card">

    <div class="auth-logo"><i class="bi bi-shield-lock-fill"></i></div>
    <h3 class="auth-title">Verify OTP</h3>
    <p class="auth-sub">Enter the 6-digit OTP sent to <b>${email}</b></p>

    <c:if test="${not empty otpSentMsg}">
      <p class="text-success text-center">${otpSentMsg}</p>
    </c:if>
    <c:if test="${not empty otpErrorMsg}">
      <p class="text-danger text-center">${otpErrorMsg}</p>
    </c:if>

    <form action="${pageContext.request.contextPath}/verifyOtp" method="post">
      <input type="hidden" name="email" value="${email}">

      <div class="mb-4">
        <label class="form-label">OTP</label>
        <input type="text" name="otp" maxlength="6" pattern="[0-9]{6}" class="form-control otp-input" placeholder="------" required autofocus>
      </div>

      <button type="submit" class="btn btn-primary w-100 py-2">
        <i class="bi bi-check2-circle me-1"></i> Verify OTP
      </button>
    </form>

    <div class="auth-links">
      Didn't get the code?
      <form action="${pageContext.request.contextPath}/forgotPassword" method="post" style="display:inline;">
        <input type="hidden" name="email" value="${email}">
        <button type="submit" class="btn btn-link p-0" style="font-weight:600; text-decoration:none;">Resend OTP</button>
      </form>
    </div>
    <div class="auth-links mt-1">
      <a href="${pageContext.request.contextPath}/login"><i class="bi bi-arrow-left"></i> Back to Login</a>
    </div>

  </div>
</div>

</body>
</html>
