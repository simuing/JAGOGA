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
<title>MyRoomBookingList.jsp</title>

<!-- 부트스트랩 CDN -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="<%= cp%>/memberAssets/css/Member.css">
<link rel="stylesheet" href="<%= cp%>/memberAssets/css/MemberLogin.css">


<!-- 달력 -->
<script src="https://code.jquery.com/jquery-3.2.1.js"></script>
<script type='text/javascript' src='//code.jquery.com/jquery-1.8.3.js'></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.5.0/css/bootstrap-datepicker3.min.css">
<script type='text/javascript' src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.5.0/js/bootstrap-datepicker.min.js"></script>
<script src="<%=cp %>/memberAssets/js/bootstrap-datepicker.kr.js" charset="UTF-8"></script>

<script type="text/javascript">

   $(document).ready(function()
   {
      // 조회하기 버튼 클릭시
      $("#dateTransForm").click(function()
      {         
         // 달력의 값을 에이젝스로 넘기려고 설정한 변수
         //alert("test");
         var day1 = $("[name=startCheck]").val();
         var day2 = $("[name=endCheck]").val();

         location.href="timeCheck.do?startCheck=" + day1+ "&endCheck="+day2+"&tempStart="+day1+"&tempEnd="+day2;
      });
      
      // 에티켓 평가 버튼 클릭시 값을 담기위한 jquery
      $("[name=tempId]").on("click", function()
      {
         //$("#tempbcode").val($(this).attr("id"));
         $("#tempbcode").val($(this).val());
         //alert($("#tempbcode").val());
      });
      
      // 에티켓점수 증가 클릭시
      $("#pointUp").click(function()
      {
         location.href="pointup.do?bcode="+$("#tempbcode").val();
      });
      
      
      // 에티켓점수 감점 클릭시
      $("#pointDown").click(function()
      {
         location.href="pointdown.do?bcode="+$("#tempbcode").val();
      });
      
      // 전체보기 클릭시
      $("#standardView").click(function()
      {
         // 원래 전체보기 페이지로 보내겠다.
         location.href="myroombookinglist.do";
      });

   });
   
</script>

<!-- 현재시간 출력 함수 호출 -->
<script>

   function printTime()
   {
      // 출력할 장소 선택
      var clock = document.getElementById("clock");
      
      // 현재시간
      var now = new Date();
      var nowTime = now.getFullYear() + "년 " + (now.getMonth()+1) + "월 " + now.getDate()
            + "일 " + now.getHours() + "시 " + now.getMinutes() + "분 " + now.getSeconds() + "초 ";
      
      // 현재시간을 출력
      clock.innerHTML = nowTime;           
      
      // setTimeout(“실행할함수”,시간) 시간은1초의 경우 1000
      setTimeout("printTime()",1000);         
   }
   
   window.onload = function()
   {
      // 페이지가 로딩되면 실행
      printTime();
   }
</script>


<script type="text/javascript">

   //검색 시작일 달력으로 체크
   $(function()
      {
         $("[name=startCheck]").datepicker(
         {
            minDate : 0,
              calendarWeeks: false,
              todayHighlight: true,
              autoclose: true,
              format: "yyyy-mm-dd",
              language: "kr"
            
         });
      });
   
   // 검색 끝나는일 달력으로 체크
   $(function()
   {
      $("[name=endCheck]").datepicker(
      {
         minDate : 0,
           calendarWeeks: false,
           todayHighlight: true,
           autoclose: true,
           format: "yyyy-mm-dd",
           language: "kr"
         
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

   <h1>내 숙소 예약 내역</h1>
   <h6>현재 시각 : <span class="panel-subtitle" id="clock"></span></h6>
   
   
   <input type="hidden" value="" id="tempbcode">
   
   <div>
      <input type="text" name="startCheck" value="${tempStart }"> &nbsp;&nbsp;~&nbsp;&nbsp;<input type="text" value="${tempEnd }" name="endCheck">
      <button type="button" class="btn btn-primary" id="dateTransForm">조회</button>
      <button type="button" class="btn btn-primary" id="standardView">전체보기</button>
   </div>
   
   <table class="table table-striped">
      <tr>
          <td>예약번호</td>
          <td>숙소이름</td>
          <td>예약날짜</td>
          <td>숙박기간</td>
          <td>예약자아이디</td>
          <td>결제금액</td>
          <td>환불금액</td>
          <td>에티켓평가</td>
          <td>취소하기</td>
          <td>상태</td>
       </tr>
       <c:forEach var="list" items="${list }">
         <tr>
            <td>${list.bcode }</td>
            <td>${list.rname }</td>
            <td>${list.bdate }</td>
            <td>${list.realCheckInDate } ~ ${list.realCheckOutDate }</td>
            <td>${list.gmemId }</td>
            <td>${list.bpay }</td>
            <td>${list.refund }</td>
            <td>
            <c:if test="${list.checkPoints eq 'N'}">
               <button data-toggle="modal" class="btn btn-primary" data-target="#pointModal" name="tempId" value="${list.bcode }">평가</button>
            </c:if>
            <c:if test="${list.checkPoints eq 'Y'}">
               <p>완료</p>
            </c:if>
            <c:if test="${list.status eq '호스트취소' or '게스트취소' or '관리자취소' or '예약중'}">
               <p>완료</p>
            </c:if>
            
            </td>
            <td>
               <c:choose>
                  <c:when test="${list.status eq '호스트취소' }">
                     <p>취소</p>
                  </c:when>
                  <c:when test="${list.status eq '게스트취소' }">
                     <p>취소</p>
                  </c:when>
                  <c:when test="${list.status eq '관리자취소' }">
                     <p>취소</p>
                  </c:when>
                  <c:when test="${list.status eq '예약중' }">
                     <button type="button" class="btn btn-primary">취소하기</button>
                     
                  </c:when>
                  <c:otherwise>
                     <p>취소불가</p>
                  </c:otherwise>
               </c:choose>
            
            </td>
            <td>${list.status }</td>      
         </tr>

      </c:forEach>
   </table>

<p>
※ 에티켓 평가 : 체크아웃일로부터 30일 후까지 평가가 가능합니다.※ 예약취소 : 체크인날의 5일 전부터는 취소가 불가능합니다. (6일전까지 가능)※ 이용완료 : 게스트의 실제 숙박정보를 입력해야 숙박 금액을 받으실 수 있습니다. 
                          게스트의 체크아웃일부터 3일 후까지 실제 숙박정보를 등록하여 이용완료처리 할 수 있으며, 
                          입력하지 않는 경우 3일 후에 자동으로 이용완료 처리됩니다.
</p>

</div>

<!-- 푸터 영역 -->
<c:import url="../source/MemberFooter.jsp"></c:import>



<!-- 로그인 모달 -->
<div id="pointModal" class="modal fade">
   <div class="modal-dialog" style="width: 215px;">
      <div class="modal-content">
         
         <div class="modal-body">
         <form name="pointUpgrade">
            <button type="button" id="pointUp"><img alt="에티켓점수업" src="memberAssets/img/upPoint.png"></button>
            <button type="button" id="pointDown"><img alt="에티켓점수다운" src="memberAssets/img/downPoint.png"></button>
         </form>
         </div>
      </div>
   </div>
</div>


</body>
</html>