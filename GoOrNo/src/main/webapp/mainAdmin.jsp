<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="WEB-INF/adminCommon/adminHeader.jsp"%>
<!--  admin header 부분 -->

<!-- <style>
    .table th, .table td {
        text-align: center;
        vertical-align: middle;
        padding: 10px;
    }
    .form-select{
    	align: right;
    }
    
</style> -->

<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	
	var  eventListFlag = <%=request.getAttribute("eventListFlag")%>;
	if(!eventListFlag){
		
		location.href = "AdminList.event";
	}
});

//팝업창 크기
var _width = 500;
var _height = 600;

//게시글 수정
function insertEvent(){
	// 팝업창을 중앙에 생성하기
	var _top = Math.ceil(( window.screen.height - _height )/2);
	var _left = Math.ceil(( window.screen.width - _width )/2);
	var url = 'insert.event';
	var name = 'event insert';
	var options = 'width = ' + _width + ', height = ' + _height + ', location = no, top = '+ _top + ', left = ' + _left;
	var windowPopup = window.open(url, name, options);
}

function update(eventNo, whatColumn, keyword, pageNumber) {
	location.href = "AdminDetail.event?eventNo=" + eventNo + "&whatColumn="
			+ whatColumn + "&keyword=" + keyword + "&pageNumber="
			+ pageNumber;
}
</script>

<main id="main" class="main">
	<div class="pagetitle">
		<h1>Event</h1>
		<nav>
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="mainAdmin.jsp">Event</a></li>
				<li class="breadcrumb-item active">List</li>
			</ol>
		</nav>
	</div>
	<!-- End Page Title -->

	<section class="section dashqna">
		<div class="row" style="display: flex;">
			<div class="col-lg-12">
				<div class="card h-100">
					<div class="card-body">
						<!-- Active Table -->
						<table class="table table-borderless" style="margin-top: 10px;">
							<thead>
								<!-- 행사 검색 -->
								<tr>
									<td colspan="6" align="right">
										<form action="AdminList.event">
											<!-- 글작성 및 바로가기 버튼 -->
											<button class="btn btn-secondary" style="float: left;"
												onClick="insertEvent()">등록</button>

											<select name="whatColumn" class="form-select"
												style="width: 15%; display: inline;">
												<option value="all">전체 검색</option>
												<option value="performance_type">카테고리</option>
												<option value="title">제목</option>
												<option value="place">장소</option>
											</select> <input type="text" name="keyword" class="form-control"
												style="width: 15%; display: inline;"> <input
												type="submit" value="검색" class="btn btn-secondary">
										</form>
									</td>
								</tr>
								<!-- 컬럼 제목 -->
								<tr>
									<th scope="col" width="10%">번호</th>
									<th scope="col" width="10%">카테고리</th>
									<th scope="col" width="30%">행사</th>
									<th scope="col" width="10%">장소</th>
									<th scope="col" width="20%">기간</th>
									<th scope="col" width="20%">상세보기</th>
								</tr>
							</thead>
							<!-- 글 목록 -->
							<tbody>
								<c:forEach var="event" items="${lists}">
									<tr>
										<td>${event.event_no}</td>
										<td>${event.performance_type}</td>
										<td>${event.title} </td>
										<td>${event.place}</td>
										<td>${event.event_period}</td>
										<%--                                         <td>
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
                                        </td> --%>
									<td>
										<button type="button" class="btn btn-secondary"
											onclick="update('${event.event_no }','${param.whatColumn}', '${param.keyword}', '${pageInfo.pageNumber}')">확
											인</button>
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

<%@ include file="WEB-INF/adminCommon/adminFooter.jsp"%>
