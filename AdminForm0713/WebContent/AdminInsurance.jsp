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
			
				<!-- 정책 및 이용약관 -->
				<div class="row">
					<div class="col-md-5">
						<div class="panel panel-headline">
							<div class="panel-heading">
								<div class="row">
									<div class="col-md-12">
										<h3 class="panel-title">보험 정보</h3>
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
										<img src=""><span>보험 이름 : JGG</span>
										<form>
										    <div class="form-group">
										      <textarea class="form-control" rows="7" disabled="disabled" style="resize:none;">보험 내용
게스트는 결제금액의 일부를 보험료로 내어 필수로가입해야 하며, 호스트는 인증된 보험이  없을 시 필수로 가입하여야 한다. 보험 가입자는 해당 숙소시설에 의한 피해와 숙소 내의 여러 피해 상황에 대한 보험금을 받을 수 있다.</textarea>
											    </div>
										</form>
										<button type="button"  class="btn btn-default updatebtn" style="width:100%; height: 30px;">수정</button>
									</div>
								</div>
							</div>
						</div>
					</div>
					<!-- END 정책 및 이용약관 -->
					<!-- 게스트 보험 약관 -->
					<div class="col-md-7">
						<div class="panel panel-headline">
							<div class="panel-heading">
								<div class="row">
									<div class="col-md-12">
										<h3 class="panel-title">게스트 보험 약관</h3>
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
										  <form>
										    <div class="form-group">
										      <textarea class="form-control" rows="15" id="comment" disabled="disabled" style="resize:none;">JAGOGA 개인정보취급방침
JAGOGA  온라인 숙박공유 플랫폼 개인정보취급방침
(발효일: 2012년 5월)
		
제1조(목적)
이 약관은 (주)JAGOGA (이하 회사라 한다.)가 운영하는 JAGOGA 숙박공유 플랫폼(이하 JAGOGA 한다.)에서 제공하는 인터넷 및 모바일 서비스(이하 서비스라 한다.)를 이용함에 있어 회사와 이용자의 권리·의무 및 책임사항을 규정함을 목적으로 합니다.
		
제2조(정의)
JAGOGA  회사가 재화 또는 용역을 이용자에게 제공하기 위하여 컴퓨터 등 정보통신설비를 이용하여 재화 또는 용역을 거래할 수 있도록 설정한 가상의 영업장을 말하며, 아울러 사이트를 운영하는 사업자의 의미로도 사용합니다. 이용자란 JAGOGA 에 접속하여 이 약관에 따라 JAGOGA 가 제공하는 서비스를 받는 회원 및 비회원을 말합니다. 회원이라 함은 JAGOGA 에 개인정보를 제공하여 회원등록을 한 자로서, JAGOGA 의 정보를 지속적으로 제공받으며, JAGOGA 가 제공하는 서비스를 계속해서 이용할 수 있는 자를 말합니다. 비회원이라 함은 회원에 가입하지 않고 JAGOGA 보험가 제공하는 서비스를 이용하는 자를 말합니다. 게스트라 함은 회원으로서 JAGOGA 보험에서 숙박 장소를 빌리는 사람을 말합니다. 호스트라 함은 회원으로 JAGOGA 보험에서 숙박 장소를 대여해 주는 사람을 말합니다. 게스트 수수료는 숙소 호스트가 회사에 지불하여야 하는 수수료를 말합니다. 컨텐츠는 호스트 또는 게스트가 JAGOGA 보험에 게재한 모든 회원소개, 이용후기, 사진, 동영상 등을 말합니다.
	
