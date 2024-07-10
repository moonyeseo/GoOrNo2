<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "../userCommon/userHeader.jsp" %>
<style type="text/css">
.aco_list {
	list-style: none;
	pause: 0;
}
.aco_list li {
	border-bottom: 1px solid #ddd;	
}
.aco_list li a {
	display : block;
	height : 50px;
	padding-left:  20px;
	line-height: 50px;
	color: #222;
	text-decoration: none;
	transition : .2s;
}
.aco_list li a:hover{
	background-color: #8F89E9;
	color : #fff;
}
.aco_list li .text_box{ 
	display: none;
	padding: 10px 40px;
	color : #555
}
</style>
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
						<a href="list.faq" style="color:inherit;"><em>FA</em>Q</a>
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
								
									<!-- 게시판 검색 -->
									<table class="table table-borderless">
										<tr>
											<td colspan="5" align="right">
												<form action="list.faq">
													<select name="whatColumn" class="form-select" style="width : 15%; display:inline;">
														<option value="all">전체 검색</option>
														<option value="question">질문</option>
														<option value="answer">내용</option>
													</select>
													<input type="text" name="keyword" class="form-control" style="width : 15%; display:inline;">
													<input type="submit" value="검색" class="btn btn-secondary">
												</form>
											</td>
										</tr>
									</table>
									
									<!-- faq 글 0개 -->
									<c:if test="${ fn:length(flists) eq 0 }">
										글이 존재하지 않습니다.
									</c:if>
									
									<!-- faq 글 1개 이상 -->
									<c:if test="${ fn:length(flists) > 0 }">
										<c:forEach var="i" begin="0" end="${ fn:length(flists)-1 }" varStatus="status">	
											<!-- 아코디언 시작 -->
											<ul class = "aco_list">
												<li>
													<a href="#n">${ flists[i].question }</a>
													<p class="text_box">
														${ flists[i].answer }
													</p>
												</li>
											</ul>
											<!-- 아코디언 끝 -->
										</c:forEach>
									</c:if>
									<span style="align-items: center; display: flex; justify-content: center; margin-top: 20px;">${ pageInfo.pagingHtml }</span>
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
<%@include file = "../userCommon/userFooter.jsp" %>
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/vendor/jquery/jquery.js"></script>
<script type="text/javascript">
$(function(){
    const acoAco = $('.aco_list li a');
    
    acoAco.on('click', function(event){
        event.preventDefault(); // 링크 기본 동작 방지
        const item = $(this);
        
        // 모든 .text_box를 슬라이드 업
        $('.text_box').slideUp();
        
        // 클릭된 아이템의 .text_box만 슬라이드 다운
        item.parent().find('.text_box').stop(true, true).slideDown();
    });
});
</script>

