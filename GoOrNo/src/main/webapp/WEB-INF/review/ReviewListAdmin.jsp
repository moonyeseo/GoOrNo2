<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@include file="../adminCommon/adminHeader.jsp"%>

<script type="text/javascript">
	function deleteReview(review_no, whatColumn, keyword, pageNumber) {
		location.href = "deleteReview.review?review_no=" + review_no
				+ "&whatColumn=" + whatColumn + "&keyword=" + keyword
				+ "&pageNumber=" + pageNumber;
	}
</script>

<style type="text/css">
.starR {
	display: inline-block;
	width: 20px;
	height: 20px;
	color: transparent;
	text-shadow: 0 0 0 #f0f0f0;
	font-size: 1.2em;
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
<main id="main" class="main">

	<div class="pagetitle">
		<h1>Review</h1>
		<nav>
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="mainAdmin.jsp">Home</a></li>
				<li class="breadcrumb-item active">Review</li>
			</ol>
		</nav>
	</div>


	<div class="col-lg-12 wow fadeInUp" data-wow-duration="0.5s"
		data-wow-delay="0.25s">
		<section class="section">
			<div class="row">
				<div class="col-lg-12">

					<div class="card">
						<div class="card-body">
							<h5 class="card-title">ReviewList</h5>

							<form action="list.review" method="post" align="center">
								<div class="search-bar">
									<select name="whatColumn"
										style="height: 37px; vertical-align: middle;">
										<option value="all">전체 검색</option>
										<option value="user_id">작성자 검색</option>
										<option value="rating">평점 검색</option>
									</select> 
									<input type="text" name="keyword" placeholder="Search"
										style="height: 37px; vertical-align: middle;"> 
									<input type="submit" value="검색" class="btn btn-dark">
								</div>
							</form>
							<br>
							<div style="text-align: center;">
								<table class="table table-borderless">
									<thead>
										<tr>
											<th>번호</th>
											<th>작성자</th>
											<th>별점</th>
											<th>내용</th>
											<th>삭제</th>
										</tr>
									</thead>

									<tbody>
										<c:if test="${totalCount == 0}">

											<tr>
												<td align="center" colspan="5">작성된 리뷰가 없습니다.</td>
											</tr>

										</c:if>
										<c:forEach var="review" items="${reviewList }">
											
											<tr>
												<td>${review.review_no }</td>
												<td>${review.user_id }</td>
												<td><c:forEach begin="1" end="${review.rating}" var="i">
														<span class="starR on" id="${i}">⭐</span>
													</c:forEach></td>
												<td>${review.comments }</td>
												<td>
													<button type="button" class="btn btn-dark"
														onclick="deleteReview('${review.review_no}', '${param.whatColumn}', '${param.keyword}', '${pageInfo.pageNumber}')">삭제</button>
												</td>
											</tr>
										</c:forEach>

									</tbody>

								</table>
							</div>
							<center>${pageInfo.pagingHtml }</center>
						</div>
					</div>

				</div>
			</div>
		</section>
	</div>
</main>


<%@include file="../adminCommon/adminFooter.jsp"%>