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

<title>updateQnaReply</title>
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

<script type="text/javascript" src="<%= request.getContextPath() %>/resources/vendor/jquery/jquery.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		var isSuccess = document.getElementById("isSuccess").value;
		if(isSuccess == 'yes'){
			window.opener.parent.location.reload();
			window.close();
		}
	});
</script>

<body>

<!-- 본문 시작 -->
<div id="contact" class="contact-us section h-100" style="padding-top : 20px; ">
	<div class="container h-100">
		<div class="row" style="height: 90%;">
			<!-- 본문 제목 -->
			<div class="col-lg-6 offset-lg-3">
				<div class="section-heading" style="margin-bottom : 20px;">
					<br>
					<h4>
						답변 수정
					</h4>
				</div>
			</div>
			
			<!-- 테두리 안 본문 내용 -->
			<div class="col-lg-12">
				<section class="section">
					<div class="row" style="height : 90%;">
						<div class="col-lg-12">
							<div class="card h-100" style="padding-bottom: 10px;">
								<div class="card-body">
								
									<!-- 글 내용 감싸는 컨테이너 -->
									<div class="container" style="width: 100%; margin-top: 30px; margin-bottom:10px;">
									<!-- 테이블 시작 -->
									<form:form commandName="qna" action="update.qna" method="post">
										<input type="hidden" name="isAdmin" value="yes">
										<input type="hidden" id="isSuccess" value="${ isSuccess }">
										<input type="hidden" name="qna_no" value="${ qna.qna_no }">
										<table class="table table-borderless" width="100%">
											<tr>
												<td>
													<font size="4px"><b> 제목 </b></font>
													<input type="text" name="subject" value="${ qna.subject }" class="form-control" style="width:80%; diaply:inline;" disabled="disabled">
													<input type="hidden" name="subject" value="${ qna.subject }">
													<%-- <form:errors path="subject" cssClass="err"></form:errors> --%>
												</td>
											</tr>
											<tr>
												<td>
													<textarea class="form-control" placeholder="내용" style="resize:none;" name="content" rows="5" maxlength="300" required>${ qna.content }</textarea>
													<%-- <form:errors path="content" cssClass="err"></form:errors> --%>
												</td>	
											</tr>
											<tr>
												<td align="center">
													<input type="submit" value="수정" class="btn btn-light">
												</td>
											</tr>
										</table>
									<!-- 테이블 끝 -->
									</form:form>
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