<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>Update Exam</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
rel="stylesheet">
<link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet">

</head>

<body class="bg-light">

<jsp:include page="adminHeader.jsp"/>

<div class="container mt-4">

<div class="card shadow">

<div class="card-header bg-primary text-white">

<h3>Update Exam</h3>

</div>

<div class="card-body">

<form:form action="${pageContext.request.contextPath}/admin/updateExam"
           method="post"
           modelAttribute="exam">

<form:hidden path="examId"/>
<form:hidden path="status"/>

<div class="mb-3">

<label>Exam Name</label>

<form:input path="examName"
            class="form-control"/>

<form:errors path="examName"
             cssClass="text-danger"/>

<c:if test="${not empty examExistError}">
    <div class="text-danger">
        ${examExistError}
    </div>
</c:if>

</div>

<div class="mb-3">

<label>Subject</label>

<form:select path="subject.subjectId"
             class="form-select">

    <form:option value="">
        Select Subject
    </form:option>

    <c:forEach items="${subjectList}" var="subject">

        <form:option value="${subject.subjectId}">
            ${subject.subjectName}
        </form:option>

    </c:forEach>

</form:select>

<form:errors path="subject.subjectId"
             cssClass="text-danger"/>

</div>

<div class="mb-3">

<label>Duration (Minutes)</label>

<form:input path="duration"
            type="number"
            class="form-control"/>

<form:errors path="duration"
             cssClass="text-danger"/>

</div>

<div class="mb-3">

<label>Total Marks</label>

<form:input path="totalMarks"
            type="number"
            class="form-control"/>

<form:errors path="totalMarks"
             cssClass="text-danger"/>

</div>

<div class="mb-3">

<label>Exam Date</label>

<form:input path="examDate"
            type="date"
            class="form-control"/>

<form:errors path="examDate"
             cssClass="text-danger"/>

</div>

<div class="mb-3">

<label>Start Time</label>

<form:input path="startTime"
            type="time"
            class="form-control"/>

<form:errors path="startTime"
             cssClass="text-danger"/>

</div>

<button class="btn btn-success">

Update Exam

</button>

</form:form>

</div>

</div>

</div>

</body>

</html>