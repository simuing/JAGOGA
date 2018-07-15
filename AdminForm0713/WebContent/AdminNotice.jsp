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
	<title>Admin sample</title>
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
			
				<!-- 공지목록 -->
				<div class="panel panel-headline">
					<div class="panel-heading">
						<div class="row">
							<div class="col-md-12">
								<h3 class="panel-title">공지 목록</h3>
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
					                    	<span id="search_concept">전체공지</span> <span class="caret"></span>
					                    </button>
					                    <ul class="dropdown-menu" role="menu">
					                      <li><a href="#noticeTitle">공지제목</a></li>
					                      <li><a href="#adminId">작성자아이디</a></li>
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
									<th>공지코드</th>
									<th>공지제목</th>
									<th>등록일</th>
									<th>첨부파일</th>
									<th>조회수</th>
									<th>비공개상태</th>
									<th>상태변경</th>
									<th>관리자아이디</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>11</td>
									<td>JAGOGA 이벤트 관련 알림</td>
									<td>2018-07-11</td>
									<td>file.zip</td>
									<td>3550</td>
									<td>공개</td>
									<td>
										<button type="button" class="btn btn-default updatebtn">수정</button>
										<button type="button" class="btn btn-default deletebtn">삭제</button>
									</td>
									<td>helper</td>
								</tr>
								<tr>
									<td>11</td>
									<td>JAGOGA 이벤트 관련 알림</td>
									<td>2018-07-11</td>
									<td>file.zip</td>
									<td>3550</td>
									<td>공개</td>
									<td>
										<button type="button" class="btn btn-default updatebtn">수정</button>
										<button type="button" class="btn btn-default deletebtn">삭제</button>
									</td>
									<td>helper</td>
								</tr>
								<tr>
									<td>11</td>
									<td>JAGOGA 이벤트 관련 알림</td>
									<td>2018-07-11</td>
									<td>file.zip</td>
									<td>3550</td>
									<td>공개</td>
									<td>
										<button type="button" class="btn btn-default updatebtn">수정</button>
										<button type="button" class="btn btn-default deletebtn">삭제</button>
									</td>
									<td>helper</td>
								</tr>
								<tr>
									<td>11</td>
									<td>JAGOGA 이벤트 관련 알림</td>
									<td>2018-07-11</td>
									<td>file.zip</td>
									<td>3550</td>
									<td>공개</td>
									<td>
										<button type="button" class="btn btn-default updatebtn">수정</button>
										<button type="button" class="btn btn-default deletebtn">삭제</button>
									</td>
									<td>helper</td>
								</tr>
							</tbody>
						</table>
						<div class="col-md-12">
							<div class="left">
								<button type="button" class="btn btn-default insertbtn">등록</button>
							</div>
						</div>
					</div>
				</div>
				<!-- END 공지목록 -->
				<!-- 공지등록 -->
				<div>
				
				</div>
				<!-- END 공지등록 -->
				
				
				<!-- 이용가이드 -->
				<div class="panel panel-headline">
					<div class="panel-heading">
						<div class="row">
							<div class="col-md-12">
								<h3 class="panel-title">이용가이드</h3>
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
							<div class="col-md-12">
								<div class="form-group col-md-6">
									1<input type="text" class="form-control" value="1. 안전을 바탕으로 한 커뮤니티"><br>
									<input type="text" class="form-control" value="안전을 최우선으로"><br>
									2<input type="text" class="form-control" value="2. 신뢰할 수 있는 서비스"><br>
									<input type="text" class="form-control" value="신뢰를 최우선으로"><br>
									3<input type="text" class="form-control" value="3. 검증된 서비스"><br>
									<input type="text" class="form-control" value="검증을 통한 안전성 확보"><br>
								</div>
								<div class="form-group col-md-6">
									4<input type="text" class="form-control" value="4. 다양한 숙소"><br>
									<input type="text" class="form-control" value="다양한 숙소"><br>
									5<input type="text" class="form-control" value=""><br>
									<input type="text" class="form-control" value=""><br>
									6<input type="text" class="form-control" value=""><br>
									<input type="text" class="form-control" value=""><br>
								</div>
								<button type="button"  class="btn btn-default updatebtn" style="width:100%; height: 30px;">수정</button>
							</div>
						</div>
					</div>
				</div>
				<!-- END 이용가이드 -->
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
