<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% 
	request.setCharacterEncoding("UTF-8"); 
	String cp = request.getContextPath();
%>
<%
	String memId = null;
	/* if (session.getAttribute("id") != null) 
		memId = (String)session.getAttribute("id"); */
%>
<!doctype html>
<html lang="en">

<head>
	<title>Admin Question</title>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
	<!-- VENDOR CSS -->
	<link rel="stylesheet" href="assets/vendor/bootstrap/css/bootstrap.css">
	<link rel="stylesheet" href="assets/vendor/font-awesome/css/font-awesome.min.css">
	<link rel="stylesheet" href="assets/vendor/linearicons/style.css">
	<link rel="stylesheet" href="assets/vendor/chartist/css/chartist-custom.css">
	<!-- MAIN CSS -->
	<link rel="stylesheet" href="assets/css/main.css">
	<link rel="stylesheet" href="assets/css/admin.css">
	<!-- GOOGLE FONTS -->
	<link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700" rel="stylesheet">
	<!-- ICONS -->
	<link rel="apple-touch-icon" sizes="76x76" href="assets/img/apple-icon.png">
	<link rel="icon" type="image/png" sizes="96x96" href="assets/img/favicon.png">
	<!-- jquery -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	
	<script type="text/javascript">
		
		$(function()
		{
			// 답변 등록버튼을 누를 때 실행
			$("#register").click(function()
			{
				$(location).attr("href", "questionanswer.do?qstCode="+$(this).val()+"&adminId="+$("#adminId").val()+"&adminAns="+$("[name=adminAns]").val());
			});
			
			// FAQ 삭제
			$(".faqDelete").click(function()
			{
				$(location).attr("href", "faqdelete.do?faqCode=" + $(this).val());
			});
			
			// 정책 및 이용약관 수정
			// 수정상태를 확인하는 변수 선언 
			var policyState = 0;
			$("#policyModify").click(function()
			{
				// 상태가 0(수정시도)이면
				if (policyState==0)
				{
					policyState=1;
					$("#policy").removeAttr("disabled");
					$("#policyModify").html("수정완료");
				}
				else 	// 상태가 1(수정완료)이면
				{
					$(location).attr("href", "termsmodify.do?termsContent=" + $("#policy").val().replace(/\n/g, '<br>') + "&select=1");
				}// .replace(/\n/g, '<br>')
			});
			
			// 개인정보 취급방침 수정
			// 수정상태를 확인하는 변수 선언
			var privacyState = 0;
			$("#privacyModify").click(function()
			{
				// 상태가 0(없음→수정)이면
				if (privacyState==0)
				{
					privacyState=1;
					$("#privacy").removeAttr("disabled");
					$("#privacyModify").html("수정완료");
				}
				else 	// 상태가 1(수정→수정완료)이면
				{
					$(location).attr("href", "termsmodify.do?termsContent=" + $("#policy").val().replace(/\n/g, '<br>') + "&select=2");
				}
			});
			
			
			
			// 문의 내용에 답변이 있으면 도큐먼트 속성값 변경
			if (${qstContent.qstAnsState=="답변완료"})
			{
				// 답변 등록버튼 비활성화
				$("#register").attr("disabled", "disabled");
				$("#register").html("등록완료");
				
				// 처리자 입력란 readonly 부여
				$("#adminId").attr("readonly", "readonly");
				
				// 문의 답변란 readonly 부여
				$("[name=adminAns]").attr("readonly", "readonly");
			}
		});
		
		
	</script>
	
	
