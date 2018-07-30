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
<title>MyInfoUpdateForm.jsp</title>

<!-- 부트스트랩 CDN -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="<%= cp%>/memberAssets/css/Member.css">
<link rel="stylesheet" href="<%= cp%>/memberAssets/css/MemberLogin.css">

<script type="text/javascript">

   $(document).ready(function()
   {
      // 취소 버튼이 눌리면 실행
      $("#cancel").click(function() 
      {
         // form의 action 속성 바꾼뒤 submit 수행
         document.form.action = "myinformation.do"
         document.form.submit();
      });
      
      // 수정 버튼이 눌리면 실행
      $("#update").click(function()
      {
         // 폼에서 입력한 번호 변수에 담기
         var tel1 = $("#memTel1").val();
         var tel2 = $("#memTel2").val();
         var tel3 = $("#memTel3").val();
         var tel = tel1 + "-" + tel2 + "-" + tel3;
         
         // 입력한 번호 하나로 합치고 value 로 설정해서 넘기기
         $("[name=memTel]").attr("value", tel);
         
         document.form.submit();
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

</head>
<body>

<!-- 회원 상단 메뉴바 영역 -->
<% if (memCode == null) { %>
<c:import url="../source/MemberLoginMainbar.jsp"></c:import>
<% } else { %>
<c:import url="../source/MemberMainbar.jsp"></c:import>
<% } %>
<div class="container">

   <h1>내 정보 수정</h1>
   <h2>회원님의 JAGOGA 회원정보를 수정할 수 있습니다.</h2>
   
   <form name="form" action="updatemyinfo.do" method="post" enctype="multipart/form-data">
      
      <table class="table table-striped">
         <tr>
            <td>아이디</td>
            <td>${memInfo.memId}</td>
         </tr>
         <tr>
            <td>비밀번호</td>
            <td><input id="memPw" type="password" name="memPw"></td>
         </tr>
         <tr>
            <td>비밀번호 확인</td>
            <td><input id="memPwCheck" type="password" name="memPwCheck" onkeyup="pwCheck()"><span id="pwErrMsg" style="color: red;"></span></td>
         </tr>
         <tr>
            <td>이름</td>
            <td>${memInfo.memName}</td>
         </tr>
         <tr>
            <td>주민번호</td>
            <td>${memInfo.memSsn}</td>
         </tr>
         <tr>
            <td>휴대폰번호</td>
            <td>
               <input type="text" id="memTel1" value="${memInfo.memTel.substring(0,3) }"> -
               <input type="text" id="memTel2" value="${memInfo.memTel.substring(4,8) }"> -
               <input type="text" id="memTel3" value="${memInfo.memTel.substring(9,13) }">
               <span><button type="button" class="btn btn-primary">인증</button></span>
            </td>
         </tr>
         <tr>
            <td>인증번호</td>
            <td>
               <input type="text" id="telCheckNum">
               <span><button type="button" class="btn btn-primary">인증번호 확인</button></span>
            </td>
         </tr>
         <tr>
            <td>이메일</td>
            <td>
               <input type="email" name="memEmail" value="${memInfo.memEmail }">
            </td>
         </tr>
         <tr>
            <td>프로필사진 등록</td>
            <td>
               <input type="file" name="memProfile">
            </td>
         </tr>         
         <tr>
            <td>에티켓등급</td>
            <td>아이콘으로 표시</td>
         </tr>
      </table>
      
      
      <button id="update" class="btn btn-primary">수정</button>
      <button id="cancel" class="btn btn-primary">취소</button>
      <button type="button" class="btn btn-primary" onclick="window.location.href='leavepwform.do'">회원탈퇴</button>
      <input name="memTel" type="hidden">
   </form>

</div>

<!-- 푸터 영역 -->
<c:import url="../source/MemberFooter.jsp"></c:import>

</body>
</html>