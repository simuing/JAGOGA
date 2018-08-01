<%@ page contentType="text/html; charset=UTF-8"%>
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
<title>MemberQuestion.jsp</title>

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
  <h2>FAQ</h2>
  <p><strong>Tip:</strong>자주묻는 문의를 조회해보세요.</p>
  <ul class="nav nav-tabs">
    <li class="active"><a data-toggle="tab" href="#home">이용문의</a></li>
    <li><a data-toggle="tab" href="#menu1">예약문의</a></li>
    <li><a data-toggle="tab" href="#menu2">검증문의</a></li>
    <li><a data-toggle="tab" href="#menu3">결제문의</a></li>
    <li><a data-toggle="tab" href="#menu4">회원문의</a></li>
    <li><a data-toggle="tab" href="#menu5">기타문의</a></li>
    <% if (memCode != null) { %><li><a data-toggle="tab" href="#menu6">내 문의</a></li><% }%>
  </ul>

  <div class="tab-content">
    <div id="home" class="tab-pane fade in active">
	    <c:forEach var="useFaq" items="${useFaqList}">
			<br>
			<h3>Q.${useFaq.faqContent}</h3>
			<h4>A.${useFaq.faqAns}</h4>
		</c:forEach>
    </div>
    <div id="menu1" class="tab-pane fade">
        <c:forEach var="bookingFaq" items="${bookingFaqList}">
			<br>
			<h3>Q.${bookingFaq.faqContent}</h3>
			<h4>A.${bookingFaq.faqAns}</h4>
		</c:forEach>
    </div>
    <div id="menu2" class="tab-pane fade">
        <c:forEach var="verificationFaq" items="${verificationFaqList}">
			<br>
			<h3>Q.${verificationFaq.faqContent}</h3>
			<h4>A.${verificationFaq.faqAns}</h4>
		</c:forEach>
    </div>
    <div id="menu3" class="tab-pane fade">
        <c:forEach var="payFaq" items="${payFaqList}">
			<br>
			<h3>Q.${payFaq.faqContent}</h3>
			<h4>A.${payFaq.faqAns}</h4>
		</c:forEach>
    </div>
    <div id="menu4" class="tab-pane fade">
        <c:forEach var="memberFaq" items="${memberFaqList}">
			<br>
			<h3>Q.${memberFaq.faqContent}</h3>
			<h4>A.${memberFaq.faqAns}</h4>
		</c:forEach>
    </div>
    <div id="menu5" class="tab-pane fade">
        <c:forEach var="etcFaq" items="${etcFaqList}">
			<br>
			<h3>Q.${etcFaq.faqContent}</h3>
			<h4>A.${etcFaq.faqAns}</h4>
		</c:forEach>
    </div>
    <% if (memCode != null) { %>
    <div id="menu6" class="tab-pane fade">
        <c:forEach var="myQuestion" items="${myQuestionList}">
			<br>
			<h2>Q.${myQuestion.qstTitle}</h2>
			<h4>${myQuestion.qstContent}</h4>
			<p>${myQuestion.qstDate }</p>
			<p>${myQuestion.qstAttach }</p>
			<h4>A.${myQuestion.adminAns}</h4>
			<p>${myQuestion.adminAnsDate }</p>
			<p>${myQuestion.adminId }</p>
		</c:forEach>
    </div>
    <% }%>
  </div>
  	<button type="button" id="insertMyQuestion">내문의등록</button>
</div>
<br><br><br><br><br><br><br><br><br>

<script type="text/javascript">

	$(document).ready(function()
	{
		$("#insertMyQuestion").click(function()
		{
			location.href ="addmyquestion.do"; 
		});
	});
	
</script>

<!-- 푸터 영역 -->
<c:import url="../source/MemberFooter.jsp"></c:import>
</body>
</html>