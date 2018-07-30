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
<title>MyRoomVerificationList.jsp</title>

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

<div>
   <h1>검증 내역</h1>

   <select>
      <option>전체 숙소</option>
      <option>유빈이네집</option>
      <option>은영이네집</option>
      <option>진성이네집</option>
   </select>
   
   <select>
      <option>검증성공</option>
      <option>검증실패</option>
      <option>검증 중</option>
   </select>

   <a href="myroomlist.do">
      <button type="button" class="btn btn-primary">내 숙소 관리</button>
   </a>
</div>

<table class="table table-striped">
   <tr>
      <th>번호</th>
      <th>숙소 이름</th>
      <th>최초숙소등록일</th>
      <th>검증요청일</th>
      <th>처리완료일</th>
      <th>검증만료일</th>
      <th>처리상태</th>
      <th>등급변동</th>
      <th>처리사유</th>
   </tr>
   <c:forEach var="myVerificationList" items="${myVerificationList }">
   <tr>
      <td>${myVerificationList.rownum }</td>
      <td>${myVerificationList.rname }</td>
      <td>${myVerificationList.rregDate }</td>
      <td>${myVerificationList.reqvDate }</td>
      <td>${myVerificationList.processingDate }</td>
      <td>${myVerificationList.effectiveDate }</td>
      <td>${myVerificationList.vsContent }</td>
      <td>${myVerificationList.vafterGrade }</td>
      <td>
         <button type="button" class="btn btn-primary">조회</button>
      </td>
   </tr>
   </c:forEach>
</table>

</div>

<!-- 푸터 영역 -->
<c:import url="../source/MemberFooter.jsp"></c:import>

</body>
</html>