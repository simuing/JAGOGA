<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% 
	request.setCharacterEncoding("UTF-8"); 
	String cp = request.getContextPath();
%>
<%
	String memId = null;
	/* if (session.getAttribute("id") != null) 
		memId = (String)session.getAttribute("id"); */
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>





<link rel="stylesheet" href="assets/css/Member.css">
</head>
<body>

<!-- 관리자 로그인 페이지 상단 메뉴바 영역 -->
<c:import url="AdminLoginMainbar.jsp"></c:import>

<!-- 관리자 상단 메뉴바 영역 -->
<c:import url="AdminMainbar.jsp"></c:import>



<!--  =========== 작업영역 ============== -->
<!--                                      -->



</body>
</html>

