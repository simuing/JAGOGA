<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<title>Booking2.jsp</title>

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
	<h1>예약 및 결제</h1>
	<hr>
</div>

<div class="container" style="padding-left:120px; padding-right:120px;">
	<form action="booking3.do" method="post" onsubmit="return formCheck();" enctype="multipart/form-data">

		<!-- 숙소내용기입 -->
		<div class="row">
		
			<!-- 히든 태그 - 숙소코드 -->
			<input type="hidden" name="rcode" value="${rcode }">
		
			<!-- 예약자 이름 -->
			<div class="form-group col-md-12">
				<div class="col-md-2"></div>
				<div class="col-md-4">
					<h4>예약자 이름</h4>
					<input type="text" class="form-control" name="memName" id="memName" style="width:100%;">
				</div>
			</div>
			<!-- END 예약자 이름 -->
			
			<!-- 휴대폰인증 -->
			<div class="form-group col-md-12">
				<div class="col-md-2"></div>
				<div class="col-md-8">
					<h4>휴대폰인증</h4>
					<div class="col-md-2" style="padding:0px;"><input type="text" id="tel1" name="tel1" class="form-control" maxlength="4"></div>
					<div class="col-md-1">-</div>
					<div class="col-md-2" style="padding:0px;"><input type="text" id="tel2" name="tel2" class="form-control" maxlength="4"></div>
					<div class="col-md-1">-</div>
					<div class="col-md-2" style="padding:0px;"><input type="text" id="tel3" name="tel3" class="form-control" maxlength="4"></div>
					<div class="col-md-1"></div>
					<div class="col-md-2" style="padding:0px;">
						<button type="button" class="btn" onclick="createCheckNum();" style="background-color: #1BB3C8; color:white">휴대폰인증</button>
					</div>
				</div>
				<div class="col-md-2"></div>
			</div>
			<div class="form-group col-md-12">
				<div class="col-md-2"></div>
				<div class="col-md-8">
					<div class="col-md-8" style="padding:0px;">
						<input type="text" id="telCheckNum" name="telCheckNum" class="form-control">
						<input type="checkbox" id="tel_ok" disabled="disabled">
						인증여부
					</div>
					<div class="col-md-3">
						<button type="button" class="btn" onclick="checkNum();" style="background-color: #1BB3C8; color:white">인증번호 확인</button>
					</div>
				</div>
				<div class="col-md-2"></div>
			</div>
			<!-- END 휴대폰인증 -->
			
			<!-- 구분선 --><div class="col-md-12"><hr></div>
			
			<!-- 카드사 -->
			<div class="form-group col-md-12">
				<div class="col-md-2"></div>
				<div class="col-md-8">
					<h4>카드번호</h4>
					<div class="col-md-3">
						<select id="cardFirm" class="form-control">
							<option value="">--선택--</option>
							<option value="국민">국민</option>
							<option value="신한">신한</option>
							<option value="현대">현대</option>
							<option value="농협">농협</option>
							<option value="삼성">삼성</option>
						</select>
					</div>
					<div class="col-md-2">
						<input type="text" name="card1" class="form-control" maxlength="4">
					</div>
					<div class="col-md-2">
						<input type="text" name="card2" class="form-control" maxlength="4">
					</div>
					<div class="col-md-2">
						<input type="text" name="card3" class="form-control" maxlength="4">
					</div>
					<div class="col-md-2">
						<input type="text" name="card4" class="form-control" maxlength="4">
					</div>
				</div>
				<div class="col-md-2"></div>
			</div>
			<!-- END 카드사 -->
			
			<!-- 유효기간 -->
			<div class="form-group col-md-12">
				<div class="col-md-2"></div>
				<div class="col-md-8">
					<h4>유효기간</h4>
					<div class="col-md-2">
						<input type="text" name="cardMonth" class="form-control" value="month"  maxlength="2">
					</div>
					<div class="col-md-2">
						<input type="text" name="cardYear" class="form-control" value="year"  maxlength="2">
					</div>
				</div>
				<div class="col-md-2"  maxlength="3"></div>
			</div>
			<!-- END 유효기간 -->
			
			<!-- CVC -->
			<div class="form-group col-md-12">
				<div class="col-md-2"></div>
				<div class="col-md-8">
					<h4>CVC</h4>
					<div class="col-md-2">
						<input type="text" name="cardCVC" class="form-control">
					</div>
				</div>
				<div class="col-md-2"></div>
			</div>
			<!-- END CVC -->
			
			<!-- 구분선 --><div class="col-md-12"><hr></div>
			
			<!-- 신분증 사본 업로드 -->
			<div class="form-group col-md-12">
				<div class="col-md-2"></div>
				<div class="col-md-8">
					<h4>신분증 사본 업로드</h4>
					<div class="col-md-2">
						<input type="text" id="idCard" class="file_input_textbox" readonly="readonly" style="width: 250px;">
						<div class="file_input_div">
							<input type="button" value="files" class="file_input_button">
							<input type="file" class="file_input_hidden" name="idCard" onchange="javascript:document.getElementById('idCard').value = this.value">
						</div>
					</div>
				</div>
				<div class="col-md-2"></div>
			</div>
			<!-- END 신분증 사본 업로드 -->
			
			<!-- 예약기간 -->
			<div class="form-group col-md-12">
				<div class="col-md-2"></div>
				<div class="col-md-8">
					<h4>예약기간</h4>
					<div class="col-md-3">
						<input type="text" name="checkInDate" value="${dto.checkInDate }" readonly="readonly">${dto.checkInDate }
					</div>
					<div class="col-md-1">~</div>
					<div class="col-md-3">
						<input type="text" name="checkOutDate" value="${dto.checkOutDate }" readonly="readonly">${dto.checkOutDate }
					</div>
				</div>
				<div class="col-md-2"></div>
			</div>
			<!-- END 예약기간 -->
			
			<!-- 인원수 -->
			<div class="form-group col-md-12">
				<div class="col-md-2"></div>
				<div class="col-md-8">
					<h4>인원수</h4>
					<div class="col-md-3">
						<h4>성인 <input type="text" name="adultCount" value="${dto.adultCount }" readonly="readonly"></h4>
					</div>
					<div class="col-md-3">
						<h4>어린이 <input type="text" name="childCount" value="${dto.childCount }" readonly="readonly"></h4>
					</div>
					<div class="col-md-3">
						<h4>유아 <input type="text" name="babyCount" value="${dto.babyCount }" readonly="readonly"></h4>
					</div>
					<div class="col-md-3">
						<h4>결제금액 : <input type="text" name="bpay" value="${dto.bpay }" readonly="readonly"></h4>
					</div>
				</div>
				<div class="col-md-2"></div>
			</div>
			<!-- END 인원수 -->
			
		</div>
		<!-- END 숙소내용기입 -->
		
		<!-- 구분선 --><div class="col-md-12"><hr></div>
		
		<!-- 예약하기 버튼 -->
		<div class="form-group col-md-12">
			<div class="col-md-2"></div>
			<div class="col-md-8">
				<button type="submit" class="btn" style="background-color: #1BB3C8; color:white; width:100%;">예약하기</button>
			</div>
			<div class="col-md-2"></div>
		</div>
		<!-- END 취소 / 등록 버튼 -->
		
		<!-- 구분선 --><div class="col-md-12" style="margin-bottom: 100px;"></div>
		
	</form>
