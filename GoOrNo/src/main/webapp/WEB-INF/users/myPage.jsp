<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "../userCommon/userHeader.jsp" %>

<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">
  <meta name="robots" content="noindex, nofollow">
  <meta content="" name="description">
  <meta content="" name="keywords">

  <!-- Favicons -->
  <link href="<%=request.getContextPath() %>/resources/assetsAdmin/img/favicon.png" rel="icon">
  <link href="<%=request.getContextPath() %>/resources/assetsAdmin/img/apple-touch-icon.png" rel="apple-touch-icon">

  <!-- Google Fonts -->
  <link href="https://fonts.gstatic.com" rel="preconnect">
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">

  <!-- Vendor CSS Files -->
  <link href="<%=request.getContextPath() %>/resources/assetsAdmin/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <link href="<%=request.getContextPath() %>/resources/assetsAdmin/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
  <link href="<%=request.getContextPath() %>/resources/assetsAdmin/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
  <link href="<%=request.getContextPath() %>/resources/assetsAdmin/vendor/quill/quill.snow.css" rel="stylesheet">
  <link href="<%=request.getContextPath() %>/resources/assetsAdmin/vendor/quill/quill.bubble.css" rel="stylesheet">
  <link href="<%=request.getContextPath() %>/resources/assetsAdmin/vendor/remixicon/remixicon.css" rel="stylesheet">
  <link href="<%=request.getContextPath() %>/resources/assetsAdmin/vendor/simple-datatables/style.css" rel="stylesheet">

  <!-- Template Main CSS File -->
  <link href="<%=request.getContextPath() %>/resources/assetsAdmin/css/style.css" rel="stylesheet">

  <!-- =======================================================
  * Template Name: NiceAdmin
  * Template URL: https://bootstrapmade.com/nice-admin-bootstrap-admin-html-template/
  * Updated: Apr 20 2024 with Bootstrap v5.3.3
  * Author: BootstrapMade.com
  * License: https://bootstrapmade.com/license/
  ======================================================== -->
  
<style>

body {
  font-family: "Open Sans", sans-serif;
  background: #FFE6EB;
  color: #444444;
}

.profile .bookmark-spot .label {
  font-weight: 600;
  color: rgba(1, 41, 112, 0.6);
  margin-bottom: 10px;
  font-size: 15px;
}
	
/* 섹션 사이에 선 추가 */
.pagetitle {
  border-top: 1px solid #dee2e6;
  margin-top: 20px;
  padding-top: 20px;
}

/* 마지막 섹션의 아래쪽 선 제거 */
.pagetitle:last-of-type {
  border-top: none;
}

#profile-section .pagetitle {
  background-color: #FFE6EB; /* 원하는 배경색으로 변경 */
}

#bookmark-section .pagetitle {
  background-color: #FFE6EB; /* 원하는 배경색으로 변경 */
}

#board-section .pagetitle {
  background-color: #FFE6EB; /* 원하는 배경색으로 변경 */
}

.bookmark-item {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 10px;
  border-bottom: 1px solid #dee2e6;
}

.bookmark-item:last-child {
  border-bottom: none;
}

.bookmark-info {
  display: flex;
  align-items: center;
  word-wrap: break-word;
  width: 100%;
}

.bookmark-info i {
  font-size: 24px;
  margin-right: 10px;
}

.bookmark-info div {
  display: flex;
  flex-direction: column;
  width: 100%;
}

.bookmark-actions {
  display: flex;
  align-items: center;
  gap: 10px;
}

.bookmark-actions button {
  border: none;
  background: none;
  cursor: pointer;
}

.bookmark-actions button i {
  font-size: 18px;
  color: #6c757d;
}

.bookmark-actions button:hover i {
  color: #000;
}

/* 관심목록 */
.icon-button {
  border: none; 
  background: none; 
  padding: 0; 
  cursor: pointer;
  position: absolute;
  top: 10px; 
  left: 10px;
}

.icon-button i {
  font-size: 24px; 
  color: #fa64b0; /* 채워진 하트 색상 */
  transition: color 0.3s;
}

.icon-button i.bi-heart {
  display: none;
}

.icon-button:hover i.bi-heart-fill {
  display: none;
}

.icon-button:hover i.bi-heart {
  display: inline-block;
}

.image-container {
  position: relative; 
  display: inline-block;
}

.image-container img {
  width: 100%; 
  height: auto;
}

.bookmark-event img {
    display: block;
    width: 100%;
    height: auto;
}

