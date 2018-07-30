<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<title>MyRoomList.jsp</title>

<!-- 부트스트랩 CDN -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="<%= cp%>/memberAssets/css/Member.css">
<link rel="stylesheet" href="<%= cp%>/memberAssets/css/MemberLogin.css">

<!-- 룸 이미지 위에 텍스트 얹기 -->
<link rel="stylesheet" href="<%= cp%>/memberAssets/css/MyRoomList.css">

<style>@import url('https://fonts.googleapis.com/css?family=Do+Hyeon');</style>
</head>
<body>

<!-- 회원 상단 메뉴바 영역 -->
<% if (memCode == null) { %>
<c:import url="../source/MemberLoginMainbar.jsp"></c:import>
<% } else { %>
<c:import url="../source/MemberMainbar.jsp"></c:import>
<% } %>

<!-- RoomList -->
<div class="main">
   <div class="main-content">
      <!-- RoomContent -->
      <div class="row">
         <div class="col-md-2"></div>
         <div class="col-md-8" style="width:1200px; padding:0px;">
            <h1>호스팅 중인 숙소 목록</h1>
            <div class="btn-group" role="group">
               <button type="button" class="btn btn-default roomlistbtn" onclick="window.location.href='verificationlist.do'">검증 내역</button>
               <button type="button" class="btn btn-default roomlistbtn" onclick="window.location.href='myroombookinglist.do'">전체 예약내역</button>
               <button type="button" class="btn btn-default roomlistbtn" onclick="window.location.href='insertroom1.do'">숙소등록</button>
            </div>
         </div>
         <div class="col-md-2"></div>
      </div>
      <!-- ENDRoomContent -->
      
      <!-- 숙소목록 -->
      <c:forEach var="myRoom" items="${myRoomList }">
      <div class="row">
         <div class="col-md-2"></div>
         <div class="col-md-8 center-block" style="width:1200px; padding:0px;">
            <div class="roomimg" style="background-image: url('roomImage/${fn:substringAfter(myRoom.rimg, 'roomImage/') }')">
               <div class="roomtext">
                  <h1 class="roomtitle"><span class="label label-info">${myRoom.vafterGrade}</span><a href="roomdetail.do?rcode=${myRoom.rcode}"> ${myRoom.rname}</a></h1>
                  <p>호스팅한 날짜 : ${myRoom.rregDate}</p>
                  <p>검증 유효기간 : </p>
                  <div class="roomlink">
                     <c:if test="${myRoom.vafterGrade ne 'A'}">
                     <a href="verification.do?rcode=${myRoom.rcode }&vafterGrade=${myRoom.vafterGrade}&rname=${myRoom.rname}">검증요청</a>
                     </c:if>
                     <a href="#">삭제하기</a>
                     <a href="updateroomform.do?rcode=${myRoom.rcode }">수정하기</a>
                  </div>
               </div>
            </div>
         </div>
         <div class="col-md-2"></div>
      </div>
      </c:forEach>
      <!-- END 숙소목록 -->
      
   </div>
</div>
<!-- END RoomList -->


</body>
</html>