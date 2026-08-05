<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<style>

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
}

/* ================= HEADER ================= */

.student-header{
    width:100%;
    min-height:70px;

    background:#0d6efd;
    color:white;

    display:flex;
    justify-content:space-between;
    align-items:center;

    padding:0 40px;

    box-shadow:0 2px 8px rgba(0,0,0,0.12);
}


/* ================= LOGO ================= */

.student-logo{
    display:flex;
    align-items:center;
    gap:10px;

    font-size:23px;
    font-weight:700;

    white-space:nowrap;
}


/* ================= RIGHT AREA ================= */

.student-nav{
    display:flex;
    align-items:center;
    gap:8px;
}


/* ================= MENU LINKS ================= */

.student-nav > a{
    color:white;
    text-decoration:none;

    padding:9px 12px;

    border-radius:6px;

    font-size:15px;
    font-weight:500;

    transition:0.2s;
}

.student-nav > a:hover{
    background:rgba(255,255,255,0.15);
    color:white;
}


/* ================= USER SECTION ================= */

.student-user{
    display:flex;
    align-items:center;

    gap:10px;

    margin-left:15px;
    padding-left:18px;

    border-left:1px solid rgba(255,255,255,0.35);
}


/* ================= PROFILE IMAGE ================= */

.header-profile-image{

    width:42px;
    height:42px;

    border-radius:50%;

    object-fit:cover;

    border:2px solid white;

    background:white;
}


/* ================= DEFAULT AVATAR ================= */

.header-default-avatar{

    width:42px;
    height:42px;

    border-radius:50%;

    display:flex;
    align-items:center;
    justify-content:center;

    background:white;
    color:#0d6efd;

    font-size:21px;

    font-weight:bold;
}


/* ================= USER NAME ================= */

.student-user-info{
    line-height:1.2;
}

.student-welcome{
    font-size:11px;
    opacity:0.8;
}

.student-name{
    font-size:14px;
    font-weight:600;

    max-width:130px;
    overflow:hidden;
    text-overflow:ellipsis;
    white-space:nowrap;
}


/* ================= LOGOUT ================= */

.logout-link{
    margin-left:8px;

    background:rgba(255,255,255,0.12);
}

.logout-link:hover{
    background:#dc3545 !important;
}


/* ================= RESPONSIVE ================= */

@media(max-width:1000px){

    .student-header{
        padding:12px 20px;
        flex-direction:column;
        gap:12px;
    }

    .student-nav{
        flex-wrap:wrap;
        justify-content:center;
    }

}

</style>


<div class="student-header">


    <!-- ================= LOGO ================= -->

    <div class="student-logo">

        <span>Online Exam Portal</span>

    </div>



    <!-- ================= NAVIGATION ================= -->

    <div class="student-nav">


        <a href="${pageContext.request.contextPath}/student/dashboard">
            Dashboard
        </a>


        <a href="${pageContext.request.contextPath}/student/availableExams">
            Available Exams
        </a>


        <a href="${pageContext.request.contextPath}/student/myResults">
            My Results
        </a>


        <a href="${pageContext.request.contextPath}/student/editProfile">
            Profile
        </a>



        <!-- ================= LOGGED USER ================= -->

        <div class="student-user">


            <!-- USER KE PASS IMAGE HAI -->

            <c:if test="${not empty loggedInUserProfileImage}">

                <img
                    src="${pageContext.request.contextPath}/profile-images/${loggedInUserProfileImage}"
                    class="header-profile-image"
                    alt="Profile">

            </c:if>



            <!-- USER KE PASS IMAGE NAHI HAI -->

            <c:if test="${empty loggedInUserProfileImage}">

                <div class="header-default-avatar">

                    <!-- User ke naam ka first letter -->
                    ${loggedInUser.name.substring(0,1)}

                </div>

            </c:if>



            <!-- NAME -->

            <div class="student-user-info">

                <div class="student-welcome">
                    Welcome
                </div>

                <div class="student-name">
                    ${loggedInUser.name}
                </div>

                <c:if test="${not empty loggedInUser.studentId}">
                    <div class="student-id-badge" style="font-size:12px;opacity:0.85;letter-spacing:0.5px;">
                        ${loggedInUser.studentId}
                    </div>
                </c:if>

            </div>


        </div>



        <!-- ================= LOGOUT ================= -->

        <a
            href="${pageContext.request.contextPath}/logout"
            class="logout-link">

            Logout

        </a>


    </div>

</div>