.section {
  padding-top: 50px;
  margin-top: -50px;
}

.scrollable {
  max-height: 400px;
  overflow-y: auto;
}

</style>


</head>



<body>
<%-- 
<!-- ============ Header ============ -->
<header id="header" class="header fixed-top d-flex align-items-center">
	
<!-- -----최상단----- -->
	<nav class="header-nav ms-auto">
		<ul class="d-flex align-items-center">

		<!-- -----채팅(채팅 아이콘) 시작----- -->
		<li class="nav-item dropdown">
			<a class="nav-link nav-icon" href="#" data-bs-toggle="dropdown">
				<i class="bi bi-chat-left-text"></i>
				<span class="badge bg-success badge-number">3</span>
			</a>
		
		<!-- 채팅 메시지 관련 -->
		<ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow messages">
		<li class="dropdown-header">
			You have 3 new messages
			<a href="#"><span class="badge rounded-pill bg-primary p-2 ms-2">View all</span></a>
		</li>
		
		<li><hr class="dropdown-divider"></li>

		<li class="message-item">
			<a href="#">
				<img src="<%=request.getContextPath() %>/resources/assetsAdmin/img/messages-1.jpg" alt="" class="rounded-circle">
			<div>
				<h4>Maria Hudson</h4>
				<p>Velit asperiores et ducimus soluta repudiandae labore officia est ut...</p>
				<p>4 hrs. ago</p>
			</div>
			</a>
		</li>
		
		<li><hr class="dropdown-divider"></li>

		<li class="message-item">
			<a href="#">
				<img src="<%=request.getContextPath() %>/resources/assetsAdmin/img/messages-2.jpg" alt="" class="rounded-circle">
			<div>
				<h4>Anna Nelson</h4>
				<p>Velit asperiores et ducimus soluta repudiandae labore officia est ut...</p>
				<p>6 hrs. ago</p>
			</div>
			</a>
		</li>
            
		<li><hr class="dropdown-divider"></li>

		<li class="message-item">
			<a href="#">
				<img src="<%=request.getContextPath() %>/resources/assetsAdmin/img/messages-3.jpg" alt="" class="rounded-circle">
			<div>
				<h4>David Muldon</h4>
				<p>Velit asperiores et ducimus soluta repudiandae labore officia est ut...</p>
				<p>8 hrs. ago</p>
			</div>
			</a>
		</li>

		<li><hr class="dropdown-divider"></li>

		<li class="dropdown-footer">
			<a href="#">Show all messages</a>
		</li>

		</ul><!-- End Messages Dropdown Items -->

        </li><!-- End Messages Nav -->
		<!-- -----채팅(채팅 아이콘) 끝----- -->


		<!-- -----프로필(프로필 아이콘) 시작----- -->
		<li class="nav-item dropdown pe-3">	
			<a class="nav-link nav-profile d-flex align-items-center pe-0" href="#" data-bs-toggle="dropdown">
				<img src="${pageContext.request.contextPath}/resources/uploadImage/${usersBean.profile}" alt="Profile" class="rounded-circle">
				<span class="d-none d-md-block dropdown-toggle ps-2">${usersBean.id}</span>
			</a><!-- End Profile Iamge Icon -->
		
		<!-- 프로필 메시지 관련 -->
		<ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow profile">
		<li class="dropdown-header">
			<h6>${usersBean.id}</h6>
			<span>${usersBean.name}</span>
		</li>

		<li><hr class="dropdown-divider"></li>

		<li>
			<a class="dropdown-item d-flex align-items-center" href="#profile-section">
				<i class="bi bi-person"></i>
				<span>My Page</span>
			</a>
		</li>

		<li><hr class="dropdown-divider"></li>

		<li>
			<a class="dropdown-item d-flex align-items-center" href="">
				<i class="bi bi-gear"></i>
				<span>Account Settings</span>
			</a>
		</li>

		<li><hr class="dropdown-divider"></li>

		<li>
			<a class="dropdown-item d-flex align-items-center" href="#">
				<i class="bi bi-box-arrow-right"></i>
				<span>Sign Out</span>
			</a>
		</li>

		</ul><!-- End Profile Dropdown Items -->
		
        </li><!-- End Profile Nav -->
		<!-- -----프로필(프로필 아이콘) 끝----- -->

		</ul>
	</nav><!-- End Icons Navigation -->
</header><!-- End Header -->
 --%>
  

