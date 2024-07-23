<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="event.model.EventBean"%>
<%@include file="../adminCommon/adminHeader.jsp"%>

<!-- <style type="text/css">
.event-detail-container {
	display: flex;
	justify-content: center;
	flex-direction: column;
	margin: 100px auto;
	max-width: 1200px;
	width: 100%;
	padding-top: 20px; /* 메뉴바에 가리지 않도록 패딩 추가 */
}

.event-detail-container img {
	width: 30%;
	height: 400px;
	margin-right: 50px;
	margin-left: 150px;
}

.event-info {
	flex: 1;
	display: flex;
	align-items: center;
	background-color: #ffffff;
	border-radius: 10px;
	height: 400px; /* 이미지와 동일한 높이로 설정 */
}

.event-title {
	width: 100%;
	text-align: center;
	margin-bottom: 20px;
}
.card{
	height: 500px;
	width: 1200px;
	margin-left: 100px;
}
</style> -->

<script type="text/javascript">
	function deleteEvent(eventNo){	
		if(confirm('삭제하면 복구할수 없습니다.\n정말로 삭제하시겠습니까?')){
			location.href='delete.event?eventNo=' + eventNo;
		}
	}
	
	//팝업창 크기
	var _width = 500;
	var _height = 600;

	//게시글 수정
	function updateEvent(eventNo){
		// 팝업창을 중앙에 생성하기
		var _top = Math.ceil(( window.screen.height - _height )/2);
		var _left = Math.ceil(( window.screen.width - _width )/2);
		var url = 'update.event?eventNo='+eventNo;
		var name = 'event update';
		var options = 'width = ' + _width + ', height = ' + _height + ', location = no, top = '+ _top + ', left = ' + _left;
		var windowPopup = window.open(url, name, options);
	}
</script>


<jsp:useBean id="event" class="event.model.EventBean" scope="session">
	<jsp:setProperty name="event" property="*" />
</jsp:useBean>

<input type="hidden" name="event_no" value="${eventNo }">
<input type="hidden" name="whatColumn" value="${whatColumn}">
<input type="hidden" name="keyword" value="${keyword}">
<input type="hidden" name="pageNumber" value="${pageNumber}">
<main id="main" class="main">

	<div class="pagetitle">
		<h1>Event</h1>
		<nav>
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="#">Event</a></li>
				<li class="breadcrumb-item active">Detail</li>
			</ol>
		</nav>
	</div>
	<!-- End Page Title -->
	
	<section class="section profile">
		<div class="row">
			<div class="col-xl-4">

				<div class="card">
					<div
						class="card-body profile-card pt-4 d-flex flex-column align-items-center">
						<c:choose>
							<c:when test="${not empty event.fimg}">
								<!-- 업로드된 이미지가 있으면 해당 이미지를 사용 -->
								<img
									src="${pageContext.request.contextPath}/resources/uploadImage/${event.fimg}"
									alt="${event.title}" height = "80%" width = "70%"/>
							</c:when>
							<c:otherwise>
								<!-- 업로드된 이미지가 없으면 API 이미지를 사용 -->
								<img src="${event.img}" alt="${event.title}" />
							</c:otherwise>
						</c:choose>
					</div>
				</div>

			</div>

			<div class="col-xl-8">

				<div class="card">
					<div class="card-body pt-3">
						<!-- Bordered Tabs -->

						<div class="tab-content pt-2">
							<div align="right">
								<input type="button" class="btn btn-secondary" value="목록"
									onClick="location.href='AdminList.event?eventNo=${event.event_no }&whatColumn=${param.whatColumn}&keyword=${param.keyword}&pageNumber=${param.pageNumber}'">
								<input type="button" class="btn btn-secondary" value="수정" onClick="updateEvent(${event.event_no })">
								<input type="button" class="btn btn-secondary" value="삭제" onClick="deleteEvent(${event.event_no})">
							</div>
						</div>

						<div class="tab-pane fade show active profile-overview"
							id="profile-overview">

							<h5 class="card-title">
								<b>${event.title }</b>
							</h5>

							<div class="row">
								<div class="col-lg-3 col-md-4 label ">카테고리</div>
								<div class="col-lg-9 col-md-8">${event.performance_type}</div>
							</div>

							<div class="row">
								<div class="col-lg-3 col-md-4 label">기간</div>
								<div class="col-lg-9 col-md-8">${event.event_period}</div>
							</div>

							<div class="row">
								<div class="col-lg-3 col-md-4 label">장소</div>
								<div class="col-lg-9 col-md-8">${event.place}</div>
							</div>
						</div>
					</div>
				</div>

			</div>
		</div>
	</section>
</main>
<%@include file="../adminCommon/adminFooter.jsp"%>
