<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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

span {
	font-size: 13px;
	color: gray;
}

.err {
	font-size: 9pt;
	font-weight: bold;
	color: #FA64B0;
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
	
	function Check(){
		const why = document.getElementById('why').value;
		
		if(why == ""){
			if(!confirm("신고 사유를 작성하지 않으면 처리되지 않습니다. \n종료 하시겠습니까?")){
				return false;
			}
		}
	}
</script>

<body>
	<input type="hidden" value="${close }" id="close">
	<!-- model 속성 close 값 확인 : sumit 후에 close 안에 'close' 저장-->

	<jsp:useBean id="now" class="java.util.Date" />
	<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="now" />

	<!-- 본문 시작 -->
	<div id="contact" class="contact-us section" style="padding-top: 20px;">
		<div class="container">
			<div class="row">
				<!-- 본문 제목 -->
				<div class="col-lg-6 offset-lg-3">
					<div class="section-heading" style="margin-bottom: 20px;">
						<br>
						<h4>REPORT</h4>
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
										<div class="container"
											style="width: 80%; margin-top: 30px; margin-bottom: 10px;">
											<!-- 입력폼 시작 -->
											<form:form commandName="report" action="insert.report" method="post">
												<input type="hidden" name="board_no" value="${board_no }">
												<input type="hidden" name="subject" value="${subject }">
												<input type="hidden" name="user_no" value="${loginInfo.user_no }">
												
												<table class="table table-borderless" width="100%">
													<tr>
														<td><font size="4px"><b> 신고자 </b></font>
															<input type="text" id="user_no" value = "${loginInfo.id }" disabled  class="form-control" style="width:80%; diaply:inline;">
														</td>
													</tr>
													<tr>
														<td>
															<textarea  class="form-control" id = "why" name="why" rows="10"  placeholder="신고 사유"  style="resize: none;" >${report.why }</textarea>
														</td>
													</tr>
													<tr>
														<td align="center"><input type="submit" value="신고"
															class="btn btn-secondary" onClick = "return Check()"></td>
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
	<!-- 본문 끝 -->
</body>