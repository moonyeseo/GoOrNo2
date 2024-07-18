<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>  
<%@ include file = "../userCommon/userHeader.jsp" %>
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
			<div class="col-lg-6 offset-lg-3"> 
				<div class="section-heading wow fadeIn" data-wow-duration="1s"
					data-wow-delay="0.5s">
					<br>
					<h6>Notice</h6>
					<h4>
						<a href="list.qna" style="color:inherit;">Q<em>&</em>A</a>
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
													<form action="list.qna">
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
											<!-- 글 작성 버튼 -->
											<tr>
												<td colspan="5" align="right">
													<input type="button" onClick="return writeQna()" value="글쓰기" class="btn btn-secondary">
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
											<c:if test="${ fn:length(qlists) eq 0 }">
												<tr>
													<td colspan="5" align="center">글이 존재하지 않습니다.</td>
												</tr>
											</c:if>
											<!-- 게시판 글 1개 이상 -->
											<c:if test="${ fn:length(qlists) > 0 }">
												<c:forEach var="i" begin="0" end="${ fn:length(qlists)-1 }" varStatus="status">
													<tr>
														<!-- 글번호 -->
														<td align="center">${ pageInfo.totalCount - pageInfo.beginRow - status.index + 1}</td>
														<!-- 제목 -->
														<td align="left">
															<!-- 답글이면 re 아이콘 삽입 -->
															<c:if test="${ qlists[i].qna_no ne qlists[i].ref }">
																<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-return-right" viewBox="0 0 16 16">
																  <path fill-rule="evenodd" d="M1.5 1.5A.5.5 0 0 0 1 2v4.8a2.5 2.5 0 0 0 2.5 2.5h9.793l-3.347 3.346a.5.5 0 0 0 .708.708l4.2-4.2a.5.5 0 0 0 0-.708l-4-4a.5.5 0 0 0-.708.708L13.293 8.3H3.5A1.5 1.5 0 0 1 2 6.8V2a.5.5 0 0 0-.5-.5"/>
																</svg>	
															</c:if>
															<a href="detail.qna?qna_no=${ qlists[i].qna_no }&pageNumber=${param.pageNumber}&whatColumn=${ param.whatColumn }&keyword=${ param.keyword }"><font color="black">${ qlists[i].subject }</font></a> &nbsp;
														</td>
														<!-- 작성자 -->
														<td align="center">
															<c:if test="${ qlists[i].user_no eq '' }">
																<font color="gray">탈퇴한 회원</font>
															</c:if>
															<c:if test="${ qlists[i].user_no ne '' }">
																${ qlists[i].user_id }
															</c:if>	
														</td>
														<!-- 작성일 -->
														<td align="center">
															<fmt:parseDate var="parsedDate" pattern="yyyy-MM-dd">${ fn:substring(qlists[i].regdate,0,10) }</fmt:parseDate>
															<fmt:formatDate value="${ parsedDate }" pattern="yyyy/MM/dd"/>
														</td>
														<!-- 조회수 -->
														<td align="center">${ qlists[i].readcount }</td>
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
<script type="text/javascript">
const id = '${ sessionScope.id }';

function writeQna(){
	if(id == ''){
		alert("로그인한 회원만 글을 작성할 수 있습니다.");
		return false;
	}else{
		location.href='insert.qna?pageNumber=${pageInfo.pageNumber}&whatColumn=${ pageInfo.whatColumn }&keyword=${ pageInfo.keyword }';
	}
}
</script>
<!-- 본문 끝 -->
<%@include file = "../userCommon/userFooter.jsp" %> <!--  user header 부분 -->