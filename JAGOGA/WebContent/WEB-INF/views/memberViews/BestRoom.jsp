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
<title>BestRoom.jsp</title>
<!-- 부트스트랩 CDN -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="<%= cp%>/memberAssets/css/Member.css">
<link rel="stylesheet" href="<%= cp%>/memberAssets/css/MemberLogin.css">
<link rel="stylesheet" href="<%= cp%>/memberAssets/css/Search.css">

</head>
<body>

<!-- 메뉴 영역 -->
<% if (memCode == null) { %>
<c:import url="../source/MemberLoginMainbar.jsp"></c:import>
<% } else { %>
<c:import url="../source/MemberMainbar.jsp"></c:import>
<% } %>


<!-- 검색 영역 -->
<div class="input-group search-box">
	<input type="text" class="form-control" placeholder="${search }">
	<span class="input-group-btn">
		<button class="btn btn-default btn-search" type="button">
			<span class="glyphicon glyphicon-search"></span>
		</button>
	</span>
</div>



<!-- 추천 숙소 영역 (인기방) -->
<div class="container box">
	<div class="recommend-title-box">
		<div class="recommend-title">인기방</div>
		<div class="recommend-all"><a href="#" style="color: #000000;">전체보기</a></div>
	</div>
	<br>
	<div class="container">
		<c:forEach var="bestRoom" items="${bestRoomList }">
			<div class="room-item">
				<a href="${bestRoom.rcode }"></a>
				<img src="roomImage/${fn:substringAfter(bestRoom.rimg, 'roomImage/') }" width="100%" height="auto"/>
				<div>${bestRoom.rname }</div>
				<div>${bestRoom.adultFee }원 / 박</div>
				<div><span class="star-prototype">${bestRoom.avgPoint }</span>${bestRoom.avgPoint }</div> 
			</div>
		</c:forEach>
    </div>
</div>


<script type="text/javascript">
$(function()
{
	$(".btn-search").click(function()
	{
		$(location).attr("href", "searchroom.do?search=" + $(".form-control").val());
	});
});
</script>
<!-- 푸터 영역 -->
<c:import url="../source/MemberFooter.jsp"></c:import>
</body>
</html>