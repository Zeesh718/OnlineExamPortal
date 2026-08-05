<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>My Results</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
</head>

<body class="bg-light">

<jsp:include page="studentHeader.jsp"/>

<div class="container mt-4 mb-5">

<div class="card shadow">

<div class="card-header text-white">
<h3 class="mb-0"><i class="bi bi-bar-chart-fill me-2"></i>My Results</h3>
</div>

<div class="card-body">

<c:if test="${empty myResultList}">
<div class="alert alert-warning text-center">No Results Available.</div>
</c:if>

<c:if test="${not empty myResultList}">
<div class="table-responsive">
<table class="table table-bordered table-hover align-middle">

<thead class="table-dark">
<tr>
<th>S.No.</th>
<th>Exam Name</th>
<th>Subject</th>
<th>Correct</th>
<th>Wrong</th>
<th>Unattempted</th>
<th>Marks</th>
<th>Submitted Date</th>
<th>Report</th>
</tr>
</thead>

<tbody>
<c:forEach items="${myResultList}" var="result" varStatus="status">
<tr>
<td>${(pageResult.currentPage - 1) * pageResult.pageSize + status.count}</td>
<td>${result.exam.examName}</td>
<td>${result.exam.subject.subjectName}</td>
<td class="text-success fw-bold">${result.correct}</td>
<td class="text-danger fw-bold">${result.wrong}</td>
<td class="text-warning fw-bold">${result.unattemted}</td>
<td class="fw-bold">${result.obtainedMarks} / ${result.exam.totalMarks}</td>
<td>${result.submittedDate}</td>
<td>
<a class="btn btn-outline-secondary btn-sm" href="${pageContext.request.contextPath}/student/viewResult/${result.resutId}">
<i class="bi bi-eye-fill me-1"></i>View Details
</a>
<a class="btn btn-outline-primary btn-sm" href="${pageContext.request.contextPath}/student/downloadResultPdf/${result.resutId}">
<i class="bi bi-file-earmark-pdf-fill me-1"></i>PDF
</a>
</td>
</tr>
</c:forEach>
</tbody>

</table>
</div>
</c:if>

</div>

</div>

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
