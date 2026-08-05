<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="studentHeader.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Exam Result</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
<script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.4/dist/chart.umd.min.js"></script>

<style>

body{ font-family:Arial,sans-serif; background:#f4f6f9; }

.container{ width:85%; max-width:1100px; margin:30px auto 50px; }

.result-header{
	background:white; border-radius:14px; box-shadow:0 0 10px lightgray;
	padding:28px; margin-bottom:22px; display:flex; justify-content:space-between;
	align-items:center; flex-wrap:wrap; gap:20px;
}
.result-header h2{ margin:0 0 6px; }
.result-header .exam-sub{ color:#6c757d; }

.grade-badge{
	font-size:15px; font-weight:bold; padding:8px 18px; border-radius:30px; color:white;
}
.grade-pass{ background:#198754; }
.grade-fail{ background:#dc3545; }

.summary-grid{
	display:grid; grid-template-columns:repeat(4, 1fr); gap:16px; margin-bottom:22px;
}
.summary-card{
	background:white; border-radius:12px; box-shadow:0 0 10px lightgray;
	padding:18px; text-align:center;
}
.summary-card .num{ font-size:26px; font-weight:bold; }
.summary-card .lbl{ font-size:13px; color:#6c757d; margin-top:4px; }
.c-correct .num{ color:#198754; }
.c-wrong .num{ color:#dc3545; }
.c-skip .num{ color:#fd7e14; }
.c-score .num{ color:#4361ee; }

.chart-card{
	background:white; border-radius:14px; box-shadow:0 0 10px lightgray;
	padding:22px; margin-bottom:22px; display:flex; gap:30px; align-items:center; flex-wrap:wrap;
}
.chart-canvas-wrap{ width:220px; height:220px; }
.chart-side{ flex:1; min-width:220px; }
.chart-side .row-line{ display:flex; justify-content:space-between; padding:8px 0; border-bottom:1px solid #f1f1f1; font-size:15px; }

.qa-card{
	background:white; border-radius:14px; box-shadow:0 0 10px lightgray;
	padding:22px; margin-bottom:22px;
}
.qa-card h4{ margin-bottom:16px; }

.qa-row{ border:1px solid #eee; border-radius:10px; padding:14px 16px; margin-bottom:12px; }
.qa-row.correct{ border-left:4px solid #198754; }
.qa-row.wrong{ border-left:4px solid #dc3545; }
.qa-row.skipped{ border-left:4px solid #fd7e14; }
.qa-num{ font-weight:bold; margin-bottom:6px; }
.qa-text{ margin-bottom:8px; }
.qa-answer-line{ font-size:14px; margin:2px 0; }
.qa-badge{ font-size:12px; font-weight:bold; padding:3px 10px; border-radius:20px; color:white; }
.badge-correct{ background:#198754; }
.badge-wrong{ background:#dc3545; }
.badge-skipped{ background:#fd7e14; }

.footer{ text-align:center; margin-top:10px; display:flex; gap:15px; justify-content:center; flex-wrap:wrap; }

@media(max-width:768px){
	.summary-grid{ grid-template-columns:repeat(2, 1fr); }
	.result-header{ flex-direction:column; align-items:flex-start; }
}

</style>

</head>

<body>

<div class="container">

<c:set var="totalMarks" value="${exam.totalMarks > 0 ? exam.totalMarks : 1}"/>
<c:set var="percentage" value="${(marks * 100.0) / totalMarks}"/>
<c:set var="isPass" value="${percentage >= 40}"/>

<div class="result-header">
	<div>
		<h2><i class="bi bi-check-circle-fill text-success"></i> ${exam.examName}</h2>
		<div class="exam-sub">${exam.subject.subjectName} &bull; Submitted on ${exam.examDate}</div>
	</div>
	<div style="text-align:right;">
		<div class="grade-badge ${isPass ? 'grade-pass' : 'grade-fail'}">
			<c:choose>
				<c:when test="${isPass}">PASS</c:when>
				<c:otherwise>FAIL</c:otherwise>
			</c:choose>
			&bull;
			<c:choose>
				<c:when test="${percentage >= 90}">Grade A+</c:when>
				<c:when test="${percentage >= 75}">Grade A</c:when>
				<c:when test="${percentage >= 60}">Grade B</c:when>
				<c:when test="${percentage >= 40}">Grade C</c:when>
				<c:otherwise>Grade F</c:otherwise>
			</c:choose>
		</div>
		<div style="margin-top:8px; font-size:14px; color:#6c757d;">
			<fmt:formatNumber value="${percentage}" maxFractionDigits="1"/>% Accuracy
		</div>
	</div>
</div>

<div class="summary-grid">
	<div class="summary-card c-score"><div class="num">${marks} / ${exam.totalMarks}</div><div class="lbl">Marks Obtained</div></div>
	<div class="summary-card c-correct"><div class="num">${correct}</div><div class="lbl">Correct</div></div>
	<div class="summary-card c-wrong"><div class="num">${wrong}</div><div class="lbl">Wrong</div></div>
	<div class="summary-card c-skip"><div class="num">${unattempted}</div><div class="lbl">Skipped</div></div>
</div>

<div class="chart-card">
	<div class="chart-canvas-wrap"><canvas id="resultChart"></canvas></div>
	<div class="chart-side">
		<div class="row-line"><span>&#128994; Correct</span><span>${correct}</span></div>
		<div class="row-line"><span>&#128308; Wrong</span><span>${wrong}</span></div>
		<div class="row-line"><span>&#128992; Skipped</span><span>${unattempted}</span></div>
		<div class="row-line" style="border-bottom:none;"><b>Total Questions</b><b>${correct + wrong + unattempted}</b></div>
	</div>
</div>

<c:if test="${not empty studentAnswers}">
<div class="qa-card">
	<h4>Question-wise Analysis</h4>

	<c:forEach items="${studentAnswers}" var="sa" varStatus="st">
		<c:set var="rowClass" value="${empty sa.selectedOption ? 'skipped' : (sa.correct ? 'correct' : 'wrong')}"/>
		<div class="qa-row ${rowClass}">
			<div class="qa-num">
				Q${st.count}.
				<c:choose>
					<c:when test="${rowClass == 'correct'}"><span class="qa-badge badge-correct">Correct</span></c:when>
					<c:when test="${rowClass == 'wrong'}"><span class="qa-badge badge-wrong">Wrong</span></c:when>
					<c:otherwise><span class="qa-badge badge-skipped">Skipped</span></c:otherwise>
				</c:choose>
			</div>
			<div class="qa-text">${sa.question.questionText}</div>

			<div class="qa-answer-line">
				<b>Your Answer:</b>
				<c:choose>
					<c:when test="${empty sa.selectedOption}">Not Attempted</c:when>
					<c:when test="${sa.selectedOption == 'A'}">${sa.question.optionA}</c:when>
					<c:when test="${sa.selectedOption == 'B'}">${sa.question.optionB}</c:when>
					<c:when test="${sa.selectedOption == 'C'}">${sa.question.optionC}</c:when>
					<c:otherwise>${sa.question.optionD}</c:otherwise>
				</c:choose>
			</div>

			<c:if test="${rowClass != 'correct'}">
				<div class="qa-answer-line">
					<b>Correct Answer:</b>
					<c:choose>
						<c:when test="${sa.question.correctAnswer == 'A'}">${sa.question.optionA}</c:when>
						<c:when test="${sa.question.correctAnswer == 'B'}">${sa.question.optionB}</c:when>
						<c:when test="${sa.question.correctAnswer == 'C'}">${sa.question.optionC}</c:when>
						<c:otherwise>${sa.question.optionD}</c:otherwise>
					</c:choose>
				</div>
			</c:if>
		</div>
	</c:forEach>

</div>
</c:if>

<div class="footer">
<a href="${pageContext.request.contextPath}/student/availableExams" class="btn btn-primary">Back To Available Exams</a>
<a href="${pageContext.request.contextPath}/student/myResults" class="btn btn-outline-secondary">All My Results</a>
<a href="${pageContext.request.contextPath}/student/downloadResultPdf/${resultId}" class="btn btn-outline-primary">
<i class="bi bi-file-earmark-pdf-fill"></i> Download PDF Report
</a>
</div>

</div>

<script>
new Chart(document.getElementById('resultChart'), {
	type: 'doughnut',
	data: {
		labels: ['Correct', 'Wrong', 'Skipped'],
		datasets: [{
			data: [${correct}, ${wrong}, ${unattempted}],
			backgroundColor: ['#198754', '#dc3545', '#fd7e14'],
			borderWidth: 0
		}]
	},
	options: {
		plugins: { legend: { display: false } },
		cutout: '68%'
	}
});
</script>

</body>
</html>
