<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../userCommon/userHeader.jsp"%>
<!--  user header 부분 -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<title>Event Detail</title>
<style type="text/css">
    .event-detail-container {
        display: flex;
        justify-content: center;
        flex-direction: column;
        margin: 100px auto;
        max-width: 1200px;
        width: 100%;
        padding-top: 20px; /* 메뉴바에 가리지 않도록 패딩 추가 */
    }

    .event-detail-container img {
        width: 50%; 
        height: 400px;
        margin-right: 20px;
    }

    .event-info {
        flex: 1;
        display: flex;
        align-items: center;
        background-color: #ffffff;
        border-radius: 10px;
        height: 400px; /* 이미지와 동일한 높이로 설정 */
    }

    .event-info table {
        width: 100%;
        height: 100%;
        border-collapse: separate;
        border-spacing: 0;
    }

    .event-info th{
		background-color: #f2f2f2;
        width: 120px;
        padding: 15px;
        text-align: center;
        border: 1px solid #dddddd;
    }
    
    .event-info td {
        padding: 15px;
        text-align: left;
        border: 1px solid #dddddd;
    }

    .event-title {
        width: 100%;
        text-align: center;
        margin-bottom: 20px;
    }
    
    #btnList{
    	text-align: center;
    }
    
</style>
  
	<!-- 챗봇 -->
<div id="asideChatbot" class="asideChatbot " style="heigth: 80%">
	<%@include file="../chatbot/chatbot.jsp"%>
</div>

<div id="chatbotIcon" style="heigth: 20%">
	<%@include file="../chatbot/chatbotIcon.jsp"%>
</div>


<section class="event-detail-container">
    <div class="event-title">
        <h2>상세정보</h2>
    </div>
    <div style="display: flex; width: 100%;">
        <%-- <img src="${event.img}" alt="${event.title}"> --%>
		<c:choose>
		    <c:when test="${not empty event.fimg}">
		        <!-- 업로드된 이미지가 있으면 해당 이미지를 사용 -->
		        <img src="${pageContext.request.contextPath}/resources/uploadImage/${event.fimg}"
		            width="100" height="100" alt="${event.title}" />
		    </c:when>
		    <c:otherwise>
		        <!-- 업로드된 이미지가 없으면 API 이미지를 사용 -->
		        <img src="${event.img}" width="100" height="100" alt="${event.title}" />
		    </c:otherwise>
		</c:choose>
        <div class="event-info">
            <table>
                <tr>
                    <th>분류</th>
                    <td>${event.performance_type}</td>
                </tr>
                <tr>
                    <th>행사/공연</th>
                    <td>${event.title}</td>
                </tr>
                <tr>
                    <th>기간</th>
                    <td>${event.event_period}</td>
                </tr>
                <tr>
                    <th>장소</th>
                    <td>${event.place}</td>
                </tr>
                <tr>
                	<td id="btnList"colspan="2">
               			
	  					<input type="button" class="btn btn-secondary" value="목록보기" onClick="location.href='list.event?eventNo=${event.event_no }&whatColumn=${param.whatColumn}&keyword=${param.keyword}&pageNumber=${pageNumber}'">
	  					<input type="button" class="btn btn-secondary" value="길찾기" onClick="location.href='search.bookmark?lat=${event.lat}&lot=${event.lot }&place=${event.place }'">
                	</td>
                </tr>
            </table>
        </div>
    </div>
</section>

<%@include file="../userCommon/userFooter.jsp"%>
