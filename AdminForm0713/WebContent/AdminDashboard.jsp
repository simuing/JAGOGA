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
	<title>Admin Dashboard</title>
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

	<!-- NAVBAR -->
	<c:import url="AdminMainbar.jsp"></c:import>
	
	<!-- MAIN -->
	<div class="main">
		<div class="main-content">
			<div class="container-fluid">
				<!-- OVERVIEW -->
				<div class="panel panel-headline">
					<div class="panel-heading">
						<h3 class="panel-title">전날 기준 통계</h3>
						<p><span>현재시간 : </span><span class="panel-subtitle" id="clock"></span></p>
					</div>
					<div class="panel-body">
						<div class="row">
							<div class="col-md-3">
								<div class="metric">
									<span class="icon"><i class="fa fa-download"></i></span>
									<p>
										<span class="number">1,252</span>
										<span class="title">새로운 호스팅 수</span>
									</p>
								</div>
							</div>
							<div class="col-md-3">
								<div class="metric">
									<span class="icon"><i class="fa fa-shopping-bag"></i></span>
									<p>
										<span class="number">22</span>
										<span class="title">새로운 회원 수</span>
									</p>
								</div>
							</div>
							<div class="col-md-3">
								<div class="metric">
									<span class="icon"><i class="fa fa-eye"></i></span>
									<p>
										<span class="number">274,678</span>
										<span class="title">어제 하루 매출</span>
									</p>
								</div>
							</div>
							<div class="col-md-3">
								<div class="metric">
									<span class="icon"><i class="fa fa-bar-chart"></i></span>
									<p>
										<span class="number">35%</span>
										<span class="title">전월 대비 매출추이</span>
									</p>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- END OVERVIEW -->
				<!-- MULTI CHARTS -->
				<div class="row">
					<div class="col-md-3">
						<div class="panel panel-headline">
							<div class="panel-heading">
								<h3 class="panel-title">매출 추이</h3>
							</div>
							<div class="panel-body">
								<div id="visits-trends-chart" class="ct-chart"></div>
							</div>
						</div>
					</div>
					<!-- END MULTI CHARTS -->
					<!-- RECENT PURCHASES -->
					<div class="col-md-6">
						<div class="panel panel-headline">
							<div class="panel-heading">
								<h3 class="panel-title">회원수 통계</h3>
							</div>
							<div class="row">
								<div class="col-md-7">
									<div id="headline-chart" class="ct-chart"></div>
								</div>
								<div class="col-md-3">
									<div class="weekly-summary text-right">
										<span class="number">2,315</span> <span class="percentage"><i class="fa fa-caret-up text-success"></i> 12%</span>
										<span class="info-label">Total Sales</span>
									</div>
									<div class="weekly-summary text-right">
										<span class="number">$5,758</span> <span class="percentage"><i class="fa fa-caret-up text-success"></i> 23%</span>
										<span class="info-label">Monthly Income</span>
									</div>
								</div>
							</div>
						</div>
					</div>
					<!-- END RECENT PURCHASES -->
					<!-- REALTIME CHART -->
					<div class="col-md-3">
						<div class="panel panel-headline">
							<div class="panel-heading">
								<h3 class="panel-title">JAGOGA</h3>
							</div>
							<div class="panel-body">
								<div id="system-load" class="easy-pie-chart" data-percent="70">
									<span class="percent">70</span>
								</div>
								<h4>Happy Load</h4>
								<ul class="list-unstyled list-justify">
									<li>Thinking: <span>95%</span></li>
									<li>Energy: <span>87%</span></li>
									<li>Fail: <span>20%</span></li>
									<li>Happy: <span>996</span></li>
								</ul>
							</div>
						</div>
					</div>
				</div>
				<!-- END REALTIME CHART -->
				<!-- TASKS -->
				<div class="row">
					<div class="col-md-12">
						<div class="row">
							<div class="col-md-12">
								<div class="panel panel-headline">
									<div class="panel-heading">
										<h3 class="panel-title">에티켓 등급별 회원수 통계</h3>
										<div class="row">
											<div class="col-md-2"></div>
											<div class="col-md-8">
												<br>
												<img alt="membergrade.jpg" src="assets/img/membergrade.png"  style="width:100%;">
												<br>
											</div>
											<div class="col-md-2"></div>
										</div>
										<div class="right">
											<button type="button" class="btn-toggle-collapse"><i class="lnr lnr-chevron-down"></i></button>
											<button type="button" class="btn-remove"><i class="lnr lnr-cross"></i></button>
										</div>
									</div>
									<div class="row">
										<div class="col-md-2"></div>
											<div class="col-md-8">
												<div class="panel-body">
													<ul class="list-unstyled task-list">
														<li>
															<p>최우수회원<span class="label-percent">23%</span></p>
															<div class="progress progress-xs">
																<div class="progress-bar progress-bar-danger" role="progressbar"
																 aria-valuenow="23" aria-valuemin="0" aria-valuemax="100" style="width:23%">
																	<span class="sr-only">23% Complete</span>
																</div>
															</div>
														</li>
														<li>
															<p>우수회원<span class="label-percent">80%</span></p>
															<div class="progress progress-xs">
																<div class="progress-bar progress-bar-success" role="progressbar"
																 aria-valuenow="80" aria-valuemin="0" aria-valuemax="100" style="width: 80%">
																	<span class="sr-only">80% Complete</span>
																</div>
															</div>
														</li>
														<li>
															<p>일반회원<span class="label-percent">100명</span></p>
															<div class="progress progress-xs">
																<div class="progress-bar progress-bar-success" role="progressbar"
																 aria-valuenow="100" aria-valuemin="0" aria-valuemax="100" style="width: 100%">
																	<span class="sr-only">Success</span>
																</div>
															</div>
														</li>
														<li>
															<p>불량회원<span class="label-percent">45%</span></p>
															<div class="progress progress-xs">
																<div class="progress-bar progress-bar-warning" role="progressbar"
																 aria-valuenow="45" aria-valuemin="0" aria-valuemax="100" style="width: 45%">
																	<span class="sr-only">45% Complete</span>
																</div>
															</div>
														</li>
														<li>
															<p>최악회원<span class="label-percent">10%</span></p>
															<div class="progress progress-xs">
																<div class="progress-bar progress-bar-danger" role="progressbar"
																 aria-valuenow="10" aria-valuemin="0" aria-valuemax="100" style="width: 10%">
																	<span class="sr-only">10% Complete</span>
																</div>
															</div>
														</li>
													</ul>
												</div>
											<div class="col-md-2"></div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- END TASKS -->
			</div>
		</div>
	</div>
