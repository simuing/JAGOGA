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
<title>UpdateMyInfoComplete.jsp</title>

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
   <h1>내 정보 수정 완료</h1>
   <hr>
   <div class="row">
      <div class="col-md-1"></div>
      <div class="resultMent col-md-10">
         <div class="col-md-12"><h1>회원 정보가 성공적으로 수정되었습니다.</h1></div>
         <div class="col-md-3"></div>
         <div class="col-md-6"><a href="trymyinfo.do"><button type="button" class="btn nextbtn">내 정보 조회 페이지로</button></a></div>
         <div class="col-md-3"></div>
      </div>
   <div class="col-md-1"></div>
   </div>
</div>

<!-- 푸터 영역 -->
<c:import url="../source/MemberFooter.jsp"></c:import>
</body>
</html>