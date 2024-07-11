<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@include file="WEB-INF/userCommon/userHeader.jsp"%>

<style type="text/css">
/* section calendar */
.sec_cal {
	width: 360px;
	margin: 0 auto;
	font-family: "NotoSansR";
}

.sec_cal .cal_nav {
	display: flex;
	justify-content: center;
	align-items: center;
	font-weight: 700;
	font-size: 48px;
	line-height: 78px;
}

.sec_cal .cal_nav .year-month {
	width: 200px;
	text-align: center;
	line-height: 1;
}

.sec_cal .cal_nav .nav {
	display: flex;
	border: 1px solid #333333;
	border-radius: 5px;
}

.sec_cal .cal_nav .go-prev, .sec_cal .cal_nav .go-next {
	display: block;
	width: 50px;
	height: 78px;
	font-size: 0;
	display: flex;
	justify-content: center;
	align-items: center;
}

.sec_cal .cal_nav .go-prev::before, .sec_cal .cal_nav .go-next::before {
	content: "";
	display: block;
	width: 20px;
	height: 20px;
	border: 3px solid #000;
	border-width: 3px 3px 0 0;
	transition: border 0.1s;
}

.sec_cal .cal_nav .go-prev:hover::before, .sec_cal .cal_nav .go-next:hover::before
	{
	border-color: #ed2a61;
}

.sec_cal .cal_nav .go-prev::before {
	transform: rotate(-135deg);
}

.sec_cal .cal_nav .go-next::before {
	transform: rotate(45deg);
}

.sec_cal .cal_wrap {
	padding-top: 40px;
	position: relative;
	margin: 0 auto;
}

.sec_cal .cal_wrap .days {
	display: flex;
	margin-bottom: 20px;
	padding-bottom: 20px;
	border-bottom: 1px solid #ddd;
}

.sec_cal .cal_wrap::after {
	top: 368px;
}

.sec_cal .cal_wrap .day {
	display: flex;
	align-items: center;
	justify-content: center;
	width: calc(100%/ 7);
	text-align: left;
	color: #999;
	font-size: 12px;
	text-align: center;
	border-radius: 5px
}

.current.today {
	background: #FBD2BD;
}

.sec_cal .cal_wrap .dates {
	display: flex;
	flex-flow: wrap;
	height: 290px;
}

.moon {
	color: gray;
}

.sec_cal .cal_wrap .day:nth-child(7n -1)>a {
	color: #8F89E9;
}

.sec_cal .cal_wrap .day:nth-child(7n)>a {
	color: #FA64B0;
}

.sec_cal .cal_wrap .day.disable {
	color: #ddd;
}

.moon:hover, .sec_cal .cal_wrap .day:nth-child(7n -1)>a:hover, .sec_cal .cal_wrap .day:nth-child(7n)>a:hover
	{
	color: #FF8224;
}
</style>

