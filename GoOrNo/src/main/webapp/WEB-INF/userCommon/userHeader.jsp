<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html lang="en">
 
<head>

<style type="text/css">

header{
   font-family : 'Poppins', sans-serif;   
}

body {
    padding-top: 180px; /* pre-header와 header-area 높이 합과 일치하도록 설정 */
}

.pre-header {
    position: fixed;
    top: 0;
    width: 100%;
    z-index: 1001;
}

.header-area {
    position: fixed;
    top: 60px; /* pre-header 높이만큼 내림 */
    z-index: 1000;
}


.err {
	color: red;
	size: 1em;
}

/* woo 추가 */
.notifications {
    width: 350px;
}

.notification-item a {
    display: block;
    color: #333;
    padding: 5px 5px;
    text-align: center;
    width: fit-content;
}

.notification-item a:hover {
    background-color: #f5f5f5;
}
</style>

<!-- moonyeseo 추가 -->
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$('#asideChatbot').hide();

		/* 챗봇 페이지 이동 */
		$("#chatbot").click(function() {
			$("#asideChatbot").toggle();
			$("#inputText").focus();
		});
		
		$("#close").click(function(){
			$('#asideChatbot').hide();
		});
		
		// 날짜 정보 가져오기
		date = new Date(); // 현재 날짜(로컬 기준) 가져오기
		utc = date.getTime() + (date.getTimezoneOffset() * 60 * 1000); // uct 표준시 도출
		kstGap = 9 * 60 * 60 * 1000; // 한국 kst 기준시간 더하기
		today = new Date(utc + kstGap); // 한국 시간으로 date 객체 만들기(오늘)
		todayDate = today.getDate();
			
			$("#calendarIcon").click(function(){
				var popupW = 900;
		    	var popupH = 700;
		    	var left = (document.body.offsetWidth - popupW) / 2;
		    	var top = (window.screen.height - popupH) / 2;
		    	
		    	popup = window.open("calendar.event?year="+today.getFullYear()+ "&month=" + (today.getMonth()+1) + "&day=" + today.getDate(), "calendar", "width=" + popupW + ",height =" + popupH +", left=" + left + ",top=" + top + ",scrollbars=yes,resizable=no,toolbar=no,titlebar=no,menubar=no,location=no");
			});

	/* 알림 & 채팅 */
	if ("${sessionScope.loginInfo}" != "") {
        fetchUnreadAlarms();
        fetchChatCount();
        //setInterval(fetchUnreadAlarms, 5000);
        //setInterval(fetchChatCount, 5000);
    }
	
});


	function goEvent(eventNo){
		alert("goEvent");
		
		location.href = "detail.event?eventNo=" + eventNo;
	}

	function fetchUnreadAlarms() {
        console.log("Fetching unread alarms...");
        $.ajax({
            url: "${pageContext.request.contextPath}/notifications/alarms/unread",
            method: "GET",
            success: function(data) {
                console.log("AJAX 응답 데이터:", data);
                let unreadCount = data.length;
                console.log("Unread Count:", unreadCount);
                $('#unread-count').text(unreadCount);
                $('#unread-count-header').text(unreadCount);

                let notificationList = $('#notification-list');
                notificationList.find('.notification-item').remove();

                if (data && data.length > 0) {
                    data.forEach(function(alarmBean) {
                        console.log("AlarmBean:", alarmBean);
                        console.log("alarm_no:", alarmBean.alarm_no);
                        console.log("user_id:", alarmBean.user_id);
                        console.log("message:", alarmBean.message);

                        let notificationItem = '<li class="notification-item">'
                            + '<a href="#" class="alarm-link" data-alarm_no="' + alarmBean.alarm_no + '" data-alarm_type="' + alarmBean.alarm_type + '" data-type_id="' + alarmBean.type_id + '">'
                            + alarmBean.user_id + ' 님이  ' + alarmBean.message
                            + '</a></li>'
                            + '<li><hr class="dropdown-divider"></li>';
                        console.log("Generated notification item:", notificationItem); // 추가된 HTML 출력 확인
                        notificationList.append(notificationItem);

                    });

                 	// 알림 클릭 시 읽음 상태로 변경하고 해당 글의 디테일 페이지로 이동
                    $('.alarm-link').click(function() {
                        let alarm_no = $(this).data('alarm_no');
                        let alarm_type = $(this).data('alarm_type');
                        let type_id = $(this).data('type_id');
                        console.log("alarm_no clicked:", alarm_no);
                        checkRead(alarm_no, alarm_type, type_id);
                    });
                }
            },
            error: function(xhr, status, error) {
                console.error("AJAX Error: ", status, error);
            }
        });
    }

	function checkRead(alarm_no, alarm_type, type_id, user_id) {
	    console.log("Marking alarm as read: " + alarm_no);
	    $.ajax({
	        url: "${pageContext.request.contextPath}/notifications/alarms/read",
	        method: "POST",
	        data: { alarm_no: alarm_no },
	        success: function() {
	            console.log("Alarm marked as read: " + alarm_no);
	            // 해당 글의 디테일 페이지로 이동
	            let detailUrl = "";
	            if (alarm_type === "board") {
	                detailUrl = "${pageContext.request.contextPath}/detail.board?board_no=" + type_id;
	            } else if (alarm_type === "qna") {
	                detailUrl = "${pageContext.request.contextPath}/detail.qna?qna_no=" + type_id;
	            }
	            window.location.href = detailUrl;
	        },
	        error: function(xhr, status, error) {
	            console.error("AJAX Error: ", status, error);
	        }
	    });
	}

	
	function fetchChatCount() {
		console.log("Fetching chat...");
        $.ajax({
            url: "${pageContext.request.contextPath}/chatCount.chat",
            method: "POST",
            dataType: "json",
            success: function(data) {
            	console.log("AJAX 응답 데이터:", data);
            	let chatCount = data.length;
            	$('#chat-count').text(data);
            	$('#chat-count-header').text(data);
            },
            error : function(request,status,error){
                //alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
             }
        });
    }
	
