<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Register | Online Exam Portal</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">

</head>

<body>

<div class="auth-wrapper">
  <div class="auth-card" style="max-width:480px;">

    <div class="auth-logo"><i class="bi bi-person-plus-fill"></i></div>
    <h3 class="auth-title">Create Your Account</h3>
    <p class="auth-sub">Register to start attempting exams</p>

    <form:form action="register" method="post" modelAttribute="user">

      <div class="mb-3">
        <label class="form-label">Full Name</label>
        <form:input path="name" class="form-control" placeholder="Enter your full name"/>
        <form:errors path="name" cssClass="text-danger small"/>
      </div>

      <div class="mb-3">
        <label class="form-label">Email Address</label>
        <form:input path="email" class="form-control" placeholder="Enter your email"/>
        <span class="text-danger small">${emailError}</span>
        <form:errors path="email" cssClass="text-danger small"/>
      </div>

      <div class="mb-3">
        <label class="form-label">Password</label>
        <form:password path="password" class="form-control" placeholder="Create a password (min 6 characters)"/>
        <form:errors path="password" cssClass="text-danger small"/>
      </div>

      <div class="mb-4">
        <label class="form-label">Mobile Number</label>
        <form:input path="mobile" class="form-control" placeholder="Enter your 10-digit mobile number"/>
        <form:errors path="mobile" cssClass="text-danger small"/>
      </div>

      <button type="submit" class="btn btn-primary w-100 py-2">
        <i class="bi bi-check-circle-fill me-1"></i> Register
      </button>

      <div class="auth-links">
        Already have an account? <a href="login">Login</a>
      </div>

    </form:form>

  </div>
</div>

</body>
</html>
