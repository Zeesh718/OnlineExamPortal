<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>Add Exam Questions</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
rel="stylesheet">
<link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet">

</head>

<body class="bg-light">

<jsp:include page="adminHeader.jsp"/>

<div class="container mt-4">

<div class="d-flex justify-content-between mb-3">

<h2>Add Exam Questions</h2>



</div>
<form action="${pageContext.request.contextPath}/admin/saveExamQuestion" method="post">
<input type="hidden" name="examId" value="${examId}">
<table class="table table-bordered table-striped shadow">

<thead class="table-dark">

<tr>

<th>ID</th>

<th>Question</th>

<th>Correct Answer</th>

<th>Marks</th>

<th>Subject</th>

<th>Select</th>

<th>Action</th>

</tr>

</thead>

<tbody>

<c:forEach items="${subjectQuestionList}" var="questionn">

<tr>

<td> ${questionn.questionId}</td>
<td> ${questionn.questionText} <br>
A) ${questionn.optionA} &nbsp;&nbsp; B) ${questionn.optionB} &nbsp;&nbsp; C) ${questionn.optionC} &nbsp;&nbsp; D) ${questionn.optionD}
</td>

<td> ${questionn.correctAnswer}</td>
<td> ${questionn.marks}</td>

<td> ${questionn.subject.subjectName}</td>


<td>

<input type="checkbox" name="questionIds" value="${questionn.questionId}">

</td>

<td>

<a class="btn btn-warning btn-sm"

href="${pageContext.request.contextPath}/admin/updateQuestion/${questionn.questionId}">

Update

</a>





<a class="btn btn-danger btn-sm"

onclick="return confirm('Delete this Question?')"

href="${pageContext.request.contextPath}/admin/deleteQuestion/${questionn.questionId}">

Delete

</a>

</td>

</tr>

</c:forEach>

</tbody>

</table>

	 <div class="text-center">
	    
	   <button class="btn btn-success">
         Add Selected Questions To This Exam
	   </button> 
	   <a href="${pageContext.request.contextPath}/admin/viewExamDetails/${examId}"
                               class="btn btn-primary">
                                View Exam Details
                            </a>                      
	  </div>
</form>
</div>

</body>

</html>