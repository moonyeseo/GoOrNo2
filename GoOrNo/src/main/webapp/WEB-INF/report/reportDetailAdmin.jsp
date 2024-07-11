<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@include file="../adminCommon/adminHeader.jsp"%>
<main id="main" class="main">

	<div class="pagetitle">
		<h1>Report Detail</h1>
		<nav>
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="list.report">Report</a></li>
				<li class="breadcrumb-item">Detail</li>
			</ol>
		</nav>
	</div>
	<!-- End Page Title -->

	<section class="section profile">
		<div class="row">
			
			<div class="col-xl-6">
				<div class="card">
					<div class="card-body pt-3">
						<!-- Bordered Tabs -->
						<ul class="nav nav-tabs nav-tabs-bordered">
							<li class="nav-item">
								<button class="nav-link active" data-bs-toggle="tab"
									data-bs-target="#profile-overview">Board</button>
							</li>
						</ul>
						<div class="tab-content pt-2">

							<div class="tab-pane fade show active profile-overview"
								id="profile-overview">
								<h5 class="card-title"><b>신고된 글 내용</b></h5>

								<div class="row">
									<div class="col-lg-3 col-md-4 label ">글 제목</div>
									<div class="col-lg-9 col-md-8">${report.subject }</div>
								</div>

								<div class="row">
									<div class="col-lg-3 col-md-4 label ">내용</div>
									<div class="col-lg-9 col-md-8">${report.content }</div>
								</div>

								<div class="row" style="margin-top: 50px; font-weight: bold;">
									<div class="col-lg-3 col-md-4 label">
										<button type="submit" class="btn btn-secondary " onClick = "location.href='list.board?isAdmin=yes&whatColumn=all&keyword=${report.content}'">글 관리</button>
									</div>
									<div class="col-lg-9 col-md-8">
									</div>
								</div>

							</div>
						</div>
					</div>
				</div>
			</div>
			
			<div class="col-xl-6">
				<div class="card">
					<div class="card-body pt-3">
						<!-- Bordered Tabs -->
						<ul class="nav nav-tabs nav-tabs-bordered">
							<li class="nav-item">
								<button class="nav-link active" data-bs-toggle="tab"
									data-bs-target="#profile-overview">Report</button>
							</li>
						</ul>
						<div class="tab-content pt-2">

							<div class="tab-pane fade show active profile-overview"
								id="profile-overview">
								<h5 class="card-title"><b>신고 정보</b></h5>

								<div class="row">
									<div class="col-lg-3 col-md-4 label ">신고자</div>
									<div class="col-lg-9 col-md-8">${report.id }</div>
								</div>

								<div class="row">
									<div class="col-lg-3 col-md-4 label">신고 사유</div>
									<div class="col-lg-9 col-md-8">${report.why }</div>
								</div>

								<div class="row">
									<div class="col-lg-3 col-md-4 label">신고 날짜</div>
									<div class="col-lg-9 col-md-8">
										<fmt:parseDate value="${report.reportdate }"
											pattern="yyyy-MM-dd HH:mm" var="date" />
										<fmt:formatDate value="${date }" pattern="yyyy/MM/dd " />
									</div>
								</div>

								<div class="row" style="margin-top: 50px; font-weight: bold;">
									<div class="col-lg-3 col-md-4 label">
										<button type="submit" class="btn btn-secondary " onClick = "location.href='delete.report?re_no=${report.re_no }&pageNumber=${param.pageNumber}&whatColumn=${param.whatColumn}&keyword=${param.keyword}'">삭제</button>
									</div>
									<div class="col-lg-9 col-md-8">
									</div>
								</div>

							</div>
						</div>
					</div>
				</div>
			</div>
			</div>
	</section>

</main>
<!-- End #main -->
<%@include file="../adminCommon/adminFooter.jsp"%>