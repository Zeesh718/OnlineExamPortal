<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>


<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>Update Question</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
rel="stylesheet">
<link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet">

</head>

<body class="bg-light">

<jsp:include page="adminHeader.jsp"/>

<div class="container mt-4">

<div class="card shadow">

<div class="card-header bg-primary text-white">

<h3>Update Question</h3>

</div>

<div class="card-body">

<form:form action="${pageContext.request.contextPath}/admin/updateQuestion" method="post" modelAttribute="question">

<div class="mb-3">
<form:hidden path="questionId"/>
<form:hidden path="status"/>
<!-- input type="hidden" name="questionId" value="${question.questionId}" >
<input type="hidden" name="status" value="${question.status}"-->

<label>Question</label>
<form:textarea path="questionText" class="form-control"/>
<!--textarea name="questionText"  class="form-control" required>${question.questionText}</textarea-->
<form:errors path="questionText" cssClass="text-danger"/>
</div>

<div class="mb-3">

<label>Option A</label>

<!--input type="text" name="optionA" value="${question.optionA}" class="form-control"-->
<form:input path="optionA"  class="form-control"/>
<form:errors path="optionA" cssClass="text-danger"/>
</div>

<div class="mb-3">

<label>Option B</label>

<!--input type="text" name="optionB" value="${question.optionB}" class="form-control"-->
<form:input path="optionB"  class="form-control"/>
<form:errors path="optionB" cssClass="text-danger"/>
</div>

<div class="mb-3">

<label>Option C</label>

<!--input type="text" name="optionC" value="${question.optionC}" class="form-control"-->
<form:input path="optionC"  class="form-control"/>
<form:errors path="optionC" cssClass="text-danger"/>
</div>

<div class="mb-3">

<label>Option D</label>

<!--input type="text" name="optionD" value="${question.optionD}" class="form-control"-->
<form:input path="optionD"  class="form-control"/>
<form:errors path="optionD" cssClass="text-danger"/>
</div>

<div class="mb-3">

<label>Correct Answer</label>

<!--select name="correctAnswer"  class="form-select">

<option>A</option>

<option>B</option>

<option>C</option>

<option>D</option>

</select-->
<form:select path="correctAnswer" class="form-select">

    <form:option value="">Select Correct Answer</form:option>

    <form:option value="A">Option A</form:option>
    <form:option value="B">Option B</form:option>
    <form:option value="C">Option C</form:option>
    <form:option value="D">Option D</form:option>

</form:select>
<form:errors path="correctAnswer"  cssClass="text-danger"/>

</div>


<div class="mb-3">

<label>Marks For This Question</label>

<!--input type="text" name="marks"  value="${question.marks}"class="form-control"-->
<form:input path="marks" class="form-control"/>
<form:errors path="marks"  cssClass="text-danger"/>
</div>

<div class="mb-3">

<label>Subject</label>

<!-- select name="subject.subjectId" class="form-select">

<c:forEach items="${subjectList}" var="subject">

<option value="${subject.subjectId}" ${question.subject.subjectId==subject.subjectId?'selected':''}>

${subject.subjectName}

</option>

</c:forEach>

</select-->



<form:select path="subject.subjectId"
             class="form-select"> <!-- ye jo ki alredy jis subject ka question hai wo hai  or ye question entity se aaya just like question.subject.suubjectId essa jo oehle karte the but jstl me question likjhne ki zarurrat nahi hoti hai direct nam likho to nam tha subject me subjectId ess-->

    <form:option value="">
        Select Subject
    </form:option>

    <c:forEach items="${subjectList}" var="subject"><!-- Ye baki ke sare subject uthane ke liye hai  -->

        <form:option value="${subject.subjectId}">
            ${subject.subjectName}
        </form:option>

    </c:forEach>

</form:select>

<form:errors path="subject.subjectId"   cssClass="text-danger"/>

</div>

<button class="btn btn-success">

Update Question

</button>

</form:form>

</div>

</div>

</div>

</body>

</html>