<!-- ============ Sidebar(사이드바) ============ -->
	<aside id="sidebar" class="sidebar" style="z-index: 900; position: fixed;">

		<ul class="sidebar-nav" id="sidebar-nav">

			<li class="nav-heading">MY PAGE</li>

			<li class="nav-item">
				<a class="nav-link" href="#profile-section">
					<i class="bi bi-person"></i>
					<span>Profile</span>
				</a>
			</li><!-- End Profile Page Nav -->

			<li class="nav-item">
				<a class="nav-link collapsed" href="#bookmark-section">
					<i class="bi bi-bookmark"></i>
					<span>Bookmark</span>
				</a>
			</li><!-- End Bookmark Page Nav -->

			<li class="nav-item">
				<a class="nav-link collapsed" href="#board-section">
					<i class="bi bi-person"></i>
					<span>MyBoard</span>
				</a>
			</li><!-- End MyBoard Page Nav -->

		</ul>

	</aside><!-- End Sidebar-->



<!-- ============ Main ============ -->
<main id="main" class="main">

<!-- -----프로필 페이지 소제목 시작----- -->
<section class="section profile" id="profile-section">
	<div class="pagetitle" id="profile-section">
		<h1>MY PAGE</h1>
		<br>
		<nav>
			<ol class="breadcrumb">
			<li class="breadcrumb-item active">Profile</li>
			</ol>
		</nav>
	</div><!-- End Page Title -->
<!-- -----프로필 페이지 소제목 끝----- -->


<!-- -----프로필 페이지 카드 시작----- -->
	<div class="row">
		<div class="col-xl-8">
			<div class="card">
			<div class="card-body profile-card pt-4 d-flex flex-column align-items-center">

				<img src="${pageContext.request.contextPath}/resources/uploadImage/${usersBean.profile}" alt="Profile" class="rounded-circle">
				<h2>${usersBean.id}</h2>
				<h3>${usersBean.name}</h3>
			</div>
			</div>
		</div>
	</div>
<!-- -----프로필 페이지 카드 끝----- -->


