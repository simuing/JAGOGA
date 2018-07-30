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
<title>MemberLeave2.jsp</title>

<!-- 부트스트랩 CDN -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="<%= cp%>/memberAssets/css/Member.css">
<link rel="stylesheet" href="<%= cp%>/memberAssets/css/MemberLogin.css">

<script type="text/javascript">

 	$(function()
	{
		$("#leave").click(function()
		{
			if ($("input:checkbox[name='check']").is(":checked") == true)
			{
				$(location).attr("href", "leavepwform.do");
				
			}else
			{	
				alert("유의사항 및 안내란을 확인해주세요.");
				return;
			}				
		});
	});


</script>

</head>
<body>

<!-- 회원 상단 메뉴바 영역 -->
<% if (memCode == null) { %>
<c:import url="../source/MemberLoginMainbar.jsp"></c:import>
<% } else { %>
<c:import url="../source/MemberMainbar.jsp"></c:import>
<% } %>

<div class="container">

<h1>회원탈퇴 유의사항 및 안내</h1>

<h3>회원 탈퇴 전 다음 사항을 꼭 확인하시기 바랍니다.</h3>
<ul>
	<li>이용 중인 호스팅서비스가 존재한다면 회원 탈퇴가 불가합니다.</li>
	<li>이용 중인 유료 서비스에 대한 철회 및 환불은 고객센터를 통해 문의/요청 바랍니다.</li>
	<li>회원탈퇴 진행 시 본인을 포함한 타인 모두 아이디 재사용이나 복구가 불가능합니다.</li>
	<li>회원탈퇴 후 1년 이내 재가입 시 에티켓점수가 유지됩니다.</li>
</ul>

<h3>탈퇴회원 회원정보 보존기간</h3>
<ul>
	<li>회원탈퇴가 완료되더라도 다음과 같이 회원정보가 일정기간 보존됨을 알려드립니다.</li>
	<li>아이디 및 계약, 대금결제 등에 관한 기록 : 1년</li>
	<li>소비자의 불만 또는 분쟁처리에 관한 기록 : 1년</li>
	<li>부정이용 등에 관한 기록 : 1년</li>	
</ul>


<br>
<label><input type="checkbox" name="check"> 위 내용을 모두 확인하였으며, 해지 및 정보가 복구 불가능함에 동의합니다.</label>
<br>
<button id="leave" type="button" class="btn btn-primary">탈퇴신청</button>

</div>

<!-- 푸터 영역 -->
<c:import url="../source/MemberFooter.jsp"></c:import>

</body>
</html>