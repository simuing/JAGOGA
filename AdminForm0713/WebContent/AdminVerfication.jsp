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
	<title>Admin Verification</title>
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
	
<script>
	// 현재 시간을 출력해주는 함수
	function printTime()
	{
		// 출력할 장소 선택
		var clock = document.getElementById("clock");
		
		// 현재시간
		var now = new Date();
		var nowTime = now.getFullYear() + "년" + (now.getMonth()+1) + "월" + now.getDate()
				+ "일" + now.getHours() + "시" + now.getMinutes() + "분" + now.getSeconds() + "초";
		
		// 현재시간을 출력
		clock.innerHTML = nowTime;           
		
		// setTimeout(“실행할함수”,시간) 시간은1초의 경우 1000
		setTimeout("printTime()",1000);         
	}
	
	window.onload = function()
	{
		// 페이지가 로딩되면 현재시간 출력함수 실행
		printTime();
	}
</script>
</head>
<body>
<!-- WRAPPER -->
<div id="wrapper">

	<!-- NAVBAR, SIDEBAR -->
	<c:import url="AdminMainbar.jsp"></c:import>
	
	<!-- MAIN -->
	<div class="main">
		<div class="main-content">
			<div class="container-fluid">
			
			
				<!-- 숙소목록 -->
				<div class="panel panel-headline">
					<div class="panel-heading">
						<div class="row">
							<div class="col-md-12">
								<h3 class="panel-title">검증 목록</h3>
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
					        <div class="col-md-8">
							    <div class="input-group">
					                <div class="input-group-btn search-panel">
					                    <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
					                    	<span id="search_v">전체검증</span> <span class="caret"></span>
					                    </button>
					                    <ul class="dropdown-menu" role="menu">
					                      <li><a href="#vcode">검증코드</a></li>
					                      <li><a href="#rcode">숙소코드</a></li>
					                      <li><a href="#hmemId">호스트아이디</a></li>
					                      <li><a href="#adminId">관리자아이디</a></li>
					                    </ul>
					                </div>
					                 <div class="input-group-btn search-panel">
					                    <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
					                    	<span id="search_vgrade">검증등급</span> <span class="caret"></span>
					                    </button>
					                    <ul class="dropdown-menu" role="menu">
					                      <li><a href="#a">A 등급</a></li>
					                      <li><a href="#b">B 등급</a></li>
					                      <li><a href="#c">C 등급</a></li>
					                    </ul>
					                </div>
					                <div class="input-group-btn search-panel">
					                    <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
					                    	<span id="search_vstate">검증상태</span> <span class="caret"></span>
					                    </button>
					                    <ul class="dropdown-menu" role="menu">
					                      <li><a href="#vwaiting">검증대기</a></li>
					                      <li><a href="#verifying">검증중</a></li>
					                      <li><a href="#vsuccess">검증완료</a></li>
					                      <li><a href="#vfail">검증실패</a></li>
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
									<th>검증코드</th>
									<th>숙소코드</th>
									<th>검증단계</th>
									<th>검증유효기간</th>
									<th>숙소유형</th>
									<th>호스트아이디</th>
									<th>숙소이름</th>
									<th>등록일</th>
									<th>상태</th>
									<th>관리자아이디</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>33</td>
									<td>22</td>
									<td>A</td>
									<td>~2019-05-05</td>
									<td>주택</td>
									<td>wd098</td>
									<td>행복했던 나의 집1</td>
									<td>2018-07-05</td>
									<td><button type="button" class="btn btn-default updatebtn">검증중</button></td>
									<td>helper</td>
								</tr>
								<tr>
									<td>32</td>
									<td>22</td>
									<td>B</td>
									<td>~2019-05-05</td>
									<td>주택</td>
									<td>wd098</td>
									<td>행복했던 나의 집1</td>
									<td>2018-07-05</td>
									<td><button type="button" class="btn btn-default updatebtn">검증완료</button></td>
									<td>helper</td>
								</tr>
								<tr>
									<td>31</td>
									<td>22</td>
									<td>C</td>
									<td>~2019-05-05</td>
									<td>주택</td>
									<td>wd098</td>
									<td>행복했던 나의 집1</td>
									<td>2018-07-05</td>
									<td><button type="button" class="btn btn-default updatebtn">검증대기</button></td>
									<td>helper</td>
								</tr>
								<tr>
									<td>30</td>
									<td>22</td>
									<td>A</td>
									<td>~2019-05-05</td>
									<td>주택</td>
									<td>wd098</td>
									<td>행복했던 나의 집1</td>
									<td>2018-07-05</td>
									<td><button type="button" class="btn btn-default updatebtn">검증대기</button></td>
									<td>helper</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
				<!-- END 숙소목록 -->
				
			</div>
		</div>
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
