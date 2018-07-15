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
	<title>Admin Member</title>
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
				<div class="panel panel-headline">
					<div class="panel-heading">
						<div class="row">
							<div class="col-md-12">
								<h3 class="panel-title">회원 목록</h3>
								<div class="right">
									<button type="button" class="btn-toggle-collapse">
										<i class="lnr lnr-chevron-down"></i>
									</button>
								</div>
							</div>
						</div>
					</div>
					<div class="panel-body">
					    <div class="row">    
					        <div class="col-md-6">
							    <div class="input-group">
					                <div class="input-group-btn search-panel">
					                    <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
					                    	<span id="search_concept">전체회원</span> <span class="caret"></span>
					                    </button>
					                    <ul class="dropdown-menu" role="menu">
					                      <li><a href="#memCode">회원코드</a></li>
					                      <li><a href="#memId">아이디</a></li>
					                      <li><a href="#memTel">휴대폰번호</a></li>
					                    </ul>
					                </div>
					                <input type="hidden" name="search_param" value="all" id="search_param">         
					                <input type="text" class="form-control" name="x" placeholder="Search...">
					                <span class="input-group-btn">
					                    <button class="btn btn-default" type="button">
					                    	<span class="glyphicon glyphicon-search"></span>
					                    </button>
					                </span>
					            </div>
					        </div>
						</div>
						<table class="table">
							<thead>
								<tr>
									<th>회원코드</th>
									<th>아이디</th>
									<th>이름</th>
									<th>주민번호</th>
									<th>휴대폰번호</th>
									<th>이메일</th>
									<th>에티켓등급(점수)</th>
									<th>프로필사진</th>
									<th>가입일</th>
									<th>상태변경</th>
									<th>상태</th>
									<th>관리자아이디</th>
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
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
								</tr>
								<tr>
									<td>2</td>
									<td>Steve</td>
									<td>Jobs</td>
									<td>@steve</td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td>
										<button type="button"  class="btn btn-default updatebtn">수정</button>
										<button type="button"  class="btn btn-default deletebtn">삭제</button>
									</td>
									<td></td>
									<td></td>
								</tr>
								<tr>
									<td>3</td>
									<td>Simon</td>
									<td>Philips</td>
									<td>@simon</td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td>
										<button type="button"  class="btn btn-default updatebtn">수정</button>
										<button type="button"  class="btn btn-default deletebtn">삭제</button>
									</td>
									<td></td>
									<td></td>
								</tr>
								<tr>
									<td>4</td>
									<td>Jane</td>
									<td>Doe</td>
									<td>@jane</td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td>
										<button type="button"  class="btn btn-default updatebtn">수정</button>
										<button type="button"  class="btn btn-default deletebtn">삭제</button>
									</td>
									<td></td>
									<td></td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			<!-- END ADMIN LIST TABLE -->
			<!-- 에티켓 점수별 등급 -->
			<div class="container-fluid">
				<!-- ADMIN LIST TABLE -->
				<div class="panel panel-headline">
					<div class="panel-heading">
						<div class="row">
							<div class="col-md-12">		
								<h3 class="panel-title">에티켓 점수별 등급</h3>
							</div>
						</div>
					</div>
					<div class="panel-body">
						<div class="row">
							<div class="col-md-2"></div>
							<div class="col-md-8">
								<br>
								<img alt="membergrade.jpg" src="assets/img/membergrade.png"  style="width:100%;">
								<br>
							</div>
							<div class="col-md-2"></div>
						</div>
					</div>
				</div>
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
