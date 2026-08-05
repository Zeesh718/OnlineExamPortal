<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Manage Questions</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
</head>
<body class="bg-light">

<jsp:include page="adminHeader.jsp"/>

<div class="container mt-4 mb-5">

<div class="d-flex justify-content-between align-items-center mb-3">
<h2><i class="bi bi-patch-question-fill me-2"></i>Manage Questions</h2>
<a href="${pageContext.request.contextPath}/admin/addQuestion" class="btn btn-primary"><i class="bi bi-plus-circle me-1"></i>Add Question</a>
</div>

<div class="card">
<div class="table-responsive">
<table class="table table-hover align-middle mb-0">
<thead class="table-dark">
<tr>
<th>ID</th>
<th>Question</th>
<th>Correct Answer</th>
<th>Marks</th>
<th>Subject</th>
<th>Status</th>
<th>Action</th>
</tr>
</thead>
<tbody>
<c:forEach items="${questionList}" var="question">
<tr id="qRow-${question.questionId}">
<td>${question.questionId}</td>
<td>${question.questionText}<br>
<small class="text-muted">A) ${question.optionA} &nbsp; B) ${question.optionB} &nbsp; C) ${question.optionC} &nbsp; D) ${question.optionD}</small>
</td>
<td>${question.correctAnswer}</td>
<td>${question.marks}</td>
<td>${question.subject.subjectName}</td>
<td id="qStatus-${question.questionId}">
<c:choose>
<c:when test="${question.status}"><span class="badge bg-success">Active</span></c:when>
<c:otherwise><span class="badge bg-danger">Inactive</span></c:otherwise>
</c:choose>
</td>
<td id="qAction-${question.questionId}">
<a class="btn btn-warning btn-sm" href="${pageContext.request.contextPath}/admin/updateQuestion/${question.questionId}">Update</a>
<c:choose>
<c:when test="${question.status}">
<a class="btn btn-secondary btn-sm"
href="${pageContext.request.contextPath}/admin/changeQuestionStatus/${question.questionId}/false">
Deactivate
</a>
</c:when>
<c:otherwise>
<a class="btn btn-success btn-sm"
href="${pageContext.request.contextPath}/admin/changeQuestionStatus/${question.questionId}/true">
Activate
</a>
</c:otherwise>
</c:choose>
<a class="btn btn-danger btn-sm"
href="${pageContext.request.contextPath}/admin/deleteQuestion/${question.questionId}"
onclick="return confirm('Delete this Question?')">
Delete
</a>
</td>
</tr>
</c:forEach>
<c:if test="${empty questionList}">
<tr><td colspan="7" class="text-center text-muted py-4">No questions found.</td></tr>
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

<!-- script>
const ctx = "${pageContext.request.contextPath}";

function qWireButtons() {
	document.querySelectorAll('.q-toggle-btn').forEach(function (btn) {
		btn.onclick = function () {
			const id = btn.getAttribute('data-id');
			const next = btn.getAttribute('data-next');
			const fd = new URLSearchParams();
			fd.append('questionId', id);
			fd.append('status', next);
			fetch(ctx + '/admin/api/changeQuestionStatus', { method:'POST', headers:{'Content-Type':'application/x-www-form-urlencoded'}, body: fd })
			.then(r => r.json())
			.then(data => {
				if (!data.success) { alert('Failed: ' + (data.message||'')); return; }
				const active = (next === 'true');
				document.getElementById('qStatus-' + id).innerHTML = active
					? '<span class="badge bg-success">Active</span>'
					: '<span class="badge bg-danger">Inactive</span>';
				document.getElementById('qAction-' + id).innerHTML =
					'<a class="btn btn-warning btn-sm" href="' + ctx + '/admin/updateQuestion/' + id + '">Update</a> '
					+ (active
						? '<button type="button" class="btn btn-secondary btn-sm q-toggle-btn" data-id="'+id+'" data-next="false">Deactivate</button>'
						: '<button type="button" class="btn btn-success btn-sm q-toggle-btn" data-id="'+id+'" data-next="true">Activate</button>')
					+ ' <button type="button" class="btn btn-danger btn-sm q-delete-btn" data-id="'+id+'">Delete</button>';
				qWireButtons();
			});
		};
	});
	document.querySelectorAll('.q-delete-btn').forEach(function (btn) {
		btn.onclick = function () {
			const id = btn.getAttribute('data-id');
			if (!confirm('Are you sure you want to delete this Question?')) return;
			const fd = new URLSearchParams();
			fd.append('questionId', id);
			fetch(ctx + '/admin/api/deleteQuestion', { method:'POST', headers:{'Content-Type':'application/x-www-form-urlencoded'}, body: fd })
			.then(r => r.json())
			.then(data => {
				if (!data.success) { alert('Failed: ' + (data.message||'')); return; }
				const row = document.getElementById('qRow-' + id);
				if (row) row.remove();
			});
		};
	});
}
qWireButtons();
</script-->

</body>
</html>
