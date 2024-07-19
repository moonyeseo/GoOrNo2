<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../adminCommon/adminHeader.jsp"%>


<form action="detailUsers.users" method="post">
	<main id="main" class="main">

		<div class="pagetitle">
			<h1>User</h1>
			<nav>
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a href="list.users">User</a></li>
					<li class="breadcrumb-item active">Detail</li>
				</ol>
			</nav>
		</div>
		<!-- End Page Title -->

		<section class="section profile">
			<div class="row">
				<div class="col-xl-4">

					<div class="card">
						<div
							class="card-body profile-card pt-4 d-flex flex-column align-items-center">
							<img src="<%=request.getContextPath()+"/resources/uploadImage/"%>${users.profile}" width="290" height="290" class="rounded-circle">
							<h2>${users.name }</h2> 
<!-- 							<div class="social-links mt-2">
								<a href="#" class="twitter"><i class="bi bi-twitter"></i></a> <a
									href="#" class="facebook"><i class="bi bi-facebook"></i></a> <a
									href="#" class="instagram"><i class="bi bi-instagram"></i></a>
								<a href="#" class="linkedin"><i class="bi bi-linkedin"></i></a>
							</div> -->
						</div>
					</div>

				</div>

				<div class="col-xl-8">

					<div class="card">
						<div class="card-body pt-3">
							<!-- Bordered Tabs -->

							<div class="tab-content pt-2">

								<div class="tab-pane fade show active profile-overview"
									id="profile-overview">							

									<h5 class="card-title">Profile Details</h5>

									<div class="row">
										<div class="col-lg-3 col-md-4 label ">ID</div>
										<div class="col-lg-9 col-md-8">${users.id }</div>
									</div>

									<div class="row">
										<div class="col-lg-3 col-md-4 label">PassWord</div>
										<div class="col-lg-9 col-md-8">${users.pw }</div>
									</div>

									<div class="row">
										<div class="col-lg-3 col-md-4 label">Gender</div>
										<div class="col-lg-9 col-md-8">${users.gender }</div>
									</div>

									<div class="row">
										<div class="col-lg-3 col-md-4 label">Email</div>
										<div class="col-lg-9 col-md-8">${users.email }</div>
									</div>

									<div class="row">
										<div class="col-lg-3 col-md-4 label">Phone</div>
										<div class="col-lg-9 col-md-8">${users.phoneNum }</div>
									</div>

									<div class="row">
										<div class="col-lg-3 col-md-4 label">Postcode</div>
										<div class="col-lg-9 col-md-8">${users.postcode }</div>
									</div>

									<div class="row">
										<div class="col-lg-3 col-md-4 label">Address</div>
										<div class="col-lg-9 col-md-8">${users.address }</div>
									</div>

								</div>

								<div class="tab-pane fade profile-edit pt-3" id="profile-edit">

									<!-- Profile Edit Form -->

								</div>
							</div>

						</div>
					</div>

				</div>
			</div>
		</section>

	</main>
	<!-- End #main -->
</form>

<%@include file="../adminCommon/adminFooter.jsp"%>
