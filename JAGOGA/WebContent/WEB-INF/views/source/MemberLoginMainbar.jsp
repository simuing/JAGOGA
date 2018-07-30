<%@ page contentType="text/html; charset=UTF-8"%>

<!-- 비회원 상단 바 -->
<div class="navbar navbar-default">
	<div class="container">
		<div class="navbar-header">
			<a class="navbar-brand mainbar" href="main.do">
				<span><img src="memberAssets/img/logo.png" style="width: 20px; height: 20px;">&nbsp;&nbsp;JAGOGA</span>
			</a>
		</div>
		<div>
			<ul class="nav navbar-nav navbar-right">
				<li><a href="noticelist.do" class="mainbar">이용가이드</a></li>
				<li><a href="memberjointerms.do" class="mainbar">회원가입</a></li>
				<li><a href="#" data-toggle="modal" data-target="#loginModal" class="mainbar">로그인</a></li>
			</ul>
		</div>
	</div>
</div>


<!-- 로그인 모달 -->
<div id="loginModal" class="modal fade">
	<div class="modal-dialog modal-login">
		<div class="modal-content">
			<div class="modal-header">				
				<h4 class="modal-title mainbar">JAGOGA 로그인</h4>
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			</div>
			<div class="modal-body">
				<form action="login.do" method="post">
					<div class="form-group">
						<i class="glyphicon glyphicon-user"></i>
						<input type="text" class="form-control" placeholder="아이디" required="required" name="memId">
					</div>
					<div class="form-group">
						<i class="glyphicon glyphicon-lock"></i>
						<input type="password" class="form-control" placeholder="비밀번호" required="required" name="memPw">
					</div>
					<div class="form-group">
						<span id="loginErrMsg" style="color: red; font-weight: bold;">아이디 또는 비밀번호가 정확하지 않습니다.</span>
					</div>
					<div class="form-group">
						<input type="submit" class="btn btn-primary btn-block btn-lg" value="로그인">
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<a href="memberjointerms.do">회원가입</a> /
				<a href="findid.do">아이디 찾기</a> /
				<a href="findpw.do">비밀번호 찾기</a>
			</div>
		</div>
	</div>
</div>
