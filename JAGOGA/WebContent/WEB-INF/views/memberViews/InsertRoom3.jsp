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
<title>InsertRoom3.jsp</title>

<!-- 부트스트랩 CDN -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="<%= cp%>/memberAssets/css/Member.css">
<link rel="stylesheet" href="<%= cp%>/memberAssets/css/MemberLogin.css">

</head>
<body>
<!-- 메뉴 영역 -->
<% if (memCode == null) { %>
<c:import url="../source/MemberLoginMainbar.jsp"></c:import>
<% } else { %>
<c:import url="../source/MemberMainbar.jsp"></c:import>
<% } %>

<div class="container" style="padding-left:120px; padding-right:120px;">
	<div class="row">
	
		<div class="col-md-12">
			<h1>숙소 정보 확인</h1>
		</div>
		
		<!-- 구분선 --><div class="col-md-12"><hr></div>
		
		<br><br><br><br>
		
		<!-- 등록된 숙소정보 조회 -->
		<form action="insertroom4.do" method="get">
			<div class="col-md-2"></div>
				<div class="col-md-8" style="border: 1px solid lightgray;">
					<br><br>
					
					<div class="form-group col-md-12">
						<h4>숙소이름</h4>
						<div>${room.rname }</div>
					</div>
					
					<div class="form-group col-md-12">
						<h4>숙소 위치</h4>
						<div>${room.rzipCode } ${room.rbasicAddr } ${room.rdetailAddr }</div>
					</div>
					
					<!-- 구분선 --><div class="col-md-12"><hr></div>
					
					<div class="form-group col-md-3">
						<h4>숙소 유형</h4>
						<div>${rtype.rtype }</div>
					</div>
					
					<div class="form-group col-md-3">
						<h4>숙소면적</h4>
						<div>${room.rarea } ㎡</div>
					</div>
					
					<div class="form-group col-md-3">
						<h4>숙박 인원</h4>
						<div>최소 ${room.minHumanCount } 명</div>
						<div>최대 ${room.maxHumanCount } 명</div>
					</div>
					
					<div class="form-group col-md-3">
						<h4>숙소요금</h4>
						<div>성　인 : ${room.adultFee }</div>
						<div>어린이 : ${room.childFee }</div>
					</div>
					
					<!-- 구분선 --><div class="col-md-12"><hr></div>
					
					<div class="form-group col-md-4">
						<h4>제공하는 편의시설</h4>
						<c:forEach var="conv" items="${convList }">
							<div>${conv.convContent}&nbsp;&nbsp;</div>
						</c:forEach>
					</div>
					
					<div class="form-group col-md-4">
						<h4>제공하는 제한사항</h4>
						<c:forEach var="cons" items="${consList }">
							<div>${cons.consContent}&nbsp;&nbsp;</div>
						</c:forEach>
					</div>
					
					<div class="form-group col-md-4">
						<h4>예약가능일</h4>
						<c:forEach var="bookable" items="${bookableList }">
							<div>${bookable.startDate } ~ ${bookable.endDate }</div>
						</c:forEach>
					</div>
					
					<!--추천요금 생략-->
					<br><br>
					
				
			</div>
			<div class="col-md-2"></div>
			<!-- END 등록된 숙소정보 조회 -->
			
			<!-- 다음으로 버튼 -->
			<div class="col-md-12">
				<div class="col-md-2"></div>
				<div class="col-md-8">
					<button type="submit" class="btn nextbtn">다음으로</button>
				</div>
				<div class="col-md-2"></div>
			</div>
		</form>
		
	</div>
</div>

<!-- 푸터 영역 -->
<c:import url="../source/MemberFooter.jsp"></c:import>

</body>
</html>