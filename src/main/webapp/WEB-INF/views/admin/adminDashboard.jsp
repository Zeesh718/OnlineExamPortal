<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Admin Dashboard</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
<script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.4/dist/chart.umd.min.js"></script>

<style>
body { background: #f4f7fc; font-family: Arial, sans-serif; }
.navbar-brand { font-weight: bold; font-size: 24px; }

.container { max-width: 1250px; }

.stat-grid { display:grid; grid-template-columns:repeat(4, 1fr); gap:18px; margin:26px 0; }
.stat-card {
	background:white; border-radius:14px; box-shadow:0 5px 15px rgba(0,0,0,.08);
	padding:20px; display:flex; align-items:center; gap:14px;
}
.stat-icon { font-size:26px; width:52px; height:52px; border-radius:12px; display:flex; align-items:center; justify-content:center; color:white; flex-shrink:0; }
.stat-num { font-size:24px; font-weight:bold; }
.stat-lbl { font-size:13px; color:#6c757d; }

.bg-p1 { background:#4361ee; } .bg-p2 { background:#198754; } .bg-p3 { background:#fd7e14; }
.bg-p4 { background:#6f42c1; } .bg-p5 { background:#0dcaf0; } .bg-p6 { background:#dc3545; }
.bg-p7 { background:#20c997; } .bg-p8 { background:#e83e8c; }

.panel { background:white; border-radius:14px; box-shadow:0 5px 15px rgba(0,0,0,.08); padding:22px; margin-bottom:22px; }
.panel h5 { margin-bottom:16px; }

.chart-row { display:grid; grid-template-columns:320px 1fr; gap:20px; }
.chart-canvas-wrap { width:100%; max-width:230px; margin:0 auto; }

.recent-list { list-style:none; padding:0; margin:0; }
.recent-list li { display:flex; justify-content:space-between; padding:9px 0; border-bottom:1px solid #f1f1f1; font-size:14px; }
.recent-list li:last-child { border-bottom:none; }

.dashboard-card { border-radius:15px; box-shadow:0px 5px 15px rgba(0,0,0,0.10); padding:26px; background:white; }
.card-btn { height:110px; border-radius:15px; font-size:17px; font-weight:bold; transition:.3s; }
.card-btn:hover { transform:translateY(-5px); box-shadow:0px 10px 20px rgba(0,0,0,.2); }

@media(max-width:900px){ .stat-grid{ grid-template-columns:repeat(2,1fr); } .chart-row{ grid-template-columns:1fr; } }
</style>

</head>

<body>

<jsp:include page="adminHeader.jsp"/>

<div class="container mt-4 mb-5">

	<h2 class="text-primary mb-1">Admin Dashboard</h2>
	<div class="text-muted mb-3">Welcome back, ${loggedInUser.name}</div>

	<div class="stat-grid">
		<div class="stat-card"><div class="stat-icon bg-p1"><i class="bi bi-people-fill"></i></div>
			<div><div class="stat-num">${totalStudents}</div><div class="stat-lbl">Total Students</div></div></div>

		<div class="stat-card"><div class="stat-icon bg-p2"><i class="bi bi-person-check-fill"></i></div>
			<div><div class="stat-num">${activeStudents}</div><div class="stat-lbl">Active Students</div></div></div>

		<div class="stat-card"><div class="stat-icon bg-p3"><i class="bi bi-journal-bookmark-fill"></i></div>
			<div><div class="stat-num">${totalSubjects}</div><div class="stat-lbl">Total Subjects</div></div></div>

		<div class="stat-card"><div class="stat-icon bg-p4"><i class="bi bi-file-earmark-text-fill"></i></div>
			<div><div class="stat-num">${totalExams}</div><div class="stat-lbl">Total Exams</div></div></div>

		<div class="stat-card"><div class="stat-icon bg-p5"><i class="bi bi-calendar-event-fill"></i></div>
			<div><div class="stat-num">${todaysExams}</div><div class="stat-lbl">Today's Exams</div></div></div>

		<div class="stat-card"><div class="stat-icon bg-p6"><i class="bi bi-question-circle-fill"></i></div>
			<div><div class="stat-num">${totalQuestions}</div><div class="stat-lbl">Total Questions</div></div></div>

		<div class="stat-card"><div class="stat-icon bg-p7"><i class="bi bi-clipboard-check-fill"></i></div>
			<div><div class="stat-num">${completedExams}</div><div class="stat-lbl">Exams Completed (Attempts)</div></div></div>

		<div class="stat-card"><div class="stat-icon bg-p8"><i class="bi bi-graph-up-arrow"></i></div>
			<div><div class="stat-num">${avgPercentage}%</div><div class="stat-lbl">Average Score</div></div></div>
	</div>

	<div class="panel">
		<h5>Pass / Fail Overview</h5>
		<c:choose>
			<c:when test="${completedExams > 0}">
				<div class="chart-row">
					<div class="chart-canvas-wrap"><canvas id="passFailChart"></canvas></div>
					<div>
						<div class="recent-list">
							<li><span>&#128994; Pass Percentage</span><b>${passPercentage}%</b></li>
							<li><span>&#128308; Fail Percentage</span><b>${failPercentage}%</b></li>
							<li><span>Total Attempts Recorded</span><b>${completedExams}</b></li>
							<li><span>Average Score Across All Attempts</span><b>${avgPercentage}%</b></li>
						</div>
					</div>
				</div>
			</c:when>
			<c:otherwise>
				<div class="text-muted">No exam attempts recorded yet.</div>
			</c:otherwise>
		</c:choose>
	</div>

	<div class="row">
		<div class="col-md-6">
			<div class="panel">
				<h5>Recent Results</h5>
				<c:choose>
					<c:when test="${empty recentResults}">
						<div class="text-muted">No results yet.</div>
					</c:when>
					<c:otherwise>
						<ul class="recent-list">
							<c:forEach items="${recentResults}" var="r">
								<li>
									<span>${r.user.name} &bull; ${r.exam.examName}</span>
									<b>${r.obtainedMarks}/${r.exam.totalMarks}</b>
								</li>
							</c:forEach>
						</ul>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
		<div class="col-md-6">
			<div class="panel">
				<h5>Recent Registrations</h5>
				<c:choose>
					<c:when test="${empty recentStudents}">
						<div class="text-muted">No students yet.</div>
					</c:when>
					<c:otherwise>
						<ul class="recent-list">
							<c:forEach items="${recentStudents}" var="s">
								<li><span>${s.name} &bull; ${s.studentId}</span><b>${s.email}</b></li>
							</c:forEach>
						</ul>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</div>

	<div class="dashboard-card">

		<h5 class="mb-4 text-primary">Quick Actions</h5>

		<div class="row g-4">

			<div class="col-md-4">
				<a href="${pageContext.request.contextPath}/admin/manageStudents"
					class="btn btn-primary w-100 card-btn d-flex flex-column align-items-center justify-content-center gap-2">
					<i class="bi bi-people-fill" style="font-size:26px;"></i>
					Manage Students
				</a>
			</div>

			<div class="col-md-4">
				<a href="${pageContext.request.contextPath}/admin/addSubject"
					class="btn btn-success w-100 card-btn d-flex flex-column align-items-center justify-content-center gap-2">
					<i class="bi bi-journal-plus" style="font-size:26px;"></i>
					Add Subject
				</a>
			</div>

			<div class="col-md-4">
				<a href="${pageContext.request.contextPath}/admin/manageSubjects"
					class="btn btn-warning w-100 card-btn d-flex flex-column align-items-center justify-content-center gap-2">
					<i class="bi bi-journal-bookmark-fill" style="font-size:26px;"></i>
					Manage Subjects
				</a>
			</div>

			<div class="col-md-6">
				<a href="manageExams"
					class="btn btn-info w-100 card-btn d-flex flex-column align-items-center justify-content-center gap-2">
					<i class="bi bi-file-earmark-text-fill" style="font-size:26px;"></i>
					Manage Exams
				</a>
			</div>

			<div class="col-md-6">
				<a href="manageQuestions"
					class="btn btn-secondary w-100 card-btn d-flex flex-column align-items-center justify-content-center gap-2">
					<i class="bi bi-question-circle-fill" style="font-size:26px;"></i>
					Manage Questions
				</a>
			</div>

		</div>

	</div>

</div>

<c:if test="${completedExams > 0}">
<script>
new Chart(document.getElementById('passFailChart'), {
	type: 'doughnut',
	data: {
		labels: ['Pass', 'Fail'],
		datasets: [{
			data: [${passPercentage}, ${failPercentage}],
			backgroundColor: ['#198754', '#dc3545'],
			borderWidth: 0
		}]
	},
	options: { plugins: { legend: { position: 'bottom' } }, cutout: '65%' }
});
</script>
</c:if>

</body>
</html>
