<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Exam Details</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet">

<style>

body{
    font-family:Arial, sans-serif;
    background:#f4f6f9;
    margin:0;
    padding:0;
}

.container{
    width:70%;
    margin:40px auto;
    background:white;
    padding:30px;
    border-radius:10px;
    box-shadow:0 0 12px rgba(0,0,0,.12);
}

h2{
    text-align:center;
    color:#0d6efd;
    margin-bottom:30px;
}

table{
    width:100%;
    border-collapse:collapse;
}

table td{
    padding:15px;
    border-bottom:1px solid #ddd;
}

.label{
    width:35%;
    font-weight:bold;
    background:#f8f9fa;
}

.instructions{
    margin-top:30px;
    padding:20px;
    background:#fff8e1;
    border-left:5px solid orange;
    border-radius:5px;
}

.instructions h3{
    margin-top:0;
    color:#d35400;
}

.instructions ul{
    padding-left:22px;
}

.instructions li{
    margin:10px 0;
    line-height:1.5;
}

.action-box{
    margin-top:35px;
    text-align:center;
}

.attempted-box{
    display:flex;
    flex-direction:column;
    align-items:center;
}

.attempted-badge{
    display:inline-block;
    background:#d4edda;
    color:#155724;
    border:1px solid #28a745;
    padding:15px 30px;
    border-radius:8px;
    font-size:22px;
    font-weight:bold;
}

.attempted-message{
    margin-top:10px;
    margin-bottom:25px;
    color:#666;
    font-size:16px;
}

.button-group{
    display:flex;
    justify-content:center;
    gap:20px;
    flex-wrap:wrap;
}

.btn{
    display:inline-block;
    min-width:180px;
    text-align:center;
    text-decoration:none;
    color:white;
    font-size:18px;
    background:#0d6efd;
    padding:13px 25px;
    border-radius:6px;
    transition:.3s;
}

.btn:hover{
    background:#0b5ed7;
}

.back{
    background:#6c757d;
}

.back:hover{
    background:#5a6268;
}

.start{
    background:#198754;
}

.start:hover{
    background:#157347;
}

</style>

</head>
<body>

<%@ include file="studentHeader.jsp"%>

<div class="container">

<h2>Exam Details</h2>

<table>

<tr>
    <td class="label">Exam Name</td>
    <td>${exam.examName}</td>
</tr>

<tr>
    <td class="label">Subject</td>
    <td>${exam.subject.subjectName}</td>
</tr>

<tr>
    <td class="label">Exam Date</td>
    <td>${exam.examDate}</td>
</tr>

<tr>
    <td class="label">Duration</td>
    <td>${exam.duration} Minutes</td>
</tr>

<tr>
    <td class="label">Total Marks</td>
    <td>${exam.totalMarks}</td>
</tr>

</table>

<div class="instructions">

<h3>Exam Instructions</h3>

<ul>

<li>Read every question carefully before selecting your answer.</li>

<li>Each question carries equal marks unless mentioned otherwise.</li>

<li>Once the exam starts, do not refresh or close the browser.</li>

<li>Use only the provided navigation buttons.</li>

<li>Submit the exam before the allotted time expires.</li>

<li>If the timer ends, your exam will be submitted automatically.</li>

<li>Do not open another browser tab or window during the exam.</li>

<li>Only one attempt is allowed for each exam.</li>

<li>Any unfair means may lead to cancellation of your attempt.</li>

<li>Click <b>Start Exam</b> only when you are completely ready.</li>

</ul>

</div>

<div class="action-box">

<c:choose>

<c:when test="${exam.attemted}">

<div class="attempted-box">

<div class="attempted-badge">
✔ Exam Already Submitted
</div>

<div class="attempted-message">
You have already attempted this exam. You can view your result anytime.
</div>

<div class="button-group">

<a href="${pageContext.request.contextPath}/student/viewResult/${exam.examId}"
class="btn">
View Result
</a>

<a href="${pageContext.request.contextPath}/student/availableExams"
class="btn back">
Back
</a>

</div>

</div>

</c:when>

<c:otherwise>

<div class="button-group">

<a href="${pageContext.request.contextPath}/student/startExam/${exam.examId}"
class="btn start">
Start Exam
</a>

<a href="${pageContext.request.contextPath}/student/availableExams"
class="btn back">
Back
</a>

</div>

</c:otherwise>

</c:choose>

</div>

</div>

</body>
</html>