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
						<a href="list.qna" style="color:inherit;"><em>자유</em>게시판</a>
					</h4>
					<div class="line-dec"></div>
				</div>
			</div>
			
			<!-- 테두리 안 본문 내용 -->
			<div class="col-lg-12 wow fadeInUp" data-wow-duration="0.5s"
				data-wow-delay="0.25s" align="center">
				<section class="section">
					<div class="row">
						<div class="col-lg-12">
							<div class="card">
								<div class="card-body">
									
									<!-- 글 내용 감싸는 테두리 -->
									<div class="container border border-secondary-subtle rounded" style="width: 80%; margin-top: 30px; margin-bottom:10px;">

									<!-- 글 내용 시작 -->
									<table class="table table-borderless" style="text-align:center; width: 80%; margin-top: 50px;">
										<tr>
											<!-- 제목 -->
											<td colspan="2" width="70%" style="text-align: left;"><font size="4px"><b>${ qna.subject }</b></font></td>
										</tr>
										<tr>
											<!-- 작성자 ID -->
											<td align="left" style="width: 10%">${ qna.user_id }</td>
											<!-- 작성일  -->
											<td align="left" style="width: 80%">
												<fmt:parseDate var="parsedDate" pattern="yyyy-MM-dd">${ fn:substring(qna.regdate,0,10) }</fmt:parseDate>
												<fmt:formatDate value="${ parsedDate }" pattern="yyyy-MM-dd"/>
											</td>
											<!-- 조회수 -->
											<td align="right" style="width: 10%">${ qna.readcount }</td>
										</tr>
										<tr>
											<!-- 글 내용 -->
											<td colspan="3" style="padding:20px; text-align:left;">${ qna.content }</td>
										</tr>
										<tr>
											<td colspan="3" align="right" style="border-bottom:none;">
												<!-- 본인의 글일 경우에만 수정/삭제 버튼 나타남 -->
												<c:if test="${ loginInfo.user_no eq qna.user_no }">
													<input type="button" class="btn btn-secondary" value="글수정" onClick="location.href='update.qna?qna_no=${ qna.qna_no }&pageNumber=${param.pageNumber}&whatColumn=${ param.whatColumn }&keyword=${ param.keyword }'" style="background-color:white; color:black;">
													<input type="button" class="btn btn-secondary" value="글삭제" id="deleteConfirm" style="background-color:white; color:black;">
												</c:if>
												<input type="button" class="btn btn-secondary" onClick="location.href='list.qna?pageNumber=${param.pageNumber}&whatColumn=${ param.whatColumn }&keyword=${ param.keyword }'" value="글목록" style="background-color:white; color:black;">
											</td>
										</tr>
									</table>
									</div>
									<!-- 테이블 끝 -->

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
<%@include file = "../userCommon/userFooter.jsp" %> <!--  user header 부분 -->

<script type="text/javascript" src="<%= request.getContextPath() %>/resources/js/jquery.js"></script>
<script type="text/javascript">
$(function(){
	//게시글 삭제
    $('#deleteConfirm').click(function(){
        if(!confirm('삭제하면 복구할수 없습니다.\n정말로 삭제하시겠습니까?')){
            return false;
        }else{
        	const qna_no = '${qna.qna_no}';
        	const pageNumber = '${ param.pageNumber }';
        	const whatColumn = '${ param.whatColumn }';
        	const keyword = '${ param.keyword }';
        	
        	location.href = "delete.qna?qna_no=" + qna_no + "&pageNumber="
        			+ pageNumber+"&whatColumn=" + whatColumn + "&keyword=" + keyword;
        }
    });
	
});
</script>
