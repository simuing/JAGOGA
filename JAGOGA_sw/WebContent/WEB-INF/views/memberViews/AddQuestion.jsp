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
<title>InsertRoom2.jsp</title>

<!-- 부트스트랩 CDN -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="<%= cp%>/memberAssets/css/Member.css">
<link rel="stylesheet" href="<%= cp%>/memberAssets/css/MemberLogin.css">

<!-- 달력 -->
<script src="https://code.jquery.com/jquery-3.2.1.js"></script>
<script type='text/javascript' src='//code.jquery.com/jquery-1.8.3.js'></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.5.0/css/bootstrap-datepicker3.min.css">
<script type='text/javascript' src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.5.0/js/bootstrap-datepicker.min.js"></script>
<script src="<%=cp %>/memberAssets/js/bootstrap-datepicker.kr.js" charset="UTF-8"></script>
</head>
<body>
<!-- 메뉴 영역 -->
<% if (memCode == null) { %>
<c:import url="../source/MemberLoginMainbar.jsp"></c:import>
<% } else { %>
<c:import url="../source/MemberMainbar.jsp"></c:import>
<% } %>

<div class="container">
	<h1>글 등록하기</h1>
	<hr>
</div>

<div class="container" style="padding-left:120px; padding-right:120px;">
	<form action="insertmyquestion.do" method="post" enctype="multipart/form-data">
		<input type="hidden" value="${memCode }">
		<table>
			<tr>
				<td>제목</td>
				<td>
					<input type="text" style="width: 100%" name="qstTitle">
				</td>	
			</tr>
			
			
			<tr>
				<td>문의종류</td>
				<td>
					<select name="qstcCode">
						<c:forEach var="category" items="${category }" >
						<option value="${category.qstcCode }">${category.qstcContent }</option>
						</c:forEach>
					</select>
				</td>	
			</tr>
			
			
			<tr>
				<td>글내용</td>
				<td>
					<textarea rows="20" cols="60" name="qstContent">
					</textarea>
				</td>	
			</tr>
			<tr>
				<td>첨부파일</td>
				<td>
					<input type="text" id="fileName1" class="file_input_textbox" readonly="readonly" style="width: 250px;">
				<div class="file_input_div">
					<input type="button" value="files" class="file_input_button">
					<input type="file" class="file_input_hidden" name="rimg1" onchange="javascript:document.getElementById('fileName1').value = this.value">
				</div>
					
				
				
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<button type="submit" style="background-color: #1BB3C8; color:white; width:100%;">제출</button>
				</td>
			</tr>
		</table>
		
	
	</form>
</div>


<!-- javascript -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script><script charset="UTF-8" type="text/javascript" src="http://t1.daumcdn.net/postcode/api/core/180619/1529384927473/180619.js"></script>

<!-- 푸터 영역 -->
<c:import url="../source/MemberFooter.jsp"></c:import>
</body>
</html>