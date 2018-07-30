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
<title>LikeList.jsp</title>

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

<h1>찜 목록</h1>

<table class="table table-striped">
	<tr>
		<th>번호</th>
		<th>호스팅 글 제목</th>
		<th>주소</th>
		<th>숙소유형</th>
		<th>가격(1박)</th>
		<th>삭제</th>
	</tr>
	<% int i = 0; %>
	<c:forEach var="likeList" items="${likeList }">
		<% i=i+1; %>
		<tr>
			<td><%=i %></td>
			<td>
				<a href="roomdetail.do?rcode=${likeList.rcode }">
					${likeList.rname }
				</a>
			</td>
			<td>${likeList.addr }</td>
			<td>${likeList.rtype }</td>
			<td>${likeList.adultFee }</td>
			<td>
				<a href="deletelike.do?likeCode=${likeList.likeCode }">
					<button type="button" class="btn btn-primary" value="${likeList.likeCode }">삭제</button>
				</a>
			</td>
		</tr>
	</c:forEach>
</table>

</div>

<!-- 푸터 영역 -->
<c:import url="../source/MemberFooter.jsp"></c:import>

</body>
</html>