<!-- -----프로필 페이지 메인 내용 시작----- -->
		<!-- -----상세 탭----- -->
	<div class="row">
		<div class="col-xl-8">
			<div class="card">
			<div class="card-body pt-3">
			
			<!-- Bordered Tabs -->
			<ul class="nav nav-tabs nav-tabs-bordered">

			<li class="nav-item">
				<button class="nav-link active" data-bs-toggle="tab" data-bs-target="#profile-overview">내정보</button>
			</li>

			<li class="nav-item">
				<button class="nav-link" data-bs-toggle="tab" data-bs-target="#profile-edit">프로필 수정</button>
			</li>

			<li class="nav-item">
				<button class="nav-link" data-bs-toggle="tab" data-bs-target="#profile-change-password">비밀번호 변경</button>
			</li>
			
			</ul>
                
                
			<!-- -----내정보 상세 내용----- -->
			<div class="tab-content pt-2">
			<div class="tab-pane fade show active profile-overview" id="profile-overview">
			
				<div class="row">
					<div class="col-lg-3 col-md-4 label">아이디</div>
					<div class="col-lg-9 col-md-8">${usersBean.id}</div>
				</div>
				
				<div class="row">
					<div class="col-lg-3 col-md-4 label">이름</div>
					<div class="col-lg-9 col-md-8">${usersBean.name}</div>
				</div>

				<div class="row">
					<div class="col-lg-3 col-md-4 label">이메일</div>
					<div class="col-lg-9 col-md-8">${usersBean.email}</div>
				</div>
				
				<div class="row">
					<div class="col-lg-3 col-md-4 label">휴대폰번호</div>
					<div class="col-lg-9 col-md-8">${usersBean.phoneNum}</div>
				</div>
				
				<div class="row">
					<div class="col-lg-3 col-md-4 label">주소</div>
					<div class="col-lg-9 col-md-8">${usersBean.address}</div>
				</div>
				
			</div>
	
	
			<!-- -----프로필수정 상세 내용----- -->
			<div class="tab-pane fade profile-edit pt-3" id="profile-edit">

			<!-- Profile Edit Form -->
			<form:form commandName="usersBean" method="post" action="updateMyPage.users" enctype="multipart/form-data">
			<input type="hidden" name="user_no" value="${usersBean.user_no}"/>
			<input type="hidden" name="pw" value="${usersBean.pw}"/>
			<input type="hidden" name="upload2" value="${usersBean.profile}"/>
			
			<div class="row mb-3">
				<label for="profileImage" class="col-md-4 col-lg-3 col-form-label">프로필 사진</label>
				<div class="col-md-8 col-lg-9">
					<img src="${pageContext.request.contextPath}/resources/uploadImage/${usersBean.profile}" alt="Profile">
					<div class="pt-2">
						<%-- 
						<input type="file" name="upload" class="btn btn-primary btn-sm" title="Upload new profile image" value="${usersBean.profile}">
						<a href="#" class="btn btn-primary btn-sm" title="Upload new profile image"><i class="bi bi-upload"></i></a>
						 --%>
						<input type="file" name="upload" id="upload" class="d-none">
                <label for="upload" class="btn btn-primary btn-sm" title="Upload new profile image">
                    <i class="bi bi-upload"></i>
                </label>
						
						<a href="#" class="btn btn-danger btn-sm" title="Remove my profile image"><i class="bi bi-trash"></i></a>
					</div>
				</div>
			</div>

			<div class="row mb-3">
				<label for="id" class="col-md-4 col-lg-3 col-form-label">아이디</label>
				<div class="col-md-8 col-lg-9">
					<input name="id" type="text" class="form-control" id="id" value="${usersBean.id}">
				</div>
			</div>
			<div class="row mb-3">
				<label for="id" class="col-md-4 col-lg-3 col-form-label">이름</label>
				<div class="col-md-8 col-lg-9">
					<input name="name" type="text" class="form-control" id="name" value="${usersBean.name}">
				</div>
			</div>

			<div class="row mb-3">
				<label for="email" class="col-md-4 col-lg-3 col-form-label">이메일</label>
				<div class="col-md-8 col-lg-9">
					<input name="email" type="text" class="form-control" id="email" value="${usersBean.email}">
				</div>
			</div>

			<div class="row mb-3">
				<label for="phoneNum" class="col-md-4 col-lg-3 col-form-label">휴대폰번호</label>
				<div class="col-md-8 col-lg-9">
					<input name="phoneNum" type="text" class="form-control" id="phoneNum" value="${usersBean.phoneNum}">
				</div>
			</div>
			
			<div class="row mb-3">
				<label for="postcode" class="col-md-4 col-lg-3 col-form-label">우편번호</label>
				<div class="col-md-8 col-lg-9">
					<input type="text" name="postcode" class="form-control" id="postcode" value="${usersBean.postcode}" placeholder="우편번호">
					<input type="button" class="btn btn-primary" onclick="execDaumPostcode()" value="우편번호 찾기"><br>
				</div>
			</div>
			
			<div class="row mb-3">
				<label for="address" class="col-md-4 col-lg-3 col-form-label">주소</label>
				<div class="col-md-8 col-lg-9">
					<input type="text" name="address" class="form-control" id="address" value="${usersBean.address}" placeholder="주소"><br>
				</div>
			</div>

			<div class="text-center">
				<button type="submit" class="btn btn-primary">프로필 저장</button>
				<button type="button" class="btn btn-danger" onclick="userDelete(${usersBean.user_no})">회원탈퇴</button>
			</div>
			</form:form><!-- End Profile Edit Form -->
			</div>


			<!-- -----비밀번호변경 상세 내용----- -->
			<div class="tab-pane fade pt-3" id="profile-change-password">
			
			<!-- Change Password Form -->
			<form:form commandName="usersBean" method="post" action="updatePw.users">
			<input type="hidden" name="user_no" value="${usersBean.user_no}"/>
			<input type="hidden" name="pw" value="${usersBean.pw}"/>
			
			<div class="row mb-3">
				<label for="currentPw" class="col-md-4 col-lg-3 col-form-label">현재 비밀번호</label>
				<div class="col-md-8 col-lg-9">
					<input name="currentPw" type="password" class="form-control" id="currentPw">
				</div>
			</div>

			<div class="row mb-3">
				<label for="newPw" class="col-md-4 col-lg-3 col-form-label">새로운 비밀번호</label>
				<div class="col-md-8 col-lg-9">
					<input name="newPw" type="password" class="form-control" id="newPw">
				</div>
			</div>

			<div class="row mb-3">
				<label for="reNewPw" class="col-md-4 col-lg-3 col-form-label">새로운 비밀번호 확인</label>
				<div class="col-md-8 col-lg-9">
					<input name="reNewPw" type="password" class="form-control" id="reNewPw">
				</div>
			</div>

			<div class="text-center">
				<button type="submit" class="btn btn-primary">비밀번호 변경</button>
			</div>
			</form:form><!-- End Change Password Form -->
			</div>

			</div><!-- End Bordered Tabs -->

			</div>
			</div>
		</div>
	</div>
