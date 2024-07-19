<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<head>
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

<title>event update</title>
</head>


<style type="text/css">
body {
	background-color: #FFE6EB;
}

span{
	font-size : 13px;
	color : gray;
}
.err{
	font-size: 9pt;
	font-weight: bold;
	color : #FA64B0;
}
</style>

<%
	String[] typeArray = {"축제-문화/예술","기타","국악","뮤지컬/오페라","교육/체험","전시/미술","무용","콘서트","클래식","영화","연극","독주/독창회","축제-기타"};
%>

<body>
	<!-- 본문 시작 -->
<div id="contact" class="contact-us section" style="padding-top : 20px; ">
	<div class="container">
		<div class="row">
			<!-- 본문 제목 -->
			<div class="col-lg-6 offset-lg-3">
				<div class="section-heading" style="margin-bottom : 20px;">
					<br>
					<h4>
						행사 등록
					</h4>
				</div>
			</div>
			
			<!-- 테두리 안 본문 내용 -->
			<div class="col-lg-12">
				<section class="section">
					<div class="row">
						<div class="col-lg-12">
							<div class="card">
								<div class="card-body">
								
									<!-- 글 내용 감싸는 컨테이너 -->
									<div class="container" style="width: 80%; margin-top: 30px; margin-bottom:10px;">
									<!-- 입력폼 시작 -->
									<form:form commandName="event" action="insert.event" method="post" enctype="multipart/form-data" class="form-horizontal">
										<input type="hidden" name="pageNumber" value="${ param.pageNumber }">
										<input type="hidden" name="whatColumn" value="${ param.whatColumn }">
										<input type="hidden" name="keyword" value="${ param.keyword }">
										
										<table class="table table-borderless" width="100%">
											<tr>
												<td>
													<font size="4px"><b> 카테고리 </b></font>
										            <select name="performance_type" class="form-control" >
										                <option value="">선택</option>
										                <c:forEach var="type" items="<%= typeArray %>">
										                    <option value="${type}" <c:if test="${event.performance_type eq type}">selected</c:if>>${type}</option>
										                </c:forEach>
										            </select>
										            <form:errors path="performance_type" cssClass="err"/>
												</td>
											</tr>
											<tr>
												<td>
													<font size="4px"><b> 행사명</b></font>
													<input type="text" name="title" value="${event.title }" class="form-control">
													<form:errors path="title" cssClass="err"/>
												</td>	
											</tr>
											<tr>
												<td>
													<font size="4px"><b> 장소</b></font>
														<input type="text" name="place" value="${event.place }"  class="form-control">
														<form:errors path="place" cssClass="err"/>
												</td>	
											</tr>
											<tr>
												<td>
													<font size="4px"><b>기간</b></font>
													<input type="text" name="event_period" value="${event.event_period}" class="form-control" placeholder="예) 2024-09-10~2024-12-02">
													<form:errors path="event_period" cssClass="err"/>
												</td>	
											</tr>
											<tr>
												<td>
													<font size="4px"><b> 사진</b></font>
														<c:choose>
										                     <c:when test="${not empty event.fimg}">
										                         <!-- 업로드된 이미지가 있으면 해당 이미지를 사용 -->
										                         <img src="${pageContext.request.contextPath}/resources/uploadImage/${event.fimg}"
										                             width="100" height="100" alt="${event.title}" /><br>
										                     </c:when>
										                     <c:otherwise>
										                         <!-- 업로드된 이미지가 없으면 API 이미지를 사용 -->
										                         <img src="${event.img}" width="100" height="100" alt="${event.title}" /><br>
										                     </c:otherwise>
										                 </c:choose>
														<input type="file" name="upload" value="${event.img }" class="form-control">
										                 <%-- <input type = "text" name="upload2" value="${event.img }"> <!-- upload2:삭제할 파일명 --> --%>
														<form:errors path="fimg" cssClass="err"/>
												</td>	
											</tr>
											<tr>
												<td>
													<font size="4px"><b>위도</b></font>
														<input type="text" name="lot" value="${event.lot }" class="form-control">
														<form:errors path="lot" cssClass="err"/>
												</td>	
											</tr>
											<tr>
												<td>
													<font size="4px"><b>경도</b></font>
														<input type="text" name="lat" value="${event.lat }" class="form-control">
														<form:errors path="lat" cssClass="err"/>
												</td>	
											</tr>
											<tr>
												<td align="center">
													<input type="submit" value="작성" class="btn btn-light">
												</td>
											</tr>
										</table>
									</form:form>
									<!-- 입력폼 끝 -->
									</div>

								</div>
							</div>
						</div>
					</div>
				</section>
			</div>
			<!-- 테두리 끝 -->
		</div>
	</div>
</div>
</body>