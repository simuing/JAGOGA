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
	<!-- jquery -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	
	
<script type="text/javascript">

	$(function()
	{
		// 검증번호를 가지고 있을 전역변수
		var reqvCode = 0;
		// 검증상태를 가지고 있을 전역변수
		var verificationState;
		
		// 검증 중 또는 검증대기 버튼을 누르면 리스트 아래에 해당 정보 띄워주기 (AJAX)
		$(".verifybtn").click(function()
		{
			// 버튼을 클릭해야 해당 정보 보이도록 설정
			$("#verificationInfo").css("display", "inline");
			
			// 검증등급에 따라 안내문구 다르게 출력
			if ($("#"+$(this).val()).html()=="A")
			{
				$(".gradestate").html("B → A");
			}
			else if ($("#"+$(this).val()).html()=="B")
			{
				$(".gradestate").html("C → B");
			}
			
			// 검증 첨부파일을 가져오는 AJAX
			$.post("verifyattach.do", {reqvCode:$(this).val()}, function(data)
			{
				$(".vfile").html("호스트 제출 서류 : <a href='vattachdownload.do?verificationAttach=" +data.substring(113)+ "'>" + data.substring(113) + "</a>");
				
			});
			
			// 검증 상태에 따라 처리할 수 있는 버튼 동적으로 뿌려주기
			if ($(this).html()=="검증 중")
			{
				// 검증시작 버튼의 id 값 변경!!!
				$("#verificationStart").attr("id", "verificationComplete");
				
				$("#verificationComplete").html("검증완료");
				$("#verificationComplete").css("width", "49%");
				$("#verificationFail").css("display", "inline");
				$("#vcause").css("display", "inline");
				$("#attachMsg").css("display", "inline");
				
				verifircationState="ing";
			}
			else if ($(this).html()=="검증대기")
			{
				// 검증시작 버튼의 id 값 변경!!!
				$("#verificationComplete").attr("id", "verificationStart");
			
				$("#verificationStart").html("검증시작");
				$("#verificationStart").css("width", "100%");
				$("#verificationFail").css("display", "none");
				$("#vcause").css("display", "none");
				
				verifircationState="wating";
			}
			
			// 검증번호 변수에 해당 번호 담기
			reqvCode = $(this).val();
			
		});
		
		
		// 검증 시작버튼을 누르면
		$("#verificationStart").click(function()
		{
			$("#errMsg").css("display", "none");
			
			// 관리자 아이디를 입력했는지 확인
			if ($("#adminId").val()=="")
			{
				$("#errMsg").css("display", "inline");
			}
			else
			{
				// 관리자 아이디 유효한지 확인
				if ($("#adminId").val()=="<%=session.getAttribute("adminId") %>")
				{
					// "검증 중" 일 경우 검증 사유 입력했는지 확인
					if (verifircationState=="ing")
					{
						// 검증사유를 입력하지 않았다면
						if ($("#vcause").val()=="")
						{
							$("#errMsg").html("검증사유를 입력해주세요.");
							$("#errMsg").css("display", "inline");
						}
						else // 사유까지 정상적으로 입력했으면
						{
							var vafterGrade = $(".gradestate").html().substring(4);
							alert(vafterGrade);
							// vState : 검증결과
							$(location).attr("href", "verificationcomplete.do?reqvCode="+reqvCode +"&vsCode=1&vcause="+$("#vcause").val().replace(/\n/g, "<br>") +"&vafterGrade=" + vafterGrade);
						}
					}
					else // "검증대기일 경우"
					{
						$(location).attr("href", "verificationstart.do?reqvCode="+reqvCode);
					}
					
				}
				else
				{
					$("#errMsg").html("입력하신 아이디와 로그인한 아이디가 일치하지 않습니다.");
					$("#errMsg").css("display", "inline");
				}
			}
			
		});
		
		
		// 검증 완료버튼을 누르면
		$("#verificationFail").click(function()
		{
			// 검증사유를 입력하지 않았다면
			if ($("#vcause").val()=="")
			{
				$("#errMsg").html("검증사유를 입력해주세요.");
				$("#errMsg").css("display", "inline");
			}
			else // 사유까지 정상적으로 입력했으면
			{
				var vafterGrade = $(".gradestate").html().substring(0,1);
				
				// vState : 검증결과
				$(location).attr("href", "verificationcomplete.do?reqvCode="+reqvCode +"&vsCode=2&vcause="+$("#vcause").val().replace(/\n/g, "<br>") +"&vafterGrade=" + vafterGrade);
			}
		});
		
		
		// 검증사유를 클릭하면 수행
		$(".cause").click(function()
		{
			// Ajax 요청 및 응답 처리
			$.post("verifycause.do", {vcode:$(this).val()}, function(data)
			{
				// 모달에 사유 입력
				$("#modal-body-content").html(data);
			});
			
			// 모달 띄우기
			$("#causeModal").modal("show");
		});
		
		
		
		
	});

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
					
						<!-- 검색영역 -->
						<!-- 
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
					                <span style="float: right;">※ 탈퇴회원은 아이디가 회원코드로 표시됩니다.</span>
					            </div>
					        </div>
						</div>
						 -->
						<span style="float: right;">※ 탈퇴회원은 아이디가 회원코드로 표시됩니다.</span>
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
									<th>사유</th>
									<th>관리자아이디</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="verification" items="${verificationList }">
									<tr>
										<td>${verification.reqvCode }</td>
										<td>${verification.rcode }</td>
										<td id="${verification.reqvCode }">
											<c:if test="${verification.vsContent=='검증완료'}">
												<c:if test="${verification.vafterGrade=='A' }">
													B
												</c:if>
												<c:if test="${verification.vafterGrade=='B' }">
													C
												</c:if>
											</c:if>
											<c:if test="${verification.vsContent!='검증완료'}">
												${verification.vafterGrade}
											</c:if>
										</td>
										<td>
											<c:if test="${verification.vsContent=='검증완료' }">
												${verification.effectiveDate }
											</c:if>
											<c:if test="${verification.vsContent!='검증완료' }">
												-
											</c:if>
										</td>
										<td>${verification.rtype }</td>
										<td>${verification.memId }</td>
										<td>${verification.rname }</td>
										<td>${verification.rregDate }</td>
										<td>
											<c:if test="${verification.vsContent=='검증실패' || verification.vsContent=='검증완료' }">
												<button type="button" value="${verification.reqvCode }" class="btn btn-default updatebtn" disabled="disabled">${verification.vsContent }</button>
											</c:if>
											<c:if test="${verification.vsContent=='검증 중' }">
												<button type="button" value="${verification.reqvCode }" class="btn btn-default updatebtn verifybtn">${verification.vsContent }</button>
											</c:if>
											<c:if test="${verification.vsContent=='검증대기' }">
												<button type="button" value="${verification.reqvCode }" class="btn btn-default updatebtn verifybtn">${verification.vsContent }</button>
											</c:if>
										</td>
										<td>
											<c:if test="${verification.vsContent=='검증실패' || verification.vsContent=='검증완료' }">
												<c:if test="${verification.vsContent=='검증실패' }">
													<button type="button" value="${verification.vcode }" class="btn btn-default updatebtn cause" style="background-color: #ff4d4d;">검증사유</button>
												</c:if>
												<c:if test="${verification.vsContent=='검증완료' }">
													<button type="button" value="${verification.vcode }" class="btn btn-default updatebtn cause">검증사유</button>
												</c:if>
											</c:if>
											<c:if test="${verification.vsContent=='검증 중' || verification.vsContent=='검증대기' }">
												<button type="button" value="${verification.vcode }" class="btn btn-default updatebtn" disabled="disabled">검증사유</button>
											</c:if>
										</td>
										<td>${verification.adminId }</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						<div>
							<c:if test="${pageNumber != 1 }">
								<a href="adminverification.do?pageNumber=${pageNumber-1 }"><button class="btn btn-primary">이전</button></a>
							</c:if>
							<!-- 원래는 되어야 한다. -->
							<a href="adminverification.do?pageNumber=${pageNumber+1 }"><button class="btn btn-primary">다음</button></a>
						</div>
					</div>
				</div>
				<!-- END 숙소목록 -->
				
				<!-- 검증대기 페이지출력 -->
				<div id="verificationInfo" style="display: none;">
					<div class="panel panel-headline">
						<div class="panel-heading">
							<div class="row">
								<div class="col-md-12">
									<h3 class="panel-title">검증 내용 조회</h3>
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
									<p class="gradestate"></p>
									<p class="vfile">호스트 제출 서류 </p>
									<p id="errMsg" style="color: red; font-size: 13px; display: none;">관리자 아이디를 입력해주세요.</p>
									<input id="adminId" class="form-control" type="text" placeholder="검증을 시작할 관리자아이디를 입력하세요." style="text-align:center;"><br>
									<textarea id="vcause" class="form-control" placeholder="검증사유를 입력해주세요." style="text-align:center; display: none;" onkeyup="test()"></textarea><br>
									<button id="verificationStart" type="button"  class="btn btn-default updatebtn" style="width:100%; height: 50px; font-size:20px;">검증시작</button>
									<button id="verificationFail" type="button"  class="btn btn-default updatebtn" style="width:49%; height: 50px; background-color: #ff4d4d; font-size:20px; display: none;">검증실패</button>
									<br><br><p id="attachMsg" style="display: none;">※ 제출 서류를 모두 확인하였습니다.</p>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- 검증대기 페이지출력 -->
				
			</div>
		</div>
	</div>
	<!-- END MAIN -->
</div>
<!-- END WRAPPER -->


<!-- 검증사유 모달 -->
<div id="causeModal" class="modal fade" role="dialog">
	<div class="modal-dialog">

		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">검증사유</h4>
			</div>
			<div class="modal-body">
				<span id=modal-body-content></span>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>




<!-- Javascript -->
<script src="assets/vendor/jquery/jquery.min.js"></script>
<script src="assets/vendor/bootstrap/js/bootstrap.min.js"></script>
<script src="assets/vendor/jquery-slimscroll/jquery.slimscroll.min.js"></script>
<script src="assets/vendor/jquery.easy-pie-chart/jquery.easypiechart.min.js"></script>
<script src="assets/vendor/chartist/js/chartist.min.js"></script>
<script src="assets/scripts/klorofil-common.js"></script>

</body>

</html>
