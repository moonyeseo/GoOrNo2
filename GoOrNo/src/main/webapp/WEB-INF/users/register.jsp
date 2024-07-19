<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../userCommon/userHeader.jsp"%>
<br>
<br>
<br>
<br>
<br>

<script type="text/javascript"
	src="<%=request.getContextPath()%>/resources/vendor/jquery/jquery.js"></script>
<script type="text/javascript">
	$(document)
			.ready(
					function() {

						var use;
						var isCheck = false;

						$('#name_check')
								.click(
										function() {

											isCheck = true;

											$
													.ajax({
														url : "id_check_proc.users",
														type : "post",
														data : ({
															inputid : $(
																	'input[name= id]')
																	.val()
														}),
														success : function(data) {

															if ($(
																	'input[name=id]')
																	.val() == "") {
																$(
																		'#nameMessage')
																		.html(
																				"<font color = red>이름 입력 누락</font>");
																$(
																		'#nameMessage')
																		.show();

															} else if (data == "YES") {
																$(
																		'#nameMessage')
																		.html(
																				"<font color = green>사용가능합니다.</font>");
																$(
																		'#nameMessage')
																		.show();
																use = "possible";

															} else {
																$(
																		'#nameMessage')
																		.html(
																				"<font color = red>이미 등록된 이름입니다.</font>");
																use = "impossible";
																$(
																		'#nameMessage')
																		.show();

															}

														}

													});

										});

						$('input[name=id]').keydown(function() {
							isCheck = false;
							use = "";
							$('#nameMessage').css('display', 'none');
						});

						$('#btnSubmit').click(function() {
							if (use == "impossible") {
								alert("이미 사용중인 이름입니다.");
								return false;
							} else if (isCheck == false) {
								alert("중복체크 하세요.");
								return false;
							} else if ($('#phoneDoubleChk').val() != "true") {
								alert("본인인증을 완료해주세요.");
								return false;
							}
						});

					});
</script>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="resources/js/jquery.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		var code2 = "";

		$("#phoneChk").click(function() {
			alert("인증번호 발송이 완료되었습니다.\n인증번호 확인을 해주십시오.");

			var phoneNum = $("#phoneNum").val();

			$.ajax({
				type : "GET",
				url : "phoneCheck.users",
				data : {
					phoneNum : phoneNum
				},
				cache : false,
				success : function(data) {

					if (data == "error") {
						alert("휴대폰 번호가 올바르지 않습니다.")

					} else {
						$("#phone2").attr("disabled", false);
						$("#phoneChk2").css("display", "inline-block");
						$("#phoneNum").attr("readonly", true);
						code2 = data;
					}
				}
			});
		});

		$("#phoneChk2").click(function() {
			var enteredCode = $("#phone2").val();
			if (enteredCode === code2) {
				$(".successPhoneChk").text("인증번호가 일치합니다.");
				$(".successPhoneChk").css("color", "green");
				$("#phoneDoubleChk").val("true");
				$("#phone2").prop("disabled", true);

			} else {
				$(".successPhoneChk").text("인증번호가 일치하지 않습니다.");
				$(".successPhoneChk").css("color", "red");
				$("#phoneDoubleChk").val("false");
				$("#phoneChk2").focus(); // 포커스 설정
			}
		});
	});

	function execDaumPostcode() {
		new daum.Postcode({
			oncomplete : function(data) {
				// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

				// 각 주소의 노출 규칙에 따라 주소를 조합한다.
				// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
				var addr = ''; // 주소 변수
				var extraAddr = ''; // 참고항목 변수

				//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
				if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
					addr = data.roadAddress;
				} else { // 사용자가 지번 주소를 선택했을 경우(J)
					addr = data.jibunAddress;
				}

				// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
				if (data.userSelectedType === 'R') {
					// 법정동명이 있을 경우 추가한다. (법정리는 제외)
					// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
					if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
						extraAddr += data.bname;
					}
					// 건물명이 있고, 공동주택일 경우 추가한다.
					if (data.buildingName !== '' && data.apartment === 'Y') {
						extraAddr += (extraAddr !== '' ? ', '
								+ data.buildingName : data.buildingName);
					}
					// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
					if (extraAddr !== '') {
						extraAddr = ' (' + extraAddr + ')';
					}
					// 조합된 참고항목을 해당 필드에 넣는다.
					document.getElementById("address").value = extraAddr;

				} else {
					document.getElementById("address").value = '';
				}

				// 우편번호와 주소 정보를 해당 필드에 넣는다.
				document.getElementById('postcode').value = data.zonecode;
				document.getElementById("address").value = addr;

			}
		}).open();
	}
</script>
</head>

