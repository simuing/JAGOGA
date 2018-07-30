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
<title>Main.jsp</title>

<!-- 부트스트랩 CDN -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="<%= cp%>/memberAssets/css/Member.css">
<link rel="stylesheet" href="<%= cp%>/memberAssets/css/MemberLogin.css">

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
<div id="myCarousel" class="carousel slide" data-ride="carousel">
	<div class="carousel-inner">
		<div class="item active">
			<img src="memberAssets/img/mainimg.jpg" style="width: 100%; margin: auto;" />
			<div class="carousel-caption">
				<!-- 검색창 -->
				<div class="input-group">
					<input type="text" class="form-control" placeholder="숙소를 검색해보세요" id="search">
					<span class="input-group-btn">
						<button class="btn btn-default btn-search" type="button">
							<span class="glyphicon glyphicon-search"></span>
						</button>
					</span>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- 추천 숙소 영역 (인기방) -->
<div class="container box">
	<div class="recommend-title-box">
		<div class="recommend-title">인기방</div>
		<div class="recommend-all"><a href="bestroom.do" style="color: #000000;">전체보기</a></div>
	</div>
	<br>
	<div class="container-fluid">
		<c:forEach var="bestRoom" items="${bestRoomList }" begin="0" step="1" end="4">
			<div class="room-item">
				<a href="roomdetail.do?rcode=${bestRoom.rcode }">
					<img src="roomImage/${fn:substringAfter(bestRoom.rimg, 'roomImage/') }" width="100%" height="auto"/>
					<div>${bestRoom.rname }</div>
				</a>
				<div>${bestRoom.adultFee }원 / 박</div>
				<div><span class="star-prototype">${bestRoom.avgPoint }</span>${bestRoom.avgPoint }</div>
				<div><a href="like.do?rcode=${bestRoom.rcode }">찜하기</a></div>
			</div>
		</c:forEach>
    </div>
</div>



<!-- 추천 숙소 영역 (연령별) -->
<div class="container box">
	<div class="recommend-title-box">
		<div class="recommend-title">${age }대 추천 숙소</div>
		<div class="recommend-all"><a href="ageroom.do" style="color: #000000;">전체보기</a></div>
	</div>
	<br>
	<div class="container-fluid">
		<c:forEach var="ageRoom" items="${ageRoomList }" begin="0" step="1" end="4">
			<div class="room-item">
				<a href="roomdetail.do?rcode=${ageRoom.rcode }">
					<img src="roomImage/${fn:substringAfter(ageRoom.rimg, 'roomImage/') }" width="100%" height="auto"/>
					<div>${ageRoom.rname }</div>
				</a>
				<div>${ageRoom.adultFee }원 / 박</div>
				<div><span class="star-prototype">${ageRoom.avgPoint }</span>${ageRoom.avgPoint }</div>
				<div><a href="like.do?rcode=${bestRoom.rcode }">찜하기</a></div>
			</div>
		</c:forEach>
    </div>
</div>

<!-- 추천 키워드 -->
<div class="container box">
	<div class="recommend-title-box">
		<div class="recommend-title">HOT 키워드</div>
	</div>
	<br>
	<div class="container-fluid">
		<br>
		<c:forEach var="bestKeyword" items="${bestKeywordList }" begin="0" step="1" end="4">
			<div class="hotkeyword-item">
				<h1><a href="searchroom.do?search=${bestKeyword }">${bestKeyword }</a></h1>
			</div>
		</c:forEach>
    </div>
</div>

<script type="text/javascript">
	$(function()
	{
		$(".btn-search").click(function()
		{
			if ($("#search").val()=="adminmain.do") 
			{
				window.location.href='adminmain.do';
				return;
			}
			if ($("#search").val()=="") 
			{
				alert("검색어를 입력해주세요");
				return;
			}
			$(location).attr("href", "searchroom.do?search=" + $("#search").val());
		});
	});
	
</script>

<!-- 푸터 영역 -->
<c:import url="../source/MemberFooter.jsp"></c:import>
</body>
</html>