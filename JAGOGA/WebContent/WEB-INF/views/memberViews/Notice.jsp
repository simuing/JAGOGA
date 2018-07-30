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
<title>MemberNotice.jsp</title>

<!-- 부트스트랩 CDN -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="<%= cp%>/memberAssets/css/Member.css">
<link rel="stylesheet" href="<%= cp%>/memberAssets/css/MemberLogin.css">
<script type="text/javascript">
   $(function()
   {
      var url = document.URL;
      var urlcheck = url.split('?');
      
      
      if (urlcheck[1]=='#menu1')
      {
         $("#terms1").click();
      }
      if (urlcheck[1]=='#menu2')
      {
         $("#terms2").click();
      }
      if (urlcheck[1]=='#menu3')
      {
         $("#terms3").click();
      }
      if (urlcheck[1]=='#menu4')
      {
         $("#terms4").click();
      }
      
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
      <h2>공지사항</h2>
      <ul class="nav nav-tabs">
         <li class="active"><a data-toggle="tab" href="#home" id="home">홈</a></li>
         <li><a data-toggle="tab" href="#menu1" id="terms1">새소식</a></li>
         <li><a data-toggle="tab" href="#menu2" id="terms2">이용가이드</a></li>
         <li><a data-toggle="tab" href="#menu3" id="terms3">정책 및 이용약관</a></li>
         <li><a data-toggle="tab" href="#menu3" id="terms3">개인정보 취급 방침</a></li>
      </ul>
   
      <div class="tab-content">
         <div id="menu1" class="tab-pane fade in active">
            <%-- <c:forEach var="memberNotice" items="${memberNotice}"> --%>
               <table class="table table-striped">
                  <tr>
                     <th>번호</th>
                     <th>제목</th>
                     <th>등록일</th>
                     <th>조회수</th>
                  </tr>
                  <c:forEach var="noticeList" items="${noticeList }">
                     <c:if test="${noticeList.ntHideCheck == 'N' }">
                        <tr>
                           <td>${noticeList.ntCode }</td>
                           <td><a href="noticedetail.do?ntCode=${noticeList.ntCode }">${noticeList.ntTitle }</a></td>
                           <td>${noticeList.ntRegDate }</td>
                           <td>${noticeList.ntHitCount }</td>
                        </tr>
                     </c:if>
                  </c:forEach>
               </table>
               <div>
                  <c:if test="${pageNumber != 1 }">
                     <a href="noticelist.do?pageNumber=${pageNumber-1 }"><button class="btn btn-primary">이전</button></a>
                  </c:if>
                  <!-- 원래는 되어야 한다. -->
                  <a href="noticelist.do?pageNumber=${pageNumber+1 }"><button class="btn btn-primary">다음</button></a>
               </div>
               
            <%-- </c:forEach> --%>
         </div>
         <div id="menu2" class="tab-pane fade">
            <c:forEach var="useGuide" items="${useGuideList}">
               <br>
               <h3>${useGuide.gcContent }</h3>
               <h3>${useGuide.gtitle }</h3>
               <h4>${useGuide.gcontent }</h4>
            </c:forEach>
         </div>
         <div id="menu3" class="tab-pane fade" style="margin-left: 30%;">
            <h3>정책 및 이용약관</h3>
            <textarea class="form-control" style="width: 500px; height: 400px; margin-bottom: 50px;">
               ${terms.termsContent }
            </textarea>
         </div>
         <div id="menu4" class="tab-pane fade" style="margin-left: 30%;">
            <h3>개인정보 취급방침</h3>
            <textarea class="form-control" style="width: 500px; height: 400px; margin-bottom: 50px;">
               ${termsPrivateInfo.termsContent }
            </textarea>
         </div>
      </div>
   </div>
   
<!-- 푸터 영역 -->
<c:import url="../source/MemberFooter.jsp"></c:import>

</body>
</html>