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


<main id="main" class="main">
<div class="container mt-10">
    <div class="pagetitle">
        <h1>Event</h1>
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
                        	<a href="">${event.title}</a>
                        </td>
                        <td>${event.place}</td>
                        <td>${event.event_period}</td>
                        <td><img src="${event.img}" alt="${event.title}"></td>
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



