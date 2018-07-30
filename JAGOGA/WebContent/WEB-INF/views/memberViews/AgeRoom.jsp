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
<title>AgeRoom.jsp</title>
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



<!-- 20대 추천 숙소 -->
<div class="container box">
	<div class="recommend-title-box">
		<div class="recommend-title">20대 추천 숙소</div>
	</div>
	<br>
	<div class="container-fluid">
		<c:forEach var="ageRoom" items="${ageRoomList20 }">
			<div class="room-item">
				<a href="${ageRoom.rcode }"></a>
				<img src="roomImage/${fn:substringAfter(ageRoom.rimg, 'roomImage/') }" width="100%" height="auto"/>
				<div>${ageRoom.rname }</div>
				<div>${ageRoom.adultFee }원 / 박</div>
				<div><span class="star-prototype">${ageRoom.avgPoint }</span>${ageRoom.avgPoint }</div>
			</div>
		</c:forEach>
    </div>
</div>

<!-- 30대 추천 숙소 -->
<div class="container box">
	<div class="recommend-title-box">
		<div class="recommend-title">30대 추천 숙소</div>
	</div>
	<br>
	<div class="container-fluid">
		<c:forEach var="ageRoom" items="${ageRoomList30 }">
			<div class="room-item">
				<a href="${ageRoom.rcode }"></a>
				<img src="${ageRoom.rimg }" />
				<div>${ageRoom.rname }</div>
				<div>${ageRoom.adultFee }원 / 박</div>
				<div><span class="star-prototype">${ageRoom.avgPoint }</span>${ageRoom.avgPoint }</div>
			</div>
		</c:forEach>
    </div>
</div>

<!-- 40대 추천 숙소 -->
<div class="container box">
	<div class="recommend-title-box">
		<div class="recommend-title">40대 추천 숙소</div>
	</div>
	<br>
	<div class="container-fluid">
		<c:forEach var="ageRoom" items="${ageRoomList40 }">
			<div class="room-item">
				<a href="${ageRoom.rcode }"></a>
				<img src="${ageRoom.rimg }" />
				<div>${ageRoom.rname }</div>
				<div>${ageRoom.adultFee }원 / 박</div>
				<div><span class="star-prototype">${ageRoom.avgPoint }</span>${ageRoom.avgPoint }</div>
			</div>
		</c:forEach>
    </div>
</div>

<!-- 50대 추천 숙소 -->
<div class="container box">
	<div class="recommend-title-box">
		<div class="recommend-title">50대 추천 숙소</div>
	</div>
	<br>
	<div class="container-fluid">
		<c:forEach var="ageRoom" items="${ageRoomList50 }">
			<div class="room-item">
				<a href="${ageRoom.rcode }"></a>
				<img src="${ageRoom.rimg }" />
				<div>${ageRoom.rname }</div>
				<div>${ageRoom.adultFee }원 / 박</div>
				<div><span class="star-prototype">${ageRoom.avgPoint }</span>${ageRoom.avgPoint }</div>
			</div>
		</c:forEach>
    </div>
</div>


<!-- 푸터 영역 -->
<c:import url="../source/MemberFooter.jsp"></c:import>

</body>
</html>