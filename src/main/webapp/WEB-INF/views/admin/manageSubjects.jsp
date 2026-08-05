<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Manage Subjects</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
</head>
<body class="bg-light">

	<jsp:include page="adminHeader.jsp" />
 
	<div class="container mt-4 mb-5">

		<div class="d-flex justify-content-between align-items-center mb-3">
			<h2><i class="bi bi-journal-bookmark-fill me-2"></i>Manage Subjects</h2>
			<a href="${pageContext.request.contextPath}/admin/addSubject" class="btn btn-primary">
				<i class="bi bi-plus-circle me-1"></i>Add Subject
			</a>
		</div>

		<div class="card">
		<div class="table-responsive">
		<table class="table table-hover align-middle mb-0">
			<thead class="table-dark">
				<tr>
					<th>ID</th>
					<th>Subject Name</th>
					<th>Status</th>
					<th>Action</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${subjectList}" var="subject">
					<tr id="subjectRow-${subject.subjectId}">
						<td>${subject.subjectId}</td>
						<td>${subject.subjectName}</td>
						<td id="subjectStatus-${subject.subjectId}">
							<c:choose>
								<c:when test="${subject.status}">
									<span class="badge bg-success">Active</span>
								</c:when>
								<c:otherwise>
									<span class="badge bg-danger">Inactive</span>
								</c:otherwise>
							</c:choose>
						</td>
						<td id="subjectAction-${subject.subjectId}">
							<c:choose>
								<c:when test="${subject.status}">
								<a class="btn btn-warning btn-sm"
href="${pageContext.request.contextPath}/admin/changeSubjectStatus/${subject.subjectId}/false">
Deactivate
</a>
								</c:when>
								<c:otherwise>
								<a class="btn btn-success btn-sm"
href="${pageContext.request.contextPath}/admin/changeSubjectStatus/${subject.subjectId}/true">
Activate
</a>
								</c:otherwise>
							</c:choose>
							<a class="btn btn-danger btn-sm"
href="${pageContext.request.contextPath}/admin/deleteSubject/${subject.subjectId}"
onclick="return confirm('Are you sure you want to delete this Subject ?')">
Delete
</a>
							<a class="btn btn-info btn-sm" href="${pageContext.request.contextPath}/admin/updateSubject/${subject.subjectId}">Update</a>
						</td>
					</tr>
				</c:forEach>
				<c:if test="${empty subjectList}">
					<tr><td colspan="4" class="text-center text-muted py-4">No subjects found.</td></tr>
				</c:if>
			</tbody>
		</table>
		</div>
		</div>

		<c:if test="${pageResult.totalPages > 1}">
			<nav class="mt-4">
				<ul class="pagination justify-content-center">
					<li class="page-item ${pageResult.hasPrevious ? '' : 'disabled'}">
						<a class="page-link" href="?page=${pageResult.currentPage - 1}">Previous</a>
					</li>
					<c:forEach begin="1" end="${pageResult.totalPages}" var="p">
						<li class="page-item ${p == pageResult.currentPage ? 'active' : ''}">
							<a class="page-link" href="?page=${p}">${p}</a>
						</li>
					</c:forEach>
					<li class="page-item ${pageResult.hasNext ? '' : 'disabled'}">
						<a class="page-link" href="?page=${pageResult.currentPage + 1}">Next</a>
					</li>
				</ul>
			</nav>
		</c:if>

	</div>

<!--script>
const ctx = "${pageContext.request.contextPath}";

function subjWireButtons() {
	document.querySelectorAll('.subj-toggle-btn').forEach(function (btn) {
		btn.onclick = function () {
			const id = btn.getAttribute('data-id');
			const next = btn.getAttribute('data-next');
			const fd = new URLSearchParams();
			fd.append('subjectId', id);
			fd.append('status', next);
			fetch(ctx + '/admin/api/changeSubjectStatus', { method: 'POST', headers: {'Content-Type':'application/x-www-form-urlencoded'}, body: fd })
			.then(r => r.json())
			.then(data => {
				if (!data.success) { alert('Failed: ' + (data.message||'')); return; }
				const active = (next === 'true');
				document.getElementById('subjectStatus-' + id).innerHTML = active
					? '<span class="badge bg-success">Active</span>'
					: '<span class="badge bg-danger">Inactive</span>';
				document.getElementById('subjectAction-' + id).innerHTML =
					(active
						? '<button type="button" class="btn btn-warning btn-sm subj-toggle-btn" data-id="'+id+'" data-next="false">Deactivate</button>'
						: '<button type="button" class="btn btn-success btn-sm subj-toggle-btn" data-id="'+id+'" data-next="true">Activate</button>')
					+ ' <button type="button" class="btn btn-danger btn-sm subj-delete-btn" data-id="'+id+'">Delete</button>'
					+ ' <a class="btn btn-info btn-sm" href="' + ctx + '/admin/updateSubject/' + id + '">Update</a>';
				subjWireButtons();
			});
		};
	});
	document.querySelectorAll('.subj-delete-btn').forEach(function (btn) {
		btn.onclick = function () {
			const id = btn.getAttribute('data-id');
			if (!confirm('Are you sure you want to delete this Subject?')) return;
			const fd = new URLSearchParams();
			fd.append('subjectId', id);
			fetch(ctx + '/admin/api/deleteSubject', { method: 'POST', headers: {'Content-Type':'application/x-www-form-urlencoded'}, body: fd })
			.then(r => r.json())
			.then(data => {
				if (!data.success) { alert('Failed: ' + (data.message||'')); return; }
				const row = document.getElementById('subjectRow-' + id);
				if (row) row.remove();
			});
		};
	});
}
subjWireButtons();
</script-->

</body>
</html>