<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
	/*  캘린더 설정 */
	$(document).ready(function() {
		// 날짜 정보 가져오기
		date = new Date(); // 현재 날짜(로컬 기준) 가져오기
		utc = date.getTime() + (date.getTimezoneOffset() * 60 * 1000); // uct 표준시 도출
		kstGap = 9 * 60 * 60 * 1000; // 한국 kst 기준시간 더하기
		today = new Date(utc + kstGap); // 한국 시간으로 date 객체 만들기(오늘)
		todayDate = today.getDate();

		var year = <%=request.getParameter("year")%>
		var month = <%=request.getParameter("month")%>
		var day = <%=request.getParameter("day")%>
		
		var selectDate = new Date(year, month-1, day);
		
		calendarInit(selectDate);
		
		var calendarFlag = <%=request.getAttribute("calendarFlag")%>
		
		if(!calendarFlag){
			getDate(todayDate);
		}
	});
	
	function getDate(date){
		
		if(date != todayDate){
			day = $(date).text();
		}
		else{
			day = todayDate;
		}
		
		location.href = "calendar.event?year=" + year + "&month=" + month + "&day=" + day; // ajax 사용 x
		
		// ajax 사용
/*   		$.ajax({
			url : "calendar.event",
			data : {
				year : year,
				month : month,
				day : day
			},
			dataType : "json",
			success : function(eventLists){
				//alert("성공 : " + eventLists.length);
				
				// 랜덤 행사 출력
				$("#r_img").append("<img src = '" +eventLists[0].img +"'>");
				$("#r_ptype").append(eventLists[0].performance_type); 
				$("#r_period").append(eventLists[0].event_period); 
				$("#eventTitle").append(eventLists[0].title); 
				$("#r_place").append(eventLists[0].place); 
			
				if(eventLists.length > 1){
					$("#calendar").append('<div class="blog-posts"><div class="row">')
					
	               for(var i = 1; i < eventLists.length; i++){
	                  $("#calendar").append('<div class="col-lg-12"><div class="post-item"><div class="thumb">');
	                  $("#calendar").append('<a href="#"><img src="' + eventLists[i].img  + '"></a></div>');
	                  $("#calendar").append('<div class="right-content">');
	                  $("#calendar").append('<span class="category">' + eventLists[i].performance_type + '</span> <span class="date">' + eventLists[i].event_period + '</span>');
	                  $("#calendar").append('<h4>' + eventLists[i].title + '</h4>');
	                  $("#calendar").append('<p>' + eventLists[i].place  + '<p>');
	                  $("#calendar").append('</div></div></div>'); 
	               }

	                  $("#calendar").append('</div></div>'); 
					
				} 
			}
		}); */
		
	}

	/*
	 달력 렌더링 할 때 필요한 정보 목록 

	 현재 월(초기값 : 현재 시간)
	 금월 마지막일 날짜와 요일
	 전월 마지막일 날짜와 요일
	 */

	function calendarInit(selectDate) {

		var thisMonth = new Date(today.getFullYear(), today.getMonth(), today
				.getDate());
		
		if(selectDate.getYear() != -1){
			thisMonth = selectDate;
		}
		
		// 달력에서 표기하는 날짜 객체
		var currentYear = thisMonth.getFullYear(); // 달력에서 표기하는 연
		var currentMonth = thisMonth.getMonth(); // 달력에서 표기하는 월
		var currentDate = thisMonth.getDate(); // 달력에서 표기하는 일

		// kst 기준 현재시간
		// console.log(thisMonth);

		// 캘린더 렌더링
		renderCalender(thisMonth);

		function renderCalender(thisMonth) {

			// 렌더링을 위한 데이터 정리
			currentYear = thisMonth.getFullYear();
			currentMonth = thisMonth.getMonth();
			currentDate = thisMonth.getDate();

			// 이전 달의 마지막 날 날짜와 요일 구하기
			var startDay = new Date(currentYear, currentMonth, 0);
			var prevDate = startDay.getDate();
			var prevDay = startDay.getDay();

			// 이번 달의 마지막날 날짜와 요일 구하기
			var endDay = new Date(currentYear, currentMonth + 1, 0);
			var nextDate = endDay.getDate();
			var nextDay = endDay.getDay();

			// console.log(prevDate, prevDay, nextDate, nextDay);

			// 현재 월 표기
			$('.year-month').text(currentYear + '.' + (currentMonth + 1));
			year = currentYear;
			month = currentMonth+1;

			// 렌더링 html 요소 생성
			calendar = document.querySelector('.dates')
			calendar.innerHTML = '';

			// 지난달
			for (var i = prevDate - prevDay + 1; i <= prevDate; i++) {
				calendar.innerHTML = calendar.innerHTML
						+ '<div class="day prev disable">' + i + '</div>'
			}
			// 이번달
			for (var i = 1; i <= nextDate; i++) {
				calendar.innerHTML = calendar.innerHTML
						+ '<div class="day current"><a class = "moon" href="javascript:void(0);" onClick = "getDate(this)">'
						+ i + '</a></div>'
			}
			// 다음달
			for (var i = 1; i <= (7 - nextDay == 7 ? 0 : 7 - nextDay); i++) {
				calendar.innerHTML = calendar.innerHTML
						+ '<div class="day next disable">' + i + '</div>'
			}

			// 오늘 날짜 표기
			if (today.getMonth() == currentMonth) {
				todayDate = today.getDate();
				
				if(todayDate != thisMonth.getDate()){
					todayDate = thisMonth.getDate();
				}
				
				var currentMonthDate = document
						.querySelectorAll('.dates .current');
				currentMonthDate[todayDate - 1].classList.add('today');
			}
			else{
					var currentMonthDate = document
					.querySelectorAll('.dates .current');
			currentMonthDate[thisMonth.getDate() - 1].classList.add('today');
			}
		}

		// 이전달로 이동
		$('.go-prev').on('click', function() {
/* 			 thisMonth = new Date(currentYear, currentMonth - 1, 1);
			renderCalender(thisMonth); */
			
			location.href = "calendar.event?year=" + currentYear + "&month=" + currentMonth + "&day=" + 1;
		});

		// 다음달로 이동
		$('.go-next').on('click', function() {
/* 			 thisMonth = new Date(currentYear, currentMonth + 1, 1);
			renderCalender(thisMonth);
 */
			location.href = "calendar.event?year=" + currentYear + "&month=" + (currentMonth+2) + "&day=" + 1;
		});
	}
