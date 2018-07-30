<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% 
	request.setCharacterEncoding("UTF-8"); 
	String cp = request.getContextPath();	
%>
<div class="navbar navbar-default" style="background-color: rgb(0, 135, 163);">
	<div class="container" style="width:100%; height: 24px; background-color: rgb(0, 135, 163);">
		<div class="navbar-header">
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a class="navbar-brand mainbar" href="#" onclick="dashboard()">
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
						<li><a href="adminlogout.do">로그아웃</a></li>
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
				<li><a href="dashboard.do" class=""><i class="lnr lnr-home"></i> <span>대시보드</span></a></li>
				<% if (session.getAttribute("authority").toString().indexOf("1")!=-1) { %>
					<li><a href="adminlist.do" class=""><i class="lnr lnr-cog"></i> <span>관리자계정관리</span></a></li>
				<%
				}
				if (session.getAttribute("authority").toString().indexOf("2")!=-1) {%>
					<li><a href="amemberlist.do" class=""><i class="lnr lnr-user"></i> <span>회원관리</span></a></li>
				<%
				}
				if (session.getAttribute("authority").toString().indexOf("3")!=-1) {%>
					<li><a href="adminbooking.do" class=""><i class="lnr lnr-code"></i> <span>결제관리</span></a></li>
				<%
				}
				if (session.getAttribute("authority").toString().indexOf("4")!=-1) {%>
					<li><a href="adminquestion.do" class=""><i class="lnr lnr-file-empty"></i> <span>고객센터관리</span></a></li>
				<%
				}
				if (session.getAttribute("authority").toString().indexOf("5")!=-1) {%>
					<li><a href="adminnotice.do" class=""><i class="lnr lnr-alarm"></i> <span>공지관리</span></a></li>
				<%
				}
				if (session.getAttribute("authority").toString().indexOf("6")!=-1) {%>
					<li><a href="adminroom.do" class=""><i class="lnr lnr-home"></i> <span>숙소관리</span></a></li>
				<%
				}
				if (session.getAttribute("authority").toString().indexOf("7")!=-1) {%>
					<li><a href="adminverification.do" class=""><i class="lnr lnr-linearicons"></i> <span>검증관리</span></a></li>
				<%
				}
				if (session.getAttribute("authority").toString().indexOf("8")!=-1) {%>
					<li><a href="admininsurance.do" class=""><i class="lnr lnr-bookmark"></i> <span>보험관리</span></a></li>
				<%
				}
				if (session.getAttribute("authority").toString().indexOf("9")!=-1) {%>
					<li><a href="adminstatistics.do" class=""><i class="lnr lnr-chart-bars"></i> <span>통계관리</span></a></li>
				<%
				} %>
			</ul>
		</nav>
	</div>
</div>