</script>

<!-- 공통 영역 -->
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@100;200;300;400;500;600;700;800;900&display=swap"
	rel="stylesheet">

<title>GoOrNo</title>

<!-- Bootstrap core CSS -->
<link
	href="<%=request.getContextPath()%>/resources/vendor/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">

<!-- Additional CSS Files -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/assets/css/fontawesome.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/assets/css/templatemo-digimedia-v1.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/assets/css/animated.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/assets/css/owl.css">

<!--

TemplateMo 568 DigiMedia

https://templatemo.com/tm-568-digimedia

-->

<!-- 한글 글씨체(추가) -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap"
	rel="stylesheet">

</head>

<body>
	<!-- ***** Preloader Start ***** -->
	<div id="js-preloader" class="js-preloader">
		<div class="preloader-inner">
			<span class="dot"></span>
			<div class="dots">
				<span></span> <span></span> <span></span>
			</div>
		</div>
	</div>
	<!-- ***** Preloader End ***** -->
	
	<!-- Pre-header Starts -->
	<div class="pre-header">
		<div class="container">
			<div class="row">
				<div class="col-lg-4 col-sm-4 col-5">
					<ul class="info">
						<c:if test="${ loginInfo eq null }">
							<li><a href="login.users">Login</a></li>
							<li><a href="join.users">Join</a></li>
						</c:if>
						<c:if test="${ loginInfo ne null }">
							<li><a href="#">${sessionScope.loginInfo.id }님</a></li>
							<li><a href="Logout.jsp">Logout</a></li>
						
							<!-- 알림아이콘 -->
							<li>
								<a class="nav-link nav-icon" href="#" data-bs-toggle="dropdown">
									<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-bell-fill" viewBox="0 0 16 16">
										<path d="M8 16a2 2 0 0 0 2-2H6a2 2 0 0 0 2 2m.995-14.901a1 1 0 1 0-1.99 0A5 5 0 0 0 3 6c0 1.098-.5 6-2 7h14c-1.5-1-2-5.902-2-7 0-2.42-1.72-4.44-4.005-4.901"/>
									</svg>
									<span class="badge bg-primary badge-number" id="unread-count"></span>
								</a>
    
								<ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow notifications" id="notification-list">
									<li class="dropdown-header">
									읽지 않은 알림이 <span id="unread-count-header">0</span>개 있습니다.
									</li>
									<li><hr class="dropdown-divider"></li>
								</ul>
							</li>
							<!-- 
							<li>
								<a class="nav-link nav-icon" href="#" data-bs-toggle="dropdown">
									<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chat-dots-fill" viewBox="0 0 16 16">
										<path d="M16 8c0 3.866-3.582 7-8 7a9 9 0 0 1-2.347-.306c-.584.296-1.925.864-4.181 1.234-.2.032-.352-.176-.273-.362.354-.836.674-1.95.77-2.966C.744 11.37 0 9.76 0 8c0-3.866 3.582-7 8-7s8 3.134 8 7M5 8a1 1 0 1 0-2 0 1 1 0 0 0 2 0m4 0a1 1 0 1 0-2 0 1 1 0 0 0 2 0m3 1a1 1 0 1 0 0-2 1 1 0 0 0 0 2"/>
									</svg>
									<span class="badge bg-primary badge-number" id="chat-count"></span>
								</a>
							
								<ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow chat" id="chat-list">
									<li class="dropdown-header">
										현재 참여 중인 채팅이 <span id="chat-count-header">0</span>개 있습니다.
									</li>
									<li><hr class="dropdown-divider"></li>
								</ul>
					        </li>
							 -->
						</c:if>
					</ul>
				</div>
			</div>
		</div>
	</div>
	<!-- Pre-header End -->

	<!-- ***** Header Area Start ***** -->
	<header class="header-area header-sticky wow slideInDown"
		data-wow-duration="0.75s" data-wow-delay="0s">
		<div class="container">
			<div class="row">
				<div class="col-12">
					<nav class="main-nav">
						<!-- ***** Logo Start ***** -->

						<a href="<%=request.getContextPath()%>/main.jsp" class="logo"> <img
							src="<%=request.getContextPath()%>/resources/image/GoOrNo_logo.png"
							alt="logo" width="80px" height="60px">
						</a>
						<!-- ***** Logo End ***** -->
						<!-- ***** Menu Start ***** -->
						<ul class="nav">
							<li class="scroll-to-section"><a
								href="<%=request.getContextPath()%>/main.jsp" class="active">Home</a></li>
							<li class="scroll-to-section"><a href="search.bookmark">Navigation</a></li>
							<li class="scroll-to-section"><a href="list.event">Event</a></li>
							<li class="scroll-to-section"><a class="dropdown-toggle"
								href="list.board" role="button" data-bs-toggle="dropdown"
								aria-expanded="false"> Community </a>
								<ul class="dropdown-menu">
									<li><a class="dropdown-item" href="list.board">자유게시판</a></li>
									<li><a class="dropdown-item" href="list.chat">채팅</a></li>
									<li></li>
								</ul></li>
							<li class="scroll-to-section"><a class="dropdown-toggle"
								href="list.notice" role="button" data-bs-toggle="dropdown"
								aria-expanded="false"> Notice </a>
								<ul class="dropdown-menu">
									<li><a class="dropdown-item" href="list.notice">공지사항</a></li>
									<li><a class="dropdown-item" href="list.qna">Q&A</a></li>
									<li><a class="dropdown-item" href="list.faq">FAQ</a></li>
									<li></li>
								</ul></li>
								
							<li class="scroll-to-section">
								<div id="google_translate_element"></div>
							</li>
								
							<li class="scroll-to-section"><div
									class="border-first-button">
									<c:if test="${ loginInfo eq null }">
										<a href="login.users">My Page</a>
									</c:if>
									<c:if test="${ loginInfo ne null }">
										<c:choose>
											<c:when test="${loginInfo.id eq 'admin'}">
												<a href="<%=request.getContextPath()%>/mainAdmin.jsp">My Page</a>
											</c:when>
											<c:otherwise>
												<a href="myPage.users?user_no=${sessionScope.loginInfo.user_no}">My Page</a>
											</c:otherwise>
										</c:choose>
									</c:if>

								</div></li>
						</ul>
						<a class='menu-trigger'> <span>Menu</span>
						</a>
						<!-- ***** Menu End ***** --> 
					</nav>
				</div>
			</div>
		</div>
	</header>
	<!-- ***** Header Area End ***** -->