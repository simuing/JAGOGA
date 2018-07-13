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
<script>

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
		// 페이지가 로딩되면 실행
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
		<!-- MAIN CONTENT -->
		<div class="main-content">
			<div class="container-fluid">
				<!-- 결제내역 -->
				<h3 class="page-title">결제 목록</h3>
				<p id="clock"></p>
				<div class="row">
					<div class="col-md-12">
						<div class="panel">
							<div class="panel-body">
								<select>
									<option value="all">전체</option>
									<option value="bookingCode">결제코드</option>
									<option value="roomCode">숙소코드</option>
									<option value="hmemId">호스트아이디</option>
									<option value="gmemId">게스트아이디</option>
								</select>
								<select>
									<option value="allstate">거래상태</option>
									<option value="booking">예약중</option>
									<option value="used">거래완료</option>
									<option value="cancel">예약취소</option>
								</select>
								<input class=".form-control" type="text" placeholder="검색어를 입력해주세요.">
								<table class="table">
									<thead>
										<tr>
											<th>결제코드</th>
											<th>숙소코드</th>
											<th>숙소이름</th>
											<th>결제일</th>
											<th>호스트아이디</th>
											<th>게스트아이디</th>
											<th>거래상태</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td>1</td>
											<td>admin</td>
											<td>Jobs</td>
											<td>@steve</td>
											<td>testid1</td>
											<td>testid2</td>
											<td>예약중</td>
										</tr>
										<tr>
											<td>2</td>
											<td>Steve</td>
											<td>Jobs</td>
											<td>@steve</td>
											<td></td>
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
										</tr>
										<tr>
											<td>4</td>
											<td>Jane</td>
											<td>Doe</td>
											<td>@jane</td>
											<td></td>
											<td></td>
											<td></td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
				<!-- END 결제내역 -->
				<!-- 해당숙소 예약내역 -->
				<div class="row">
					<div class="col-md-12">
						<div class="panel">
							<div class="panel-heading">
								<h3 class="panel-title">해당숙소 전체 예약내역</h3>
							</div>
							<div class="panel-body">
								<table class="table">
									<thead>
										<tr>
											<th>예약코드</th>
											<th>숙소코드</th>
											<th>숙소이름</th>
											<th>예약일</th>
											<th>숙박기간</th>
											<th>게스트아이디</th>
											<th>게스트신분증</th>
											<th>취소</th>
											<th>처리상태</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td>345</td>
											<td>24</td>
											<td>두바퀴게스트하우스</td>
											<td>2018-06-06</td>
											<td>2018-06-12~2018-06-13</td>
											<td>ssw1212</td>
											<td>다운로드</td>
											<td>불가</td>
											<td>이용완료</td>
										</tr>
										<tr>
											<td>345</td>
											<td>24</td>
											<td>두바퀴게스트하우스</td>
											<td>2018-06-06</td>
											<td>2018-06-12~2018-06-13</td>
											<td>ssw1212</td>
											<td>다운로드</td>
											<td>불가</td>
											<td>이용완료</td>
										</tr>
										<tr>
											<td>345</td>
											<td>24</td>
											<td>두바퀴게스트하우스</td>
											<td>2018-06-06</td>
											<td>2018-06-12~2018-06-13</td>
											<td>ssw1212</td>
											<td>다운로드</td>
											<td>불가</td>
											<td>게스트취소</td>
										</tr>
										<tr>
											<td>345</td>
											<td>24</td>
											<td>두바퀴게스트하우스</td>
											<td>2018-06-06</td>
											<td>2018-06-12~2018-06-13</td>
											<td>ssw1212</td>
											<td>다운로드</td>
											<td><button type="button"  class="btn btn-default updatebtn">취소</button></td>
											<td>이용완료</td>
										</tr>
										<tr>
											<td>345</td>
											<td>24</td>
											<td>두바퀴게스트하우스</td>
											<td>2018-06-06</td>
											<td>2018-06-12~2018-06-13</td>
											<td>ssw1212</td>
											<td>다운로드</td>
											<td>완료</td>
											<td>이용완료</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
				<!-- END 해당숙소 예약내역 -->
				<!-- 결제정보 상세조회 -->
				<div class="panel panel-headline">
					<div class="panel-heading">
						<div class="row">
							<div class="col-md-12">
								<h3 class="panel-title">[예약중]예약코드 21</h3>
								<div>
									<table class="table">
										<tr>
											<th>예약코드</th>
											<td>21</td>
											<th>성인인원수</th>
											<td>2명</td>
										</tr>
										<tr>
											<th>숙소이름</th>
											<td>유비니네집</td>
											<th>어린이인원수</th>
											<td>0명</td>
										</tr>
										<tr>
											<th>숙소유형</th>
											<td>한옥</td>
											<th>유아인원수</th>
											<td>0명</td>
										</tr>
										<tr>
											<th>숙소면적</th>
											<td>2㎡</td>
											<th>결제금액</th>
											<td>50,000원</td>
										</tr>
										<tr>
											<th>체크인</th>
											<td>2018-06-12</td>
											<th></th>
											<td></td>
										</tr>
										<tr>
											<th>체크아웃</th>
											<td>2018-06-13</td>
											<th></th>
											<td></td>
										</tr>
									</table>
								</div>
							</div>
						</div>
					</div>
					<div class="panel-body">
						<div class="row">
							<div class="col-md-12">
							</div>
						</div>
					</div>
				</div>
				<!-- END 기본 백지 -->
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