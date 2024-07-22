<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../userCommon/userHeader.jsp"%>
<style type="text/css">
a {
	color : black;
}

a:hover{
	color : #FA64B0
}
</style>

<script>
        function openPopup(url) {
            var popupWidth = 550; // 팝업창 너비
            var popupHeight = 400; // 팝업창 높이
            var left = (screen.width - popupWidth) / 2; // 가운데 정렬
            var top = (screen.height - popupHeight) / 2; // 가운데 정렬
            window.open(url, 'popupWindow', 'width=' + popupWidth + ',height=' + popupHeight + ',top=' + top + ',left=' + left);
        }
</script>
    
<!-- 챗봇 -->
<!-- 챗봇 대화 -->
<div id="asideChatbot" class="asideChatbot " style="heigth: 80%">
	<%@include file="../chatbot/chatbot.jsp"%>
</div>

<!-- 캘린더 아이콘 -->
<div id="calendarIcon" style="heigth: 20%; bottom : 100px">
	<%@include file="../event/calendarIcon.jsp"%>
</div>
<!-- 챗봇 대화 아이콘 -->
<div id="chatbotIcon" style="heigth: 20%; bottom : 100px">
	<%@include file="../chatbot/chatbotIcon.jsp"%>
</div>
    
<body>

	<form action="login.users" method="post">

		<div class="container">

			<section
				class="section register min-vh-100 d-flex flex-column align-items-center justify-content-center py-4">
				<div class="container">
					<div class="row justify-content-center">
						<div
							class="col-lg-20 col-md-6 d-flex flex-column align-items-center justify-content-center">

							<div class="card mb-3">

								<div class="card-body">

									<div class="pt-4 pb-2">
										<h5 class="card-title text-center pb-0 fs-3">Login</h5>
										<p class="text-center small">Enter your id & password to
											login</p>  
									</div>

									<div class="col-12">
										<label for="yourUsername" class="form-label">ID</label>
										<div class="input-group has-validation">
											<input type="text" name="id" class="form-control" id="id" maxlength="20"
												required >
											<div class="invalid-feedback">아이디를 입력하세요.</div>
										</div>
									</div>
									<div class="pt-0 pb-2"></div>

									<div class="col-12">
										<label for="yourPassword" class="form-label">Password</label>
										<input type="password" name="pw" class="form-control" id="pw" maxlength="20"
											required>
										<div class="invalid-feedback">비밀번호를 입력하세요.</div>
									</div>
									<br>
									<div class="col-lg-12">
										<div class="border-first-button scroll-to-section">
											<button type="submit" id="form-submit" class="btn w-100"
												style="background-color: #FA64B0; color: white;">Login</button>			
										</div>
									</div>

									<div class="pt-0 pb-2"></div>
									<!-- 버튼과 간편로그인 사이 간격조절 -->

									<!-- REST API 방식 -->
									<div class="text-center">
										<a
											href="https://kauth.kakao.com/oauth/authorize?client_id=&redirect_uri=http://localhost:8080/kakaoLogin.users&response_type=code&prompt=login">
											<img
											src="<%=request.getContextPath()%>/resources/image/kakao_login.png">

										</a>
									</div>
									<div class="pt-0 pb-2"></div>
									<div class="col-12" align="right">
										<p class="small mb-0">
											<a href="join.users"> 회원가입</a> | <a href="javascript:void(0);" onclick="openPopup('FindPw.users')">비밀번호 찾기</a>
										</p>
									</div>

								</div>
							</div>

						</div>
					</div>
				</div>

			</section>

		</div>
	</form>

</body>
<%@include file="../userCommon/userFooter.jsp"%>