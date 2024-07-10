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
				data-wow-delay="0.25s">
				<section class="section">
					<div class="row">
						<div class="col-lg-12">
							<div class="card">
								<div class="card-body">
								
									<!-- 글 내용 감싸는 컨테이너 -->
									<div class="container" style="width: 50%; margin-top: 30px; margin-bottom:10px;">
									<!-- 입력폼 시작 -->
									<form:form commandName="qna" action="update.qna" method="post">
										<input type="hidden" name="user_id" value="${ qna.user_id }">
										<input type="hidden" name="qna_no" value="${ qna.qna_no }">
										<input type="hidden" name="pageNumber" value="${ param.pageNumber }">
										<input type="hidden" name="whatColumn" value="${ param.whatColumn }">
										<input type="hidden" name="keyword" value="${ param.keyword }">
										<table class="table table-borderless" width="100%">
											<tr>
												<td>
													<font size="4px"><b> 제목 </b></font>
													<input type="text" name="subject" value="${ qna.subject }" class="form-control" style="width:80%; diaply:inline;" disabled>
													<input type="hidden" name="subject" value="${ qna.subject }">
												</td>
											</tr>
											<tr>
												<td>
													<textarea rows="10" style="resize:none;" name="content" class="form-control">${ qna.content }</textarea>
													<form:errors path="content" cssClass="err"></form:errors>
												</td>	
											</tr>
											<tr>
												<td align="center">
													<input type="submit" value="글수정" class="btn btn-light">
													<input type="button" onClick="location.href='list.qna?pageNumber=${param.pageNumber}&whatColumn=${ param.whatColumn }&keyword=${ param.keyword }'" value="목록보기" class="btn btn-light">
												</td>
											</tr>
										</table>
									</form:form>
									<!-- 입력폼 끝 -->
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

<%@include file = "../userCommon/userFooter.jsp" %> <!--  user header 부분 -->

