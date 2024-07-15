<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@include file="../adminCommon/adminHeader.jsp"%>

<main id="main" class="main">

	<div class="pagetitle">
		<h1>Report</h1>
		<nav>
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="#">Report</a></li>
				<li class="breadcrumb-item active">List</li>
			</ol>
		</nav>
	</div>
	<!-- End Page Title -->

	<section class="section">
		<div class="row">
			<div class="col-lg-12" style="margin: auto">
				<div class="card">
					<div class="card-body">
						<h5 class="card-title">Report List</h5>
						<!-- Active Table -->

						<table class="table table-borderless">
							<thead>
								<tr>
									<td colspan="5" align="right">
										<form action="list.report" method="post">
											<select name="whatColumn" class="form-select"  style="width : 15%; display:inline;">
												<option value="all">전체</option>
												<option value="subject">글 제목</option>
												<option value="why">신고 사유</option>
											</select> <input type="text" name="keyword" class="form-control"  style="width : 15%; display:inline;">
											<button type="submit" class="btn btn-secondary ">검색</button>
										</form>
									</td>
								</tr>
								<tr>
									<th scope="col">번호</th>
									<th scope="col">글 제목</th>
									<th scope="col">신고 사유</th>
									<th scope="col">읽음</th>
									<th scope="col">신고 날짜</th>
								</tr>
							</thead>
							<tbody>
								<c:if test="${ fn:length(reportLists) eq 0 }">
									<tr>
										<td colspan="5" align="center">글이 존재하지 않습니다.</td>
									</tr>
								</c:if>
								<!-- 게시판 글 1개 이상 -->
								<c:if test="${ fn:length(reportLists) > 0 }">
									<c:forEach var="report" items="${reportLists }"
										varStatus="status">
										<tr>
											<th scope="row">${((pageInfo.pageNumber-1) * pageInfo.pageSize) + status.count}</th>
											<td><a
												href="detail.report?board_no=${report.board_no }&re_no=${report.re_no}&user_no=${report.user_no}&pageNumber=${pageInfo.pageNumber}&whatColumn=${pageInfo.whatColumn}&keyword=${pageInfo.keyword}"><font color="black">${report.subject}</font></a></td>
											<td>${report.why}</td>
											<td><c:if test="${report.re_check eq 1 }">
												✔
											</c:if></td>
											<td><fmt:parseDate value="${report.reportdate }"
													pattern="yyyy-MM-dd HH:mm" var="date" /> <fmt:formatDate
													value="${date }" pattern="yyyy/MM/dd " /></td>
										</tr>
									</c:forEach>
								</c:if>
							</tbody>
						</table>
						<center>${pageInfo.pagingHtml }</center>
					</div>
				</div>
			</div>

		</div>
	</section>

</main>
<!-- End #main -->

<%@include file="../adminCommon/adminFooter.jsp"%>