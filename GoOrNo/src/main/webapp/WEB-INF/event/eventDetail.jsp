<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../userCommon/userHeader.jsp"%>
<!--  user header 부분 -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<title>Event Detail</title>
<style type="text/css">
.event-detail-container {
	display: flex;
	justify-content: center;
	flex-direction: column;
	margin: 100px auto;
	max-width: 1200px;
	width: 100%;
	padding-top: 50px; /* 메뉴바에 가리지 않도록 패딩 추가 */
}

.event-detail-container img {
	width: 50%;
	height: 400px;
	margin-right: 20px;
}

.event-info {
	flex: 1;
	display: flex;
	align-items: center;
	background-color: #ffffff;
	border-radius: 10px;
	height: 400px; /* 이미지와 동일한 높이로 설정 */
}

.event-info table {
	width: 100%;
	height: 100%;
	border-collapse: separate;
	border-spacing: 0;
}

.event-info th {
	background-color: #f2f2f2;
	width: 120px;
	padding: 15px;
	text-align: center;
	border: 1px solid #dddddd;
}

.event-title {
	width: 100%;
	text-align: center;
	margin-bottom: 20px;
}

#btnList {
	text-align: center;
}

.event-info td {
	padding: 15px;
	text-align: left;
	border: 1px solid #dddddd;
}

.event-title {
	width: 100%;
	text-align: center;
	margin-bottom: 20px;
}

/* 리뷰 스타일 추가 */
.starR {
	display: inline-block;
	width: 23px;
	height: 20px;
	color: transparent;
	text-shadow: 0 0 0 #f0f0f0;
	font-size: 1.3em;
	box-sizing: border-box;
	cursor: pointer;
}

/* 별 이모지에 마우스 오버 시 */
.starR:hover {
	text-shadow: 0 0 0 #ccc;
}

/* 별 이모지를 클릭 후 class="on"이 되었을 경우 */
.starR.on {
	text-shadow: 0 0 0 #ffbc00;
}


/* 관심목록 */
.icon-button {
	border: none;
	background: none;
	padding: 0;
	cursor: pointer;
	position: absolute;
	top: 10px;
	left: 10px;
}

.icon-button i {
	font-size: 24px;
	color: #fa64b0; /* 채워진 하트 색상 */
	transition: color 0.3s;
}

</style>

<!-- 챗봇 -->
<div id="asideChatbot" class="asideChatbot " style="heigth: 80%">
	<%@include file="../chatbot/chatbot.jsp"%>
</div>

<div id="chatbotIcon" style="heigth: 20%">
	<%@include file="../chatbot/chatbotIcon.jsp"%>
</div>

<!-- 캘린더 아이콘 -->
<div id="calendarIcon" style="heigth: 20%">
	<%@include file="../event/calendarIcon.jsp"%>
</div>

