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

<title>MyBookingList.jsp</title>

<!-- 부트스트랩 CDN -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="<%= cp%>/memberAssets/css/Member.css">
<link rel="stylesheet" href="<%= cp%>/memberAssets/css/MemberLogin.css">

<script type="text/javascript" src= "<%=cp %>/memberAssets/js/jquery-3.3.1.js"></script>


<!-- 달력 -->
<script src="https://code.jquery.com/jquery-3.2.1.js"></script>
<script type='text/javascript' src='//code.jquery.com/jquery-1.8.3.js'></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.5.0/css/bootstrap-datepicker3.min.css">
<script type='text/javascript' src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.5.0/js/bootstrap-datepicker.min.js"></script>
<script src="<%=cp %>/memberAssets/js/bootstrap-datepicker.kr.js" charset="UTF-8"></script>


<script type="text/javascript">
    $(document).ready(function()
   {
   
      $("[name=bookingCancelButton]").on("click", function() {
         //alert($(this).val());
         $("#selectedBcode").val($(this).val()); 
      });
   }); 
    
   function deleteOk() 
   {
      var check = document.getElementById("check").checked; 
      //alert(check);
      
      
      if(check==true)
      {
         var bcode = $("#selectedBcode").val();
         //alert(bcode)
         location.href = "deletebooking.do?bcode=" + bcode;
      }
      else
      {
         alert("동의란에 표시하세요.")
      }
      /* location.href = "deletebooking.do?bcode="$("#selectedBcode").val();
      /* alert($("#selectedBcode").val()); */ 
   }
   

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

   $(document).ready(function()
   {
      // 조회하기 버튼 클릭시
      $("#dateTransForm").click(function()
      {         
         
         //alert("test");
         var day1 = $("[name=startCheck]").val();
         var day2 = $("[name=endCheck]").val();

         location.href="mybookingDateCheck.do?startCheck=" + day1+ "&endCheck="+day2+"&tempStart="+day1+"&tempEnd="+day2;
      });
      
      
      $("#standardView").click(function()
      {         
               
         //alert("test");
         var day1 = $("[name=startCheck]").val();
         var day2 = $("[name=endCheck]").val();

         location.href="bookinglist.do";
      });
      
   });
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

<input type="hidden" id="selectedBcode" value="" />

<div class="container">
   
   <h1>내가 예약한 숙소</h1>
   <h6 style="float: right;">현재 시각 : <span class="panel-subtitle" id="clock"></span></h6>
   <div>
      <input type="text" name="startCheck" value="${tempStart }"> &nbsp;&nbsp;~&nbsp;&nbsp;<input type="text" value="${tempEnd }" name="endCheck">
      <button type="button" id="dateTransForm">조회</button>
      <button type="button" id="standardView">전체보기</button>
   </div>
   <table class="table table-striped">
      <tr>
         <td>예약번호</td>
         <td>호스팅숙소</td>
         <td>예약기간</td>
         <td>결제금액</td>
         <td>환불금액</td>
         <td>상태</td>
         <td>취소하기</td>
      </tr>
      <c:forEach var="booking" items="${bookingList }">
         <tr>
            <td>${booking.bcode }</td>
            <td><a href="bookingdetail.do?bcode=${booking.bcode }">${booking.rname }</a></td>
            <td>${booking.checkInDate } ~ ${booking.checkOutDate }</td>
            <td>${booking.bpay }</td>
            <td>${booking.refund }</td>
            <td>${booking.status }</td>
            <td>   
            <c:choose>
                <c:when test="${booking.status eq '예약중'}">
                    <button type="button" class="btn btn-primary active" name="bookingCancelButton" value="${booking.bcode }" data-toggle="modal" data-target="#bookingModal">취소하기</button>
                </c:when>
                <c:otherwise>
                    <button type="button" class="btn btn-primary disabled" value="${booking.bcode }">취소하기</button>
                </c:otherwise>
            </c:choose>
            </td>
            
         </tr>
      </c:forEach>
   
   </table>
</div>

<div id="bookingModal" class="modal fade">
   <div class="modal-dialog modal-booking">
      <div class="modal-content">
         <div class="modal-header">            
            <h4 class="modal-title">예약 취소 및 환불</h4>
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
         </div>
         <div class="modal-body">
            <form action="" method="post">
            
            <h4> - 예약 취소 및 환불 안내 돌아가기 예약취소위 내용을 모두 확인하였습니다.</h4>
            <h4> - 한번 취소한 내역은 다시 되돌릴 수 없습니다.</h4>
            <h4> - 취소한 후 다시 절차를 거쳐 예약하실 수 있습니다.</h4>
            <h4> - 결제 금액은 JAGOGA의 환불정책에 따라 환불됩니다.</h4>
            <h4>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(환불정책은 공지사항 참고)</h4>
            <h4> - 취소내역은 예약내역에서 확인하실 수 있습니다.</h4>
            
            </form>
         </div>
         <div class="modal-footer">
            <input type="checkbox" class="check" id="check"> 위 내용을 모두 확인하였습니다.
            <button type="button" onclick="deleteOk();">예약취소</button>
            
            <button type="button" data-dismiss="modal">돌아가기</button>
         </div>
      </div>
   </div>
</div>

<!-- 푸터 영역 -->
<c:import url="../source/MemberFooter.jsp"></c:import>

</body>
</html>