<br>
<br>
<body>
	<form name="register" action="join.users" method="post"
		enctype="multipart/form-data">
		<main>
			<div class="container">

				<section
					class="section register min-vh-100 d-flex flex-column align-items-center justify-content-center py-4">
					<div class="container">
						<div class="row justify-content-center">
							<div
								class="col-lg-20 col-md-20 d-flex flex-column align-items-center justify-content-center">


								<!-- End Logo -->

								<div class="card mb-15">

									<div class="card-body">

										<div class="pt-4 pb-2">
											<h3 class="card-title text-center pb-0 fs-15">Create an
												Account</h3>
											<p class="text-center small">Enter your personal details
												to create account</p>
										</div>
										<br>
										<div class="col-12">
											<label class="form-label">Profile</label> <input type="file"
												name="upload" value="${users.profile }" class="form-control"
												required>
											<div class="invalid-feedback"></div>
										</div>
										<br>
										<div class="col-12">
											<label class="form-label">ID</label>
											<div class="input-group has-validation">
												<input type="text" name="id" value="${users.id }"
													class="form-control" maxlength="10" required> <input type="button"
													class="btn" id="name_check" value="  Check  "
													style="background-color: #D8D8D8;">

												<div class="input-group has-validation">
													<span id="nameMessage"></span>
												</div>

												<div class="invalid-feedback"></div>
											</div>
										</div>
										<br>
										<div class="col-12">
											<label class="form-label">Password</label> <input
												type="password" name="pw" value="${users.pw }"
												class="form-control" maxlength="10" required>
											<div class="invalid-feedback">Please enter your
												password!</div>
										</div>
										<br> <label class="form-label">Gender</label>
										<div class="col-12">
											<div class="form-check form-check-inline">
												<input class="form-check-input" type="radio" name="gender"
													id="gender_male" value="남자" required> <label
													class="form-check-label" for="gender_male">Male</label>
											</div>
											<div class="form-check form-check-inline">
												<input class="form-check-input" type="radio" name="gender"
													id="gender_female" value="여자" required> <label
													class="form-check-label" for="gender_female">Female</label>
											</div>
											<div class="invalid-feedback">성별을 선택해 주세요.</div>
										</div>
										<br>
										<div class="col-12">
											<label class="form-label">Email</label> <input type="email"
												name="email" value="${users.email }" class="form-control" maxlength="15"
												required>
											<div class="invalid-feedback">Please enter your
												password!</div>
										</div>
										<br>
										<div class="col-12">
											<label class="form-label">name</label> <input type="text"
												name="name" value="${users.name }" class="form-control" maxlength="10"
												required>
											<div class="invalid-feedback">Please enter your
												password!</div>
										</div>
										<br>
										<div class="col-12">
											<label class="form-label">Phone</label>
											<div class="input-group has-validation">

												<input id="phoneNum" type="text" name="phoneNum"
													value="${users.phoneNum }" class="form-control"
													pattern="(010)\d{3,4}\d{4}" title="형식 01012345678"
													placeholder="'-' 없이 작성해주세요." maxlength="15" required /> <input
													id="phoneChk" class="btn" type="button"
													style="background-color: #D8D8D8;" value="본인인증">
											</div>
											<div class="pt-0 pb-2"></div>
										</div>
										<div class="col-12">
											<div class="input-group has-validation">
												<input id="phone2" type="text" name="phone2" maxlength="6"
													class="form-control" title="인증번호 입력" disabled required>
												<input id="phoneChk2" type="button" class="btn"
													style="background-color: #D8D8D8;" value="  Check  ">
												<div class="input-group has-validation">
													<span class="point successPhoneChk"></span>
												</div>

											</div>

											<input type="hidden" id="phoneDoubleChk" />
											<div class="invalid-feedback"></div>
										</div>

										<br>
										<div class="col-12">
											<label class="form-label">Post</label>
											<div class="input-group has-validation">
												<input type="text" name="postcode" id="postcode"
													value="${users.postcode }" class="form-control"
													placeholder="우편번호" required> <input type="button"
													class="btn" style="background-color: #D8D8D8;"
													onclick="execDaumPostcode()" value="  Search  ">

												<div class="input-group has-validation">
													<input type="text" name="address" id="address"
														value="${users.address }" class="form-control"
														placeholder="주소" required>
												</div>
												<div class="invalid-feedback">Please enter your post!</div>
											</div>
										</div>
										<br> <br>

										<div class="col-lg-12">
											<button class="btn w-100"
												style="background-color: #FA64B0; color: white;"
												type="submit" id="btnSubmit">Create account</button>
										</div>

										<!-- a태그 -->
										<!--
									    <div class="col-lg-12">
											<div class="border-first-button scroll-to-section">
												<a href="javascript:void(0);" id="btnSubmit" onclick="javascript:register.submit();">Create account</a>
											</div>
										</div> 
										-->
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