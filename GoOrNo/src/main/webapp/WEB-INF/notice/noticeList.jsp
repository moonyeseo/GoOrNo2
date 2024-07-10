<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "../userCommon/userHeader.jsp" %>
<!-- 본문 시작 -->
<div id="contact" class="contact-us section">
	<div class="container">
		<div class="row">
			<!-- 본문 제목 -->
			<div class="col-lg-6 offset-lg-3">
				<div class="section-heading wow fadeIn" data-wow-duration="1s"
					data-wow-delay="0.5s">
					<br>
					<h6>community</h6>
					<h4>
						<a href="list.notice" style="color:inherit;"><em>공지</em>사항</a>
					</h4>
					<div class="line-dec"></div>
				</div>
			</div>
			
			<!-- 테두리 안 본문 내용 -->
			<div class="col-lg-12 wow fadeInUp" data-wow-duration="0.5s" 
				data-wow-delay="0.25s">
				<section class="section">
					<div class="row">
						<div class="col-lg-12">
							<div class="card">
								<div class="card-body">
								
									<!-- 테이블 시작 -->
									<table class="table table-borderless">
										<thead>
											<!-- 게시판 검색 -->
											<tr>
												<td colspan="5" align="right">
													<form action="list.notice">
														<select name="whatColumn" class="form-select" style="width : 15%; display:inline;">
															<option value="all">전체 검색</option>
															<option value="subject">제목</option>
															<option value="content">내용</option>
														</select>
														<input type="text" name="keyword" class="form-control" style="width : 15%; display:inline;">
														<input type="submit" value="검색" class="btn btn-secondary">
													</form>
												</td>
											</tr>
											<!-- 컬럼 제목 -->
											<tr>
												<th scope="col" width="10%" style="text-align: center">글번호</th>
												<th scope="col" width="50%" style="text-align: center">제목</th>
												<th scope="col" width="10%" style="text-align: center">작성자</th>
												<th scope="col" width="20%" style="text-align: center">작성일</th>
												<th scope="col" width="10%" style="text-align: center">조회수</th>
											</tr>
										</thead>
										<!-- 글 목록 -->
										<tbody>
											<!-- 게시판 글 0개 -->
											<c:if test="${ fn:length(nlists) eq 0 }">
												<tr>
													<td colspan="5" align="center">글이 존재하지 않습니다.</td>
												</tr>
											</c:if>
											<!-- 게시판 글 1개 이상 -->
											<c:if test="${ fn:length(nlists) > 0 }">
												<c:forEach var="i" begin="0" end="${ fn:length(nlists)-1 }" varStatus="status">
													<tr>
														<!-- 글번호 -->
														<td align="center">${ pageInfo.totalCount - pageInfo.beginRow - status.index + 1}</td>
														<!-- 제목 -->
														<td align="left">
															<a href="detail.notice?notice_no=${ nlists[i].notice_no }&pageNumber=${param.pageNumber}&whatColumn=${ param.whatColumn }&keyword=${ param.keyword }"><font color="black">${ nlists[i].subject }</font></a> &nbsp;
														</td>
														<!-- 작성자 -->
														<td align="center">관리자</td>
														<!-- 작성일 -->
														<td align="center">
															<fmt:parseDate var="parsedDate" pattern="yyyy-MM-dd">${ fn:substring(nlists[i].regdate,0,10) }</fmt:parseDate>
															<fmt:formatDate value="${ parsedDate }" pattern="yyyy/MM/dd"/>
														</td>
														<!-- 조회수 -->
														<td align="center">${ nlists[i].readcount }</td>
													</tr>
												</c:forEach>
											</c:if>
											<!-- 페이지 넘기기 -->
											<tr>
												<td colspan="5" align="center">${ pageInfo.pagingHtml }</td>
											</tr>
										</tbody>
									</table>
									<!-- 테이블 끝 -->

	
								</div>
							</div>
						</div>
					</div>
				</section>

			</div>
		</div>
	</div>
</div>
<!-- 본문 끝 -->
<%@include file = "../userCommon/userFooter.jsp" %> <!--  user header 부분 -->