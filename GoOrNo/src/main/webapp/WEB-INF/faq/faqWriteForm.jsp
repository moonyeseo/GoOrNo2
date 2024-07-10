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

<title>insertFaq</title>
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
<div id="contact" class="contact-us section" style="padding-top : 20px; ">
	<div class="container">
		<div class="row">
			<!-- 본문 제목 -->
			<div class="col-lg-6 offset-lg-3">
				<div class="section-heading" style="margin-bottom : 20px;">
					<br>
					<h4>
						FAQ 작성
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
									<form:form commandName="faq" action="insert.faq" method="post">
										<input type="hidden" id="isSuccess" value="${ isSuccess }">
										<input type="hidden" name="pageNumber" value="${ param.pageNumber }">
										<input type="hidden" name="whatColumn" value="${ param.whatColumn }">
										<input type="hidden" name="keyword" value="${ param.keyword }">
										<table class="table table-borderless" width="100%">
											<tr>
												<td>
													<font size="4px"><b> 질문 </b></font>
													<input type="text" name="question" value="${ faq.question }" class="form-control" style="width:80%; diaply:inline;">
													<form:errors path="question" cssClass="err"></form:errors>
												</td>
											</tr>
											<tr>
												<td>
													<textarea class="form-control" placeholder="답변" style="resize:none;" name="answer" rows="10">${ faq.answer }</textarea>
													<form:errors path="answer" cssClass="err"></form:errors>
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
<!-- 본문 끝 -->
</body>

