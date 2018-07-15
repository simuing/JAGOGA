<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% 
	request.setCharacterEncoding("UTF-8"); 
	String cp = request.getContextPath();	
%>
<div class="navbar navbar-default" style="background-color: rgb(0, 135, 163);">
	<div class="container" style="width:100%; height: 24px;">
		<div class="navbar-header">
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a class="navbar-brand mainbar" href="AdminDashboard.jsp">
						<span><img src="assets/img/logo.png" style="width: 20px; height: 20px;">&nbsp;&nbsp;JAGOGA</span>
					</a>
				</li>
			</ul>
		</div>
		<div>
			<ul class="nav navbar-nav navbar-right">
				<li><a class="mainbar"><%-- ${adminId } --%> 접속 중</a></li>
				<li class="dropdown">
					<a href="#" class="glyphicon glyphicon-fire" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"
					style="font-size:20px;"></a>
					<ul class="dropdown-menu" role="menu">
						<li><a href="AdminLogin.jsp">로그아웃</a></li>
					</ul>
				</li>
			</ul>
		</div>
	</div>
</div>


<!-- LEFT SIDEBAR -->
<div id="sidebar-nav" class="sidebar">
	<div class="sidebar-scroll">
		<nav>
			<ul class="nav">
<!-- 				<li><a href="index.jsp" class="active"><i class="lnr lnr-home"></i> <span>대시보드</span></a></li> -->
				<li><a href="AdminDashboard.jsp" class=""><i class="lnr lnr-home"></i> <span>대시보드</span></a></li>
				<li><a href="AdminList.jsp" class=""><i class="lnr lnr-cog"></i> <span>관리자계정관리</span></a></li>
				<li><a href="AdminMember.jsp" class=""><i class="lnr lnr-text-format"></i> <span>회원관리</span></a></li>
				<li><a href="AdminBooking.jsp" class=""><i class="lnr lnr-code"></i> <span>결제관리</span></a></li>
				<li><a href="AdminQuestion.jsp" class=""><i class="lnr lnr-file-empty"></i> <span>고객센터관리</span></a></li>
				<li><a href="AdminNotice.jsp" class=""><i class="lnr lnr-alarm"></i> <span>공지관리</span></a></li>
				<li><a href="AdminRoom.jsp" class=""><i class="lnr lnr-dice"></i> <span>숙소관리</span></a></li>
				<li><a href="AdminVerfication.jsp" class=""><i class="lnr lnr-linearicons"></i> <span>검증관리</span></a></li>
				<li><a href="AdminInsurance.jsp" class=""><i class="lnr lnr-file-empty"></i> <span>보험관리</span></a></li>
				<li><a href="AdminStatistics.jsp" class=""><i class="lnr lnr-chart-bars"></i> <span>통계관리</span></a></li>
			</ul>
		</nav>
	</div>
</div>