</div>

<!-- javascript -->
<script type="text/javascript">
	// 발급 받은 인증번호를 담아둘 전역변수
	var myCheckNum;

	// 인증번호 발급 함수
	function createCheckNum()
	{
		var tel1 = document.getElementById("tel1").value;
		var tel2 = document.getElementById("tel2").value;
		var tel3 = document.getElementById("tel3").value;
		var telCheckNum = document.getElementById("telCheckNum");
		
		if (tel1 != "" && tel2 != "" && tel3 != "")
		{
			var checkNum = Math.floor(Math.random() * 90000) + 10000;
		
			alert("인증번호가 발급되었습니다.");
		
			telCheckNum.value = checkNum;
			
			myCheckNum = checkNum;
		}
		else
			alert("휴대폰 번호를 입력해주세요");
	}
	
	// 인증번호 확인 함수
	function checkNum()
	{
		var telCheckNum = document.getElementById("telCheckNum").value;
		var checkNum = telCheckNum;
		
		if (myCheckNum == telCheckNum)
		{
			$("input:checkbox[id='tel_ok']").prop("checked", true);

			/* $("input[type=checkbox][checked]").each(
				function (){
				$(this).attr('checked', false);
			}); */
		}
		else
		{
			$("input:checkbox[id='tel_ok']").prop("checked", false);
			alert("인증실패");
		}
	}
	
</script>

<script type="text/javascript">
/* form check */
function formCheck()
{
	// 1. 예약자 이름 유효성체크
	if ($("#memName").val() == null || $("#memName").val() == ""){
		
		// 예약자 이름 미기입시 오류메세지 출력
		$("#memName").css("border", "1px solid red");
		alert("예약자 이름을 입력해주세요.");
		return false;
		
	} else {
		$("#memName").css("border", "1px solid #ccc");
	}
	
	// 2. 휴대폰인증여부 체크
	if ($('input:checkbox[id="tel_ok"]').is(":checked") == false) {
		
		// 인증확인 체크가 안됐을 경우 에러메세지 출력
		$("#telCheckNum").css("border", "1px solid red");
		alert("휴대폰 인증이 필요합니다.");
		return false;
	} else {
		$("#telCheckNum").css("border", "1px solid #ccc");
	}
	
	// 3. 카드번호 유효성체크
	// Ajax 처리 보류
	
	// 4. 신분증 유효성체크
	if ($("#idCard").val() == null || $("#idCard").val() == "")
	{
		// 신분증 미업로드시 오류메세지 출력
		$("#idCard").css("border", "1px solid red");
		alert("신분증을 등록해주세요.");
		return false;
		
	} else {
		$("#idCard").css("border", "1px solid #ccc");
	}
	
	// 5. 모든 유효성 통과시 전송요청
	return true;
}
</script>

<!-- 푸터 영역 -->
<c:import url="../source/MemberFooter.jsp"></c:import>
</body>
</html>