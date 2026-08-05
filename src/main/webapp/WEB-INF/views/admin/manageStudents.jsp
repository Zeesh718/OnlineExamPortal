<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Manage Students</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">

</head>
<body class="bg-light">

<jsp:include page="adminHeader.jsp"/>

<div class="container mt-4 mb-5">

  <div class="d-flex justify-content-between align-items-center mb-3">
    <h2><i class="bi bi-people-fill me-2"></i>Manage Students</h2>
    <span class="text-muted">${pageResult.totalItems} student(s) total</span>
  </div>

  <div class="card">
    <div class="table-responsive">
      <table class="table table-hover align-middle mb-0" id="studentTable">
        <thead class="table-dark">
          <tr>
            <th>ID</th>
            <th>Student ID</th>
            <th>Name</th>
            <th>Email</th>
            <th>Mobile</th>
            <th>Status</th>
            <th>Action</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach items="${studentList}" var="student">
            <tr id="studentRow-${student.userId}">
              <td>${student.userId}</td>
              <td>${student.studentId}</td>
              <td>${student.name}</td>
              <td>${student.email}</td>
              <td>${student.mobile}</td>
              <td id="statusCell-${student.userId}">
                <c:choose>
                  <c:when test="${student.status}">
                    <span class="badge bg-success">Active</span>
                  </c:when>
                  <c:otherwise>
                    <span class="badge bg-danger">Inactive</span>
                  </c:otherwise>
                </c:choose>
              </td>
              <td id="actionCell-${student.userId}">
                <c:choose>
                  <c:when test="${student.status}">
                   <a class="btn btn-secondary btn-sm"
href="${pageContext.request.contextPath}/admin/changeStatus?userId=${student.userId}&status=false">
Deactivate
</a>
                  </c:when>
                  <c:otherwise>
                    <a class="btn btn-success btn-sm"
href="${pageContext.request.contextPath}/admin/changeStatus?userId=${student.userId}&status=true">
Activate
</a>
                  </c:otherwise>
                </c:choose>
                <a class="btn btn-danger btn-sm"
href="${pageContext.request.contextPath}/admin/deleteStudent/${student.userId}"
onclick="return confirm('Are you sure you want to delete this student?')">
Delete
</a>
              </td>
            </tr>
          </c:forEach>
          <c:if test="${empty studentList}">
            <tr><td colspan="7" class="text-center text-muted py-4">No students found.</td></tr>
          </c:if>
        </tbody>
      </table>
    </div>
  </div>

  <!-- ================= PAGINATION ================= -->
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

<!-- script>
const ctx = "${pageContext.request.contextPath}";

// ---------- Activate / Deactivate (AJAX, no page reload, no console error) ----------
document.querySelectorAll('.toggle-status-btn').forEach(function (btn) {
    btn.addEventListener('click', function () {
        const userId = btn.getAttribute('data-user-id');
        const nextStatus = btn.getAttribute('data-next-status');

        const formData = new URLSearchParams();
        formData.append('userId', userId);
        formData.append('status', nextStatus);

        fetch(ctx + '/admin/api/changeStatus', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: formData
        })
        .then(res => res.json())
        .then(data => {
            if (!data.success) {
                alert('Something went wrong: ' + (data.message || ''));
                return;
            }
            const isNowActive = (nextStatus === 'true');
            document.getElementById('statusCell-' + userId).innerHTML = isNowActive
                ? '<span class="badge bg-success">Active</span>'
                : '<span class="badge bg-danger">Inactive</span>';

            document.getElementById('actionCell-' + userId).innerHTML =
                (isNowActive
                    ? '<button type="button" class="btn btn-secondary btn-sm toggle-status-btn" data-user-id="' + userId + '" data-next-status="false">Deactivate</button>'
                    : '<button type="button" class="btn btn-success btn-sm toggle-status-btn" data-user-id="' + userId + '" data-next-status="true">Activate</button>')
                + ' <button type="button" class="btn btn-danger btn-sm delete-student-btn" data-user-id="' + userId + '">Delete</button>';

            attachHandlers(); // naye buttons pe dobara listener lagana
        })
        .catch(err => alert('Request failed: ' + err));
    });
});

// ---------- Delete (AJAX) ----------
document.querySelectorAll('.delete-student-btn').forEach(function (btn) {
    btn.addEventListener('click', function () {
        const userId = btn.getAttribute('data-user-id');
        if (!confirm('Are you sure you want to delete this student?')) return;

        const formData = new URLSearchParams();
        formData.append('userId', userId);

        fetch(ctx + '/admin/api/deleteStudent', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: formData
        })
        .then(res => res.json())
        .then(data => {
            if (!data.success) {
                alert('Something went wrong: ' + (data.message || ''));
                return;
            }
            const row = document.getElementById('studentRow-' + userId);
            if (row) row.remove();
        })
        .catch(err => alert('Request failed: ' + err));
    });
});

// Dobara listeners lagane ke liye (AJAX ke baad naye buttons ke upar), function ke roop me reuse
function attachHandlers() {
    document.querySelectorAll('.toggle-status-btn').forEach(function (btn) {
        btn.onclick = function () {
            const userId = btn.getAttribute('data-user-id');
            const nextStatus = btn.getAttribute('data-next-status');
            const formData = new URLSearchParams();
            formData.append('userId', userId);
            formData.append('status', nextStatus);

            fetch(ctx + '/admin/api/changeStatus', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: formData
            })
            .then(res => res.json())
            .then(data => {
                if (!data.success) { alert('Something went wrong'); return; }
                const isNowActive = (nextStatus === 'true');
                document.getElementById('statusCell-' + userId).innerHTML = isNowActive
                    ? '<span class="badge bg-success">Active</span>'
                    : '<span class="badge bg-danger">Inactive</span>';
                document.getElementById('actionCell-' + userId).innerHTML =
                    (isNowActive
                        ? '<button type="button" class="btn btn-secondary btn-sm toggle-status-btn" data-user-id="' + userId + '" data-next-status="false">Deactivate</button>'
                        : '<button type="button" class="btn btn-success btn-sm toggle-status-btn" data-user-id="' + userId + '" data-next-status="true">Activate</button>')
                    + ' <button type="button" class="btn btn-danger btn-sm delete-student-btn" data-user-id="' + userId + '">Delete</button>';
                attachHandlers();
            });
        };
    });
    document.querySelectorAll('.delete-student-btn').forEach(function (btn) {
        btn.onclick = function () {
            const userId = btn.getAttribute('data-user-id');
            if (!confirm('Are you sure you want to delete this student?')) return;
            const formData = new URLSearchParams();
            formData.append('userId', userId);
            fetch(ctx + '/admin/api/deleteStudent', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: formData
            })
            .then(res => res.json())
            .then(data => {
                if (!data.success) { alert('Something went wrong'); return; }
                const row = document.getElementById('studentRow-' + userId);
                if (row) row.remove();
            });
        };
    });
}
</script-->

</body>
</html>
