<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
<title>MyInfo2.jsp</title>

<!-- 부트스트랩 CDN -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="<%= cp%>/memberAssets/css/Member.css">
<link rel="stylesheet" href="<%= cp%>/memberAssets/css/MemberLogin.css">

<script type="text/javascript">

   $(function()
   {
      $("#update").click(function()
      {
         $(location).attr("href", "updatemyinfoform.do");
      });
      
      $("#leave").click(function()
      {
         $(location).attr("href", "leaveterms.do");
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

<h1>내 정보</h1>


<table class="table table-striped">
   <tr>
      <th>아이디</th>
      <td>${memInfo.memId }</td>
      <th>프로필사진</th>
   </tr>
   <tr>
      <th>이름</th>
      <td>${memInfo.memName }</td>
      <td rowspan="5" style="width: 200px;">
         <img src="memberProfile/${fn:substringAfter(memInfo.memProfile, 'memberProfile/') }"
          style="width: 200px;" onerror="this.src='http://via.placeholder.com/200x250'">
      </td>
   </tr>
   <tr>
      <th>주민번호</th>
      <td>${memInfo.memSsn }</td>
   </tr>
   <tr>
      <th>휴대폰번호</th>
      <td>${memInfo.memTel }</td>
   </tr>
   <tr>
      <th>이메일</th>
      <td>${memInfo.memEmail }</td>
   </tr>
   <tr>
      <th>에티켓등급</th>
      <!-- 에티켓등급 점수에 따른 아이콘 출력 -->
      <c:choose>
       <c:when test="${memInfo.memEtiquette > 8000 }">
           <td id="etq"><img class="memEtiquette" src="memberAssets/img/best.png"></td>
       </c:when>
        <c:when test="${memInfo.memEtiquette > 6000 }">
           <td id="etq"><img class="memEtiquette" src="memberAssets/img/good.png"></td>
       </c:when>
        <c:when test="${memInfo.memEtiquette > 4000 }">
           <td id="etq"><img class="memEtiquette" src="memberAssets/img/nomal.png"></td>
       </c:when>
       <c:when test="${memInfo.memEtiquette > 3000 }">
           <td id="etq"><img class="memEtiquette" src="memberAssets/img/notgood.png"></td>
       </c:when>  
       <c:otherwise>
            <td id="etq"><img class="memEtiquette" src="memberAssets/img/worst.png"></td>
       </c:otherwise>
       
   </c:choose> 

   </tr>
   <tr>
      <td colspan="3">
         <button id="update" type="button" class="btn btn-primary">수정</button>
      </td>
   </tr>
</table>

</div>

<!-- 푸터 영역 -->
<c:import url="../source/MemberFooter.jsp"></c:import>

</body>
</html>