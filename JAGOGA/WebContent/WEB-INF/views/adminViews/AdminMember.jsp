<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
<!-- VENDOR CSS -->
<link rel="stylesheet" href="assets/vendor/bootstrap/css/bootstrap.css">
<link rel="stylesheet"
	href="assets/vendor/font-awesome/css/font-awesome.min.css">
<link rel="stylesheet" href="assets/vendor/linearicons/style.css">
<link rel="stylesheet"
	href="assets/vendor/chartist/css/chartist-custom.css">
<!-- MAIN CSS -->
<link rel="stylesheet" href="assets/css/main.css">
<link rel="stylesheet" href="assets/css/admin.css">
<!-- GOOGLE FONTS -->
<link
	href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700"
	rel="stylesheet">
<!-- ICONS -->
<link rel="apple-touch-icon" sizes="76x76"
	href="assets/img/apple-icon.png">
<link rel="icon" type="image/png" sizes="96x96"
	href="assets/img/favicon.png">
<!-- jquery -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>


<script type="text/javascript">
	$(function()
	{
		$("#search").click(function()
		{
			// 아무것도 입력하지 않고 검색했을 경우 전체 리스트 조회!
			if ($("#keyword").val() == "")
			{
				$(location).attr("href", "amemberlist.do");
				return;
			}

			// 검색어를 입력해서 검색했을 경우 해당 url 요청
			$(location).attr("href", "amembersearch.do?" + $("#select").val() + "=" + $("#keyword").val());
		});

		
		// 수정버튼을 누르면 에이잭스로 모달의 입력란 채우기
		$(".updateMemInfo").click(function()
		{
			// 모달 입력란 초기화
			$("#errMsg").attr("display", "none");
			$("#errMsg").html("");
			$("#blockCause").val("");
			$("#adminId").val("");
			
			// 에이쟉스로 회원정보 모달에 뿌려주기
			$.post("memberinfo.do", {memCode : $(this).val()}, function(data)
			{
				// 제이슨 이용^^
				var obj = JSON.parse(data);

				$("#memCode").val(obj.memCode);
				$("#memId").val(obj.memId);
				$("#memSsn").val(obj.memSsn);
				$("#memTel").val(obj.memTel);
				$("#memName").val(obj.memName);
				$("#memEtiquette").val(obj.memEtiquette);
				$("#memEmail").val(obj.memEmail);
			});
			
		});
		
		
		// 모달의 수정 버튼을 눌르면 수행
		$("#modifyBtn").click(function()
		{
			// 에티켓 점수를 입력하지 않았으면 안내문구 출력
			if ($("#memEtiquette").val()=="")
			{
				$("#errMsg").html("에티켓점수를 입력해주세요.");
				$("#errMsg").css("margin-left", "180px");
				$("#errMsg").css("display", "inline");
			}
			else
			{
				// 폼액션 속성 바꿔서 서브밋
				$("#modalForm").attr("action", "updatememinfo.do");
				$("#modalForm").submit();
			}
		});
		
		// 영구 정지 시키기
		$("#blockBtn").click(function()
		{
			// 사유 또는 관리자 입력란이 비어있을 경우 안내메시지 출력
			if ($("#blockCause").val()=="" || $("#adminId").val()=="")
			{
				$("#errMsg").html("사유 또는 관리자를 입력하지 않았습니다.");
				$("#errMsg").css("margin-left", "140px");
				$("#errMsg").css("display", "inline");
			}
			// 모두 입력했다면 다음 프로세스 진행
			else
			{
				// 입력한 관리자가 현재 로그인한 관리자인지 확인
				if ($("#adminId").val()!="<%=session.getAttribute("adminId")%>")
				{
					$("#errMsg").html("입력한 관리자와 로그인한 관리자가 일치하지 않습니다.");
					$("#errMsg").css("margin-left", "110px");
					$("#errMsg").css("display", "inline");
				}
				else
				{
					// 개행 및 폼액션 속성 바꿔서 서브밋
					$("#blockCause").val($("#blockCause").val().replace(/\n/g, "<br>"));
					$("#modalForm").attr("action", "blockmember.do");
					$("#modalForm").submit();
				}
			}
		});
		
		
		
		// 영구정지 사유 및 처리자 조회
		$(".restoreB").click(function()
		{
			// 복구 버튼 value 값에 멤버코드 담기
			$("#restoreBtn").attr("value", $(this).val());
			
			// 에이잭스로 사유 및 처리자 모달에 뿌려주기
			$.post("checkblockcause.do", {memCode : $(this).val()}, function(data)
			{
				// 제이슨 이용^^
				var obj = JSON.parse(data);

				$("#bfBlockCause").val(obj.blockCause);
				$("#bfAdminId").html("처리자 : " + obj.adminId);
			});
		});
		
		
		// 영구정지 회원 복구
		$("#restoreBtn").click(function()
		{
			$(location).attr("href", "restoreblock.do?memCode="+$(this).val());
		});
		
		
		// 탈퇴회원 복구
		$(".restoreL").click(function()
		{
			if (confirm("이 탈퇴계정을 정말 복구하시겠습니까?"))
			{
				$(location).attr("href", "restoreleave.do?memCode="+$(this).val());
			}
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
											<!-- 
                                   <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
                                      <span id="search_concept">전체회원</span> <span class="caret"></span>
                                   </button>
                                    -->
											<!--
                                   <ul class="dropdown-menu" role="menu">
                                     <li><a href="#memCode">회원코드</a></li>
                                     <li><a href="#memId">아이디</a></li>
                                     <li><a href="#memTel">휴대폰번호</a></li>
                                   </ul>
                                    -->
											<select id="select" style="width: 100px; height: 32px;">
												<option value="memId" selected="selected">아이디</option>
												<option value="memCode">회원코드</option>
												<option value="memTel">전화번호</option>
											</select>

										</div>
										<input type="hidden" name="search_param" value="all" id="search_param">
										<input type="text" class="form-control" id="keyword" placeholder="Search..." value="${searchWord }">
										<span class="input-group-btn">
											<button id="search" class="btn btn-default" type="button">
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
									<!-- 검색결과했을 경우 검색한 객체가 넘어와 뿌려지지만 -->
									<!-- 검색하지 않으면 검색 객체가 없어 실행하지 않음 -->
									<c:forEach var="aMemberSearch" items="${aMemberSearch }">
										<tr>
											<td>${aMemberSearch.memCode }</td>
											<td>${aMemberSearch.memId }</td>
											<td>${aMemberSearch.memName }</td>
											<td>${aMemberSearch.memSsn }</td>
											<td>${aMemberSearch.memTel }</td>
											<td>${aMemberSearch.memEmail }</td>
											<td>${aMemberSearch.memEtiquette }</td>
											<td>
												<a href="memberprofiledownload.do?memProfile=${fn:substringAfter(aMemberSearch.memProfile, 'memberProfile/') }">
													${fn:substringAfter(aMemberSearch.memProfile, 'memberProfile/') }
												</a>
											</td>
											<td>${aMemberSearch.memJoinDate }</td>
											<td><c:if test="${aMemberSearch.status=='회원탈퇴' }">
													<button type="button" class="btn btn-default updatebtn" disabled="disabled">수정</button>
													<button type="button" class="btn btn-default deletebtn" disabled="disabled">삭제</button>
												</c:if> <c:if test="${aMemberSearch.status!='회원탈퇴' }">
													<a href="amemberdelete.do?memCode=${aMemberList.memCode }">
														<button id="updateMemInfo" type="button" value="${aMemberList.memCode }" type="button" class="btn btn-default updatebtn" data-toggle="modal" data-target="#modifyMemInfo">수정</button>
														<button type="button" class="btn btn-default deletebtn">삭제</button>
													</a>
												</c:if></td>
											<td>${aMemberSearch.status }</td>
											<td>${aMemberSearch.adminId }</td>
										</tr>
									</c:forEach>

									<!-- 검색했을 경우엔 전체 리스트 객체를 받아오지 않기 때문에 -->
									<!-- 뿌려지지 않음 -->
									<c:forEach var="aMemberList" items="${aMemberList }">
										<tr>
											<td>${aMemberList.memCode }</td>
											<td>${aMemberList.memId }</td>
											<td>${aMemberList.memName }</td>
											<td>${aMemberList.memSsn }</td>
											<td>${aMemberList.memTel }</td>
											<td>${aMemberList.memEmail }</td>
											<td>${aMemberList.memEtiquette }</td>
											<td><a
												href="memberprofiledownload.do?memProfile=${fn:substringAfter(aMemberList.memProfile, 'memberProfile/') }">
													${fn:substringAfter(aMemberList.memProfile, 'memberProfile/') }
											</a></td>
											<td>${aMemberList.memJoinDate }</td>
											<td>
												<c:if test="${aMemberList.status=='회원탈퇴' }">
														<button type="button" value="${aMemberList.memCode }" class="btn btn-default updatebtn restoreL" style="background-color: #ff4d4d;">복구</button>
												</c:if>
												<c:if test="${aMemberList.status=='영구정지' }">
													<button type="button" value="${aMemberList.memCode }" class="btn btn-default updatebtn restoreB" style="background-color: #ff4d4d;" data-toggle="modal" data-target="#blockCauseModal">복구</button>
													<a href="amemberdelete.do?memCode=${aMemberList.memCode }">
														<button type="button" class="btn btn-default deletebtn" style="background-color: #ff4d4d;">삭제</button> </a>
												</c:if>
												<c:if test="${aMemberList.status!='영구정지' && aMemberList.status!='회원탈퇴' }">
													<button type="button" value="${aMemberList.memCode }" class="btn btn-default updatebtn updateMemInfo" data-toggle="modal" data-target="#modifyMemInfo">수정</button>
													<a href="amemberdelete.do?memCode=${aMemberList.memCode }">
														<button type="button" class="btn btn-default deletebtn">삭제</button> </a>
												</c:if>
											</td>
											<td>${aMemberList.status }</td>
											<td>${aMemberList.adminId }</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
							<div>
								<c:if test="${pageNumber != 1 }">
									<a href="amemberlist.do?pageNumber=${pageNumber-1 }"><button class="btn btn-primary">이전</button></a>
								</c:if>
								<!-- 원래는 되어야 한다. -->
								<a href="amemberlist.do?pageNumber=${pageNumber+1 }"><button class="btn btn-primary">다음</button></a>
							</div>
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
									<br> <img alt="membergrade.jpg" src="assets/img/membergrade.png" style="width: 100%;"> <br>
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




	<!-- 회원정보 수정 모달 -->
	<div id="modifyMemInfo" class="modal fade">
		<div class="modal-dialog modal-login">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="false">&times;</button>
					<h4 class="modal-title">회원정보 수정</h4>
				</div>
				<div class="modal-body">
					<form id="modalForm" action="updatememinfo.do" method="post">
						<div class="row">


							<!-- 회원번호 -->
							<div class="form-group col-md-12" style="margin-bottom: 0px;">
								<div class="form-group col-md-1"></div>
								<div class="form-group col-md-10">
									<div class="col-md-3">회원번호</div>
									<div class="col-md-9">
										<input type="text" class="form-control" id="memCode" name="memCode" readonly="readonly">
									</div>
								</div>
								<div class="form-group col-md-1"></div>
							</div>
							<!-- END 회원번호 -->

							<!-- 아이디 -->
							<div class="form-group col-md-12" style="margin-bottom: 0px;">
								<div class="form-group col-md-1"></div>
								<div class="form-group col-md-10">
									<div class="col-md-3">아이디</div>
									<div class="col-md-9">
										<input type="text" class="form-control" id="memId" name="memId" readonly="readonly">
									</div>
								</div>
								<div class="form-group col-md-1"></div>
							</div>
							<!-- END 아이디 -->

							<!-- 이름 -->
							<div class="form-group col-md-12" style="margin-bottom: 0px;">
								<div class="form-group col-md-1"></div>
								<div class="form-group col-md-10">
									<div class="col-md-3">이 름</div>
									<div class="col-md-9">
										<input type="text" class="form-control" id="memName" name="memName" readonly="readonly">
									</div>
								</div>
								<div class="form-group col-md-1"></div>
							</div>
							<!-- END 이름 -->

							<!-- 주민번호 -->
							<div class="form-group col-md-12" style="margin-bottom: 0px;">
								<div class="form-group col-md-1"></div>
								<div class="form-group col-md-10">
									<div class="col-md-3">주민번호</div>
									<div class="col-md-4">
										<input id="memSsn" name="memSsn" class="form-control" readonly="readonly">
									</div>
								</div>
							</div>
							<!-- END 주민번호 -->

							<!-- 핸드폰번호 -->
							<div class="form-group col-md-12" style="margin-bottom: 0px;">
								<div class="form-group col-md-1"></div>
								<div class="form-group col-md-10">
									<div class="col-md-3">전화번호</div>
									<div class="col-md-9">
										<input id="memTel" name="memTel" type="text" class="form-control" readonly="readonly">
									</div>
								</div>
								<div class="form-group col-md-1"></div>
							</div>
							<!-- END 핸드폰번호 -->

							<!-- 이메일 -->
							<div class="form-group col-md-12" style="margin-bottom: 0px;">
								<div class="form-group col-md-1"></div>
								<div class="form-group col-md-10">
									<div class="col-md-3">이 메 일</div>
									<div class="col-md-9">
										<input type="text" class="form-control" id="memEmail" name="memEmail">
									</div>
								</div>
								<div class="form-group col-md-1"></div>
							</div>
							<!-- END 이메일 -->

							<!-- 에티켓 -->
							<div class="form-group col-md-12" style="margin-bottom: 0px;">
								<div class="form-group col-md-1"></div>
								<div class="form-group col-md-10">
									<div class="col-md-3">에 티 켓</div>
									<div class="col-md-9">
										<input type="text" class="form-control" id="memEtiquette" name="memEtiquette">
									</div>
								</div>
								<div class="form-group col-md-1"></div>
							</div>
							<!-- END 에티켓 -->

							<!-- 사유입력 -->
							<div class="form-group col-md-12" style="margin-bottom: 0px;">
								<div class="form-group col-md-1"></div>
								<div class="form-group col-md-10">
									<div class="col-md-3">사유<br>(영구정지)</div>
									<div class="col-md-9">
										<textarea class="form-control" id="blockCause" name="blockCause" style="height: 150px;"></textarea>
									</div>
								</div>
								<div class="form-group col-md-1"></div>
							</div>
							<!-- END 사유입력 -->

							<!-- 관리자 아이디 -->
							<div class="form-group col-md-12" style="margin-bottom: 0px;">
								<div class="form-group col-md-1"></div>
								<div class="form-group col-md-10">
									<div class="col-md-3">관리자<br>(영구정지)</div>
									<div class="col-md-9">
										<input type="text" class="form-control" id="adminId" name="adminId">
									</div>
								</div>
								<div class="form-group col-md-12">
									<span id="errMsg" style="color: red; display: none;"></span>
								</div>
								
								<!-- END 관리자 아이디 -->
								<div class="form-group">
									<div class="col-md-12">
										<div class="col-md-4">
											<button id="blockBtn" type="button" class="btn btn-primary btn-block" style="background-color: #ff4d4d;">영구정지</button>
										</div>
										<div class="col-md-4">
											<button id="modifyBtn" type="button" class="btn btn-primary btn-block">수정</button>
										</div>
										<div class="col-md-4">
											<button type="button" class="btn btn-primary btn-block" data-dismiss="modal">취소</button>
										</div>
									</div>
								</div>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>



	<!-- 사유조회 모달 -->
	<div id="blockCauseModal" class="modal fade">
		<div class="modal-dialog modal-login">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="false">&times;</button>
					<h4 class="modal-title">영구정지 사유</h4>
				</div>
				<div class="modal-body">
					<form id="blockCauseModalForm" action="unblockmember.do" method="post">
						<div class="row">

							<!-- 사유입력 -->
							<div class="form-group col-md-12" style="margin-bottom: 0px;">
								<div class="form-group col-md-1"></div>
								<div class="form-group col-md-10">
									<div class="col-md-12">
										<textarea class="form-control" id="bfBlockCause" style="height: 150px;" readonly="readonly"></textarea>
									</div>
								</div>
								<div class="form-group col-md-1"></div>
							</div>
							<!-- END 사유입력 -->

							<!-- 관리자 아이디 -->
							<div class="form-group col-md-12" style="margin-bottom: 0px;">
								<div class="form-group col-md-1"></div>
								<div class="form-group col-md-10">
									<div class="col-md-4"></div>
									<div class="col-md-8"><h4 id="bfAdminId">처리자 : </h4></div>
								</div>
							</div>
							<div class="form-group col-md-12" style="margin-bottom: 0px;">
								<div class="form-group">
									<div class="col-md-12">
										<div class="col-md-6">
											<button id="restoreBtn" type="button" class="btn btn-primary btn-block">복구</button>
										</div>
										<div class="col-md-6">
											<button type="button" class="btn btn-primary btn-block" data-dismiss="modal">취소</button>
										</div>
									</div>
								</div>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	
	




	<!-- Javascript -->
	<script src="assets/vendor/jquery/jquery.min.js"></script>
	<script src="assets/vendor/bootstrap/js/bootstrap.min.js"></script>
	<script src="assets/vendor/jquery-slimscroll/jquery.slimscroll.min.js"></script>
	<script
		src="assets/vendor/jquery.easy-pie-chart/jquery.easypiechart.min.js"></script>
	<script src="assets/vendor/chartist/js/chartist.min.js"></script>
	<script src="assets/scripts/klorofil-common.js"></script>

</body>

</html>