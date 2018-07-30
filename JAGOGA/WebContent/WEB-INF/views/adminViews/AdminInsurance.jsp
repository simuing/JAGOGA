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
	<!-- jquery -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	
	
<script type="text/javascript">
	
	$(function()
	{
		// ○ 보험 정보 수정
		// 게스트 보험정보 수정상태를 확인하는 변수 선언 
		var geustInsuState = 0;
		$("#guestInsuBtn").click(function()
		{
			reset();
			
			// 상태가 0(수정시도)이면
			if (geustInsuState==0)
			{
				geustInsuState=1;
				$("#guestIcompany").removeAttr("readonly");
				$("#guestInsu").removeAttr("readonly");
				$("#guestInsuBtn").html("수정완료");
			}
			else // 상태가 1(수정완료)이면
			{
				$(location).attr("href", "insuranceupdate.do?select=1&irate="+$("#guestInsuRate").val() + "&icompany="+$("#guestIcompany").val() + "&icontent="+$("#guestInsu").val().replace(/\n/g, '<br>'));
			}
		});
		// 호스트 보험정보 수정상태를 확인하는 변수 선언
		var hostInsuState = 0;
		$("#hostInsuBtn").click(function()
		{
			reset();
			
			// 상태가 0(수정시도)이면
			if (hostInsuState==0)
			{
				hostInsuState=1;
				$("#hostIcompany").removeAttr("readonly");
				$("#hostInsu").removeAttr("readonly");
				$("#hostInsuBtn").html("수정완료");
			}
			else // 상태가 1(수정완료)이면
			{
				$(location).attr("href", "insuranceupdate.do?select=2&irate="+$("#hostInsuRate").val() + "&icompany="+$("#hostIcompany").val() + "&icontent="+$("#hostInsu").val().replace(/\n/g, '<br>'));
			}
		});


		// ○ 보험 약관 수정
		// 게스트 보험약관 수정상태를 확인하는 변수 선언 
		var geustTermsState = 0;
		$("#guestTermsBtn").click(function()
		{
			reset();
			
			// 상태가 0(수정시도)이면
			if (geustTermsState==0)
			{
				geustTermsState=1;
				$("#guestInsuTerms").removeAttr("readonly");
				$("#guestTermsBtn").html("수정완료");
			}
			else // 상태가 1(수정완료)이면
			{
				$(location).attr("href", "insurancetermsupdate.do?select=4&termsContent="+$("#guestInsuTerms").val().replace(/\n/g, "<br>"));
			}
		});
		// 호스트 보험정보 수정상태를 확인하는 변수 선언
		var hostTermsState = 0;
		$("#hostTermsBtn").click(function()
		{
			reset();
			
			// 상태가 0(수정시도)이면
			if (hostTermsState==0)
			{
				hostTermsState=1;
				$("#hostInsuTerms").removeAttr("readonly");
				$("#hostTermsBtn").html("수정완료");
			}
			else // 상태가 1(수정완료)이면
			{
				$(location).attr("href", "insurancetermsupdate.do?select=5&termsContent="+$("#hostInsuTerms").val().replace(/\n/g, "<br>"));
			}
		});
		
		
		// ○ 보험료 비율 수정
		var InsuRateState = 0;
		$("#insuRateBtn").click(function()
		{
			reset();
			
			// 상태가 0(수정시도)이면
			if (InsuRateState==0)
			{
				InsuRateState=1;
				$("#guestInsuRate").removeAttr("readonly");
				$("#hostInsuRate").removeAttr("readonly");
				$("#insuRateBtn").html("수정완료");
			}
			else // 상태가 1(수정완료)이면
			{
				$(location).attr("href", "insurancerateupdate.do?guestIRate="+$("#guestInsuRate").val() + "&hostIRate="+$("#guestInsuRate").val());
			}
		});
		
		
	});
	
	// 버튼 클릭 시 해당 내용만 수정할 수 있도록 하는 함수
	function reset()
	{
		// 수정버튼을 누르면 다른 내용들은 수정하지 못하도록 readonly 속성 부여
		$(".form-control").attr("readonly", "readonly");
		$(".btn").html("수정");
		
		/* 
		// 누른 버튼에 따라 수정 상태 변수 초기화
		if (stateName=='InsuRateState')
		{
			geustInsuState = 0;
			hostInsuState = 0;
			geustTermsState = 0;
			hostTermsState = 0;
		}
		else if(stateName=='hostTermsState')
		{
			geustInsuState = 0;
			hostInsuState = 0;
			geustTermsState = 0;
			hostTermsState = 0;
		}
		else if(stateName=='geustTermsState')
		{
			geustInsuState = 0;
			hostInsuState = 0;
			hostTermsState = 0;
			InsuRateState = 0;
		}
		else if(stateName=='hostInsuState')
		{
			geustInsuState = 0;
			geustTermsState = 0;
			hostTermsState = 0;
			InsuRateState = 0;
		}
		else if(stateName=='geustInsuState')
		{
			hostInsuState = 0;
			geustTermsState = 0;
			hostTermsState = 0;
			InsuRateState = 0;
		}
		
		geustInsuState = 0;
		hostInsuState = 0;
		geustTermsState = 0;
		hostTermsState = 0;
		InsuRateState = 0;
		
		alert(stateName);
		*/
	}

	