</section>
<!-- -----프로필 페이지 메인 내용 끝----- -->



<!-- -----북마크 페이지 소제목 시작----- -->
<section class="section bookmark" id="bookmark-section">
	<div class="pagetitle" id="bookmark-section">
		<nav>
			<ol class="breadcrumb">
			<li class="breadcrumb-item active">Bookmark</li>
			</ol>
		</nav>
	</div>
<!-- -----북마크 페이지 소제목 끝----- -->

<!-- -----북마크 페이지 메인 내용 시작----- -->
		<!-- -----상세 탭----- -->
	<div class="row">
        <div class="col-xl-8">
			<div class="card">
			<div class="card-body pt-3">

			<!-- Bordered Tabs -->
			<ul class="nav nav-tabs nav-tabs-bordered">

			<li class="nav-item">
				<button class="nav-link active" data-bs-toggle="tab" data-bs-target="#bookmark-spot">내장소</button>
			</li>

			<li class="nav-item">
				<button class="nav-link" data-bs-toggle="tab" data-bs-target="#bookmark-event">관심목록</button>
			</li>

			</ul>
                
                
			<!-- -----내장소 상세 내용----- -->
			<div class="tab-content pt-2">
			<div class="tab-pane fade show active bookmark-spot" id="bookmark-spot">
				
				<form:form id="bookmark-house-form" method="post" action="${pageContext.request.contextPath}/bookmarkUpdate.bookmark">
				<div class="bookmark-item">
					<div class="bookmark-info">
						<i class="bi bi-house"></i>
						<div>
						<div class="col-lg-3 col-md-4 label">집</div>
						<input type="text" name="b_addr" id="houseAddr" value="${bookmarkList[0] != null && bookmarkList[0].type == 'house' ? bookmarkList[0].b_addr : ''}" placeholder="내 장소를 추가해보세요." class="form-control" readonly>
						<input type="hidden" name="book_no" value="${bookmarkList[0] != null && bookmarkList[0].type == 'house' ? bookmarkList[0].book_no : 0}">
						<input type="hidden" name="type" value="house">
						<input type="hidden" name="b_post" id="housePost" value="${bookmarkList[0] != null && bookmarkList[0].type == 'house' ? bookmarkList[0].b_post : ''}">
						</div>
					</div>
				<div class="bookmark-actions">
					<button type="button" onclick="execDaumPostcode('house')"><i class="bi bi-pencil"></i></button>
					<button type="submit"><i class="bi bi-save"></i></button>
					<button type="button" onclick="bookmarkDelete('${bookmarkList[0].book_no}','${usersBean.user_no}','house')"><i class="bi bi-trash"></i></button>
				</div>
				</div>
				</form:form>
				
				<form:form id="bookmark-company-form" method="post" action="${pageContext.request.contextPath}/bookmarkUpdate.bookmark">
				<div class="bookmark-item">
					<div class="bookmark-info">
						<i class="bi bi-building"></i>
						<div>
						<div class="col-lg-3 col-md-4 label">회사/학교</div>
						<input type="text" name="b_addr" id="companyAddr" value="${bookmarkList[1] != null && bookmarkList[1].type == 'company' ? bookmarkList[1].b_addr : ''}" placeholder="내 장소를 추가해보세요." class="form-control" readonly>
						<input type="hidden" name="book_no" value="${bookmarkList[1] != null ? bookmarkList[1].book_no : 0}">
						<input type="hidden" name="type" value="company">
						<input type="hidden" name="b_post" id="companyPost" value="${bookmarkList[1].type == 'company' ? bookmarkList[1].b_post : ''}">
						</div>
					</div>
				<div class="bookmark-actions">
					<button type="button" onclick="execDaumPostcode('company')"><i class="bi bi-pencil"></i></button>
					<button type="submit"><i class="bi bi-save"></i></button>
					<button type="button" onclick="bookmarkDelete('${bookmarkList[1].book_no}','${usersBean.user_no}','company')"><i class="bi bi-trash"></i></button>
				</div>
				</div>
				</form:form>
				
				<form:form id="bookmark-star-form" method="post" action="${pageContext.request.contextPath}/bookmarkUpdate.bookmark">
				<div class="bookmark-item">
					<div class="bookmark-info">
						<i class="bi bi-star"></i>
						<div>
						<div class="col-lg-3 col-md-4 label">자주가는곳</div>
						<input type="text" name="b_addr" id="starAddr" value="${bookmarkList[2] != null && bookmarkList[2].type == 'star' ? bookmarkList[2].b_addr : ''}" placeholder="내 장소를 추가해보세요." class="form-control" readonly>
						<input type="hidden" name="book_no" value="${bookmarkList[2] != null && bookmarkList[2].type == 'star' ? bookmarkList[2].book_no : 0}">
						<input type="hidden" name="type" value="star">
						<input type="hidden" name="b_post" id="starPost" value="${bookmarkList[2] != null && bookmarkList[2].type == 'star' ? bookmarkList[2].b_post : ''}">
						</div>
					</div>
				<div class="bookmark-actions">
					<button type="button" onclick="execDaumPostcode('star')"><i class="bi bi-pencil"></i></button>
					<button type="submit"><i class="bi bi-save"></i></button>
					<button type="button" onclick="bookmarkDelete('${bookmarkList[2].book_no}','${usersBean.user_no}','star')"><i class="bi bi-trash"></i></button>
				</div>
				</div>
				</form:form>
				
			</div>
			
			
			<!-- -----관심목록 상세 내용----- -->
			<div class="tab-pane fade bookmark-event scrollable" id="bookmark-event">
			
			<c:if test="${empty favoriteList}">
				<div class="alert alert-light border-light alert-dismissible fade show" role="alert" align="center">
					관심 있는 행사 목록이 없습니다. <br>
					관심 행사를 추가해보세요.
				</div>
			</c:if>
			
			<c:forEach var="favorite" items="${favoriteList}">
			<table class="table table-bordered">
				<tr>
					<td rowspan="4">
						<div class="image-container">
							<a href="${pageContext.request.contextPath}/detail.event?eventNo=${favorite.event_no}">
								<img src="${favorite.img}" alt="이미지">
							</a>
							<button type="button" onclick="favoriteDelete(${favorite.favorite_no}, ${favorite.event_no}, ${usersBean.user_no})" class="icon-button">
							<i class="bi bi-heart-fill"></i>
							<i class="bi bi-heart"></i>
						</button>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div class="label"><b>${favorite.title}</b> [ ${favorite.performance_type} ]</div>
					</td>
				</tr>
				<tr>
					<td>
						<div>기간 : ${favorite.event_period}</div>
					</td>
				</tr>
				<tr>
					<td>
						<div>장소 : ${favorite.place}</div>
					</td>
				</tr>
			</table>
			</c:forEach>
			
			</div><!-- End Bordered Tabs -->

			</div>
			</div>
			</div>
		</div>
	</div>
