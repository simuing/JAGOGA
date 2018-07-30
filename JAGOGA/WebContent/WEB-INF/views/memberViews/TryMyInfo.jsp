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
<title>MyInfo1.jsp</title>

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

<h1>내 정보</h1>
<h3>비밀번호 확인</h3>

<form action="myinformation.do" method="post">
	<table class="table table-striped">
		<tr>
			<td>아이디</td>
			<td>
				${memId }<input type="text" id="memId" value="${memId }" style="visibility: hidden;">
			</td>
		</tr>
		<tr>
			<td>비밀번호</td>
			<td>
				<input type="password" name="memPw" id="memPw">
				<span id="myInfoErrMsg" style="font-size: 12px; display: none"></span>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<span><button id="myInfoPw" type="button" class="btn btn-primary">확인</button></span>
			</td>
		</tr>
	</table>
</form>

</div>



<script type="text/javascript">
$(document).ready(function()
{
	// 확인 버튼 클릭
	$("#myInfoPw").click(function()
	{ 
		$("#myInfoErrMsg").css("display", "inline");
		
		// 비밀번호를 입력하지 않았을 때
	 	var memPw = $("#memPw").val();
	 	if ( memPw == "")
	 	{	 		
	 		$("#myInfoErrMsg").css("color","red");
			$('#myInfoErrMsg').html('비밀번호를 입력해주세요.');
			$('#memPw').focus();
			
			return;			
	 	}
	 
		// AJAX 수행
	 	$.post("logincheck.do", {memId:$("#memId" ).val(), memPw:$("#memPw").val()}, function(data)
		{
			// AJAX 처리에서 입력한 비밀번호와 아이디로 COUNT 했을때 1이면
			if (data==1)
			{				
				$("form").submit();				
			}
			// 반환된 COUNT 가 1이 아니라면
			else
			{
				$("#myInfoErrMsg").css("color","red");
				$('#myInfoErrMsg').html('비밀번호를 다시 확인해주세요.');
				$('#memPw').focus();
			}
		});
	});
});
</script>


<!-- 푸터 영역 -->
<c:import url="../source/MemberFooter.jsp"></c:import>
</body>
</html>