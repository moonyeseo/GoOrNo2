<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
 
<!DOCTYPE html>
<html lang="en">

<head>

<!-- yoon 작성 -->
<style type="text/css">
.err {
	color: red;
	size: 1em;
}
</style>

<!-- moonyeseo 추가 -->
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	$('#asideChatbot').hide();

	/* 챗봇 페이지 이동 */
	$("#chatbot").click(function() {
		$("#asideChatbot").toggle();
		$("#inputText").focus();
	});

});
</script>

<!-- 공통 영역 -->
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@100;200;300;400;500;600;700;800;900&display=swap"
	rel="stylesheet">

<title>GoOrNo</title>

<!-- Bootstrap core CSS -->
<link
	href="<%=request.getContextPath()%>/resources/vendor/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">

<!-- Additional CSS Files -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/assets/css/fontawesome.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/assets/css/templatemo-digimedia-v1.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/assets/css/animated.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/assets/css/owl.css">

<!--

TemplateMo 568 DigiMedia

https://templatemo.com/tm-568-digimedia

-->

<!-- 한글 글씨체(추가) -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap"
	rel="stylesheet">

</head>

<body>

	<!-- ***** Preloader Start ***** -->
	<div id="js-preloader" class="js-preloader">
		<div class="preloader-inner">
			<span class="dot"></span>
			<div class="dots">
				<span></span> <span></span> <span></span>
			</div>
		</div>
	</div>
	<!-- ***** Preloader End ***** -->

	<!-- Pre-header Starts -->
	<div class="pre-header">
		<div class="container">
			<div class="row">
				<!-- 				<div class="col-lg-8 col-sm-8 col-7">
					<ul class="social-media">
						<li><a href="#"><i class="fa fa-facebook"></i></a></li>
						<li><a href="#"><i class="fa fa-behance"></i></a></li>
						<li><a href="#"><i class="fa fa-twitter"></i></a></li>
						<li><a href="#"><i class="fa fa-dribbble"></i></a></li>
					</ul>
				</div> -->
				<div class="col-lg-4 col-sm-4 col-5">
					<ul class="info">
						<c:if test="${ loginInfo eq null }">
							<li><a href="login.users">Login</a></li>
						</c:if>
						<c:if test="${ loginInfo ne null }">
							<li><a href="#">${sessionScope.loginInfo.id }님</a></li>
							<li><a href="Logout.jsp">Logout</a></li>
						</c:if>
						<li><a href="join.users">Join</a></li>
					</ul>
				</div>
			</div>
		</div>
	</div>
	<!-- Pre-header End -->

	<!-- ***** Header Area Start ***** -->
	<header class="header-area header-sticky wow slideInDown"
		data-wow-duration="0.75s" data-wow-delay="0s">
		<div class="container">
			<div class="row">
				<div class="col-12">
					<nav class="main-nav">
						<!-- ***** Logo Start ***** -->
						<a href="#" class="logo"> <img
							src="<%=request.getContextPath()%>/resources/image/GoOrNo_logo.png"
							alt="logo" width="80px" height="60px">
						</a>
						<!-- ***** Logo End ***** -->
						<!-- ***** Menu Start ***** -->
						<ul class="nav">
							<li class="scroll-to-section"><a
								href="<%=request.getContextPath() %>/main.jsp" class="active">Home</a></li>
							<li class="scroll-to-section"><a href="search.bookmark">Navigation</a></li>
							<li class="scroll-to-section"><a href="list.event">Event</a></li>
							<li class="scroll-to-section"><a class="dropdown-toggle"
								href="list.board" role="button" data-bs-toggle="dropdown"
								aria-expanded="false"> Community </a>
								<ul class="dropdown-menu">
									<li><a class="dropdown-item" href="list.board">자유게시판</a></li>
									<li><a class="dropdown-item" href="list.companion">동행게시판</a></li>
									<li></li>
								</ul></li>
							<li class="scroll-to-section"><a class="dropdown-toggle"
								href="list.notice" role="button" data-bs-toggle="dropdown"
								aria-expanded="false"> Notice </a>
								<ul class="dropdown-menu">
									<li><a class="dropdown-item" href="list.notice">공지사항</a></li>
									<li><a class="dropdown-item" href="list.qna">Q&A</a></li>
									<li><a class="dropdown-item" href="list.faq">FAQ</a></li>
									<li></li>
								</ul></li>
							<li class="scroll-to-section"><div
									class="border-first-button">
									<a href="mypage.users">My Page</a>
								</div></li>
						</ul>
						<a class='menu-trigger'> <span>Menu</span>
						</a>
						<!-- ***** Menu End ***** -->
					</nav>
				</div>
			</div>
		</div>
	</header>
	<!-- ***** Header Area End ***** -->