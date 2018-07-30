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
<title>MemberJoinForm2.jsp</title>

<!-- 부트스트랩 CDN -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="<%= cp%>/memberAssets/css/Member.css">
<link rel="stylesheet" href="<%= cp%>/memberAssets/css/MemberLogin.css">

<!-- javascript -->
<script type="text/javascript">
	// 발급 받은 인증번호를 담아둘 전역변수
	var myCheckNum;

	// 인증번호 발급 함수
	function createCheckNum()
	{
		var tel1 = document.getElementById("memTel1").value;
		var tel2 = document.getElementById("memTel2").value;
		var tel3 = document.getElementById("memTel3").value;
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
			alert("인증성공")
		}
		else
		{
			$("input:checkbox[id='tel_ok']").prop("checked", false);
			alert("인증실패");
		}
	}
	
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
	<h1>회원가입</h1>
	<form action="memberjoinwelcome.do" method="post">
		<table class="table jointable">
			<tr>
				<td><h4>아이디</h4><h6>(*)영어/숫자만 허용, 5 ~ 15자</h6></td>
				<td>
					<div class="form-group">
						<input id="memId" class="form-control left" type="text" name="memId" maxlength="15">
						<button id="duplicate" class="btn btn-outline-secondary"  type="button" class="btn btn-primary">중복확인</button>
					</div>
					<span id="idErrMsg" style="font-size: 9px;"></span>
				</td>
			</tr>
			<tr>
				<td><h4>비밀번호</h4><h6>(*)대/소문자구분, 10 ~ 20자</h6></td>
				<td>
					<input type="password" name="memPw" id="memPw" maxlength="20"><span></span>
				</td>
			</tr>
			<tr>
				<td><h4>비밀번호 확인</h4></td>
				<td>
					<input type="password" name="memPwCheck" id="memPwCheck" maxlength="20" onkeyup="pwCheck()">
					<span id="pwErrMsg" style="font-size: 9px; display: none"></span>
				</td>
			</tr>
			<tr>
				<td><h4>이름</h4></td>
				<td>
					<input type="text" name="memName">
				</td>
			</tr>
			<tr>
				<td><h4>주민번호</h4></td>
				<td>
					<input type="text" name="memSsn1"> -
					<input type="text" name="memSsn2" placeholder="맨앞 1자리">******
				</td>
			</tr>
			<tr>
				<td><h4>휴대폰번호</h4></td>
				<td>
					<input type="text" id="memTel1" name="memTel1"> -
					<input type="text" id="memTel2" name="memTel2"> -
					<input type="text" id="memTel3" name="memTel3">
					<span><button type="button" class="btn btn-primary" onclick="createCheckNum();">인증</button></span>
				</td>
			</tr>
			<tr>
				<td><h4>인증번호</h4></td>
				<td>
					<input type="text" id="telCheckNum">
					<span><button type="button" class="btn btn-primary" onclick="checkNum()">인증번호 확인</button></span>
				</td>
			</tr>
			<tr>
				<td><h4>이메일</h4></td>
				<td>
					<input type="email" name="memEmail">
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<button type="button" id="join" class="btn btn-primary">가입하기</button>
				</td>
			</tr>
		</table>
	
		<!-- 핸드폰 번호를 하나로 합치기 위한 태그 -->
		<input name="memTel" type="hidden">
		<input name="memSsn" type="hidden">
	
	</form>
</div>



<!-- javascript -->
<script type="text/javascript">
	$(function()
	{
		// 아이디 중복확인 버튼 클릭
		$("#duplicate").click(function()
		{
			// 입력된 값이 없을 경우
			if ( $("#memId").val()==null || $("#memId").val()=="" )
			{
				$("#idErrMsg").css("color","red");
				$('#idErrMsg').html('아이디를 입력해주세요.');
			}
			else
			{
				// AJAX 수행
				$.post("duplicateid.do", {memId:$("#memId").val()}, function(data)
				{
					// AJAX 처리에서 입력한 아이디로 COUNT 했을때 0이면
					if (data==0)
					{
						$("#idErrMsg").css("color","green");
						$('#idErrMsg').html('사용 가능한 아이디입니다.');
					}
					// 반환된 COUNT 가 0이 아니라면
					else
					{
						$("#idErrMsg").css("color","red");
						$('#idErrMsg').html('중복된 아이디입니다.');
					}
				});
			}
		});
		
		$("#join").click(function()
		{
			// 필수 정보 입력여부 및 형식 확인
			
			// 아이디 중복 확인(AJAX)
			
			// 핸드폰 번호 합치기====================================
			// 폼에서 입력한 번호 변수에 담기
			var tel1 = $("#memTel1").val();
			var tel2 = $("#memTel2").val();
			var tel3 = $("#memTel3").val();
			var tel = tel1 + "-" + tel2 + "-" + tel3;
			
			// 입력한 번호 하나로 합치고 value 로 설정해서 넘기기
			$("[name=memTel]").attr("value", tel);
			//========================================================
			
			// 주민번호 합치기========================================
			var ssn1 = $("[name=memSsn1]").val();
			var ssn2 = $("[name=memSsn2]").val();
			var ssn = ssn1 + ssn2;
			
			// 입력한 번호 하나로 합치고 value 로 설정해서 넘기기
			$("[name=memSsn]").attr("value", ssn);
			//========================================================
			
			// 핸드폰 번호 중복 확인(AJAX)
			
			// 핸드폰 인증번호 확인
			
			// 비밀번호 일치 확인
			
			// submit 수행
			$("form").submit();
		});
	});
	
	// 비밀번호 확인란에 키를 입력할 때마다 일치여부 확인해서 메시지 띄우기
	function pwCheck()
	{
		var userPassword1 = $("#memPw").val();
		var userPassword2 = $("#memPwCheck").val();
		
		$("#pwErrMsg").css("display", "inline");
		
		if(userPassword1 == userPassword2 & userPassword1 != null & userPassword1 != "")
		{
			$('#pwErrMsg').html('비밀번호가 일치합니다');
		    $("#pwErrMsg").css("color", "green");
		}
		else
		{
		   $('#pwErrMsg').html('비밀번호가 일치하지 않습니다.');
		   $("#pwErrMsg").css("color", "red");
		}
	}
</script>




<!-- 푸터 영역 -->
<c:import url="../source/MemberFooter.jsp"></c:import>
</body>
</html>