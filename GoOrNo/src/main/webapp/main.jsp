<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@include file="WEB-INF/userCommon/userHeader.jsp"%>

<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
	/*  캘린더 설정 */
	$(document).ready(function() {
		
		var  calendarFlag = <%=request.getAttribute("calendarFlag")%>;
		
		if(!calendarFlag){
			getRandom();
		}
	});
	
	function getRandom(){
		location.href = "random.event";
	}
	
</script>

<!-- 챗봇 -->
<!-- 챗봇 대화 -->
<div id="asideChatbot" class="asideChatbot ">
	<%@include file="WEB-INF/chatbot/chatbot.jsp"%>
</div>

<!-- 캘린더 아이콘 -->
<div id="calendarIcon">
	<%@include file="WEB-INF/event/calendarIcon.jsp"%>
</div>
<!-- 챗봇 대화 아이콘 -->
<div id="chatbotIcon">
	<%@include file="WEB-INF/chatbot/chatbotIcon.jsp"%>
</div>

<div class="main-banner wow fadeIn" id="top" data-wow-duration="1s"
	data-wow-delay="0.5s">
	<div class="container">
		<div class="row">
			<div class="col-lg-12">
				<div class="row">
					<div class="col-lg-6 align-self-center">
						<div class="left-content show-up header-text wow fadeInLeft"
							data-wow-duration="1s" data-wow-delay="1s">
							<div class="row">
								<div class="col-lg-12">
									<h6
										style="color: black; font-family: 'Do Hyeon'; font-style: normal; font-weight: 200; font-size: 30px">서울
										시 행사의 모든 것을 담다,</h6>
									<h2
										style="color: #FA64B0; font-family: 'Do Hyeon'; font-weight: 400; font-style: normal; font-size: 100px">
										<b>갈&nbsp;까&nbsp;말<font color="#8F89E9">&nbsp;까&nbsp;</font>?
										</b>
									</h2>
									<p>
										Welcom to '갈까말까' <br> You look up various events in Seoul<br>
										And you can check the current congestion level of several
										areas!
									</p>
								</div>
							</div>
						</div>
					</div>
					<div class="col-lg-6" style="margin-top: 40px">
						<div class="left-content show-up header-text wow fadeInLeft"
							data-wow-duration="1s" data-wow-delay="0.5s">
							<div class="blog-post">
								<div class="thumb">
									<a href="detail.event?eventNo=${event.event_no}"><span id="r_img">
											<c:choose>
												 <c:when test="${not empty event.fimg}">
													 <!-- 업로드된 이미지가 있으면 해당 이미지를 사용 -->
													<img src="${pageContext.request.contextPath}/resources/uploadImage/${event.fimg}" width = "70px" height = "300px" alt="${event.title}" />
												 </c:when>
											<c:otherwise>
													 <!-- 업로드된 이미지가 없으면 API 이미지를 사용 -->
													  <img src="${event.img }" width = "70px" height = "300px" alt="img">
													</c:otherwise>
											</c:choose>
									</span></a>
								</div>
								<div class="down-content">
									<span class="category" id="r_ptype">${event.performance_type }</span>
									<span class="date" id="r_period">${event.event_period }</span>
									<h4 id="eventTitle">${event.title }</h4>
									<p id="r_place">${event.place }</p>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<%@include file="WEB-INF/userCommon/userFooter.jsp"%><!--  user footer 부분 -->