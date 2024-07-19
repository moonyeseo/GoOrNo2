<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@include file="../adminCommon/adminHeader.jsp"%>

<script type="text/javascript">
	function deleteReview(review_no, whatColumn, keyword, pageNumber) {
		if(confirm('삭제하면 복구할수 없습니다.\n정말로 삭제하시겠습니까?')){
			location.href = "deleteReview.review?review_no=" + review_no
			+ "&whatColumn=" + whatColumn + "&keyword=" + keyword
			+ "&pageNumber=" + pageNumber;
		}
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
				<li class="breadcrumb-item"><a href="#">Review</a></li>
				<li class="breadcrumb-item active">List</li>
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
							<div style="text-align: center;">
								<table class="table table-borderless" style="margin-top :10px;">
									<thead>
											<!-- 게시판 검색 -->
											<tr>
												<td colspan="5" align="right">
													<form action="list.review" method = "post">
														<select name="whatColumn" class="form-select" style="width : 15%; display:inline;">
															<option value="all">전체 검색</option>
															<option value="user_id">작성자</option>
															<option value="rating">평점</option>
														</select>
														<input type="text" name="keyword" class="form-control" style="width : 15%; display:inline;">
														<input type="submit" value="검색" class="btn btn-secondary">
													</form>
												</td>
											</tr>
										<tr>
											<th  scope="col" width="10%" style="text-align: center">번호</th>
											<th  scope="col" width="10%" style="text-align: center">작성자</th>
											<th  scope="col" width="10%" style="text-align: center">별점</th>
											<th  scope="col" width="10%" style="text-align: center">내용</th>
											<th  scope="col" width="10%" style="text-align: center">삭제</th>
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
													<button type="button"  class="btn btn-secondary"
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