제3조 (약관의 명시와 개정)
JAGOGA 보험는 이 약관의 내용과 상호, 영업소 소재지, 대표자의 성명, 사업자등록번호, 연락처(전화, 팩스, 전자우편 주소 등) 등을 이용자가 알 수 있도록 JAGOGA 보험의 초기 서비스화면(전면)에 게시합니다. JAGOGA 보험는 약관의 규제 등에 관한 법률, 전자거래기본법, 전자서명법, 정보통신망이용촉진 등에 관한 법률, 방문판매 등에 관한 법률, 소비자보호법 등 관련법을 위배하지 않는 범위에서 이 약관을 개정할 수 있습니다. JAGOGA 보험가 약관을 개정할 경우에는 적용일자 및 개정사유를 명시하여 현행약관과 함께 JAGOGA 보험의 초기화면에 그 적용일자 7일 이전부터 적용일자 전일까지 공지합니다. 또한 JAGOGA 보험는 개정된 이용자약관을 이용자에게 이메일로 공지하고 이용자가 4주 이내에 개정에 대한 반대의사를 표시하지 않으면 변경에 동의한 것으로 간주합니다. 코자자가 약관을 개정할 경우에는 그 개정약관은 그</textarea>
												    </div>
												  </form>
												  <button type="button"  class="btn btn-default updatebtn" style="width:100%; height: 30px;">수정</button>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- END 게스트 보험 약관 -->
				<!-- 정책 및 이용약관 -->
				<div class="row">
					<div class="col-md-5">
						<div class="panel panel-headline">
							<div class="panel-heading">
								<div class="row">
									<div class="col-md-12">
										<h3 class="panel-title">보험료 비율</h3>
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
										  <form>
										    <div class="form-group">
										    	<input class="form-control" type="text" readonly="readonly" value="현재 보험료 비율 4%" style="text-align:center;">
										    </div>
										  </form>
										  <button type="button"  class="btn btn-default updatebtn" style="width:100%; height: 30px;">수정</button>
									</div>
								</div>
							</div>
						</div>
					</div>
					<!-- END 정책 및 이용약관 -->
					<!-- 호스트 보험 약관 -->
					<div class="col-md-7">
						<div class="panel panel-headline">
							<div class="panel-heading">
								<div class="row">
									<div class="col-md-12">
										<h3 class="panel-title">호스트 보험 약관</h3>
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
									  <form>
									    <div class="form-group">
									      <textarea class="form-control" rows="15" id="comment" disabled="disabled" style="resize:none;">JAGOGA 개인정보취급방침
JAGOGA  온라인 숙박공유 플랫폼 개인정보취급방침
(발효일: 2012년 5월)
	
제1조(목적)
이 약관은 (주)JAGOGA (이하 회사라 한다.)가 운영하는 JAGOGA 숙박공유 플랫폼(이하 JAGOGA 한다.)에서 제공하는 인터넷 및 모바일 서비스(이하 서비스라 한다.)를 이용함에 있어 회사와 이용자의 권리·의무 및 책임사항을 규정함을 목적으로 합니다.

제2조(정의)
JAGOGA  회사가 재화 또는 용역을 이용자에게 제공하기 위하여 컴퓨터 등 정보통신설비를 이용하여 재화 또는 용역을 거래할 수 있도록 설정한 가상의 영업장을 말하며, 아울러 사이트를 운영하는 사업자의 의미로도 사용합니다. 이용자란 JAGOGA 에 접속하여 이 약관에 따라 JAGOGA 가 제공하는 서비스를 받는 회원 및 비회원을 말합니다. 회원이라 함은 JAGOGA 에 개인정보를 제공하여 회원등록을 한 자로서, JAGOGA 의 정보를 지속적으로 제공받으며, JAGOGA 가 제공하는 서비스를 계속해서 이용할 수 있는 자를 말합니다. 비회원이라 함은 회원에 가입하지 않고 JAGOGA 보험가 제공하는 서비스를 이용하는 자를 말합니다. 게스트라 함은 회원으로서 JAGOGA 보험에서 숙박 장소를 빌리는 사람을 말합니다. 호스트라 함은 회원으로 JAGOGA 보험에서 숙박 장소를 대여해 주는 사람을 말합니다. 게스트 수수료는 숙소 호스트가 회사에 지불하여야 하는 수수료를 말합니다. 컨텐츠는 호스트 또는 게스트가 JAGOGA 보험에 게재한 모든 회원소개, 이용후기, 사진, 동영상 등을 말합니다.
	
제3조 (약관의 명시와 개정)
JAGOGA 보험는 이 약관의 내용과 상호, 영업소 소재지, 대표자의 성명, 사업자등록번호, 연락처(전화, 팩스, 전자우편 주소 등) 등을 이용자가 알 수 있도록 JAGOGA 보험의 초기 서비스화면(전면)에 게시합니다. JAGOGA 보험는 약관의 규제 등에 관한 법률, 전자거래기본법, 전자서명법, 정보통신망이용촉진 등에 관한 법률, 방문판매 등에 관한 법률, 소비자보호법 등 관련법을 위배하지 않는 범위에서 이 약관을 개정할 수 있습니다. JAGOGA 보험가 약관을 개정할 경우에는 적용일자 및 개정사유를 명시하여 현행약관과 함께 JAGOGA 보험의 초기화면에 그 적용일자 7일 이전부터 적용일자 전일까지 공지합니다. 또한 JAGOGA 보험는 개정된 이용자약관을 이용자에게 이메일로 공지하고 이용자가 4주 이내에 개정에 대한 반대의사를 표시하지 않으면 변경에 동의한 것으로 간주합니다. 코자자가 약관을 개정할 경우에는 그 개정약관은 그</textarea>
										   </div>
									  </form>
									  <button type="button"  class="btn btn-default updatebtn" style="width:100%; height: 30px;">수정</button>
									</div>
								</div>
							</div>
						</div>
					</div>
					<!-- END 호스트 보험 약관 -->
				</div>
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
