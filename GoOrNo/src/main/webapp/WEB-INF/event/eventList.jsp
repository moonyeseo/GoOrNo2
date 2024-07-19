<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../userCommon/userHeader.jsp"%>
<!--  user header 부분 -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- 테스트 -->
<title>Event List</title>
<style type="text/css">
    section {
        display: flex;
        flex-direction: column;
        padding: 15px;
        margin-top: 170px;
    }
    
    section h2{
    	display: none;
    }

    .performance-type-container {
        display: flex;
        margin: 0 auto;
    }

    .performance-type-container .nav-item {
        font-size: 15px;
        margin: 0 3px 0 3px;
    }

    .event-container {
        display: flex;
        margin: 0 auto;
        flex-wrap: wrap;
        width: 100%;
        max-width: 1350px;
    }

    .event-container .card {
        display: flex;
        flex-direction: column;
        max-width: 250px;
        min-width: 250px;
        margin: 6px;
        height: auto;
        border: 1px solid #dddddd;
        border-radius: 5px;
        overflow: hidden;
        transition: transform 0.2s;
    }
    

    .event-container .card:hover {
        transform: translateY(-5px);
    }

    .event-container .card img {
        width: 100%;
        height: 250px;
        object-fit: contain; /* 이미지가 잘리지 않도록 설정 */
    }

    .event-container .card-body {
    	font-size: 0.8em;
        padding: 15px;
        display: flex;
        flex-direction: column;
        justify-content: flex-start;
        flex-grow: 1;
    }
    
    .card-body a {
	    color: black;
	}
    
    .event-container .card-text {
        font-size: 15px;
        color: #666;
    }

    .search {
        margin-left: 800px;
    }

    .form {
        display: none;
    }

    .nav-link {
        color: #2a2a2a;
    }

    .nav-link:hover {
        color: #fa65b1;
    }

    .nav-link.active {
        background-color: #fa65b1 !important;
    }

    .paging-info {
        margin: 14px auto;
    }
</style>

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

<div id="contact" class="contact-us section">
	<div class="container">
		<div class="row">
			<!-- 본문 제목 -->
			<div class="col-lg-6 offset-lg-3">
				<div class="section-heading wow fadeIn" data-wow-duration="1s"
					data-wow-delay="0.5s">
					<br>
					<h6>Event</h6>
					<h4>
						<a href="#" style="color: inherit;">전체<em> 행사</em></a>
					</h4>
					<div class="line-dec"></div>
				</div>
			</div>
    <div class="performance-type-container">
        <form action="list.event" method="get" class="form" id="performanceTypeForm">
            <input type="text" name="whatColumn" value="performance_type">
            <input type="text" name="keyword" id="keyword">
            <input type="hidden" name="isAdmin" value="yes">
			<input type="hidden" name="pageNumber" value="${pageNumber }">
            <input type="submit" value="검색">
        </form>
        <ul class="nav nav-pills mb-3" id="pills-tab" role="tablist" style = "margin:auto">
            <li class="nav-item" role="presentation">
                <button class="nav-link <c:if test='${pageInfo.keyword eq "" || pageInfo.keyword eq null}'>active</c:if>"
                    id="전체" type="button">전체</button>
            </li>
            <c:forEach var="item" items="${performanceTypeList}">
                <li class="nav-item" role="presentation">
                    <button class="nav-link <c:if test='${pageInfo.keyword eq item.performance_type}'>active</c:if>"
                        id="${item.performance_type}" type="button">${item.performance_type}</button>
                </li>
            </c:forEach>
        </ul>
    </div>
    <div class="event-container" style = "padding-left : 37px;width :85%">
        <c:forEach var="event" items="${lists}">
            <div class="card">
                <a href="detail.event?eventNo=${event.event_no}&whatColumn=${whatColumn}&keyword=${keyword }&pageNumber=${pageNumber}">
                    <%-- <img src="${event.img}" class="card-img-top event-thumbnail" alt="${event.title}"> --%>
                    <c:choose>
					    <c:when test="${not empty event.fimg}">
					        <!-- 업로드된 이미지가 있으면 해당 이미지를 사용 -->
					        <img src="${pageContext.request.contextPath}/resources/uploadImage/${event.fimg}"
					            class="card-img-top event-thumbnail" alt="${event.title}" />
					    </c:when>
					    <c:otherwise>
					        <!-- 업로드된 이미지가 없으면 API 이미지를 사용 -->
					        <img src="${event.img}" class="card-img-top event-thumbnail" alt="${event.title}" />
					    </c:otherwise>
					</c:choose>
                </a>
                <div class="card-body">
                    <a href="detail.event?eventNo=${event.event_no}&whatColumn=${whatColumn}&keyword=${keyword }&pageNumber=${pageNumber}">
                        ${event.title}
                    </a>
                    <p class="card-text">${event.performance_type}</p>
                </div>
            </div>
        </c:forEach>
    </div>
    <center>
    	<div class="paging-info">${pageInfo.pagingHtml}</div>
    </center>
</div>
</div>
</div>

<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
    $('.nav-link').click(function () {
        const id = $(this).attr('id');
        if (id !== '전체') {
            $('#performanceTypeForm > #keyword').val(id);
        }
        $('#performanceTypeForm').submit();
    });
</script>

<%@include file="../userCommon/userFooter.jsp"%>
