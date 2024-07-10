<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../userCommon/userHeader.jsp"%>


<body>


	<form action="FindPw.users" method="post">
		<main>
			<div class="container">

				<section
					class="section register min-vh-100 d-flex flex-column align-items-center justify-content-center py-4">
					<div class="container">
						<div class="row justify-content-center">
							<div
								class="col-lg-4 col-md-6 d-flex flex-column align-items-center justify-content-center">


								<!-- End Logo -->

								<div class="card mb-3">

									<div class="card-body">

										<div class="pt-4 pb-2">
											<h5 class="card-title text-center pb-0 fs-4">비밀번호 찾기</h5>
										</div>

										<div class="col-12">
											<label for="yourUsername" class="form-label">아이디</label>
											<div class="input-group has-validation">
												<input type="text" name="id" class="form-control" id="id"
													required>
												<div class="invalid-feedback">아이디를 입력하세요.</div>
											</div>
										</div>
										<br>
										<div class="col-lg-12">
											<div class="border-first-button scroll-to-section">
												<button type="submit" id="form-submit" class="btn w-100"
													style="background-color: pink;">Search Password</button>
											</div>
										</div>

									</div>
								</div>

							</div>
						</div>
					</div>

				</section>

			</div>
		</main>
	</form>
</body>

<%@include file="../userCommon/userFooter.jsp"%>