</script>

<!-- 챗봇 -->
<!-- 챗봇 대화 -->
<div id="asideChatbot" class="asideChatbot " style="heigth: 80%">
	<%@include file="WEB-INF/chatbot/chatbot.jsp"%>
</div>
<!-- 챗봇 대화 아이콘 -->
<div id="chatbotIcon" style="heigth: 20%">
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
								<div class="col-lg-12">
									<div class="border-first-button scroll-to-section">
										<a href="#cal">Check Calendar</a>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="col-lg-6" style="margin-top: 40px">
						<div class="left-content show-up header-text wow fadeInLeft"
							data-wow-duration="1s" data-wow-delay="0.5s">
							<div class="blog-post">
								<div class="thumb">
									<a href="detail.event?eventNo=${eventLists.get(0).event_no}"><span id="r_img"><img src="${eventLists.get(0).img }" alt="img"></span></a>
								</div>
								<div class="down-content">
									<span class="category" id="r_ptype">${eventLists.get(0).performance_type }</span> <span class="date"
										id="r_period">${eventLists.get(0).event_period }</span>
									<h4 id="eventTitle">${eventLists.get(0).title }</h4>
									<p id="r_place">${eventLists.get(0).place }</p>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- 캘린더 -->
<div id="cal" style="margin-top: 50px; z-index: 0">
	<div class="container">
		<div class="row">
			<div class="col-lg-12">
				<div class="row">
					<div class="col-lg-6 align-self-center  wow fadeInRight"
						data-wow-duration="1s" data-wow-delay="0.5s">
						<div class="about-right-content">
							<div class="section-heading">
								<h6>CHECK CALENDAR</h6>
								<h4>
									<em>행사 </em> 일정
								</h4>
								<div class="line-dec"></div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div id="blog" class="blog" style="padding-top: 40px; z-index: 0">
		<div class="container">
			<div class="row">
				<div class="col-lg-6 show-up wow fadeInUp" data-wow-duration="1s"
					data-wow-delay="0.3s">
					<div class="blog-post">
						<div class="down-content">
							<div class="sec_cal">
								<div class="cal_nav">
									<a href="javascript:;" class="nav-btn go-prev">prev</a>
									<div class="year-month"></div>
									<a href="javascript:;" class="nav-btn go-next">next</a>
								</div>
								<div class="cal_wrap">
									<div class="days">
										<div class="day">MON</div>
										<div class="day">TUE</div>
										<div class="day">WED</div>
										<div class="day">THU</div>
										<div class="day">FRI</div>
										<div class="day">SAT</div>
										<div class="day">SUN</div>
									</div>
									<div class="dates"></div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="col-lg-6 wow fadeInUp" data-wow-duration="1s"
					data-wow-delay="0.3s"  id = "calendar">
				<div class="blog-posts">
						<div class="row">
						<c:set var="eventListsSize" value="${fn:length(eventLists)}" />
							<c:if test="${eventListsSize > 1}">
								<c:forEach var="i" begin="1" end="${eventListsSize-1 }">
									<div class="col-lg-12">
										<div class="post-item">
											<div class="thumb">
												<a href="detail.event?eventNo=${eventLists.get(i).event_no}"><img src="${eventLists.get(i).img }" alt="img"></a>
											</div>
											<div class="right-content">
												<span class="category">${eventLists.get(i).performance_type }</span>
												<span class="date">${eventLists.get(i).event_period }</span>
												<h4>${eventLists.get(i).title }</h4>
												<p>${eventLists.get(i).place }</p>
											</div>
										</div>
									</div>
								</c:forEach>
							</c:if>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<%@include file="WEB-INF/userCommon/userFooter.jsp"%><!--  user footer 부분 -->