</head>
<body>
<!-- WRAPPER -->
<div id="wrapper">

	<!-- NAVBAR, SIDEBAR -->
	<c:import url="AdminMainbar.jsp"></c:import>
	
	<!-- MAIN -->
	<div class="main">
		<div class="main-content">
			<div class="container-fluid">
				<div class="row" >
					<!-- 문의 목록 -->
					<div class="col-md-6">
						<div class="panel panel-headline">
							<div class="panel-heading">
								<div class="row">
									<div class="col-md-12">
										<h3 class="panel-title">문의 목록</h3>
									</div>
								</div>
							</div>
							<div class="panel-body">
								<table class="table">
									<thead>
										<tr>
											<th>문의코드</th>
											<th>문의분류</th>
											<th>문의제목</th>
											<th>문의아이디</th>
											<th>답변상태</th>
											<th>처리자</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="question" items="${questionList }">
											<tr>
												<td>${question.qstCode }</td>
												<td>[${question.qstcContent }]</td>
												<td><a href="qstcontent.do?qstCode=${question.qstCode }">${question.qstTitle }</a></td>
												<td>${question.memId }</td>
												<td>${question.qstAnsState }</td>
												<td>${question.adminId }</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
								<div>
									<c:if test="${pageNumber != 1 }">
										<a href="adminquestion.do?pageNumber=${pageNumber-1 }"><button class="btn btn-primary">이전</button></a>
									</c:if>
									<!-- 원래는 되어야 한다. -->
									<a href="adminquestion.do?pageNumber=${pageNumber+1 }"><button class="btn btn-primary">다음</button></a>
								</div>
							</div>
						</div>
					</div>
					<!-- END 문의목록 -->
					<!-- 문의 내용 -->
					<div class="col-md-6">
						<div class="panel panel-headline">
							<div class="panel-heading">
								<div class="row">
									<div class="col-md-12">
										<h3 class="panel-title">문의 내용</h3>
										<div class="right">
											<p class="qstanswer">${qstContent.qstAnsState }</p>
										</div>
									</div>
								</div>
							</div>
							<div class="panel-body">
								<div class="row">
									<div class="col-md-12">
										<div class="panel" style="border:1px solid lightgray;">
										<c:if test="${qstContent!=null }">
											<div class="panel-heading">
												<h4><span>[${qstContent.qstcContent}] </span> ${qstContent.qstTitle }</h4>
												<p>${qstContent.qstContent }</p>
											</div>
											<div class="panel-body">
												<hr>
												<div class="row">
													<div class="col-md-4">
													    <span class="input-group-text" id="inputGroup-sizing-sm">관리자아이디 :</span>
													</div>
													<div class="col-md-8">
													    <input id="adminId" type="text" class="form-control" aria-label="Small" aria-describedby="inputGroup-sizing-sm" value="${qstContent.adminId }">
													</div>
													<div class="col-md-12">
														<!-- textarea 이어서 개행하면 프론트에 적용되기 때문에 개행안함 -->
														<textarea name="adminAns" class="form-control" rows="5" style="resize:none;">${qstContent.adminAns }</textarea>
														<button id="register" value="${qstContent.qstCode }" type="button" class="btn btn-default updatebtn" style="width:100%; height: 30px;">등록</button>
													</div>
												</div>
											</div>
											<div class="col-md-12">
												<p class="left">첨부파일 : ${qstContent.qstAttach }</p>
												<p class="right">문의 아이디 : ${qstContent.memId }</p>
											</div>
											</c:if>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<!-- END 문의 내용 -->
				</div>
					
				<!-- 자주 묻는 문의 (FAQ) -->
				<div class="panel panel-headline">
					<div class="panel-heading">
						<div class="row">
							<div class="col-md-12">
								<h3 class="panel-title">자주 묻는 문의 (FAQ)</h3>
							</div>
						</div>
					</div>
					<div class="panel-body">
						<div class="row">
							<div class="col-md-12">
								<div class="tab">
								  <button class="tablinks" onclick="openCity(event, 'use')" id="defaultOpen">이용문의</button>
								  <button class="tablinks" onclick="openCity(event, 'booking')">예약문의</button>
								  <button class="tablinks" onclick="openCity(event, 'verification')">검증문의</button>
								  <button class="tablinks" onclick="openCity(event, 'pay')">결제문의</button>
								  <button class="tablinks" onclick="openCity(event, 'member')">회원정보</button>
								  <button class="tablinks" onclick="openCity(event, 'etc')">기타문의</button>
								</div>
								
								<!-- 모달버튼 : data-toggle="modal" data-target="#faqModal" -->
								<div id="use" class="tabcontent">
								<c:forEach var="faqList" items="${faqList }">
									<c:if test="${faqList.qstcContent=='이용문의' }">
										<h4><span>[${faqList.qstcContent }]</span>
											  ${faqList.faqTitle }
										 <button type="button" class="btn btn-default updatebtn" value="${faqList.faqCode }">수정</button>
										 <button type="button" class="btn btn-default deletebtn faqDelete" value="${faqList.faqCode }">삭제</button>
										</h4>
										<p>${faqList.faqContent }</p>
										<h4><span class="ans">[답변]</span>${faqList.faqAns }</h4>
										<br>
									</c:if>
								</c:forEach>
								</div>
								
								<div id="booking" class="tabcontent">
								<c:forEach var="faqList" items="${faqList }">
									<c:if test="${faqList.qstcContent=='예약문의' }">
										<h4><span>[${faqList.qstcContent }]</span>
											  ${faqList.faqTitle }
										 <button type="button" class="btn btn-default updatebtn" value="${faqList.faqCode }">수정</button>
										 <button type="button" class="btn btn-default deletebtn faqDelete" value="${faqList.faqCode }">삭제</button>
										</h4>
										<p>${faqList.faqContent }</p>
										<h4><span class="ans">[답변]</span>${faqList.faqAns }</h4>
										<br>
									</c:if>
								</c:forEach>
								</div>
								
								<div id="verification" class="tabcontent">
								<c:forEach var="faqList" items="${faqList }">
									<c:if test="${faqList.qstcContent=='검증문의' }">
										<h4><span>[${faqList.qstcContent }]</span>
											  ${faqList.faqTitle }
										 <button type="button" class="btn btn-default updatebtn" value="${faqList.faqCode }">수정</button>
										 <button type="button" class="btn btn-default deletebtn faqDelete" value="${faqList.faqCode }">삭제</button>
										</h4>
										<p>${faqList.faqContent }</p>
										<h4><span class="ans">[답변]</span>${faqList.faqAns }</h4>
										<br>
									</c:if>
								</c:forEach>
								</div>
								
								<div id="pay" class="tabcontent">
								<c:forEach var="faqList" items="${faqList }">
									<c:if test="${faqList.qstcContent=='결제문의' }">
										<h4><span>[${faqList.qstcContent }]</span>
											  ${faqList.faqTitle }
										 <button type="button" class="btn btn-default updatebtn" value="${faqList.faqCode }">수정</button>
										 <button type="button" class="btn btn-default deletebtn faqDelete" value="${faqList.faqCode }">삭제</button>
										</h4>
										<p>${faqList.faqContent }</p>
										<h4><span class="ans">[답변]</span>${faqList.faqAns }</h4>
										<br>
									</c:if>
								</c:forEach>
								</div>
								
								<div id="member" class="tabcontent">
								<c:forEach var="faqList" items="${faqList }">
									<c:if test="${faqList.qstcContent=='회원정보' }">
										<h4><span>[${faqList.qstcContent }]</span>
											  ${faqList.faqTitle }
										 <button type="button" class="btn btn-default updatebtn" value="${faqList.faqCode }">수정</button>
										 <button type="button" class="btn btn-default deletebtn faqDelete" value="${faqList.faqCode }">삭제</button>
										</h4>
										<p>${faqList.faqContent }</p>
										<h4><span class="ans">[답변]</span>${faqList.faqAns }</h4>
										<br>
									</c:if>
								</c:forEach>
								</div>
								
								<div id="etc" class="tabcontent">
								<c:forEach var="faqList" items="${faqList }">
									<c:if test="${faqList.qstcContent=='기타문의' }">
										<h4><span>[${faqList.qstcContent }]</span>
											  ${faqList.faqTitle }
										 <button type="button" class="btn btn-default updatebtn" value="${faqList.faqCode }">수정</button>
										 <button type="button" class="btn btn-default deletebtn faqDelete" value="${faqList.faqCode }">삭제</button>
										</h4>
										<p>${faqList.faqContent }</p>
										<h4><span class="ans">[답변]</span>${faqList.faqAns }</h4>
										<br>
									</c:if>
								</c:forEach>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-md-12">
								<div class="right">
									<button type="button" class="btn btn-default insertbtn">등록</button>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- END 자주 묻는 문의 (FAQ) -->
				<!-- 정책 및 이용약관 -->
				<div class="row">
					<div class="col-md-6">
						<div class="panel panel-headline">
							<div class="panel-heading">
								<div class="row">
									<div class="col-md-12">
										<h3 class="panel-title">정책 및 이용약관</h3>
										<div class="right">
											<button type="button" class="btn-toggle-collapse">
												<i class="lnr lnr-chevron-down"></i>
											</button>
										</div>
									</div>
								</div>
							</div>
							<div class="panel-body">
								<div class="row">
									<div class="col-md-12">
										  <form>
										    <div class="form-group">
										      <textarea class="form-control" rows="15" id="policy" disabled="disabled" style="resize:none;">${policiesTerms.termsContent }</textarea>
										    </div>
										  </form>
										  <button id="policyModify" type="button"  class="btn btn-default updatebtn" style="width:100%; height: 30px;">수정</button>
									</div>
								</div>
							</div>
						</div>
					</div>
					<!-- END 정책 및 이용약관 -->
					<!-- 개인정보취급방침 -->
					<div class="col-md-6">
						<div class="panel panel-headline">
							<div class="panel-heading">
								<div class="row">
									<div class="col-md-12">
										<h3 class="panel-title">개인정보취급방침</h3>
										<div class="right">
											<button type="button" class="btn-toggle-collapse">
												<i class="lnr lnr-chevron-down"></i>
											</button>
										</div>
									</div>
								</div>
							</div>
							<div class="panel-body">
								<div class="row">
									<div class="col-md-12">
										  <form>
										    <div class="form-group">
										      <textarea class="form-control" rows="15" id="privacy" disabled="disabled" style="resize:none;">${privacyTerms.termsContent }</textarea>
										    </div>
										  </form>
										  <button id="privacyModify" type="button"  class="btn btn-default updatebtn" style="width:100%; height: 30px;">수정</button>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- END 개인정보취급방침 -->
			</div>
		</div>
	</div>
	<!-- END MAIN -->	
	
	<!-- FAQ 수정 및 등록 모달 -->
	<!-- 
	<div id="faqModal" class="modal fade">
		<div class="modal-dialog modal-login">
			<div class="modal-content">
				<div class="modal-header">				
					<h4 class="modal-title mainbar">FAQ 수정
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					</h4>
				</div>
				<div class="modal-body">
					<form action="login.do" method="post">
						<div class="form-group">
							<span id="qstcContent">dd</span>
							<input type="text" class="form-control" name="faqTitle">
							<input type="text" class="form-control" name="faqContent">
						</div>
						<div class="form-group">
							<span class="ans">[답변]</span>
							<input type="text" class="form-control" name="faqAns">
							<input type="password" class="form-control" placeholder="비밀번호" required="required" name="memPw">
						</div>
						<div class="form-group">
							<input type="submit" class="btn btn-primary btn-block btn-lg" value="수정">
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
 	-->

	
