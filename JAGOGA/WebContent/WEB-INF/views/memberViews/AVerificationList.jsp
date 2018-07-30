<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EmpList</title>

<!-- jquery CDN  -->
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<!-- 부트스트랩 CDN -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<style type="text/css">
	table, table td, table th
	{
		border: 1px solid black;
		text-align: center;
	}
	
	input
	{
		width: 100px;
	}
	
</style>



<script type="text/javascript">
		
		$(function()
		{
			
			// 취소사유 버튼 클릭
			$(".cause").click(function()
			{
				// Ajax 요청 및 응답 처리
				$.post("causeAjax.do", {vcode:$(this).val()}, function(data)
				{
					// 공백제거 및 모달에 사유 입력
					data = data.replace(/\s/g, "");
					$("#modal-body-content").html(data);
				});
				
				// 모달 띄우기
				$("#causeModal").modal("show");
			});
			
			// 검증대기 중인 숙소 클릭(첨부파일 조회 및 검증시작 가능)
			$(".wait").click(function()
			{
				var reqvCode = $(this).val()
				
				// Ajax 요청 및 응답 처리
				$.post("verificationAttach.do", {reqvCode:$(this).val()}, function(data)
				{
					// 공백제거 관리자 아이디 입력버튼 생성
					data = data.replace(/\s/g, "");
					$("#attach").html(data);
					
					$("#adminInput").html(function()
					{
						return "관리자아이디 : <input type='text' id='adminId'><button id='start' value='" + reqvCode + "'>시작</button>";
					});
				});
			});
			
			// 검증 중인 숙소 클릭(첨부파일 조회 및 검증시작 가능)
			$(".ing").click(function()
			{
				var reqvCode = $(this).val()
				
				// Ajax 요청 및 응답 처리
				$.post("verificationAttach.do", {reqvCode:$(this).val()}, function(data)
				{
					// 공백제거 및 모달에 사유 입력
					data = data.replace(/\s/g, "");
					$("#attach").html(data);
					$("#adminInput").html("관리자아이디 : <input type='text' id='adminId'><br>");
					$("#adminInput").append(function()
					{
						return "<button id='success' value='" + reqvCode + "'>검증성공</button><button id='fail' value='" + reqvCode + "'>검증실패</button>";
					});
				});
			});
			
			// 검증시작 (아이디 입력하지 않으면 알림문구 출력)
			$(document).on("click", "#start", function()
			{
				
				// 관리자 아이디 입력 여부 검사
				if ($("#start").val()=="")
				{
					$("#adminErr").html("관리자 아이디를 입력해주세요.");
					$("#adminErr").css("display", "inline");
				}
				else
				{
					// Ajax 요청 및 응답 처리
					$.post("verificationStart.do", {reqvCode:$(this).val(), adminId:$("#adminId").val()}, function(data1, data2)
					{
						// 공백제거 및 모달에 사유 입력
						data = data.replace(/\s/g, "");
						$("#attach").html(data);
						$("#adminInput").html("관리자아이디 : <input type='text' id='adminId'><br>");
						$("#adminInput").append(function()
						{
							return "<button id='success' value='" + reqvCode + "'>검증성공</button><button id='fail' value='" + reqvCode + "'>검증실패</button>";
						};
					});
				}
			});
			
		});
		/* $(location).attr("href", "verificationStart.do?reqvCode="+$(this).val()+"attach="+$(".attach").val()); */
		

</script>

</head>
<body>

<div>

	<div>
		<h1>[ 테스트 ]</h1>
		<br><br>
		
			<table>
				<tr>
					<th>신청번호</th>
					<th>게시물번호</th>
					<th>검증단계</th>
					<th>검증유효기간</th>
					<th>집유형</th>
					<th>호스트아이디</th>
					<th>숙소이름</th>
					<th>등록일</th>
					<th>상태</th>
					<th>관리자아이디</th>
				</tr>
				
				
				<c:forEach var="verificationList" items="${verificationList }">
					<tr>
						<td>${verificationList.reqvCode }</td>
						<td>${verificationList.rcode }</td>
						<td>${verificationList.vafterGrade.equals("B") ? "A":"B" }</td>
						<td>${verificationList.effectiveDate }</td>
						<td>${verificationList.rtype }</td>
						<td>${verificationList.memId }</td>
						<td>
							<c:choose>
							    <c:when test="${verificationList.vsContent.equals('검증대기')}">
							    	<button class="wait" value="${verificationList.reqvCode }">${verificationList.rname }</button>
							    </c:when>
							    <c:when test="${verificationList.vsContent.equals('검증 중')}">
							    	<button class="ing" value="${verificationList.reqvCode }">${verificationList.rname }</button>
							    </c:when>
							    <c:otherwise>${verificationList.rname }</c:otherwise>
							</c:choose>
						</td>
						<td>${verificationList.rregDate }</td>
						<td>
							<c:choose> 
							    <c:when test="${verificationList.vsContent.equals('검증성공')}">
							    	<button class="cause" value="${verificationList.reqvCode }">${verificationList.vsContent }</button>
							    </c:when>
							    <c:when test="${verificationList.vsContent.equals('검증실패')}">
							    	<button class="cause" value="${verificationList.reqvCode }">${verificationList.vsContent }</button>
							    </c:when>
							    <c:otherwise>${verificationList.vsContent }</c:otherwise>
							</c:choose>
						</td>
						<td>${verificationList.adminId }</td>
					</tr>
				</c:forEach>
				
			</table>
		
		<br /><br />
		
		첨부파일 : <span id="attach"></span><br>
		<span id="adminInput"></span><br>
		<span id="adminErr" style="display: none; color: red; font-size: 12px;"></span>
		
	</div>
</div>

<!-- 검증사유 모달 -->
<div id="causeModal" class="modal fade" role="dialog">
	<div class="modal-dialog">

		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">검증사유</h4>
			</div>
			<div class="modal-body">
				<span id=modal-body-content></span>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>


</body>
</html>