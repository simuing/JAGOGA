<%@ page contentType="text/html; charset=UTF-8"%>
<div class="navbar navbar-default" style="background-color: rgb(0, 135, 163);">
	<div class="container" style="background-color: rgb(0, 135, 163);">
		<div class="navbar-header">
			<a class="navbar-brand mainbar" href="#">
				<span><img src="images/logo.png" style="width: 20px; height: 20px;">&nbsp;&nbsp;JAGOGA</span>
			</a>
		</div>
		<div>
			<ul class="nav navbar-nav navbar-right">
				<li><a class="mainbar">${adminId } 접속 중</a></li>
				<li class="dropdown">
					<a href="#" class="glyphicon glyphicon-fire" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"
					style="font-size:20px;"></a>
					<ul class="dropdown-menu" role="menu">
						<li><a href="#">로그아웃</a></li>
					</ul>
				</li>
			</ul>
		</div>
	</div>
</div>