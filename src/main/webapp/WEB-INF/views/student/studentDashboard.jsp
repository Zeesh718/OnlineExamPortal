<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Student Dashboard</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
<script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.4/dist/chart.umd.min.js"></script>

<style>
body { background: #f4f7fc; font-family: Arial, sans-serif; }
.container { max-width: 1150px; }

.welcome-card{
	background: linear-gradient(135deg, #4361ee, #7209b7);
	border-radius:16px; padding:26px 30px; color:white; margin:24px 0 20px;
	display:flex; justify-content:space-between; align-items:center; flex-wrap:wrap; gap:18px;
}
.welcome-card h3{ margin:0 0 6px; }
.welcome-card .sub{ opacity:.9; font-size:14px; }
.profile-completion{ min-width:220px; }
.profile-completion .pc-label{ font-size:12px; margin-bottom:6px; display:flex; justify-content:space-between; }
.progress{ height:10px; border-radius:10px; background:rgba(255,255,255,.25); }
.progress-bar{ background:white; }

.stat-grid{ display:grid; grid-template-columns:repeat(4,1fr); gap:16px; margin-bottom:22px; }
.stat-card{ background:white; border-radius:14px; box-shadow:0 5px 15px rgba(0,0,0,.08); padding:18px; display:flex; gap:12px; align-items:center; }
.stat-icon{ width:48px; height:48px; border-radius:12px; display:flex; align-items:center; justify-content:center; color:white; font-size:21px; flex-shrink:0; }
.stat-num{ font-size:22px; font-weight:bold; }
.stat-lbl{ font-size:12px; color:#6c757d; }

.panel{ background:white; border-radius:14px; box-shadow:0 5px 15px rgba(0,0,0,.08); padding:20px; margin-bottom:20px; }
.panel h5{ margin-bottom:14px; }
.list-row{ display:flex; justify-content:space-between; align-items:center; padding:10px 0; border-bottom:1px solid #f1f1f1; font-size:14px; }
.list-row:last-child{ border-bottom:none; }
.list-row .badge-soft{ background:#eef1ff; color:#4361ee; padding:3px 10px; border-radius:20px; font-size:12px; font-weight:600; }

.qa-grid{ display:grid; grid-template-columns:repeat(3,1fr); gap:16px; }
.qa-card{
	border-radius:14px; padding:22px 18px; text-decoration:none; color:white;
	display:flex; flex-direction:column; gap:10px; transition:.2s; min-height:120px; justify-content:center;
}
.qa-card:hover{ transform:translateY(-4px); box-shadow:0 10px 20px rgba(0,0,0,.18); color:white; }
.qa-card i{ font-size:26px; }
.qa-card .qa-title{ font-size:16px; font-weight:bold; }
.qa-card .qa-sub{ font-size:12px; opacity:.9; }
.qa-exam{ background:linear-gradient(135deg,#4361ee,#3a0ca3); }
.qa-result{ background:linear-gradient(135deg,#fd7e14,#e8590c); }
.qa-profile{ background:linear-gradient(135deg,#20c997,#0ca678); }

.chart-wrap{ width:100%; max-width:260px; margin:0 auto; }

@media(max-width:900px){ .stat-grid, .qa-grid{ grid-template-columns:repeat(2,1fr); } }
@media(max-width:600px){ .stat-grid, .qa-grid{ grid-template-columns:1fr; } .welcome-card{ flex-direction:column; align-items:flex-start; } }
</style>

</head>
<body>
<%@ include file="studentHeader.jsp"%>

<div class="container">

	<div class="welcome-card">
		<div>
			<h3>Welcome back, ${user.name} <c:if test="${not empty user.studentId}">&bull; ${user.studentId}</c:if></h3>
			<div class="sub">Here's how your preparation is going.</div>
		</div>
		<div class="profile-completion">
			<div class="pc-label"><span>Profile Completion</span><span>${profileCompletion}%</span></div>
			<div class="progress"><div class="progress-bar" style="width:${profileCompletion}%;"></div></div>
			<c:if test="${profileCompletion < 100}">
				<a href="${pageContext.request.contextPath}/student/editProfile" style="color:white;font-size:12px;">Complete your profile &rarr;</a>
			</c:if>
		</div>
	</div>

	<div class="stat-grid">
		<div class="stat-card"><div class="stat-icon" style="background:#4361ee;"><i class="bi bi-journal-check"></i></div>
			<div><div class="stat-num">${completedExamsCount}</div><div class="stat-lbl">Exams Completed</div></div></div>

		<div class="stat-card"><div class="stat-icon" style="background:#fd7e14;"><i class="bi bi-calendar2-week"></i></div>
			<div><div class="stat-num">${upcomingExamsCount}</div><div class="stat-lbl">Available Exams</div></div></div>

		<div class="stat-card"><div class="stat-icon" style="background:#198754;"><i class="bi bi-graph-up-arrow"></i></div>
			<div><div class="stat-num">${avgScore}%</div><div class="stat-lbl">Average Score</div></div></div>

		<div class="stat-card"><div class="stat-icon" style="background:#6f42c1;"><i class="bi bi-trophy-fill"></i></div>
			<div><div class="stat-num">${highScore}%</div><div class="stat-lbl">Highest Score</div></div></div>
	</div>

	<div class="row">
		<div class="col-md-4">
			<div class="panel">
				<h5>Performance Overview</h5>
				<c:choose>
					<c:when test="${completedExamsCount > 0}">
						<div class="chart-wrap"><canvas id="perfChart"></canvas></div>
					</c:when>
					<c:otherwise>
						<div class="text-muted small">Attempt an exam to see your performance chart here.</div>
					</c:otherwise>
				</c:choose>
			</div>
		</div>

		<div class="col-md-4">
			<div class="panel">
				<h5>Upcoming Exams</h5>
				<c:choose>
					<c:when test="${empty recentExams}">
						<div class="text-muted small">No exams available right now.</div>
					</c:when>
					<c:otherwise>
						<c:forEach items="${recentExams}" var="e">
							<div class="list-row">
								<span>${e.examName}</span>
								<span class="badge-soft">${e.examDate}</span>
							</div>
						</c:forEach>
					</c:otherwise>
				</c:choose>
				<a href="${pageContext.request.contextPath}/student/availableExams" class="d-block mt-2 small">View all &rarr;</a>
			</div>
		</div>

		<div class="col-md-4">
			<div class="panel">
				<h5>Recent Results</h5>
				<c:choose>
					<c:when test="${empty recentResults}">
						<div class="text-muted small">No results yet.</div>
					</c:when>
					<c:otherwise>
						<c:forEach items="${recentResults}" var="r">
							<div class="list-row">
								<span>${r.exam.examName}</span>
								<span class="badge-soft">${r.obtainedMarks}/${r.exam.totalMarks}</span>
							</div>
						</c:forEach>
					</c:otherwise>
				</c:choose>
				<a href="${pageContext.request.contextPath}/student/myResults" class="d-block mt-2 small">View all &rarr;</a>
			</div>
		</div>
	</div>

	<div class="panel">
		<h5>Quick Actions</h5>
		<div class="qa-grid">
			<a href="${pageContext.request.contextPath}/student/availableExams" class="qa-card qa-exam">
				<i class="bi bi-pencil-square"></i>
				<div class="qa-title">Available Exams</div>
				<div class="qa-sub">Browse and attempt your exams</div>
			</a>
			<a href="${pageContext.request.contextPath}/student/myResults" class="qa-card qa-result">
				<i class="bi bi-bar-chart-line-fill"></i>
				<div class="qa-title">My Results</div>
				<div class="qa-sub">Score history & analysis</div>
			</a>
			<a href="${pageContext.request.contextPath}/student/editProfile" class="qa-card qa-profile">
				<i class="bi bi-person-gear"></i>
				<div class="qa-title">My Profile</div>
				<div class="qa-sub">Update your details</div>
			</a>
		</div>
	</div>

</div>

<c:if test="${completedExamsCount > 0}">
<script>
new Chart(document.getElementById('perfChart'), {
	type: 'bar',
	data: {
		labels: ['Lowest', 'Average', 'Highest'],
		datasets: [{
			data: [${lowScore}, ${avgScore}, ${highScore}],
			backgroundColor: ['#fd7e14', '#4361ee', '#198754'],
			borderRadius: 6
		}]
	},
	options: {
		plugins: { legend: { display:false } },
		scales: { y: { beginAtZero:true, max:100, ticks:{ callback:v=>v+'%' } } }
	}
});
</script>
</c:if>

</body>
</html>
