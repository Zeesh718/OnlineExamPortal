<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>    

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Subject</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
      rel="stylesheet">
<link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet">

</head>
<body class="bg-light">

<jsp:include page="adminHeader.jsp"/>

<div class="container mt-5">

    <div class="row justify-content-center">

        <div class="col-md-6">

            <div class="card shadow">

                <div class="card-header bg-primary text-white">
                    <h3 class="text-center">Add Subject</h3>
                </div>

                <div class="card-body">

                    
                          
                    <form:form action="${pageContext.request.contextPath}/admin/saveSubject"
				           method="post"
				           modelAttribute="subject">      

                        <div class="mb-3">

                            <label class="form-label">
                                Subject Name
                            </label>

                            
                                   
                                   
                             <form:input path="subjectName"
					            class="form-control" placeholder="Enter Subject Name"
                                   />
					
					         <form:errors path="subjectName"
					             cssClass="text-danger"/>      
        					<span class="text-danger"> ${subjectError}</span>
                        </div>

                        <div class="text-center">

                            <button class="btn btn-success">
                                Save Subject
                            </button>

                            <a href="${pageContext.request.contextPath}/admin/manageSubjects"
                               class="btn btn-secondary">
                                View Subjects
                            </a>

                        </div>

                    </form:form>

                </div>

            </div>

        </div>

    </div>

</div>

</body>
</html>