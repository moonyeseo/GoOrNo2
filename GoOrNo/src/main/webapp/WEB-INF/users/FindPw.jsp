<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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

<title>GoOrNo</title>

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

</head>	

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
											<h5 class="card-title text-center pb-0 fs-4">Search Password</h5>
											<p class="text-center small">Enter your id</p>
										</div>
										<div class="pt-0 pb-2"></div>

										<div class="col-12">
											<label for="yourUsername" class="form-label">ID</label>
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
													style="background-color: #FA64B0; color: white;">Search Password</button>
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
