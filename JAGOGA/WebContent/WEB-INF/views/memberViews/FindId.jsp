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
<title>FindId.jsp</title>

<!-- 부트스트랩 CDN -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="<%= cp%>/memberAssets/css/Member.css">
<link rel="stylesheet" href="<%= cp%>/memberAssets/css/MemberLogin.css">

<script type="text/javascript">
	// 발급 받은 인증번호를 담아둘 전역변수
	var myCheckNum;

	// 인증번호 발급 함수
	function createCheckNum()
	{
		var tel1 = document.getElementById("tel1").value;
		var tel2 = document.getElementById("tel2").value;
		var tel3 = document.getElementById("tel3").value;
		var telCheckNum = document.getElementById("telCheckNum");
		
		if (tel1 != "" && tel2 != "" && tel3 != "")
		{
			var checkNum = Math.floor(Math.random() * 90000) + 10000;
		
			alert("인증번호가 발급되었습니다.");
		
			telCheckNum.value = checkNum;
			
			myCheckNum = checkNum;
		}
		else
			alert("휴대폰 번호를 입력해주세요");
	}
	
	// 인증번호 확인 함수
	function checkNum()
	{
		var telCheckNum = document.getElementById("telCheckNum").value;
		var checkNum = telCheckNum;
		
		if (myCheckNum == telCheckNum)
		{
			alert("인증성공");
		}
		else
		{
			alert("인증실패");
		}
	}
	
	function findid()
	{
		var tel1 = document.getElementById("tel1").value;
		var tel2 = document.getElementById("tel2").value;
		var tel3 = document.getElementById("tel3").value;
		
		var memTel = tel1 + "-" + tel2 + "-" + tel3;
		
		$("[name=memTel]").attr("value", memTel);
        
        document.form.submit();
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

<h1>아이디 찾기</h1>

<form action="findidcomplete.do" method="GET" onsubmit="findid();">

	<table class="table table-striped">
		<tr>
			<th>핸드폰 번호</th>
			<td>
				<input type="text" id="tel1"> - 
				<input type="text" id="tel2"> - 
				<input type="text" id="tel3">
				<button type="button" class="btn btn-primary" onclick="createCheckNum();">인증</button>
			</td>
		</tr>
		<tr>
			<th>인증번호</th>
			<td>
				<input type="text" id="telCheckNum">
				<button type="button" class="btn btn-primary" onclick="checkNum();">인증번호확인</button>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<button type="submit" class="btn btn-primary">다음으로</button>
			</td>
		</tr>
	</table>
	
	<input type="hidden" name="memTel">
	
</form>

</div>

<!-- 푸터 영역 -->
<c:import url="../source/MemberFooter.jsp"></c:import>

</body>
</html>