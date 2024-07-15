<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../adminCommon/adminHeader.jsp"%>
<!--  admin header 부분 -->
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
    
</style>
<input type="hidden" name="event_no" value="${eventNo }"> 
<input type="hidden" name="whatColumn" value="${whatColumn}"> 
<input type="hidden" name="keyword" value="${keyword}"> 
<input type="hidden" name="pageNumber" value="${pageNumber}"> 


<section class="event-detail-container">
    <div class="event-title">
        <h2>상세정보</h2>
    </div>
    <div style="display: flex; width: 100%;">
        <img src="${event.img}" alt="${event.title}">
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
                	<td colspan="2">
	  					<input type="button" class="btn btn-outline-primary btn-sm" value="목록보기" onClick="location.href='AdminList.event?eventNo=${event.event_no }&whatColumn=${param.whatColumn}&keyword=${param.keyword}&pageNumber=${param.pageNumber}'">
	  					<input type="button" class="btn btn-outline-primary btn-sm" value="수정하기" onClick="location.href='update.event?eventNo=${event.event_no }&whatColumn=${param.whatColumn}&keyword=${param.keyword}&pageNumber=${param.pageNumber}'">
                	</td>
                </tr>
            </table>
        </div>
    </div>
</section>

<%@include file="../adminCommon/adminFooter.jsp"%>