</section>
<!-- -----북마크 페이지 메인 내용 끝----- -->



<!-- -----내가쓴글 페이지 소제목 시작----- -->
<section class="section myboard" id="board-section">
	<div class="pagetitle" id="board-section">
		<nav>
			<ol class="breadcrumb">
			<li class="breadcrumb-item active">Baord</li>
			</ol>
		</nav>
	</div>
<!-- -----내가쓴글 페이지 소제목 끝----- -->

<!-- -----내가쓴글 페이지 메인 내용 시작----- -->
		<!-- -----상세 탭----- -->
	<div class="row">
		<div class="col-xl-8">
			<div class="card">
			<div class="card-body pt-3">
		
			<!-- Bordered Tabs -->
			<ul class="nav nav-tabs nav-tabs-bordered">

			<li class="nav-item">
				<button class="nav-link active" data-bs-toggle="tab" data-bs-target="#myQna">Q&A</button>
			</li>

			<li class="nav-item">
				<button class="nav-link" data-bs-toggle="tab" data-bs-target="#myBoard">작성글</button>
			</li>
                
			<li class="nav-item">
				<button class="nav-link" data-bs-toggle="tab" data-bs-target="#myComments">작성댓글</button>
			</li>

			</ul>
                
                
			<!-- -----Q&A 상세 내용----- -->
			<div class="tab-content pt-2">
			<div class="tab-pane fade show active profile-overview scrollable" id="myQna">

				<div>
				
				<table class="table table-borderless" style="text-align: center;">
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>등록일</th>
						<th>답변상태</th>
					</tr>
					
					<c:forEach var="qna" items="${myQnaList}" varStatus="status">
					<tr>
						<td>${status.count}</td>
						<td><a href="${pageContext.request.contextPath}/detail.qna?qna_no=${qna.qna_no}">${qna.subject}</a></td>
						<td>
							<fmt:parseDate value="${qna.regdate}" var="dayFmt" pattern="yyyy-MM-dd"/>
							<fmt:formatDate value="${dayFmt}" pattern="yyyy-MM-dd"/>
						</td>
						<td>
							<c:choose>
								<c:when test="${qna.state == 1}">
									답변완료
								</c:when>
								<c:otherwise>
									미답변
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
					</c:forEach>
					
				</table>
				
				</div>
				
			</div>

			<!-- -----작성글 상세 내용----- -->
			<div class="tab-pane fade profile-overview scrollable" id="myBoard">

				<div>
				
				<table class="table table-borderless" style="text-align: center;">
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>등록일</th>
						<th>조회수</th>
					</tr>
					
					<c:forEach var="board" items="${myBoardList}" varStatus="status">
					<tr>
						<td>${status.count}</td>
						<td><a href="${pageContext.request.contextPath}/detail.board?board_no=${board.board_no}">${board.subject} [${board.commentCount}]</a></td>
						<td>
						<fmt:parseDate value="${board.regdate}" var="dayFmt" pattern="yyyy-MM-dd"/>
						<fmt:formatDate value="${dayFmt}" pattern="yyyy-MM-dd"/>
						</td>
						<td>${board.readcount}</td>
					</tr>
					</c:forEach>
					
				</table>
				
				</div>
				
			</div>

			<!-- -----작성댓글 상세 내용----- -->
			<div class="tab-pane fade profile-overview scrollable" id="myComments">
					
				<div>
				
				<table class="table table-borderless" style="text-align: center;">
					<tr>
						<th>제목</th>
						<th>댓글내용</th>
						<th>등록일</th>
					</tr>
					
					<c:forEach var="comment" items="${myCommentList}">
					<tr>
						<td><a href="${pageContext.request.contextPath}/detail.board?board_no=${comment.board_no}">${comment.board_subject}</a></td>
						<td>${comment.content}</td>
						<td>
						<fmt:parseDate value="${comment.regdate}" var="dayFmt" pattern="yyyy-MM-dd"/>
						<fmt:formatDate value="${dayFmt}" pattern="yyyy-MM-dd"/>
						</td>
					</tr>
					</c:forEach>
					
				</table>
				
				</div>
				
			</div>
			
			</div>
			</div>
			</div>
		</div>
	</div>
	
