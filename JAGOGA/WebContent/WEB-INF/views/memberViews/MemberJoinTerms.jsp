<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% 
	request.setCharacterEncoding("UTF-8"); 
	String cp = request.getContextPath();
%>
<%
	String memCode = null;
	if (session.getAttribute("memCode") != null) 
		memCode = (String)session.getAttribute("memCode");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>MemberJoinForm1</title>

<!-- 부트스트랩 CDN -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="<%= cp%>/memberAssets/css/Member.css">
<link rel="stylesheet" href="<%= cp%>/memberAssets/css/MemberLogin.css">

</head>
<body>
<!-- 회원 상단 메뉴바 영역 -->
<% if (memCode == null) { %>
<c:import url="../source/MemberLoginMainbar.jsp"></c:import>
<% } else { %>
<c:import url="../source/MemberMainbar.jsp"></c:import>
<% } %>

<div class="container">
	<div class="row">
	
		<div class="col-md-12">
			<div class="col-md-2"></div>
			<div class="col-md-8">
				<h1 style="text-align: center; margin-top: 80px;">JAGOGA 회원가입</h1>
			</div>
			<div class="col-md-2"></div>
		</div>
		
		<!-- 구분선 --><div class="col-md-12"><hr></div>
		
		<!-- 회원가입약관 -->
		<div class="col-md-12">
			<div class="col-md-2"></div>
			<div class="col-md-8">
				<textarea rows="15" style="width: 100%;">
				Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer hendrerit quam eget tellus commodo aliquet. Vestibulum ut condimentum dui, at suscipit turpis. Aliquam rutrum venenatis purus ut commodo. Donec eleifend pharetra iaculis. Ut faucibus dignissim leo sed posuere. Nunc dignissim sagittis lectus, sed finibus arcu efficitur nec. Phasellus tempor congue eros at scelerisque. Etiam dapibus consectetur nisl at porttitor. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut nec odio efficitur, mattis risus ut, tincidunt massa. Praesent sit amet tincidunt turpis. Nunc purus erat, dapibus sit amet euismod id, fringilla quis arcu. Aenean pharetra id arcu id tempor. Etiam orci diam, ultricies ut molestie sit amet, volutpat ac dolor. Proin vel dui ac quam pharetra suscipit.
				</textarea>
				<br>
				<br>
			</div>
			<div class="col-md-2"></div>
		</div>
		<!-- END 회원가입약관 -->
		
		<!-- 약관 동의 체크 -->
		<div class="col-md-12">
			<div class="col-md-2"></div>
			<div class="col-md-8">
				<label for="agree">
					<input type="checkbox" id="agree"> 예, 이용약관에 동의합니다.
				</label>
			</div>
			<div class="col-md-2"></div>
		</div>
		<!-- END 약관 동의 체크 -->
		
		<div class="col-md-12">
			<div class="col-md-2"></div>
			<div class="col-md-8">
				<button id="next" type="button" class="btn nextbtn">다음으로</button>
			</div>
			<div class="col-md-2"></div>
		</div>
	</div>
</div>

<!-- 푸터 영역 -->
<c:import url="../source/MemberFooter.jsp"></c:import>

<!-- javascript -->
<script type="text/javascript">
/* 동의란 체크여부 확인 함수 */
$(function()
{
	$("#next").click(function()
	{
		// 동의란에 체크한 경우 회원가입 페이지 요청
		if ($("#agree").is(":checked")==true) {
			$(location).attr("href", "memberjoininput.do");
		} else {
			alert('동의란에 체크해주세요.');
		}
	});
});
</script>
</html>