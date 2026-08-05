<%@ page contentType="text/html;charset=UTF-8"%>

<!DOCTYPE html>

<html>

<head>

<title>Error</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
rel="stylesheet">
<link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet">

</head>

<body class="bg-light">

<div class="container mt-5">

<div class="alert alert-danger text-center">

<h2>Something Went Wrong</h2>

<h2>${errorTitle}</h2>

<p>${errorMessage}</p>

<a href="javascript:history.back()"
class="btn btn-primary">

Go Back

</a>

</div>

</div>

</body>

</html>