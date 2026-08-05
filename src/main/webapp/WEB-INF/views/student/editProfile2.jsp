<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">
<title>Edit Profile</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
      rel="stylesheet">
<link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet">

</head>

<body class="bg-light">

<jsp:include page="studentHeader.jsp"/>

<div class="container mt-4 mb-5">

    <div class="row justify-content-center">

        <div class="col-md-8">

            <div class="card shadow">

                <div class="card-header bg-primary text-white">

                    <h3 class="mb-0">Edit Profile</h3>

                </div>


                <div class="card-body">

                    <!-- Success Message -->
                    <c:if test="${not empty profileMsg}">

                        <div class="alert alert-success">
                            ${profileMsg}
                        </div>

                    </c:if>


                    <form:form
                        action="${pageContext.request.contextPath}/student/editProfile"
                        method="post"
                        modelAttribute="profileDTO" 
                        enctype="multipart/form-data"
                        >
					<!-- modelAttribute="profileDTO" iska matlab controller se JSP open karte waqt 
					model me isi naam se object aana chahiye  model.addAttribute("profileDTO", profileDTO); -->

                        <!-- ================= NAME ================= -->

                        <div class="mb-3">

                            <label class="form-label">
                                Name
                            </label>

                            <form:input
                                path="name"
                                class="form-control"
                                placeholder="Enter your name"/>

                            <form:errors
                                path="name"
                                cssClass="text-danger"/>

                        </div>


                        <!-- ================= EMAIL ================= -->

                        <div class="mb-3">

                            <label class="form-label">
                                Email
                            </label>

                            <form:input
                                path="email"
                                class="form-control"
                                readonly="true"/>

                            <small class="text-muted">
                                Email cannot be changed from profile.
                            </small>

                        </div>


                        <!-- ================= MOBILE ================= -->

                        <div class="mb-3">

                            <label class="form-label">
                                Mobile Number
                            </label>

                            <form:input
                                path="mobile"
                                class="form-control"
                                placeholder="Enter mobile number"/>

                            <form:errors
                                path="mobile"
                                cssClass="text-danger"/>

                        </div>


                        <!-- ================= DOB ================= -->

                        <div class="mb-3">

                            <label class="form-label">
                                Date Of Birth
                            </label>

                            <form:input
                                path="dateOfBirth"
                                type="date"
                                class="form-control"/>

                            <form:errors
                                path="dateOfBirth"
                                cssClass="text-danger"/>

                        </div>


                        <!-- ================= GENDER ================= -->

                        <div class="mb-3">

                            <label class="form-label">
                                Gender
                            </label>

                            <form:select
                                path="gender"
                                class="form-select">

                                <form:option value="">
                                    Select Gender
                                </form:option>

                                <form:option value="Male">
                                    Male
                                </form:option>

                                <form:option value="Female">
                                    Female
                                </form:option>

                                <form:option value="Other">
                                    Other
                                </form:option>

                            </form:select>

                            <form:errors
                                path="gender"
                                cssClass="text-danger"/>

                        </div>


                        <!-- ================= ADDRESS ================= -->

                        <div class="mb-3">

                            <label class="form-label">
                                Address
                            </label>

                            <form:textarea
                                path="address"
                                class="form-control"
                                rows="3"
                                placeholder="Enter your address"/>

                            <form:errors
                                path="address"
                                cssClass="text-danger"/>

                        </div>


                        <!-- ================= CITY ================= -->

                        <div class="mb-3">

                            <label class="form-label">
                                City
                            </label>

                            <form:input
                                path="city"
                                class="form-control"
                                placeholder="Enter your city"/>

                            <form:errors
                                path="city"
                                cssClass="text-danger"/>

                        </div>


                        <!-- ================= QUALIFICATION ================= -->

                        <div class="mb-3">

                            <label class="form-label">
                                Qualification
                            </label>

                            <form:input
                                path="qualification"
                                class="form-control"
                                placeholder="Enter your qualification"/>

                            <form:errors
                                path="qualification"
                                cssClass="text-danger"/>

                        </div>


                        <!-- ================= BIO ================= -->

                        <div class="mb-3">

                            <label class="form-label">
                                Bio
                            </label>

                            <form:textarea
                                path="bio"
                                class="form-control"
                                rows="4"
                                placeholder="Write something about yourself"/>

                            <form:errors
                                path="bio"
                                cssClass="text-danger"/>

                        </div>


                        <!-- ================= PROFILE IMAGE ================= -->
<!-- Agar user ki profile image pehle se saved hai -->
<c:if test="${not empty profileDTO.existingProfileImage}">

    <div class="mb-3 text-center">

        <img
            src="${pageContext.request.contextPath}/profile-images/${profileDTO.existingProfileImage}"
            alt="Profile Image"
            width="150"
            height="150"
            style="object-fit: cover; border-radius: 50%;">

    </div>

</c:if>
                        <div class="mb-3">

                            <label class="form-label">
                                Profile Image
                            </label>

                            <input
                                type="file"
                                name="profileImage"
                                class="form-control"
                                accept="image/jpeg,image/png,image/webp">

                        </div>


                        <!-- ================= BUTTON ================= -->

                        <div class="d-grid">

                           
                            <c:choose>

    <c:when test="${profileCompleted}">
        <button type="submit" class="btn btn-primary">
            Update Profile
        </button>
    </c:when>

    <c:otherwise>
        <button type="submit" class="btn btn-success">
            Complete Profile
        </button>
    </c:otherwise>

</c:choose>

                        </div>


                    </form:form>

                </div>

            </div>

        </div>

    </div>

</div>

</body>

</html>