</section>
<!-- -----내가쓴글 페이지 메인 내용 끝----- -->

</main><!-- End #main -->

<%@include file = "../userCommon/userFooter.jsp" %>

  <!-- Vendor JS Files -->
  <script data-cfasync="false" src="/cdn-cgi/scripts/5c5dd728/cloudflare-static/email-decode.min.js"></script><script src="../../../assets/vendor/apexcharts/apexcharts.min.js"></script>
  <script src="<%=request.getContextPath() %>/resources/assetsAdmin/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="<%=request.getContextPath() %>/resources/assetsAdmin/vendor/chart.js/chart.umd.js"></script>
  <script src="<%=request.getContextPath() %>/resources/assetsAdmin/vendor/echarts/echarts.min.js"></script>
  <script src="<%=request.getContextPath() %>/resources/assetsAdmin/vendor/quill/quill.js"></script>
  <script src="<%=request.getContextPath() %>/resources/assetsAdmin/vendor/simple-datatables/simple-datatables.js"></script>
  <script src="<%=request.getContextPath() %>/resources/assetsAdmin/vendor/tinymce/tinymce.min.js"></script>
  <script src="<%=request.getContextPath() %>/resources/assetsAdmin/vendor/php-email-form/validate.js"></script>

  <!-- Template Main JS File -->
  <script src="<%=request.getContextPath() %>/resources/assetsAdmin/js/main.js"></script>

