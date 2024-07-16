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
	padding-top: 20px; /* 메뉴바에 가리지 않도록 패딩 추가 */
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

<section class="event-detail-container">
	<div class="event-title">
		<h2>상세정보</h2>
	</div>
	<div style="display: flex; width: 100%;">
		<img src="${event.img}" alt="${event.title}">
		<div class="event-info">
			<table>
				<tr>
					<th>분류</th>
					<td>${event.performance_type}</td>
				</tr>
				<tr>
					<th>행사/공연</th>
					<td>${event.title}</td>
				</tr>
				<tr>
					<th>기간</th>
					<td>${event.event_period}</td>
				</tr>
				<tr>
					<th>장소</th>
					<td>${event.place}</td>
				</tr>
				<tr>
					<td colspan="2"><input type="button"
						class="btn btn-outline-primary btn-sm" value="목록보기"
						onClick="location.href='list.event?eventNo=${event.event_no }&whatColumn=${param.whatColumn}&keyword=${param.keyword}&pageNumber=${param.pageNumber}'">
						<input type="button" class="btn btn-outline-primary btn-sm"
						value="길찾기"
						onClick="location.href='search.bookmark?lat=${event.lat}&lot=${event.lot }&place=${event.place }'">
					</td>
				</tr>
			</table>
		</div>
	</div>
</section>

<!-- 리뷰  -->
<div class="col-lg-12" align="center">
	<section class="section">
		<div class="row">
			<div class="col-lg-12">
				<div class="card">
					<div class="card-body">
						<h2>Review</h2>
						<div class="pt-3 pb-2"></div>
						<p>별점을 선택해주세요.</p>

						<div>
							<div class="starRev" id="rating">
								<input type="hidden" id="count">
								<span class="starR" id="1">⭐</span>
								<span class="starR" id="2">⭐</span>
								<span class="starR" id="3">⭐</span>
								<span class="starR" id="4">⭐</span>
								<span class="starR" id="5">⭐</span>
							</div>

							<c:if test="${ loginInfo.id ne null }">
								<table class="table table-borderless" style="width: 70%;">
									<tr>
										<td align="right">
										<textarea name="comments" id="reviewComment" class="form-control"
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
												placeholder="로그인한 회원만 리뷰를 작성할 수 있습니다." disabled="disabled"
												style="resize: none;"></textarea></td>
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
								<c:when test="${averageRating != null and averageRating != 0}">
								평균 별점:
								 <span class="starR on">⭐</span> 
								 <fmt:formatNumber value="${averageRating}" type="number" maxFractionDigits="1" /> / 5
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
												</c:if>
											</td>
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

		  $.ajax({
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
								+ starIcon +"  "+ averageRating.toFixed(1) + " / 5";
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
</script>


<%@include file="../userCommon/userFooter.jsp"%>
