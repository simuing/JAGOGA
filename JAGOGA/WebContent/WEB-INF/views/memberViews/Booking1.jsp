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
<title>Booking1.jsp</title>

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

<div class="container">
	<div class="row">
	
		<div class="col-md-12">
			<div class="col-md-2"></div>
			<div class="col-md-8">
				<h1 style="text-align: center; margin-top: 80px;">예약, 결제 정책 및 이용약관</h1>
			</div>
			<div class="col-md-2"></div>
		</div>
		
		<!-- 구분선 --><div class="col-md-12"><hr></div>
		
		<!-- 회원가입약관 -->
		<div class="col-md-12">
			<div class="col-md-2"></div>
			<div class="col-md-8">
				<textarea rows="15" style="width: 100%;">
				${bookingTerm }
				</textarea>
				<br>
				<br>
			</div>
			<div class="col-md-2"></div>
		</div>
		<!-- END 회원가입약관 -->
		
		<!-- 약관 동의 체크 -->
		<div class="col-md-12">
			<div class="col-md-2"></div>
			<div class="col-md-8">
				<label for="agree">
					<input type="checkbox" id="agree"> 예, 정책 및 이용약관에 동의합니다.
				</label>
			</div>
			<div class="col-md-2"></div>
		</div>
		<!-- END 약관 동의 체크 -->
		
		<!-- hidden 태그 -->
		<form action="booking2.do" method="post" id="form">
			<input type="hidden" name="rcode" value="${rcode }">
			<input type="hidden" name="adultCount" value="${dto.adultCount }">
			<input type="hidden" name="childCount" value="${dto.childCount }">
			<input type="hidden" name="babyCount" value="${dto.babyCount }">
			<input type="hidden" name="bpay" value="${dto.bpay }">
			<input type="hidden" name="checkInDate" value="${dto.checkInDate }">
			<input type="hidden" name="checkOutDate" value="${dto.checkOutDate }">
			
			<div class="col-md-12">
				<div class="col-md-2"></div>
				<div class="col-md-8">
					<button type="button" id="next" class="btn nextbtn">다음으로</button>
				</div>
				<div class="col-md-2"></div>
			</div>
		</form>
	</div>
</div>

<!-- javascript -->
<script type="text/javascript">
/* 동의란 체크여부 확인 함수 */
$(function()
{
	$("#next").click(function()
	{
		// 동의란에 체크한 경우 회원가입 페이지 요청
		if ($("#agree").is(":checked")==true) {
			$("#form").submit();
		} else {
			alert('동의란에 체크해주세요.');
		}
	});
});
</script>

<!-- 푸터 영역 -->
<c:import url="../source/MemberFooter.jsp"></c:import>

</body>
</html>