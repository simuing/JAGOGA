<%@ page contentType="text/html; charset=UTF-8"%>
<div class="navbar navbar-default">
	<div class="container">
		<div class="navbar-header">
			<a class="navbar-brand" href="main.do">
				<span><img src="memberAssets/img/logo.png" style="width: 20px; height: 20px;">&nbsp;&nbsp;JAGOGA</span>
			</a>
		</div>
		<div>
			<ul class="nav navbar-nav navbar-right">
				<li>
					<a href="#">${name } 님! 안녕하세요~!!!</a>
				</li>
				<li class="dropdown">
					<a href="#" class="glyphicon glyphicon-user dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"></a>
					<ul class="dropdown-menu" role="menu">
						<li><a href="trymyinfo.do">내 정보</a></li>
						<li><a href="myroomlist.do">셰어하우스 관리</a></li>
						<li><a href="bookinglist.do">내가 예약한 숙소</a></li>
						<li><a href="likelist.do">찜한 숙소</a></li>
						<li><a href="noticelist.do">공지사항</a></li>
						<li><a href="reminderlist.do">알림</a></li>
						<li><a href="logout.do">로그아웃</a></li>
					</ul>
				</li>
			</ul>
		</div>
	</div>
</div>