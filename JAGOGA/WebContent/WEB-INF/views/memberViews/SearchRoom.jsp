<%@ page contentType="text/html; charset=UTF-8"%>
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
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>SearchRoom.jsp</title>
<!-- 부트스트랩 CDN -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="<%= cp%>/memberAssets/css/Member.css">
<link rel="stylesheet" href="<%= cp%>/memberAssets/css/MemberLogin.css">
<link rel="stylesheet" href="<%= cp%>/memberAssets/css/Search.css">
<script type="text/javascript">
   $(function()
   {
      // 별점 출력
      $.fn.generateStars = function() 
      {
          return this.each(function(i,e){$(e).html($('<span/>').width($(e).text()*8));});
      };
      
      // 숫자 평점을 별로 변환하도록 호출하는 함수
      $('.star-prototype').generateStars();
      
      $(".btn-search").click(function()
      {
         if ($("#search").val()=="") 
         {
            alert("검색어를 입력해주세요");
            return;
         }
         $(location).attr("href", "searchroom.do?search=" + $("#search").val());
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


<!-- 검색 영역 -->
<div class="input-group search-box">
   <input type="text" class="form-control" value="${search }" id="search" name="search">
   <span class="input-group-btn">
      <button class="btn btn-default btn-search" type="button">
         <span class="glyphicon glyphicon-search"></span>
      </button>
   </span>
</div>



<!-- 검색된 숙소 영역 -->
<div class="container box">
   <div class="recommend-title-box">
      <div class="recommend-title">검색 결과</div>
   </div>
   <br>
   <div class="container-fluid" >
      <c:forEach var="searchRoom" items="${searchRoomList }">
         <div class="room-item">
            <a href="roomdetail.do?rcode=${searchRoom.rcode }">
               <img src="roomImage/${fn:substringAfter(searchRoom.rimg, 'roomImage/') }" width="243px" height="200px"/>
               <div>${searchRoom.rname }</div>
            </a>
            <div>${searchRoom.adultFee }원 / 박</div>
            <div>
               <span class="star-prototype">${searchRoom.avgPoint }</span>${searchRoom.avgPoint }
            <a href="like.do?rcode=${bestRoom.rcode }">찜하기</a>
         </div>
         </div>
      </c:forEach>
    </div>
   <!-- 페이징 처리 부분 -->
   <div>
      <c:if test="${pageNumber != 1 }">
         <a href="searchroom.do?search=${search }&pageNumber=${pageNumber-1 }"><button class="btn btn-primary">이전</button></a>
      </c:if>
      <!-- 원래는 되어야 한다. -->
      <a href="searchroom.do?search=${search }&pageNumber=${pageNumber+1 }"><button class="btn btn-primary">다음</button></a>
   </div>
</div>


<!-- 푸터 영역 -->
<c:import url="../source/MemberFooter.jsp"></c:import>

</body>
</html>