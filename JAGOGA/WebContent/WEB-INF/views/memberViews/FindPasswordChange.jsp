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
<title>FindPassword.jsp</title>

<!-- 부트스트랩 CDN -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="<%= cp%>/memberAssets/css/Member.css">
<link rel="stylesheet" href="<%= cp%>/memberAssets/css/MemberLogin.css">

<script type="text/javascript">
	// 비밀번호 확인란에 키를 입력할 때마다 일치여부 확인해서 메시지 띄우기
	function pwCheck()
	{
		var userPassword1 = $("#memPw").val();
		var userPassword2 = $("#memPwCheck").val();
		
		$("#pwErrMsg").css("display", "inline");
		
		if(userPassword1 != userPassword2)
		{
			$('#pwErrMsg').html('비밀번호가 일치하지 않습니다.');
			$("#pwErrMsg").css("color", "red");
		}
		else
		{
		   $('#pwErrMsg').html('비밀번호가 일치합니다');
		   $("#pwErrMsg").css("color", "green");
		}
	}
</script>

</head>
<body>
<!-- 메뉴 영역 -->
<% if (memCode == null) { %>
<c:import url="../source/MemberLoginMainbar.jsp"></c:import>
<% } else { %>
<c:import url="../source/MemberMainbar.jsp"></c:import>
<% } %>

<div class="container">

<h1>비밀번호 재설정</h1>

<form action="passwordchange.do" method="POST">

<table class="table table-striped">
	<tr>
		<th>비밀번호</th>
		<td>
			<input type="password" id="memPw" name="memPw">
		</td>
	</tr>
	<tr>
		<th>비밀번호 확인</th>
		<td>
			<input type="password" id="memPwCheck" onkeyup="pwCheck()"><br>
			<span id="pwErrMsg" style="font-size: 9px; display: none"></span>
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<button type="submit" class="btn btn-primary">비밀번호 변경</button>
		</td>
	</tr>
</table>

</form>

</div>

<!-- 푸터 영역 -->
<c:import url="../source/MemberFooter.jsp"></c:import>

</body>
</html>