<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@include file="../adminCommon/adminHeader.jsp"%>

<script type="text/javascript">
	function update(user_no, whatColumn, keyword, pageNumber) {
		location.href = "detailUsers.users?user_no=" + user_no + "&whatColumn="
				+ whatColumn + "&keyword=" + keyword + "&pageNumber="
				+ pageNumber;
	}
</script>

<style type="text/css">
table {
	margin: auto;
}
</style>
<main id="main" class="main">

	<div class="pagetitle">
		<h1>User</h1>
		<nav>
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="#">User</a></li>
				<li class="breadcrumb-item active">List</li>
			</ol>
		</nav>
	</div>


	<div class="col-lg-12 wow fadeInUp" data-wow-duration="0.5s"
		data-wow-delay="0.25s">
		<section class="section">
			<div class="row">
				<div class="col-lg-12">

					<div class="card">
						<div class="card-body">
							<div style="text-align: center;">
								<table class="table table-borderless"  style="margin-top :10px;">
									<thead>
											<!-- 게시판 검색 -->
											<tr>
												<td colspan="6" align="right">
													<form  action="list.users" method="post" >
														<select name="whatColumn" class="form-select" style="width : 15%; display:inline;">
															<option value="all">전체 검색</option>
															<option value="name">이름</option>
															<option value="gender">성별</option>
														</select>
														<input type="text" name="keyword" class="form-control" style="width : 15%; display:inline;">
														<input type="submit" value="검색" class="btn btn-secondary">
													</form>
												</td>
											</tr>
										<tr>
										<tr>
											<th  scope="col" width="10%" style="text-align: center">번호</th>
											<th  scope="col" width="10%" style="text-align: center">이름</th>
											<th  scope="col" width="10%" style="text-align: center">아이디</th>
											<th  scope="col" width="10%" style="text-align: center">성별</th>
											<th  scope="col" width="10%" style="text-align: center">이메일</th>
											<th  scope="col" width="10%" style="text-align: center">상세보기</th>
										</tr>
									</thead>

									<tbody>
										<c:if test="${totalCount == 0}">

											<tr>
												<td align="center" colspan="6">회원 정보가 없습니다.</td>
											</tr>

										</c:if>
										<c:forEach var="users" items="${usersList }">

											<tr>
												<td>${users.user_no }</td>
												<td>${users.name }</td>
												<td>${users.id }</td>
												<td>${users.gender }</td>
												<td>${users.email }</td>
												<td>
													<button type="button"  class="btn btn-secondary"
														onclick="update('${users.user_no }','${param.whatColumn}', '${param.keyword}', '${pageInfo.pageNumber}')">확
														인</button>
												</td>
											</tr>
										</c:forEach>

									</tbody>

								</table>
							</div>
							<center>${pageInfo.pagingHtml }</center>
						</div>
					</div>

				</div>
			</div>
		</section>
	</div>
</main>


<%@include file="../adminCommon/adminFooter.jsp"%>