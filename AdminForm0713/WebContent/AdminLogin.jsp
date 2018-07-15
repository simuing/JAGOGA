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
						<form class="form-auth-small" action="AdminDashboard.jsp">
							<div class="form-group">
								<label for="adminId" class="control-label sr-only">id</label>
								<input type="text" class="form-control" id="adminId" placeholder="아이디를 입력하세요.">
							</div>
							<div class="form-group">
								<label for="adminPw" class="control-label sr-only">password</label>
								<input type="password" class="form-control" id="adminPw"  placeholder="패스워드를 입력하세요.">
							</div>
							<button type="submit" class="btn btn-primary btn-lg btn-block">LOGIN</button>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- END WRAPPER -->
	
	
</body>

</html>