</div>
<!-- END MAIN -->
<!-- END WRAPPER -->
<!-- Javascript -->
<script src="assets/vendor/jquery/jquery.min.js"></script>
<script src="assets/vendor/bootstrap/js/bootstrap.min.js"></script>
<script src="assets/vendor/jquery-slimscroll/jquery.slimscroll.min.js"></script>
<script src="assets/vendor/jquery.easy-pie-chart/jquery.easypiechart.min.js"></script>
<script src="assets/vendor/chartist/js/chartist.min.js"></script>
<script src="assets/scripts/klorofil-common.js"></script>
<script>
$(function() {
	var data, options;

	// headline charts
	data = {
		labels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
		series: [
			[23, 29, 24, 40, 25, 24, 35],
			[14, 25, 18, 34, 29, 38, 44],
		]
	};

	options = {
		height: 300,
		showArea: true,
		showLine: false,
		showPoint: false,
		fullWidth: true,
		axisX: {
			showGrid: false
		},
		lineSmooth: false,
	};

	new Chartist.Line('#headline-chart', data, options);


	// visits trend charts
	data = {
		labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
		series: [{
			name: 'series-real',
			data: [200, 380, 350, 320, 410, 450, 570, 400, 555, 620, 750, 900],
		}, {
			name: 'series-projection',
			data: [240, 350, 360, 380, 400, 450, 480, 523, 555, 600, 700, 800],
		}]
	};

	options = {
		fullWidth: true,
		lineSmooth: false,
		height: "270px",
		low: 0,
		high: 'auto',
		series: {
			'series-projection': {
				showArea: true,
				showPoint: false,
				showLine: false
			},
		},
		axisX: {
			showGrid: false,

		},
		axisY: {
			showGrid: false,
			onlyInteger: true,
			offset: 0,
		},
		chartPadding: {
			left: 20,
			right: 20
		}
	};

	new Chartist.Line('#visits-trends-chart', data, options);


	// visits chart
	data = {
		labels: ['1월', '2월', '3월', '4월', '5월', '6월'],
		series: [
			[6384, 6342, 5437, 2764, 3958, 5068]
		]
	};

	options = {
		height: 300,
		axisX: {
			showGrid: false
		},
	};

	new Chartist.Bar('#visits-chart', data, options);


	// real-time pie chart
	var sysLoad = $('#system-load').easyPieChart({
		size: 130,
		barColor: function(percent) {
			return "rgb(" + Math.round(200 * percent / 100) + ", " + Math.round(200 * (1.1 - percent / 100)) + ", 0)";
		},
		trackColor: 'rgba(245, 245, 245, 0.8)',
		scaleColor: false,
		lineWidth: 5,
		lineCap: "square",
		animate: 800
	});

	var updateInterval = 3000; // in milliseconds

	setInterval(function() {
		var randomVal;
		randomVal = getRandomInt(0, 100);

		sysLoad.data('easyPieChart').update(randomVal);
		sysLoad.find('.percent').text(randomVal);
	}, updateInterval);

	function getRandomInt(min, max) {
		return Math.floor(Math.random() * (max - min + 1)) + min;
	}

});
</script>
</body>

</html>
