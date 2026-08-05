<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Exam Details</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
rel="stylesheet">
<link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet">

</head>

<body class="bg-light">

<jsp:include page="adminHeader.jsp"/>

<div class="container mt-4">

    <div class="card shadow">

        <div class="card-header bg-primary text-white">
            <h3>Exam Details</h3>
        </div>

        <div class="card-body">

            <table class="table table-bordered">

                <tr>
                    <th width="25%">Exam Name</th>
                    <td>${exam.examName}</td>
                </tr>

                <tr>
                    <th>Subject</th>
                    <td>${exam.subject.subjectName}</td>
                </tr>

                <tr>
                    <th>Duration</th>
                    <td>${exam.duration} Minutes</td>
                </tr>

                <tr>
                    <th>Total Marks</th>
                    <td>${exam.totalMarks}</td>
                </tr>

                <tr>
                    <th>Exam Date</th>
                    <td>${exam.examDate}</td>
                </tr>

                <tr>
                    <th>Status</th>

                    <td>

                        <c:choose>

                            <c:when test="${exam.status}">
                                <span class="badge bg-success">Active</span>
                            </c:when>

                            <c:otherwise>
                                <span class="badge bg-danger">Inactive</span>
                            </c:otherwise>

                        </c:choose>

                    </td>

                </tr>

            </table>

        </div>

    </div>

    <br>

    <div class="card shadow">

        <div class="card-header bg-dark text-white">

            <h4>Assigned Questions</h4>

        </div>

        <div class="card-body">

            <table class="table table-striped table-bordered">

                <thead>

                <tr>

                    <th width="5%">#</th>

                    <th>Question</th>

                    <th width="12%">Correct Answer</th>

                    <th width="12%">Action</th>

                </tr>

                </thead>

                <tbody>

                <c:forEach items="${examQuestionList}" var="eqq" varStatus="i">

                    <tr>

                        <td>${i.count}</td>

                        <td>${eqq.question.questionText}</td>

                        <td>${eqq.question.correctAnswer}</td>

                        <td>

                            <a class="btn btn-danger btn-sm"

                               onclick="return confirm('Remove this Question?')"

                               href="${pageContext.request.contextPath}/admin/removeQuestion/${eqq.examQuestionId}/${exam.examId}">

                                Remove

                            </a>

                        </td>

                    </tr>

                </c:forEach>

                </tbody>

            </table>

        </div>

    </div>

    <br>

    <div class="text-end">

        <a href="${pageContext.request.contextPath}/admin/assignQuestions/${exam.examId}"

           class="btn btn-success">

            Add More Questions

        </a>

        <a href="${pageContext.request.contextPath}/admin/manageExams"

           class="btn btn-secondary">

            Back

        </a>

    </div>

</div>

</body>

</html>