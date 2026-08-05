<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>Add Question</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
rel="stylesheet">
<link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet">

</head>

<body class="bg-light">

<jsp:include page="adminHeader.jsp"/>

<div class="container mt-4">

<div class="card shadow">

<div class="card-header bg-primary text-white">

<h3>Add Question</h3>

</div>

<div class="card-body">

<form:form action="${pageContext.request.contextPath}/admin/saveQuestion" method="post" modelAttribute="question">
<div class="mb-3">

<label>Question</label>

<form:textarea path="questionText" class="form-control" placeholder="Enter Question"/>

<form:errors path="questionText" cssClass="text-danger"/>
</div>

<div class="mb-3">

<label>Option A</label>

<form:input path="optionA" placeholder="Enter Option A" class="form-control"/>

<form:errors path="optionA" cssClass="text-danger"/>

</div>

<div class="mb-3">

<label>Option B</label>

<form:input path="optionB" placeholder="Enter Option B" class="form-control"/>

<form:errors path="optionB" cssClass="text-danger"/>

</div>

<div class="mb-3">

<label>Option C</label>

<form:input path="optionC" placeholder="Enter Option C" class="form-control"/>

<form:errors path="optionC" cssClass="text-danger"/>

</div>

<div class="mb-3">

<label>Option D</label>

<form:input path="optionD"  placeholder="Enter Option D" class="form-control"/>

<form:errors path="optionD" cssClass="text-danger"/>

</div>

<div class="mb-3">

<label>Correct Answer</label>


<form:select path="correctAnswer" class="form-select">

    <form:option value="">Select Correct Answer</form:option>

    <form:option value="A">Option A</form:option>
    <form:option value="B">Option B</form:option>
    <form:option value="C">Option C</form:option>
    <form:option value="D">Option D</form:option>

</form:select>

<form:errors path="correctAnswer" cssClass="text-danger"/>

</div>


<div class="mb-3">

<label>Marks For This Question</label>

<form:input path="marks" type="number" class="form-control"/>

<form:errors path="marks" cssClass="text-danger"/>

</div>

<div class="mb-3">

<label>Subject</label>

<form:select path="subject.subjectId" class="form-select">

    <form:option value="">Select Subject</form:option>

    <c:forEach items="${subjectList}" var="subject">

        <form:option value="${subject.subjectId}">
            ${subject.subjectName}
        </form:option>

    </c:forEach>

</form:select>

<form:errors path="subject.subjectId" cssClass="text-danger"/>

</div>

<button class="btn btn-success">
    Add Question
</button>

</form:form>

</div>

</div>

</div>

</body>

</html>