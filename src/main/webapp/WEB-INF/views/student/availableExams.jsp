<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>Available Exams</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
rel="stylesheet">
<link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet">

</head>

<body class="bg-light">

<%@ include file="studentHeader.jsp"%>

<div class="container mt-4">

<div class="d-flex justify-content-between mb-3">

<h2>Available Exams</h2>

<c:if test="${not empty msg}">
<p style="color:red; text-align:center">${msg}</p>
</c:if>

</div>

<table class="table table-bordered table-striped shadow">

<thead class="table-dark">

<tr>

<th>ID</th>

<th>Exam Name</th>

<th>Subject</th>

<th>Duration</th>

<th>Total Marks</th>

<th>Date</th>

<th>Start Time</th>

<th>Status</th>

<th>Action</th>

</tr>

</thead>

<tbody>

<c:forEach items="${availableExamsList}" var="exam">

<tr>

<td>${exam.examId}</td>

<td>${exam.examName}</td>

<td>${exam.subject.subjectName}</td>

<td>${exam.duration}</td>

<td>${exam.totalMarks}</td>

<td>${exam.examDate}</td>

<td>${exam.startTime}</td>

<td>

<c:choose>

<c:when test="${exam.attemted}">

<span class="badge bg-success">

Attempted

</span>

</c:when>

<c:otherwise>

<span class="badge bg-danger">

Unattempted	

</span>

</c:otherwise>

</c:choose>

</td>

<td>


<a class="btn btn-primary btn-sm"


href="${pageContext.request.contextPath}/student/viewAvailableExamDetails/${exam.examId}">
View Exam Details

</a>

</td>

</tr>

</c:forEach>

</tbody>

</table>

<c:if test="${pageResult.totalPages > 1}">
<nav class="mt-4">
<ul class="pagination justify-content-center">
<li class="page-item ${pageResult.hasPrevious ? '' : 'disabled'}"><a class="page-link" href="?page=${pageResult.currentPage - 1}">Previous</a></li>
<c:forEach begin="1" end="${pageResult.totalPages}" var="p">
<li class="page-item ${p == pageResult.currentPage ? 'active' : ''}"><a class="page-link" href="?page=${p}">${p}</a></li>
</c:forEach>
<li class="page-item ${pageResult.hasNext ? '' : 'disabled'}"><a class="page-link" href="?page=${pageResult.currentPage + 1}">Next</a></li>
</ul>
</nav>
</c:if>

</div>

</body>

</html>