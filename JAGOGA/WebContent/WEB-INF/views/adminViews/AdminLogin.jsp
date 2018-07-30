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
<html lang="en" class="fullscreen-bg">

<head>
	<title>JAGOGA Admin login</title>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
	<!-- VENDOR CSS -->
	<link rel="stylesheet" href="assets/css/bootstrap.css">
	<link rel="stylesheet" href="assets/vendor/font-awesome/css/font-awesome.min.css">
	<link rel="stylesheet" href="assets/vendor/linearicons/style.css">
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
			// 유효성 검사 후 서브밋 수행
			$(".btn-lg").click(function()
			{
				// 에러메시지 감추기
				$("#errMsg").css("display", "none");
				
				// 아이디를 입력하지 않았을 경우 안내메시지 출력
				if ($("[name=adminId]").val()=="")
				{
					$("#errMsg").html("아이디를 입력해주세요.");
					$("#errMsg").css("display", "inline");
					$("#errMsg").css("margin-left", "100px");
				}
				// 비밀번호를 입력하지 않았을 경우 안내메시지 출력
				else if ($("[name=adminPw]").val()=="")
				{
					$("#errMsg").html("비밀번호를 입력해주세요.");
					$("#errMsg").css("display", "inline");
					$("#errMsg").css("margin-left", "90px");
				}
				// 모두 입력 했을 경우
				else
				{
					// 아이디와 비밀번호가 일치하는지 AJAX처리하여 확인
					$.post("checkadmin.do", {adminId:$("[name=adminId]").val(), adminPw:$("[name=adminPw]").val()}, function(data)
					{
						// 일치하지 않다면 안내메시지 출력
						if (data.indexOf('Y')==-1 && data.indexOf('N')==-1)
						{
							$("#errMsg").html("아이디 또는 비밀번호가 정확하지 않습니다.");
							$("#errMsg").css("display", "inline");
							$("#errMsg").css("margin-left", "50px");
						}
						// 일치하면 계정 활성화 검사
						else
						{
							if (data.indexOf('Y')!=-1)
							{
								$("form").submit();
							}
							// 삭제된 계정이라면 안내메시지 출력
							else
							{
								$("#errMsg").html("삭제된 계정입니다.");
								$("#errMsg").css("display", "inline");
								$("#errMsg").css("margin-left", "130px");
							}
						}
						
					})
				}
			});
		});
		
	</script>
	
</head>

<body>
	<div class="navbar navbar-default" style="background-color: rgb(0, 135, 163);">
		<div class="container" style="background-color: rgb(0, 135, 163);">
			<div class="navbar-header">
				<a class="navbar-brand" href="#">
					<span><img src="assets/img/logo.png" style="width: 20px; height: 20px;">&nbsp;&nbsp;JAGOGA</span>
				</a>
			</div>
			<div>
				<ul class="nav navbar-nav navbar-right">
					<li class="dropdown">
						<a>로그인이 필요합니다.</a>
					</li>
				</ul>
			</div>
		</div>
	</div>
	
	<!-- WRAPPER -->
	<div id="wrapper">
		<div class="vertical-align-wrap">
			<div class="vertical-align-middle">
				<div class="login-box">
					<div class="login-input">
						<div class="header">
							<div class="logo text-center">
								<span class="login-title">관리자 계정 로그인</span>
							</div>
							<div class="br"></div>
						</div>
						<!-- form -->
						<form class="form-auth-small" action="adminlogin.do" method="post">
							<div class="form-group">
								<label for="adminId" class="control-label sr-only">id</label>
								<input type="text" class="form-control" name="adminId" placeholder="아이디를 입력하세요.">
							</div>
							<div class="form-group">
								<label for="adminPw" class="control-label sr-only">password</label>
								<input type="password" class="form-control" name="adminPw"  placeholder="패스워드를 입력하세요.">
							</div>
							<button type="button" class="btn btn-primary btn-lg btn-block">LOGIN</button><br>
							<span id="errMsg" style="color: red; display: none;"></span>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- END WRAPPER -->
	
	
</body>



</html>
