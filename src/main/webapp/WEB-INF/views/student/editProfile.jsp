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

<!-- Default profile icon ke liye -->
<link rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<style>

    .profile-card {
        border: none;
        border-radius: 15px;
        overflow: hidden;
    }

    /* Left profile section */
    .profile-left {
        background: #f8f9fa;
        border-right: 1px solid #dee2e6;
        min-height: 100%;
    }

    /* Actual profile image */
    .profile-image {
        width: 160px;
        height: 160px;
        object-fit: cover;
        border-radius: 50%;
        border: 5px solid white;
        box-shadow: 0 3px 12px rgba(0,0,0,0.15);
    }

    /* Image nahi hone par avatar */
    .default-avatar {
        width: 160px;
        height: 160px;
        border-radius: 50%;

        display: flex;
        justify-content: center;
        align-items: center;

        background: #e9ecef;
        border: 5px solid white;
        box-shadow: 0 3px 12px rgba(0,0,0,0.15);

        font-size: 80px;
        color: #6c757d;

        margin: auto;
    }

</style>

</head>


<body class="bg-light">

<jsp:include page="studentHeader.jsp"/>


<div class="container mt-4 mb-5">

    <div class="card shadow profile-card">


        <!-- ================= HEADER ================= -->

        <div class="card-header bg-primary text-white p-3">

            <h3 class="mb-0">
                My Profile
            </h3>

        </div>


        <div class="card-body p-0">


            <!-- SUCCESS MESSAGE -->

            <c:if test="${not empty profileMsg}">

                <div class="alert alert-success m-3">
                    ${profileMsg}
                </div>

            </c:if>



            <form:form
                action="${pageContext.request.contextPath}/student/editProfile"
                method="post"
                modelAttribute="profileDTO"
                enctype="multipart/form-data">


                <div class="row g-0">


                    <!-- ================================================= -->
                    <!-- LEFT SIDE : PROFILE IMAGE                         -->
                    <!-- ================================================= -->

                    <div class="col-md-3 profile-left p-4 text-center">


                        <!-- Image already hai -->

                        <c:if test="${not empty profileDTO.existingProfileImage}">

                            <img
                                src="${pageContext.request.contextPath}/profile-images/${profileDTO.existingProfileImage}"
                                class="profile-image"
                                alt="Profile Image">

                        </c:if>



                        <!-- Image nahi hai -->

                        <c:if test="${empty profileDTO.existingProfileImage}">

                            <div class="default-avatar">

                                <i class="bi bi-person-fill"></i>

                            </div>

                        </c:if>


                        <h5 class="mt-3 mb-1">
                            ${profileDTO.name}
                        </h5>

                        <small class="text-muted">
                            ${profileDTO.email}
                        </small>


                        <!-- Upload image -->

                        <div class="mt-4 text-start">

                            <label class="form-label fw-semibold">
                                Profile Photo
                            </label>

                            <input
                                type="file"
                                name="profileImage"
                                class="form-control form-control-sm"
                                accept="image/jpeg,image/png,image/webp">

                            <small class="text-muted">
                                JPG, PNG or WEBP
                            </small>

                        </div>


                    </div>



                    <!-- ================================================= -->
                    <!-- RIGHT SIDE : PROFILE INFORMATION                  -->
                    <!-- ================================================= -->

                    <div class="col-md-9 p-4">


                        <h5 class="mb-4">
                            Personal Information
                        </h5>


                        <!-- ROW 1 -->

                        <div class="row">


                            <!-- NAME -->

                            <div class="col-md-6 mb-3">

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



                            <!-- MOBILE -->

                            <div class="col-md-6 mb-3">

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


                        </div>



                        <!-- ROW 2 -->

                        <div class="row">


                            <!-- EMAIL -->

                            <div class="col-md-6 mb-3">

                                <label class="form-label">
                                    Email
                                </label>

                                <form:input
                                    path="email"
                                    class="form-control"
                                    readonly="true"/>

                                <small class="text-muted">
                                    Email cannot be changed.
                                </small>

                            </div>



                            <!-- DOB -->

                            <div class="col-md-6 mb-3">

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


                        </div>



                        <!-- ROW 3 -->

                        <div class="row">


                            <!-- GENDER -->

                            <div class="col-md-6 mb-3">

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



                            <!-- CITY -->

                            <div class="col-md-6 mb-3">

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


                        </div>



                        <!-- ADDRESS -->

                        <div class="mb-3">

                            <label class="form-label">
                                Address
                            </label>

                            <form:textarea
                                path="address"
                                class="form-control"
                                rows="2"
                                placeholder="Enter your address"/>

                            <form:errors
                                path="address"
                                cssClass="text-danger"/>

                        </div>



                        <!-- LAST ROW -->

                        <div class="row">


                            <!-- QUALIFICATION -->

                            <div class="col-md-6 mb-3">

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



                            <!-- BIO -->

                            <div class="col-md-6 mb-3">

                                <label class="form-label">
                                    Bio
                                </label>

                                <form:textarea
                                    path="bio"
                                    class="form-control"
                                    rows="2"
                                    placeholder="Write something about yourself"/>

                                <form:errors
                                    path="bio"
                                    cssClass="text-danger"/>

                            </div>


                        </div>



                        <!-- BUTTON -->

                        <div class="text-end mt-2">

                            <c:choose>

                                <c:when test="${profileCompleted}">

                                    <button
                                        type="submit"
                                        class="btn btn-primary px-5">

                                        Update Profile

                                    </button>

                                </c:when>


                                <c:otherwise>

                                    <button
                                        type="submit"
                                        class="btn btn-success px-5">

                                        Complete Profile

                                    </button>

                                </c:otherwise>

                            </c:choose>

                        </div>


                    </div>

                </div>


            </form:form>

        </div>

    </div>

</div>


</body>
</html>