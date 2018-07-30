<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
	<title>Admin Booking</title>
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
	<!-- jquery CDN  -->
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	

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
				<div class="row">
					<div class="col-md-12">
						<div class="panel panel-headline">
							<div class="panel-heading">
								<div class="row">
									<div class="col-md-12">
										<h3 class="panel-title">결제 목록</h3>
										<p class="right" id="clock"></p>
									</div>
								</div>
							</div>
							<div class="panel-body">
								<div class="row"> 
							        <div class="col-md-6">
									    <div class="input-group">
							                <div class="input-group-btn search-panel">
							                    <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
							                    	<span id="search_concept">전체</span> <span class="caret"></span>
							                    </button>
							                    <ul class="dropdown-menu" role="menu">
							                      <li><a href="#bookingCode">결제코드</a></li>
							                      <li><a href="#roomCode">숙소코드</a></li>
							                      <li><a href="#hmemId">호스트아이디</a></li>
							                      <li><a href="#gmemId">게스트아이디</a></li>
							                    </ul>
							                </div>
							                <div class="input-group-btn search-panel">
							                    <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
							                    	<span id="search_concept">거래상태</span> <span class="caret"></span>
							                    </button>
							                    <ul class="dropdown-menu" role="menu">
							                      <li><a href="#booking">예약중</a></li>
							                      <li><a href="#used">거래완료</a></li>
							                      <li><a href="#cancel">예약취소</a></li>
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
											<th>결제번호</th>
											<th>숙소번호</th>
											<th>숙소이름</th>
											<th>결제일</th>
											<th>호스트아이디</th>
											<th>게스트아이디</th>
											<th>거래상태</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="pay" items="${payList }">
											<tr>
												<td>${pay.bcode }</td>
												<td>${pay.rcode }</td>
												<td><a href="paylistforroom.do?rcode=${pay.rcode }">${pay.rname }</a></td>
												<td>${pay.bdate }</td>
												<td>${pay.hmemId }</td>
												<td>${pay.gmemId }</td>
												<td>${pay.status }</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
								<div>
									<c:if test="${pageNumber != 1 }">
										<a href="adminbooking.do?pageNumber=${pageNumber-1 }"><button class="btn btn-primary">이전</button></a>
									</c:if>
									<!-- 원래는 되어야 한다. -->
									<a href="adminbooking.do?pageNumber=${pageNumber+1 }"><button class="btn btn-primary">다음</button></a>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- END 결제내역 -->
				<!-- 해당숙소 예약내역 -->
				<div class="row">
					<div class="col-md-12">
						<div class="panel panel-headline">
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
										<c:forEach var="payList" items="${payListForRoom }">
											<tr>
												<td>${payList.bcode }</td>
												<td id="rcode">${payList.rcode }</td>
												<td><a href="detailbooking.do?bcode=${payList.bcode }&rcode=${payList.rcode}" >${payList.rname }</a></td>
												<td>${payList.bdate }</td>
												<td>${payList.checkInDate } ~ ${payList.checkOutDate }</td>
												<td>${payList.gmemId }</td>																											
												<td>
													<a href="idcarddownload.do?idcard=${fn:substringAfter(payList.idcard, 'idcard/') }">
														${fn:substringAfter(payList.idcard, 'idCard/') }
													</a>
												</td>
												<td>
													<c:if test="${payList.status=='예약중' }">
														<button type="button" name="bcode" value="${payList.bcode }" class="btn btn-default canceledbtn" style="background-color: red;">취소</button>
													</c:if>
													<c:if test="${payList.status!='예약중' }">
														<button type="button" class="btn btn-default canceledbtn" disabled="disabled" style="background-color: red;">불가</button>
													</c:if>
												</td>
												<td>${payList.status }</td>
											</tr>
										</c:forEach>
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
								<c:if test="${detailBooking.bcode != null }">
								<h3 class="panel-title">[예약중] 예약코드 ${detailBooking.bcode }</h3>
								<div>
									<table class="table">
										<tr>
											<th>예약코드</th>
											<td>${detailBooking.bcode }</td>
											<th>성인인원수</th>
											<td>${detailBooking.adultCount }명</td>
										</tr>
										<tr>
											<th>숙소이름</th>
											<td>${detailBooking.rname }</td>
											<th>어린이인원수</th>
											<td>${detailBooking.childCount }명</td>
										</tr>
										<tr>
											<th>숙소유형</th>
											<td>${detailBooking.rtype }</td>
											<th>유아인원수</th>
											<td>${detailBooking.babyCount }명</td>
										</tr>
										<tr>
											<th>숙소면적</th>
											<td>${detailBooking.rarea }㎡</td>
											<th>결제금액</th>
											<td>${detailBooking.totalFee }원</td>
										</tr>
										<tr>
											<th>체크인</th>
											<td>${detailBooking.checkInDate }</td>
											<th></th>
											<td></td>
										</tr>
										<tr>
											<th>체크아웃</th>
											<td>${detailBooking.checkOutDate }</td>
											<th></th>
											<td></td>
										</tr>
									</table>
								</div>
								</c:if>
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

<script type="text/javascript">


	// 예약취소 버튼 눌리면 수행
	$(".canceledbtn").on("click", function()
	{
		$(location).attr("href", "admincancel.do?bcode=" + $("[name=bcode]").val());
	});
	 
	 
	 
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

</body>

</html>


