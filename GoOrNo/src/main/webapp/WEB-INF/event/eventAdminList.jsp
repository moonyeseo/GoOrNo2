<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../adminCommon/adminHeader.jsp" %> <!--  admin header 부분 -->

<style>
    .table th, .table td {
        text-align: center;
        vertical-align: middle;
        padding: 10px;
    }
    .form-select{
    	align: right;
    }
    
</style>

<main id="main" class="main">
    <div class="pagetitle">
        <h1>Event</h1>
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="mainAdmin.jsp">Event</a></li>
                <li class="breadcrumb-item active">List</li>
            </ol>
        </nav>
    </div><!-- End Page Title -->
    
    <section class="section dashqna">
        <div class="row" style="display : flex;">
            <div class="col-lg-12">
                <div class="card h-100">
                    <div class="card-body">
                        <!-- Active Table -->
                        <table class="table table-borderless" style="margin-top :10px;">
                            <thead>
                                <!-- 행사 검색 -->
                                <tr>
                                    <td colspan="6" align="right">
                                        <form action="AdminList.event">
                                            <select name="whatColumn" class="form-select" style="width : 15%; display:inline;">
                                                <option value="all">전체</option>
                                                <option value="performance_type">유형</option>
                                                <option value="title">제목</option>
                                                <option value="place">장소</option>
                                            </select>
                                            <input type="text" name="keyword" class="form-control" style="width : 15%; display:inline;">
                                            <input type="submit" value="검색" class="btn btn-secondary">
                                            <input type="button" value="등록" class="btn btn-secondary" onClick="location.href='insert.event?eventNo=${event.event_no }'">
                                        </form>
                                    </td>
                                </tr>
                                <!-- 컬럼 제목 -->
                                <tr>
                                    <th scope="col" width="10%">번호</th>
                                    <th scope="col" width="10%">유형</th>
                                    <th scope="col" width="30%">행사</th>
                                    <th scope="col" width="10%">장소</th>
                                    <th scope="col" width="20%">기간</th>
                                    <th scope="col" width="10%">사진</th>
                                </tr>
                            </thead>
                            <!-- 글 목록 -->
                            <tbody>
                                <c:forEach var="event" items="${lists}">
                                    <tr>
                                        <td>${event.event_no}</td>
                                        <td>${event.performance_type}</td>
                                        <td>
                                            <a href="AdminDetail.event?eventNo=${event.event_no}&whatColumn=${whatColumn}&keyword=${keyword}&pageNumber=${pageNumber}">
                                                ${event.title}
                                            </a>
                                        </td>
                                        <td>${event.place}</td>
                                        <td>${event.event_period}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty event.fimg}">
                                                    <!-- 업로드된 이미지가 있으면 해당 이미지를 사용 -->
                                                    <img src="${pageContext.request.contextPath}/resources/uploadImage/${event.fimg}" width="100" height="100" alt="${event.title}" />
                                                </c:when>
                                                <c:otherwise>
                                                    <!-- 업로드된 이미지가 없으면 API 이미지를 사용 -->
                                                    <img src="${event.img}" width="100" height="100" alt="${event.title}" />
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <!-- 페이지 넘기기 -->
                                <tr>
                                    <td colspan="6" align="center">${ pageInfo.pagingHtml }</td>
                                </tr>
                            </tbody>
                        </table>
                        <!-- 테이블 끝 -->
                        <!-- End Tables without borders -->
                    </div>
                </div>
            </div>
        </div>
    </section>
</main>

<%@ include file="../adminCommon/adminFooter.jsp" %>