<script defer src="https://static.cloudflareinsights.com/beacon.min.js/vcd15cbe7772f49c399c6a5babf22c1241717689176015" integrity="sha512-ZpsOmlRQV6y907TI0dKBHq9Md29nnaEIPlkf84rnaERnq6zvWvPUqr2ft8M1aS28oN72PdrCzSjY4U6VaAw1EQ==" data-cf-beacon='{"rayId":"89915ded48d16860","version":"2024.4.1","token":"68c5ca450bae485a842ff76066d69420"}' crossorigin="anonymous"></script>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
//주소 수정
function execDaumPostcode(type) {
    new daum.Postcode({
       oncomplete : function(data) {
          // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

          // 각 주소의 노출 규칙에 따라 주소를 조합한다.
          // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
          var addr = ''; // 주소 변수
          var extraAddr = ''; // 참고항목 변수

          //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
          if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
             addr = data.roadAddress;
          } else { // 사용자가 지번 주소를 선택했을 경우(J)
             addr = data.jibunAddress;
          }

          // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
          if (data.userSelectedType === 'R') {
             // 법정동명이 있을 경우 추가한다. (법정리는 제외)
             // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
             if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
                extraAddr += data.bname;
             }
             // 건물명이 있고, 공동주택일 경우 추가한다.
             if (data.buildingName !== '' && data.apartment === 'Y') {
                extraAddr += (extraAddr !== '' ? ', '
                      + data.buildingName : data.buildingName);
             }
             // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
             if (extraAddr !== '') {
                extraAddr = ' (' + extraAddr + ')';
             }
             // 조합된 참고항목을 해당 필드에 넣는다.
             document.getElementById("address").value = extraAddr;

          } else {
             document.getElementById("address").value = '';
          }

          // 우편번호와 주소 정보를 해당 필드에 넣는다.
          document.getElementById('postcode').value = data.zonecode;
          document.getElementById("address").value = addr;
		
          
		  //bookmark 주소 업데이트
          var fullAddr = addr + extraAddr;
            if (type === 'house') {
                document.getElementById('houseAddr').value = fullAddr;
                document.getElementById('housePost').value = data.zonecode;
            } else if (type === 'company') {
                document.getElementById('companyAddr').value = fullAddr;
                document.getElementById('companyPost').value = data.zonecode;
            } else if (type === 'star') {
                document.getElementById('starAddr').value = fullAddr;
                document.getElementById('starPost').value = data.zonecode;
            }
          
       }
    }).open();
 }
</script>

<!-- bookmark, favorite -->
<script type="text/javascript">

function bookmarkDelete(book_no, user_no, type) {
    event.preventDefault(); // 기본 동작 방지
    if (confirm('북마크를 삭제하시겠습니까?')) {
        // AJAX 요청
        var xhr = new XMLHttpRequest();
        xhr.open('GET', 'bookmarkDelete.bookmark?book_no=' + book_no + '&user_no=' + user_no + '&type=' + type, true);
        xhr.onreadystatechange = function() {
            if (xhr.readyState === 4 && xhr.status === 200) {
                // 서버 응답 처리
                location.reload(); // 페이지 리로드
            }
        };
        xhr.send();
    }
}

function favoriteDelete(favorite_no, event_no, user_no) {
    event.preventDefault(); // 기본 동작 방지
    if (confirm('관심목록에서 삭제하시겠습니까?')) {
        // AJAX 요청
        var xhr = new XMLHttpRequest();
        xhr.open('GET', 'favoriteDelete.favorite?favorite_no=' + favorite_no + '&event_no=' + event_no + '&user_no=' + user_no, true);
        xhr.onreadystatechange = function() {
            if (xhr.readyState === 4 && xhr.status === 200) {
                // 서버 응답 처리
                location.reload(); // 페이지 리로드
            }
        };
        xhr.send();
    }
}

// 현재 탭 상태를 로컬 스토리지에 저장
document.querySelectorAll('.nav-link').forEach(tab => {
    tab.addEventListener('click', function() {
        localStorage.setItem('activeTab', this.getAttribute('data-bs-target'));
    });
});

// 페이지 로드 시 저장된 탭 상태로 복원
document.addEventListener('DOMContentLoaded', function() {
    var activeTab = localStorage.getItem('activeTab');
    if (activeTab) {
        var tab = document.querySelector('button[data-bs-target="' + activeTab + '"]');
        if (tab) {
            tab.click();
        }
    }
});


document.querySelectorAll('form[id^="bookmark-"]').forEach(form => {
    form.addEventListener('submit', function(event) {
        event.preventDefault();
        
        // AJAX 요청
        var xhr = new XMLHttpRequest();
        xhr.open('POST', this.action, true);
        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        
        // 폼 데이터 수집
        var formData = new FormData(this);
        var params = new URLSearchParams(formData).toString();
        
        xhr.onreadystatechange = function() {
            if (xhr.readyState === 4 && xhr.status === 200) {
                alert('내장소가 업데이트 되었습니다.');
            }
        };
        xhr.send(params);
    });
});

function userDelete(user_no) {
	alert('userDelete');
	if (confirm('회원탈퇴를 하시겠습니까?')) {
        location.href = "${pageContext.request.contextPath}/delete.users?user_no=" + user_no;
    }
}



</script>

</body>

</html>