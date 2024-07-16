<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@include file="../adminCommon/adminHeader.jsp"%>

<!-- 자바 스크립트 -->
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/vendor/jquery/jquery.js"></script>
<script type="text/javascript">
//게시글 제목 클릭시 내용 보기
function viewContent(board_no, re_no, user_no, index){
/* 	detail.report?board_no=${report.board_no }&re_no=${report.re_no}&user_no=${report.user_no}&pageNumber=${pageInfo.pageNumber}&whatColumn=${pageInfo.whatColumn}&keyword=${pageInfo.keyword}
 */	
	$('#content').html(content);
	$('td a').css("color", "black");
	$('#clicked' + index).css("color", "#8F89E9");
	document.getElementById("detailBtn").disabled = false;
	document.getElementById("deleteBtn").disabled = false;

	getReport(board_no, re_no, user_no);
}

function getReport(board_no, re_no, user_no){
	
	$.ajax({
		type : "post",
		url : "detail.report",
		data : {
			board_no : board_no,
			re_no : re_no,
			user_no : user_no
		},
		dataType : "json",
		success : function(report){
			//alert("성공");

			$("#content").html(report.content);
			$("#id").html(report.id);
			$("#re_no").val(report.re_no);
			
		},
		error : function(request,status,error){
			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	});
}

function deleteReport(){
	if(!confirm('삭제하면 복구할수 없습니다.\n정말로 삭제하시겠습니까?')){
	    return false;
	}
}

function goBoard(){
	var content = $("#content").text();
	
	location.href = 'list.board?isAdmin=yes&whatColumn=content&keyword=' + content;
}
</script>

<main id="main" class="main">

	<div class="pagetitle">
		<h1>Report </h1>
		<nav>
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="#">Report</a></li>
				<li class="breadcrumb-item active">List</li>
			</ol>
		</nav>
	</div>
	<!-- End Page Title -->

	<section class="section dashboard">
		<div class="row" style="display: flex;">
			<div class="col-lg-8">

				<div class="card h-100">
					<div class="card-body">
						<!-- Active Table -->

						<table class="table table-borderless">
							<thead>
								<!-- 게시판 검색 -->
								<tr>
									<td colspan="5" align="right">
										<form action="list.report" method="post">
											<select name="whatColumn" class="form-select"
												style="width: 15%; display: inline;">
												<option value="all">전체 검색</option>
												<option value="subject">글 제목</option>
												<option value="why">신고 사유</option>
											</select> <input type="text" name="keyword" class="form-control"
												style="width: 15%; display: inline;"> <input
												type="submit" value="검색" class="btn btn-secondary">
										</form>
									</td>
								</tr>
								<tr>
									<th scope="col" width="10%" style="text-align: center">번호</th>
									<th scope="col" width="10%" style="text-align: center">글
										제목</th>
									<th scope="col" width="10%" style="text-align: center">신고
										사유</th>
									<!-- <th  scope="col" width="10%" style="text-align: center">읽음</th> -->
									<th scope="col" width="10%" style="text-align: center">신고
										날짜</th>
								</tr>
							</thead>
							<tbody>
								<c:if test="${ fn:length(reportLists) eq 0 }">
									<tr>
										<td colspan="5" align="center">신고 글이 존재하지 않습니다.</td>
									</tr>
								</c:if>
								<!-- 게시판 글 1개 이상 -->
								<c:if test="${ fn:length(reportLists) > 0 }">
									<c:forEach var="report" items="${reportLists }"
										varStatus="status">
										<tr>
											<td align="center">${ pageInfo.totalCount - pageInfo.beginRow - status.index + 1}</td>
											<td align="left"><a  onclick="viewContent('${report.board_no } ','${report.re_no }', '${report.user_no }','${ status.index }')" style="cursor : pointer;" id="clicked${ status.index }">${report.subject}</a></td>
											<td align="left">${report.why}</td>
											<%-- 			<td><c:if test="${report.re_check eq 1 }">
												✔
											</c:if></td> --%>
											<td align="center"><fmt:parseDate
													value="${report.reportdate }" pattern="yyyy-MM-dd HH:mm"
													var="date" /> <fmt:formatDate value="${date }"
													pattern="yyyy/MM/dd " /></td>
										</tr>
									</c:forEach>
								</c:if>
								<!-- 페이지 넘기기 -->
								<tr>
									<td colspan="5" align="center">${ pageInfo.pagingHtml }</td>
								</tr>
							</tbody>
						</table>
						<!-- 테이블 끝 -->
						<!-- End Tables without borders -->
					</div>
				</div>
			</div>

			<div class="col-lg-4">
				<div class="card h-100">
					<div class="card-body">
						<form action="delete.report">
							 <input
								type="hidden" id = "pageNumber" name="pageNumber" value="${ pageInfo.pageNumber }">
							<input type="hidden" id = "whatColumn" name="whatColumn"
								value="${ pageInfo.whatColumn }"> <input type="hidden" id = "keyword"
								name="keyword" value="${ pageInfo.keyword }">
							<table class="table table-borderless" style="margin-top: 10px;">
								<tr>
									<td align="right" >
									
									<input type = "hidden" id = "re_no" name = "re_no">
									
									<input type="button"
										class="btn btn-light" id="detailBtn" value="글 바로가기"
										onClick = "goBoard()" disabled> <input
										type="submit" class="btn btn-secondary" id="deleteBtn"
										value="글삭제" onClick = "return deleteReport()" disabled></td>
								</tr>
								<tr>
									<th>글내용</th>
								</tr>
								<tr>
									<td id="content"></td>
								</tr>
								<tr></tr>
								<tr></tr>
								<tr>
									<th>신고자</th>
								</tr>
								<tr>
									<td id="id"></td>
								</tr>
							</table>
						</form>
					</div>
				</div>
			</div>

		</div>
	</section>

</main>
<!-- End #main -->

<%@include file="../adminCommon/adminFooter.jsp"%>