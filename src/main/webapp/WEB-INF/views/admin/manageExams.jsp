<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Manage Exams</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
</head>
<body class="bg-light">

<jsp:include page="adminHeader.jsp"/>

<div class="container mt-4 mb-5">

<div class="d-flex justify-content-between align-items-center mb-3">
<h2><i class="bi bi-clipboard-check-fill me-2"></i>Manage Exams</h2>
<a href="${pageContext.request.contextPath}/admin/addExam" class="btn btn-primary"><i class="bi bi-plus-circle me-1"></i>Add Exam</a>
</div>

<div class="card">
<div class="table-responsive">
<table class="table table-hover align-middle mb-0">
<thead class="table-dark">
<tr>
<th>ID</th><th>Exam Name</th><th>Subject</th><th>Duration</th><th>Total Marks</th><th>Date</th><th>Start Time</th><th>Status</th><th>Action</th>
</tr>
</thead>
<tbody>
<c:forEach items="${examList}" var="exam">
<tr id="examRow-${exam.examId}">
<td>${exam.examId}</td>
<td>${exam.examName}</td>
<td>${exam.subject.subjectName}</td>
<td>${exam.duration} min</td>
<td>${exam.totalMarks}</td>
<td>${exam.examDate}</td>
<td>${exam.startTime}</td>
<td id="examStatus-${exam.examId}">
<c:choose>
<c:when test="${exam.status}"><span class="badge bg-success">Active</span></c:when>
<c:otherwise><span class="badge bg-danger">Inactive</span></c:otherwise>
</c:choose>
</td>
<td id="examAction-${exam.examId}" style="white-space:nowrap;">
<a class="btn btn-info btn-sm" href="${pageContext.request.contextPath}/admin/updateExam/${exam.examId}">Update</a>
<a class="btn btn-primary btn-sm" href="${pageContext.request.contextPath}/admin/viewExamDetails/${exam.examId}">View</a>
<a class="btn btn-outline-primary btn-sm" href="${pageContext.request.contextPath}/admin/assignQuestions/${exam.examId}">Add Questions</a>
<c:choose>
<c:when test="${exam.status}">
<a class="btn btn-secondary btn-sm"
href="${pageContext.request.contextPath}/admin/changeExamStatus/${exam.examId}/false">
Deactivate
</a>
</c:when>
<c:otherwise>
<a class="btn btn-secondary btn-sm"
href="${pageContext.request.contextPath}/admin/changeExamStatus/${exam.examId}/false">
Deactivate
</a>
</c:otherwise>
</c:choose>
<a class="btn btn-danger btn-sm"
href="${pageContext.request.contextPath}/admin/deleteExam/${exam.examId}"
onclick="return confirm('Delete this Exam?')">
Delete
</a>
</td>
</tr>
</c:forEach>
<c:if test="${empty examList}">
<tr><td colspan="9" class="text-center text-muted py-4">No exams found.</td></tr>
</c:if>
</tbody>
</table>
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

<!--script>
const ctx = "${pageContext.request.contextPath}";

function examWireButtons() {
	document.querySelectorAll('.exam-toggle-btn').forEach(function (btn) {
		btn.onclick = function () {
			const id = btn.getAttribute('data-id');
			const next = btn.getAttribute('data-next');
			const fd = new URLSearchParams();
			fd.append('examId', id);
			fd.append('status', next);
			fetch(ctx + '/admin/api/changeExamStatus', { method:'POST', headers:{'Content-Type':'application/x-www-form-urlencoded'}, body: fd })
			.then(r => r.json())
			.then(data => {
				if (!data.success) { alert('Failed: ' + (data.message||'')); return; }
				const active = (next === 'true');
				document.getElementById('examStatus-' + id).innerHTML = active
					? '<span class="badge bg-success">Active</span>'
					: '<span class="badge bg-danger">Inactive</span>';
				const toggleBtnHtml = active
					? '<button type="button" class="btn btn-secondary btn-sm exam-toggle-btn" data-id="'+id+'" data-next="false">Deactivate</button>'
					: '<button type="button" class="btn btn-success btn-sm exam-toggle-btn" data-id="'+id+'" data-next="true">Activate</button>';
				document.getElementById('examAction-' + id).innerHTML =
					'<a class="btn btn-info btn-sm" href="' + ctx + '/admin/updateExam/' + id + '">Update</a> '
					+ '<a class="btn btn-primary btn-sm" href="' + ctx + '/admin/viewExamDetails/' + id + '">View</a> '
					+ '<a class="btn btn-outline-primary btn-sm" href="' + ctx + '/admin/assignQuestions/' + id + '">Add Questions</a> '
					+ toggleBtnHtml
					+ ' <button type="button" class="btn btn-danger btn-sm exam-delete-btn" data-id="'+id+'">Delete</button>';
				examWireButtons();
			});
		};
	});
	document.querySelectorAll('.exam-delete-btn').forEach(function (btn) {
		btn.onclick = function () {
			const id = btn.getAttribute('data-id');
			if (!confirm('Are you sure you want to delete this Exam?')) return;
			const fd = new URLSearchParams();
			fd.append('examId', id);
			fetch(ctx + '/admin/api/deleteExam', { method:'POST', headers:{'Content-Type':'application/x-www-form-urlencoded'}, body: fd })
			.then(r => r.json())
			.then(data => {
				if (!data.success) { alert('Failed: ' + (data.message||'')); return; }
				const row = document.getElementById('examRow-' + id);
				if (row) row.remove();
			});
		};
	});
}
examWireButtons();
</script-->

</body>
</html>
