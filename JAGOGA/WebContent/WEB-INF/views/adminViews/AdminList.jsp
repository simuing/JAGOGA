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
	<title>AdminList</title>
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
			// 수정버튼이 눌러서 해당 관리자 수정 요청 (AJAX/JSON)
			$(".updatebtn").click(function()
			{
				// 모달 내부 속성 변경
				$(".modal-title").html("관리자 수정");
				$("#addBtn").html("수정");
				$("input:checkbox").attr("checked", false);
				$("#modalForm").attr("action", "updateadmin.do");
				$("#adminId").attr("readonly", "readonly");
				
				$.post("updateadmininfo.do", {adminCode:$(this).val()}, function(data)
				{
					var obj = JSON.parse(data);
					
					// 해당 입력란에 회원정보로 채워주기
					$("#adminId").val(obj.adminId);
					$("#adminName").val(obj.adminName);
					$("#addBtn").attr("value", obj.adminCode);
					$("[name=atNames]").val(obj.adminAtCodes);
					
					// 가지고 있는 부여권한 체크박스에 체크
					$("[name=addAt]").each(function()
					{
						if ($("[name=atNames]").val().indexOf($(this).val())!=-1)
						{
							$(this).prop("checked", true);
						}
					});
					
				});
				
			});
			
			
			// 모달의 등록 버튼을 눌러서 관리자 등록 요청
			$("#addBtn").click(function()
			{
				// 에러메시지 숨기기
				$("#errMsg").css("display", "none");
				
				// 입력하지 않은 정보가 있으면 안내메시지 출력
				if ($("#adminId").val()=="" || $("#adminName").val()=="" || $("#adminPw").val()=="" || $("#adminAuthority").val()=="")
				{
					$("#errMsg").html("입력하지 않은 정보가 있습니다.");
					$("#errMsg").css("display", "inline");
					return;
				}
				
				// 비밀번호 일치 확인
				if ($("#adminPw").val() != $("#checkPw").val())
				{
					$("#errMsg").html("비밀번호가 일치하지 않습니다.");
					$("#errMsg").css("display", "inline");
					return;
				}
				
				// 등록 과정이라면 아이디 중복검사 수행하고
				// 검사 과정에서 등록 url 요청
				if ($("#addBtn").html("")=="등록") 
				{
					// 아이디 중복 검사 (AJAX)
					var adminId;
					$.post("checkadminid.do", {adminId:$("#adminId").val()}, function(data)
					{
						// ajax 결과 담기
						if (data!=0)
						{
							// 중복이라면 안내 문구 출력
							$("#errMsg").html("이미 등록된 아이디입니다.");
							$("#errMsg").css("display", "inline");
						}
						else if (data==0)
						{
							// 중복된 값이 없으면 서브밋!
							$("#modalForm").submit();
						}
					});
				}
				
				// 등록에 빠지지 않았다면 수정 요청
				// form의 url은 수정버튼이 눌리면 바뀌도록 설정
				$("#modalForm").submit();
			});
			
			
			// 체크박스가 눌리면 부여권한 input 에 해당 값을 바로 넣어주도록 구성
			$("[name=addAt]").click(function()
			{
				// 체크된 개수를 세는 변수
				var count = 0;
				
				// 해당 값이 있으면 (체크가 해제되면) 부여권한 input에서 값 제거
				if ($("#adminAuthority").val().indexOf($(this).val())==-1)
				{
					// 부여권한 input 초기화
					$("#adminAuthority").val("");
					
					// 체크된 값만 부여권한 input에 넣어주기
					$("[name=addAt]:checked").each(function()
					{
						count++;
						// 첫번째라면 ", " 넣지 않기 
						if (count==1)
							$("#adminAuthority").val($("#adminAuthority").val() + $(this).val());
						else
							$("#adminAuthority").val($("#adminAuthority").val() + ", " + $(this).val());
					});
					// 카운트 초기화
					count=0;
				}
				// 위와 동일
				else
				{
					$("#adminAuthority").val("");
					
					$("[name=addAt]:checked").each(function()
					{
						count++;
						if (count==1)
							$("#adminAuthority").val($("#adminAuthority").val() + $(this).val());
						else
							$("#adminAuthority").val($("#adminAuthority").val() + ", " + $(this).val());
					});
					count=0;
				}
			});
			
			
			// 모달을 다시 띄우면 모달내의 값들을 변경 및 초기화
			$(".insertbtn").click(function()
			{
				$("#adminName").val("");
				$("#adminId").val("");
				$("#adminPw").val("");
				$("#checkPw").val("");
				$("#adminAuthority").val("");
				$("[name=addAt]").attr("checked", false);
				
				$(".modal-title").html("관리자 등록");
				$("#addBtn").html("등록");
				$("#modalForm").attr("action", "addAdmin.do");
				$("#adminId").removeAttr("readonly");
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
								<h3 class="panel-title">관리자 계정 목록</h3>
								<div class="right">
									<button type="button" class="btn-toggle-collapse">
										<i class="lnr lnr-chevron-down"></i>
									</button>
								</div>
							</div>
						</div>
					</div>
					<div class="panel-body">
						<table class="table">
							<thead>
								<tr>
									<th>계정코드</th>
									<th>계정이름</th>
									<th>아이디</th>
									<th>권한번호</th>
									<th>관리내용</th>
									<th>수정/삭제</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="adminList" items="${adminList }">
									<tr>
										<td>${adminList.adminCode }</td>
										<td>${adminList.adminName }</td>
										<td>${adminList.adminId }</td>
										<td>${adminList.atCodes }</td>
										<td>${adminList.atNames }</td>
										<td>
											<c:if test="${adminList.adminCode==1 }">
												<button class="btn btn-default updatebtn" value="${adminList.adminCode }" data-toggle="modal" data-target="#adminModal" disabled="disabled">수정</button>
												<button class="btn btn-default deletebtn" disabled="disabled">삭제</button>
											</c:if>
											<c:if test="${adminList.adminCode!=1 }">
												<button class="btn btn-default updatebtn" value="${adminList.adminCode }" data-toggle="modal" data-target="#adminModal">수정</button>
												<a href="changeadminactive.do?adminCode=${adminList.adminCode }&active='N'">
													<button class="btn btn-default deletebtn">삭제</button>
												</a>
											</c:if>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						<button id="addAdminBtn" type="button" class="btn btn-default insertbtn"  data-toggle="modal" data-target="#adminModal">등록</button>
					</div>
				</div>
				<!-- END 관리자계정 목록 -->
				<!-- 권한 목록 -->
				<div class="row">
					<div class="col-md-12">
						<div class="panel panel-headline">
							<div class="panel-heading">
								<div class="row">
									<div class="col-md-12">
										<h3 class="panel-title">권한 목록</h3>
										<div class="right">
											<button type="button" class="btn-toggle-collapse">
												<i class="lnr lnr-chevron-down"></i>
											</button>
										</div>
									</div>
								</div>
							</div>
							<div class="panel-body">
								<table class="table">
									<thead>
										<tr>
											<th>권한코드</th>
											<th>권한이름</th>
											<th>권한내용</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="adminAt" items="${adminAtList }">
											<tr>
												<td>${adminAt.atCode }</td>
												<td>${adminAt.atName }</td>
												<td>${adminAt.atContent }</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
				<!-- END 권한 LIST TABLE -->
			</div>
		</div>
		<!-- END MAIN CONTENT -->
	</div>
	<!-- END MAIN -->
</div>
<!-- END WRAPPER -->



<!-- 관리자 등록 및 수정 모달 -->
<div id="adminModal" class="modal fade">
	<div class="modal-dialog modal-login">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="false">&times;</button>
				<h4 class="modal-title">관리자 등록</h4>
			</div>
			<div class="modal-body">
				<form id="modalForm" action="addAdmin.do" method="post">
					<div class="row">
					<!-- 이름 -->
						<div class="form-group col-md-12" style="margin-bottom: 0px;">
							<div class="form-group col-md-1"></div>
							<div class="form-group col-md-10">
								<div class="col-md-3">계정이름</div>
								<div class="col-md-9">
									<input type="text" class="form-control"  id="adminName" name="adminName">
								</div>
							</div>
							<div class="form-group col-md-1"></div>
						</div>
		 			<!-- END 이름 -->
					
		      		<!-- 아이디 -->
						<div class="form-group col-md-12" style="margin-bottom: 0px;">
							<div class="form-group col-md-1"></div>
							<div class="form-group col-md-10">
								<div class="col-md-3">아이디</div>
								<div class="col-md-9">
									<input name="adminId" type="text" class="form-control"  id="adminId">
								</div>
							</div>
							<div class="form-group col-md-1"></div>
						</div>
		 			<!-- END 아이디 -->
		
					<!-- 패스워드 -->
						<div class="form-group col-md-12" style="margin-bottom: 0px;">
							<div class="form-group col-md-1"></div>
							<div class="form-group col-md-10">
								<div class="col-md-3">비밀번호</div>
								<div class="col-md-4">
									<input id="adminPw" name="adminPw" type="password" class="form-control">
								</div>
								<div class="col-md-1" style="width:30px; font-size: 25px;">&</div>
								<div class="col-md-4"><input id="checkPw" name="checkPw" type="password" class="form-control"></div>
							</div>
						</div>
					<!-- END 패스워드 -->
					
					<!-- 부여권한 -->
						<div class="form-group col-md-12" style="margin-bottom: 0px;">
							<div class="form-group col-md-1"></div>
							<div class="form-group col-md-10">
								<div class="col-md-3">부여권한</div>
								<div class="col-md-9">
									<input id="adminAuthority" name="atNames" type="text" class="form-control" readonly="readonly">
								</div>
							</div>
							<div class="form-group col-md-1"></div>
						</div>
		 			<!-- END 부여권한 -->
		 			
		 			<!-- 권한목록 -->
						<div class="form-group col-md-12" style="margin-bottom: 0px;">
							<div class="form-group col-md-1"></div>
							<div class="form-group col-md-10">
								<div class="col-md-3">권한목록</div>
								<div class="col-md-9">
									<input type="checkbox" name="addAt" class="col-md-1"  value="1" id="chk1"><label for="chk1">관리자계정관리</label>
									<input type="checkbox" name="addAt"  value="2" style="margin-left: 30px;" id="chk2"><label for="chk2">회원관리</label>
								</div>
								<div class="form-group col-md-3"></div>
								<div class="col-md-9">
									<input type="checkbox" name="addAt" class=" col-md-1"  value="3" id="chk3"><label for="chk3">결제관리</label>
									<input type="checkbox" name="addAt"  value="4"  style="margin-left: 72px;" id="chk4"><label for="chk4">고객센터관리</label>
								</div>
								<div class="form-group col-md-3"></div>
								<div class="col-md-9">
									<input type="checkbox" name="addAt" class=" col-md-1"  value="5" id="chk5"><label for="chk5">공지관리</label>
									<input type="checkbox" name="addAt"  value="6"  style="margin-left: 72px;" id="chk6"><label for="chk6">숙소관리</label>
								</div>
								<div class="form-group col-md-3"></div>
								<div class="col-md-9">
									<input type="checkbox" name="addAt" class="col-md-1"  value="7" id="chk7"><label for="chk7">검증관리</label>
									<input type="checkbox" name="addAt"  value="8"  style="margin-left: 72px;" id="chk8"><label for="chk8">보험관리</label>
								</div>
								<div class="form-group col-md-3"></div>
								<div class="col-md-9">
									<input type="checkbox" name="addAt" class="col-md-1"  value="9" id="chk9"><label for="chk9">통계관리</label>
								</div>
							</div>
							<div class="form-group">
								<button id="addBtn" type="button" class="btn btn-primary btn-block btn-lg">등록</button>
							</div>
							<span id="errMsg" style="color: red; margin-left: 180px; display: none;"></span>
						</div>
		 			<!-- END 권한목록 -->
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
<script src="assets/vendor/jquery.easy-pie-chart/jquery.easypiechart.min.js"></script>
<script src="assets/vendor/chartist/js/chartist.min.js"></script>
<script src="assets/scripts/klorofil-common.js"></script>

</body>

</html>