<!-- 본문 시작 -->
<div id="contact" class="contact-us section">
	<div class="container">
		<div class="row">
			<!-- 본문 제목 -->
			<div class="col-lg-6 offset-lg-3" style = "padding-top : 40px;">
				<div class="section-heading wow fadeIn" data-wow-duration="1s"
					data-wow-delay="0.5s">
					<br>
					<h6>Event</h6>
					<h4>
						<a href="#" style="color: inherit;"><em>상세</em> 정보</a>
					</h4>
					<div class="line-dec"></div>
				</div>
				</div>

			<!-- 테두리 안 본문 내용 -->
			<div class="col-lg-12 wow fadeInUp" data-wow-duration="0.5s"
				data-wow-delay="0.25s" align="center">
				<section class="section">
					<div class="row">
						<div class="col-lg-12" style="display: inline">
							<div class="card">
								<div class="card-body">

									<!-- 글 내용 감싸는 테두리 -->
									<div class="container border border-secondary-subtle rounded"
										style="width: 100%; margin-top: 30px; margin-bottom: 10px;">

										<!-- 글 내용 시작 -->
										<table class="table table-borderless"
											style="text-align: center; width: 100%; margin-top: 50px;">
											<tr>
												<td rowspan="4" width="40%"">
													<%-- <img src="${event.img}" alt="${event.title}"> --%> 
													<c:choose>
														<c:when test="${not empty event.fimg}">
															<!-- 업로드된 이미지가 있으면 해당 이미지를 사용 -->
															<img
																src="${pageContext.request.contextPath}/resources/uploadImage/${event.fimg}"
																width="100" height="100" alt="${event.title}" />
															<button type="button" onclick="favoriteInsert(${event.event_no}, ${sessionScope.loginInfo.user_no})" class="icon-button">
																<i id="heart-f" style="${favoriteStatus ? 'display: inline-block;' : 'display: none;'}">
																	<svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-heart-fill" viewBox="0 0 16 16">
																		<path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314"/>
																	</svg>
																</i>
																<i id="heart-o" style="${!favoriteStatus ? 'display: inline-block;' : 'display: none;'}">
																	<svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-heart" viewBox="0 0 16 16">
																		<path d="m8 2.748-.717-.737C5.6.281 2.514.878 1.4 3.053c-.523 1.023-.641 2.5.314 4.385.92 1.815 2.834 3.989 6.286 6.357 3.452-2.368 5.365-4.542 6.286-6.357.955-1.886.838-3.362.314-4.385C13.486.878 10.4.28 8.717 2.01zM8 15C-7.333 4.868 3.279-3.04 7.824 1.143q.09.083.176.171a3 3 0 0 1 .176-.17C12.72-3.042 23.333 4.867 8 15"/>
																	</svg>
																</i>
															</button>
														</c:when>
														<c:otherwise>
															<!-- 업로드된 이미지가 없으면 API 이미지를 사용 -->
															<img src="${event.img}" width="100" height="100"
																alt="${event.title}" />
															<button type="button" onclick="favoriteInsert(${event.event_no}, ${sessionScope.loginInfo.user_no})" class="icon-button">
																<i id="heart-f" style="${favoriteStatus ? 'display: inline-block;' : 'display: none;'}">
																	<svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-heart-fill" viewBox="0 0 16 16">
																		<path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314"/>
																	</svg>
																</i>
																<i id="heart-o" style="${!favoriteStatus ? 'display: inline-block;' : 'display: none;'}">
																	<svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-heart" viewBox="0 0 16 16">
																		<path d="m8 2.748-.717-.737C5.6.281 2.514.878 1.4 3.053c-.523 1.023-.641 2.5.314 4.385.92 1.815 2.834 3.989 6.286 6.357 3.452-2.368 5.365-4.542 6.286-6.357.955-1.886.838-3.362.314-4.385C13.486.878 10.4.28 8.717 2.01zM8 15C-7.333 4.868 3.279-3.04 7.824 1.143q.09.083.176.171a3 3 0 0 1 .176-.17C12.72-3.042 23.333 4.867 8 15"/>
																	</svg>
																</i>
															</button>
														</c:otherwise>
													</c:choose>
												</td>
												<!-- 행사 제목 -->
												<td width="30%" style="text-align: left;" colspan="2"><font
													size="4px"><b>${event.title}</b></font></td>
											</tr>
											<tr>
												<!-- 행사 분류 -->
												<td align="left" style="width: 10%; color: gray">카테고리</td>
												<td align="left" style="width: 40%" colspan="2">${event.performance_type}</td>
											</tr>
											<tr>
												<!-- 행사 기간 -->
												<td align="left" style="width: 10%; color: gray">기간</td>
												<td align="left" style="width: 40%" colspan="2">${event.event_period}</td>
											</tr>
											<tr>
												<!-- 행사 장소 -->
												<td align="left" style="width: 10%; color: gray">장소</td>
												<td align="left" style="width: 40%" colspan="2">${event.place}</td>
											</tr>
											<tr>
												<td colspan="3" align="right" style="border-bottom: none;">
													<input type="button" class="btn btn-secondary"
													onClick="location.href='list.event?eventNo=${event.event_no }&whatColumn=${param.whatColumn}&keyword=${param.keyword}&pageNumber=${pageNumber}'"
													value="글목록" style="background-color: white; color: black;">
													<input type="button" class="btn btn-secondary" value="길찾기"
													style="background-color: white; color: black;"
													onClick="location.href='search.bookmark?lat=${event.lat}&lot=${event.lot }&place=${event.place }'">
												</td>
											</tr>
										</table>
									</div>
									<!-- 리뷰  -->
										<div class="pt-3 pb-2" style = "margin-top:50px"></div>
										<p>별점을 선택해주세요.</p>

										<div>
											<div class="starRev" id="rating">
												<input type="hidden" id="count"> <span class="starR"
													id="1">⭐</span> <span class="starR" id="2">⭐</span> <span
													class="starR" id="3">⭐</span> <span class="starR" id="4">⭐</span>
												<span class="starR" id="5">⭐</span>

											</div>

											<c:if test="${ loginInfo.id ne null }">
												<table class="table table-borderless" style="width: 70%;">
													<tr>
														<td align="right"><textarea name="comments"
																id="reviewComment" class="form-control"
																placeholder="리뷰를 작성해 보세요." style="resize: none;"></textarea></td>
													</tr>
													<tr>
														<td align="right"><button onclick="commentwirte()"
																class="btn btn-secondary">작성하기</button></td>
													</tr>
												</table>
											</c:if>

											<c:if test="${ loginInfo.id eq null }">
												<table class="table table-borderless" style="width: 70%;">
													<tr>
														<td align="right"><textarea name="comments"
																id="reviewComment" class="form-control"
																placeholder="로그인한 회원만 리뷰를 작성할 수 있습니다."
																disabled="disabled" style="resize: none;"></textarea></td>
													</tr>
													<tr>
														<td align="right"><button disabled="disabled"
																class="btn btn-secondary">작성하기</button></td>
													</tr>
												</table>
											</c:if>
										</div>

										<div id="averageRating">
											<c:choose>
												<c:when
													test="${averageRating != null and averageRating != 0}">
											평균 별점:
											 <span class="starR on">⭐</span>
													<fmt:formatNumber value="${averageRating}" type="number"
														maxFractionDigits="1" /> / 5
											</c:when>
												<c:otherwise>
											평균 별점: 
											<span class="starR on">⭐</span> 0.0 / 5
											 </c:otherwise>
											</c:choose>
										</div>

										<div class="pt-1 pb-2"></div>
										<div id="reviewView">
											<table class="table table-borderless" style="width: 70%;">
												<c:if test="${fn:length(reviewLists) < 1}">
													<tr>
														<td align="center">첫 리뷰를 작성해주세요.</td>
													</tr>
												</c:if>
												<c:if test="${fn:length(reviewLists) > 0}">
													<c:forEach var="review" items="${reviewLists}">
														<tr>
															<td width="15%" align="left">${review.user_id}</td>
															<td width="25%" align="left"><c:forEach begin="1"
																	end="${review.rating}" var="i">
																	<span class="starR on" id="${i}">⭐</span>
																</c:forEach></td>
															<td width="40%" align="left">${review.comments}</td>
															<td width="20%" align="left"
																style="font-family: 'Noto Sans';"><c:if
																	test="${loginInfo.id eq review.user_id}">
																	<a onClick="return deletereview('${review.review_no}')"
																		style="cursor: pointer;"> <font size="2px">삭제</font>
																	</a>
																</c:if></td>
														</tr>
													</c:forEach>
												</c:if>
											</table>
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
<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$('.starRev span').click(function() {
			$(this).parent().children('span').removeClass('on');
			$(this).addClass('on').prevAll('span').addClass('on');
			$("#count").val(this.id);
			return false;
		});
	});

	function commentwirte() {

		const comments = document.getElementById("reviewComment").value;
		const rating = document.getElementById("count").value;
		const event_no = '${event.event_no}';
		const id = '${loginInfo.id}';

		if (count == "" || rating == "") {
			alert("별점을 선택해주세요.");
			return;
		}

		if (comments == "") {
			alert("글을 작성해주세요.");
			return;
		}

		$
				.ajax({
					type : "post",
					url : "commit.review",
					data : {
						comments : comments,
						event_no : event_no,
						id : id,
						rating : rating,
					},
					dataType : "json",
					success : function(reviewLists) {
						let output = "<table class='table table-borderless' style='width: 70%;'>";
						let totalRating = 0;

						for ( let i in reviewLists) {
							output += "<tr>";
							output += "<td width='15%' align='left'>"
									+ reviewLists[i].user_id + "</td>";
							output += "<td width='25%' align='left'>";

							for (let j = 1; j <= reviewLists[i].rating; j++) {
								output += "<span class='starR on' id='" + j + "'>⭐</span>";
							}
							output += "</td>";

							output += "<td width='40%' align='left'>"
									+ reviewLists[i].comments + "</td>";

							if (reviewLists[i].user_id == id) {
								let review_no = reviewLists[i].review_no;
								output += "<td width='20%' align='left'>";
								output += "<a onClick='return deletereview("
										+ review_no
										+ ")' style='cursor: pointer;'><font size='2px'>삭제</font></a>";
								output += "</td>";
							}

							output += "</tr>";

							totalRating += reviewLists[i].rating;
						}
						output += "</table>";

						// 평균 별점
						const averageRating = totalRating / reviewLists.length;
						const starIcon = '<span class="starR on">⭐</span>';

						document.getElementById("reviewView").innerHTML = output;
						document.getElementById("reviewComment").value = '';
						document.getElementById("averageRating").innerHTML = "평균 별점: "
								+ starIcon
								+ "  "
								+ averageRating.toFixed(1)
								+ " / 5";
					},
					error : function(request, status, error) {
						alert("code:" + request.status + "\n" + "message:"
								+ request.responseText + "\n" + "error:"
								+ error);
					}
				});
	}

	function deletereview(review_no) {
		if (!confirm('리뷰를 삭제하시겠습니까?')) {
			return false;
		} else {
			const event_no = '${event.event_no}';
			const pageNumber = '${ param.pageNumber }';
			const whatColumn = '${ param.whatColumn }';
			const keyword = '${ param.keyword }';

			location.href = "delete.review?review_no=" + review_no
					+ "&eventNo=" + event_no + "&pageNumber=" + pageNumber
					+ "&whatColumn=" + whatColumn + "&keyword=" + keyword;
		}
	}
	
	function favoriteInsert(event_no, user_no) {
	    $.ajax({
	        type: "post",
	        url: "${pageContext.request.contextPath}/favoriteInsert.favorite",
	        data: { event_no: event_no, user_no: user_no },
	        success: function(response) {
	            const heartFilled = document.getElementById("heart-f");
	            const heartOutline = document.getElementById("heart-o");

	            if (response.status === 'added') {
	                alert('관심행사로 등록합니다.');
	                heartFilled.style.display = 'inline-block';
	                heartOutline.style.display = 'none';
	            } else if (response.status === 'removed') {
	                alert('관심행사에서 삭제합니다.');
	                heartFilled.style.display = 'none';
	                heartOutline.style.display = 'inline-block';
	            }
	        },
	        error: function(request, status, error) {
	            alert("로그인이 필요한 서비스입니다.");
	        }
	    });
	}

	
</script>

<%@include file="../userCommon/userFooter.jsp"%>
