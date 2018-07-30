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
<title>MemberJoinForm2.jsp</title>

<!-- 부트스트랩 CDN -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="<%= cp%>/memberAssets/css/Member.css">
<link rel="stylesheet" href="<%= cp%>/memberAssets/css/MemberLogin.css">

</head>
<body>
<!-- 메뉴 영역 -->
<% if (memCode == null) { %>
<c:import url="../source/MemberLoginMainbar.jsp"></c:import>
<% } else { %>
<c:import url="../source/MemberMainbar.jsp"></c:import>
<% } %>

<div class="container">

<h1>예약 및 결제</h1>

<form action="">
<table class="table table-striped">
	<tr>
		<th>예약자 이름</th>
		<td>
			${memName }
		</td>
	</tr>
	<tr>
		<th>숙소 이름</th>
		<td>
			${rname }
		</td>
	</tr>
	<tr>
		<th>인원 수</th>
		<td>
			${totalCount }
		</td>
	</tr>
	<tr>
		<th>숙박 날짜</th>
		<td>
			${checkInDate } ~ ${checkOutDate }
		</td>
	</tr>
	<tr>
		<th>숙소 주소</th>
		<td>
			${rbasicAddr } 
			${rdetailAddr }
		</td>
	</tr>
	<tr>
		<th>결제 금액</th>
		<td> ${bpay } </td>
	</tr>
	<tr>
		<td colspan="2">
			<button type="button" class="btn btn-success" onclick="window.location.href='booking4.do'">결제</button>
		</td>
	</tr>
</table>
</form>

</div>

<!-- 푸터 영역 -->
<c:import url="../source/MemberFooter.jsp"></c:import>

</body>
</html>