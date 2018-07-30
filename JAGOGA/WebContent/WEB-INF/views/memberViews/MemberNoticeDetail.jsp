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
<title>MemberNoticeDetail.jsp</title>

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
      
      if (urlcheck[1]=='#home')
      {
         $("#terms1").click();
      }
      if (urlcheck[1]=='#menu1')
      {
         $("#terms2").click();
      }
      if (urlcheck[1]=='#menu2')
      {
         $("#terms3").click();
      }
      if (urlcheck[1]=='#menu3')
      {
         $("#terms4").click();
      }
   });
    
    $("#home").click(function()
    {
       $("#terms1").click();
    });
</script>


<script type="text/javascript">
    $(function () {
        var hash = window.location.hash;
        hash && $('ul.nav a[href="' + hash + '"]').tab('show');
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
      <table class="table table-striped table-hover">
         <tr>
            <th>제목</th>
            <td>${noticeDetail.ntTitle }</td>
         </tr>
         <tr>
            <th>등록일</th>
            <td>${noticeDetail.ntRegDate }</td>
         </tr>
         <tr>
            <th>내용</th>
            <td style="height: 500px;">${noticeDetail.ntContent }</td>
         </tr>
         <tr>
            <th>첨부파일</th>
            <td>
               <a href="mntattachdownload.do?ntAttach=${fn:substringAfter(noticeDetail.ntAttach, 'noticeAttach/') }">
                  ${fn:substringAfter(noticeDetail.ntAttach, 'noticeAttach/') }
               </a>
            </td>
         </tr>
      </table>
      <a href="noticelist.do"><button type="button" class="btn btn-primary">목록으로</button></a>
   </div>
   
<!-- 푸터 영역 -->
<c:import url="../source/MemberFooter.jsp"></c:import>

</body>
</html>