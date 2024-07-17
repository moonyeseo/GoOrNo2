<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../userCommon/userHeader.jsp"%>

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
											<input type="text" name="id" class="form-control" id="id"
												required>
											<div class="invalid-feedback">아이디를 입력하세요.</div>
										</div>
									</div>
									<div class="pt-0 pb-2"></div>

									<div class="col-12">
										<label for="yourPassword" class="form-label">Password</label>
										<input type="password" name="pw" class="form-control" id="pw"
											required>
										<div class="invalid-feedback">비밀번호를 입력하세요.</div>
									</div>
									<br>
									<div class="col-lg-12">
										<div class="border-first-button scroll-to-section">
											<button type="submit" id="form-submit" class="btn w-100"
												style="background-color: pink;">Login</button>
										</div>
									</div>
								
									<div class="pt-0 pb-2"></div><!-- 버튼과 간편로그인 사이 간격조절 -->
								
									
									<!-- REST API 방식 -->
									<div class="text-center">
										<a href="https://kauth.kakao.com/oauth/authorize?client_id=REST KEY&redirect_uri=http://localhost:8080/ex/kakaoLogin.users&response_type=code">
											<img
											src="<%=request.getContextPath()%>/resources/image/kakao_login.png">

										</a>
									</div>
									<div class="pt-0 pb-2"></div>
									<div class="col-12" align="right">
										<p class="small mb-0">
											<a href="join.users">회원가입 |</a> <a href="FindPw.users">비밀번호
												찾기</a>
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