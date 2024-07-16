<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../adminCommon/adminHeader.jsp" %>
<style>

.paging-info {
        margin-left: 550px;
    }
    
tbody img{
	width: 100px;
	height: 100px;
}
</style>
<input type="hidden" name="event_no" value="${eventNo }"> 
<input type="hidden" name="whatColumn" value="${whatColumn}"> 
<input type="hidden" name="keyword" value="${keyword}"> 
<input type="hidden" name="pageNumber" value="${pageNumber}"> 
<main id="main" class="main">
<div class="container mt-10">
    <div class="pagetitle">
        <h1>Event</h1>
	현재 ${pageInfo.pageNumber }
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="mainAdmin.jsp">Event</a></li>
                <li class="breadcrumb-item active">List</li>
            </ol>
        </nav>
    </div>

    <div class="card mt-4">
        <div class="card-body">
            <h5 class="card-title">Tables without borders</h5>
            <!-- Active Table -->
            <form action="AdminList.event">
            <select name="whatColumn">
            	<option value="all">전체
            	<option value="performance_type">유형
            	<option value="title">제목
            	<option value="place">장소
            </select>
            <input type="text" name="keyword">
            <input type="submit" value="검색">
            </form>

            <input type="button" class="btn btn-outline-primary btn-sm" value="등록" onClick="location.href='insert.event?eventNo=${event.event_no }&whatColumn=${param.whatColumn}&keyword=${param.keyword}&pageNumber=${pageNumber}'">
            
            <table class="table table-borderless table-striped">
                <thead class="thead-dark">
                    <tr>
                        <th scope="col">번호</th>
                        <th scope="col">유형</th>
                        <th scope="col">행사</th>
                        <th scope="col">장소</th>
                        <th scope="col">기간</th>
                        <th scope="col">사진</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="event" items="${lists }">
                    <tr>
                        <td>${event.event_no }</td>
                        <td>${event.performance_type}</td>
                        <td>
                        	<a href="AdminDetail.event?eventNo=${event.event_no}&whatColumn=${whatColumn}&keyword=${keyword }&pageNumber=${pageNumber}">${event.title}></a>
                        </td>
                        <td>${event.place}</td>
                        <td>${event.event_period}</td>
                        
                        	
                        <td>
                        	<img src = "<%=request.getContextPath() + "/resources/uploadImage/" %>${event.img}" width = "100" height = "100"/> <br><br>
                        	<img src="${event.img}" alt="${event.title}">
                        </td>
                    </tr>
                    </c:forEach>
                </tbody>
            </table>
            <!-- End Tables without borders -->
        <div class="paging-info">${pageInfo.pagingHtml}</div>
        </div>
    </div>
  
     
</div>
</main>
<%@ include file="../adminCommon/adminFooter.jsp" %>