</script>
</head>
<body id="iframe">
<!-- WRAPPER -->
<div id="wrapper">

	<!-- NAVBAR, SIDEBAR -->
	<c:import url="AdminMainbar.jsp"></c:import>
	
	<!-- MAIN -->
	<div class="main">
		<div class="main-content">
			<div class="container-fluid">
			
				
				<div class="row">
					<!-- 호스트 보험 정보 -->
					<div class="col-md-4">
						<div class="panel panel-headline">
							<div class="panel-heading">
								<div class="row">
									<div class="col-md-12">
										<h3 class="panel-title">호스트 보험</h3>
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
										<span>보험사</span><input id="hostIcompany" value="${hostInsu.icompany }" class="form-control" type="text" readonly="readonly">
										<form>
										    <div class="form-group">
										    	보험 내용
										      <textarea id="hostInsu" class="form-control" rows="15" readonly="readonly" style="resize:none;">${hostInsu.icontent }</textarea>
											    </div>
										</form>
										<button id="hostInsuBtn" type="button" value="${hostInsu.icode }" class="btn btn-default updatebtn" style="width:100%; height: 30px;">수정</button>
									</div>
								</div>
							</div>
						</div>
					</div>
					<!-- END 호스트 보험 -->
					<!-- 게스트 보험 정보 -->
					<div class="col-md-4">
						<div class="panel panel-headline">
							<div class="panel-heading">
								<div class="row">
									<div class="col-md-12">
										<h3 class="panel-title">게스트 보험</h3>
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
										<span>보험사</span>
										<input id="guestIcompany" value="${guestInsu.icompany }" class="form-control" type="text" readonly="readonly">
										<form>
										    <div class="form-group">
										    	보험 내용
										      <textarea id="guestInsu" class="form-control" rows="15" readonly="readonly" style="resize:none;">${guestInsu.icontent }</textarea>
											</div>
										</form>
										<button id="guestInsuBtn" type="button" value="${geustInsu.icode }" class="btn btn-default updatebtn" style="width:100%; height: 30px;">수정</button>
									</div>
								</div>
							</div>
						</div>
					</div>
					<!-- END 호스트 보험 -->
				<!-- 정책 및 이용약관 -->
				<div class="row">
					<div class="col-md-3">
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
										    	호스트 보험 비율(%)<input id="hostInsuRate" class="form-control" type="text" readonly="readonly" value="${hostInsuRate }" style="text-align:center;">
										    	게스트 보험 비율(%)<input id="guestInsuRate" class="form-control" type="text" readonly="readonly" value="${guestInsuRate }" style="text-align:center;">
										    </div>
										  </form>
										  <button id="insuRateBtn" type="button" class="btn btn-default updatebtn" style="width:100%; height: 30px;">수정</button>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- END 정책 및 이용약관 -->
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