</div>
<!-- END WRAPPER -->

<!-- Javascript -->
<script src="assets/vendor/jquery/jquery.min.js"></script>
<script src="assets/vendor/bootstrap/js/bootstrap.min.js"></script>
<script src="assets/vendor/jquery-slimscroll/jquery.slimscroll.min.js"></script>
<script src="assets/vendor/jquery.easy-pie-chart/jquery.easypiechart.min.js"></script>
<script src="assets/vendor/chartist/js/chartist.min.js"></script>
<script src="assets/scripts/klorofil-common.js"></script>

<script type="text/javascript">
/* 고객센터 FAQ 탭별 조회 함수 */
function openCity(evt, cityName) 
{
    var i, tabcontent, tablinks;
    tabcontent = document.getElementsByClassName("tabcontent");
    for (i = 0; i < tabcontent.length; i++) 
    {
        tabcontent[i].style.display = "none";
    }
    tablinks = document.getElementsByClassName("tablinks");
    for (i = 0; i < tablinks.length; i++) 
    {
        tablinks[i].className = tablinks[i].className.replace(" active", "");
    }
    document.getElementById(cityName).style.display = "block";
    evt.currentTarget.className += " active";
}
// Get the element with id="defaultOpen" and click on it
document.getElementById("defaultOpen").click();
</script>


</body>

</html>
