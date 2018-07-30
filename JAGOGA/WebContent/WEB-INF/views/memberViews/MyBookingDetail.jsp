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
<meta charset=UTF-8>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>MybookingDetail.jsp</title>

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

<h1>예약 상세조회</h1>

<form action="bookinglist.do" method="get">
   <table class="table table-striped">
      <tr>
         <th>예약번호</th><td>${bookingDetail.bcode }</td>
         <th>예약기간</th><td>${bookingDetail.checkDate }</td>
      </tr>
      <tr>
         <th>호스팅 글 제목</th><td>${bookingDetail.rname }</td>
         <th>숙소 주소</th><td>${bookingDetail.addr }</td>
      </tr>
      <tr>
         <th>예약자 이름</th><td>${bookingDetail.gname }</td>
         <th>예약자 에티켓 등급</th><td>${bookingDetail.memEtiquette }</td>
      </tr>
      <tr>
         <th>결제금액</th><td>${bookingDetail.bpay }</td>
         <th>환불금액</th><td>${bookingDetail.refund }</td>
      </tr>
      <tr>
         <th>처리상태</th><td>${bookingDetail.status }</td>
         <th>호스트에게 문의</th><td>${bookingDetail.memTel }</td>
      </tr>
      <tr>
         <th>인원수</th><td>${bookingDetail.humanCount }</td>
         <th>집유형</th><td>${bookingDetail.rtype }</td>
      </tr>
   </table>
   
   <button type="submit" class="btn btn-primary">목록으로가기</button>
   <!-- <a href="deleteroom.do?"><button>삭제하기</button></a> -->
   
   <c:choose>
      <c:when test="${bookingDetail.status eq '이용완료' }">
         <button type="button" class="btn btn-primary" id="deletebutton" >삭제하기</button>
      </c:when>
      
      <c:when test="${bookingDetail.status eq '예약중' }">
         <button type="button" class="btn btn-primary" id="cancelbutton">예약취소</button>
      
      </c:when>
   
   </c:choose>
   
</form>
</div>

<!-- 푸터 영역 -->
<c:import url="../source/MemberFooter.jsp"></c:import>

</body>
</html>