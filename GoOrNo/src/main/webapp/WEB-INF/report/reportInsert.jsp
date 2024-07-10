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

<title>Report</title>
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

<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		var close = $("#close").val();
		
		window.onunload = function(){ // x 버튼 눌러서 팝업창 닫았을 때
			self.close();
		}
		
		if(close == 'close'){ // sumit했을 때(close안에 'close'가 저장되어있다면)
			self.close(); // 창 닫기
		}
	});
</script>

<body>
	<input type = "hidden" value = "${close }" id = "close"> <!-- model 속성 close 값 확인 : sumit 후에 close 안에 'close' 저장-->
	
	<jsp:useBean id="now" class="java.util.Date" />
	<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="now" />
	
	<div id="contact" class="contact-us section" style="padding-top: 30px">
		<div class="container">
			<div class="row">
				<div class="col-lg-6 offset-lg-3">
					<div class="section-heading wow fadeIn">
						<h4 style="color: black">REPORT</h4>
					</div>
				</div>
				<div class="col-lg-12 wow fadeInUp" >
					<form:form commandName = "report" id="contact" action="insert.report" method="post" >
						<div class="row" >
							<div class="col-lg-12">
								<div class="fill-form">
									<div class="row ft_area">
										<div class="col-lg-12">
											<div class="col-lg-12">
													신고 사유를 작성하지 않으면 신고가 정상적으로 처리되지 않습니다.
													
													<input type="hidden" name="board_no" value = "${board_no }">
													<input type="hidden" name="subject" value = "${subject }">
													<%-- <input type="hidden" name="user_no" value = "${loginInfo.user_no }" > --%>
													<input type="hidden" name="user_no" value = "1" >
													
													<input type="text" name = "subject" value = "${subject }" disabled>
													<input type="text"  value = "${ now}" disabled>
													<textarea name = "why" rows="3" cols="50" style = "border-color : #FA64B0; border-style : dashed;">예) 욕설이 너무 많아요.</textarea>
													<form:errors path = "why"  class = "err"/>
													
													<%-- <input type="text" id="user_no" value = "${loginInfo.id }" disabled> --%>
													<input type="text" id="user_no" value = "moon" disabled>
											</div>
											<br>
											<span>
													신고해주셔서 감사합니다.<br> 검토 후 빠른 시일 내로 처리하도록 노력하겠습니다.
												</span>
												
											<div class="col-lg-12">
													<button id="form-submit" class="main-button ">신고</button>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</form:form>
				</div>
			</div>
		</div>
	</div>
</body>