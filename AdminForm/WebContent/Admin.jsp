<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% 
	request.setCharacterEncoding("UTF-8"); 
	String cp = request.getContextPath();
%>
<%
	String memId = null;
	/* if (session.getAttribute("id") != null) 
		memId = (String)session.getAttribute("id"); */
%>
<!doctype html>
<html lang="en">

<head>
	<title>Admin</title>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
	<!-- VENDOR CSS -->
	<link rel="stylesheet" href="assets/vendor/bootstrap/css/bootstrap.css">
	<link rel="stylesheet" href="assets/vendor/font-awesome/css/font-awesome.min.css">
	<link rel="stylesheet" href="assets/vendor/linearicons/style.css">
	<link rel="stylesheet" href="assets/vendor/chartist/css/chartist-custom.css">
	<!-- MAIN CSS -->
	<link rel="stylesheet" href="assets/css/main.css">
	<link rel="stylesheet" href="assets/css/admin.css">
	<!-- GOOGLE FONTS -->
	<link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700" rel="stylesheet">
	<!-- ICONS -->
	<link rel="apple-touch-icon" sizes="76x76" href="assets/img/apple-icon.png">
	<link rel="icon" type="image/png" sizes="96x96" href="assets/img/favicon.png">
</head>
<body>
<!-- WRAPPER -->
<div id="wrapper">

	<!-- NAVBAR, SIDEBAR -->
	<c:import url="AdminMainbar.jsp"></c:import>				
				
	<!-- MAIN -->
	<div class="main">
		<!-- MAIN CONTENT -->
		<div class="main-content">
			<div class="container-fluid">
				<!-- ADMIN LIST TABLE -->
				<h3 class="page-title">관리자 계정 목록</h3>
				<div class="row">
					<div class="col-md-12">
						<div class="panel">
							<div class="panel-body">
								<table class="table">
									<thead>
										<tr>
											<th>계정코드</th>
											<th>계정이름</th>
											<th>아이디</th>
											<th>권한번호</th>
											<th>관리내용</th>
											<th>수정/삭제</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td>1</td>
											<td>admin</td>
											<td>Jobs</td>
											<td>@steve</td>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td>2</td>
											<td>Steve</td>
											<td>Jobs</td>
											<td>@steve</td>
											<td></td>
											<td>
												<button type="button"  class="btn btn-default updatebtn">수정</button>
												<button type="button"  class="btn btn-default deletebtn">삭제</button>
											</td>
										</tr>
										<tr>
											<td>3</td>
											<td>Simon</td>
											<td>Philips</td>
											<td>@simon</td>
											<td></td>
											<td>
												<button type="button"  class="btn btn-default updatebtn">수정</button>
												<button type="button"  class="btn btn-default deletebtn">삭제</button>
											</td>
										</tr>
										<tr>
											<td>4</td>
											<td>Jane</td>
											<td>Doe</td>
											<td>@jane</td>
											<td></td>
											<td>
												<button type="button"  class="btn btn-default updatebtn">수정</button>
												<button type="button"  class="btn btn-default deletebtn">삭제</button>
											</td>
										</tr>
									</tbody>
								</table>
								<button type="button" class="btn btn-default insertbtn">등록</button>
							</div>
						</div>
					</div>
				</div>
				<!-- END ADMIN LIST TABLE -->
				<!-- 권한 LIST TABLE -->
				<h3 class="page-title">권한 목록</h3>
				<div class="row">
					<div class="col-md-12">
						<div class="panel">
							<div class="panel-body">
								<table class="table">
									<thead>
										<tr>
											<th>권한코드</th>
											<th>권한이름</th>
											<th>권한내용</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td>1</td>
											<td>Steve</td>
											<td>Jobs</td>
										</tr>
										<tr>
											<td>2</td>
											<td>Simon</td>
											<td>Philips</td>
										</tr>
										<tr>
											<td>3</td>
											<td>Jane</td>
											<td>Doe</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
				<!-- END 권한 LIST TABLE -->
			</div>
		</div>
		<!-- END MAIN CONTENT -->
	</div>
	<!-- END MAIN -->
</div>
<!-- END WRAPPER -->

<!-- Javascript -->
<script src="assets/vendor/jquery/jquery.min.js"></script>
<script src="assets/vendor/bootstrap/js/bootstrap.min.js"></script>
<script src="assets/vendor/jquery-slimscroll/jquery.slimscroll.min.js"></script>
<script src="assets/vendor/jquery.easy-pie-chart/jquery.easypiechart.min.js"></script>
<script src="assets/vendor/chartist/js/chartist.min.js"></script>
<script src="assets/scripts/klorofil-common.js"></script>

</body>

</html>
