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
	<title>Admin sample</title>
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
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	
<script type="text/javascript">
	
	$(function()
	{
		// 숙소문의 공개상태 버튼 클릭시 수행
		$(".rqstHideBtn").click(function()
		{
			// 모달 속성 변경 (숨김사유조회와 모달 함께 쓰기 때문)
			if ($(this).html()=="공개")
			{
				$(".modal-title").html("비공개 사유를 입력해주세요.");
				$("#adminId").html("처리자 : <%=session.getAttribute("adminId")%>");
				$("#modalText").removeAttr("readonly");
				$("#modalText").attr("placeholder", "비공개 사유 입력");
				$("#modalText").val("");
				$("#reqHideState").html("완료");
				$("#reqHideState").removeAttr("data-dismiss");
				$("#reqHideState").attr("value", $(this).val());
				
			}
			else if ($(this).html()=="비공개")
			{
				if (confirm("공개로 상태를 전환하시겠습니까?"))
				{
					// 공개로 전환할 경우 사유는 파라미터값으로 보낼 필요 없음
					$(location).attr("href", "changerqsthidestate.do?changeTo=noHide&rqstCode=" + $(this).val());
				}
			}
		});
		
		// 숨김상태변경 모달에서 완료버튼을 누르면 수행
		$("#reqHideState").click(function()
		{
			// 버튼 글씨가 완료면 수행 (확인은 사유조회기 때문에 수행X)
			if ($("#reqHideState").html()=="완료")
			{
				// 사유를 입력하지 않았다면 경고창 띄워주고 끝내기
				if ($("#modalText").val()=="")
				{
					alert("입력해주세요");
					return;
				}
				// 사유를 입력했다면 변경요청
				$(location).attr("href", "changerqsthidestate.do?changeTo=hide&rqstCode=" + $(this).val() + "&hideCause=" + $("#modalText").val().replace(/\n/g, '<br>'));
			}
		});
		
		
		
		
		
		
		// 숙소문의 숨김 사유 조회
		$(".rqstCause").click(function()
		{
			// 에이쟉스 처리
			$.post("rqstcauseajax.do", {rqstCode:$(this).val()}, function(data)
			{
				// 제이슨 이용^^
				var obj = JSON.parse(data);
				
				// 모달에 처리자와 사유 입력
				$("#adminId").html("처리자 : " + obj.adminId);
				$("#modalText").val(obj.hideCause);
				
				// 모달 속성 변경 (숨김상태변경과 모달 함께 쓰기 때문)
				$(".modal-title").html("숨김 사유 조회");
				$("#modalText").attr("readonly", "readonly");
				$("#reqHideState").html("확인");
				$("#reqHideState").attr("data-dismiss", "modal");
			});
		});
		
		
		// 숙소문의 내용 조회
		$(".rqstAns").click(function()
		{
			
			// 에이쟉스 처리
			$.post("rqstanswerajax.do", {rqstCode:$(this).val()}, function(data)
			{
				// 모달에 처리자와 사유 입력
				$("#adminId").html("호스트 답변 내용");
				$("#modalText").val(data);
				
				// 모달 속성 변경 (숨김상태변경과 모달 함께 쓰기 때문)
				$(".modal-title").html("호스트 답변");
				$("#modalText").attr("readonly", "readonly");
				$("#reqHideState").html("확인");
				$("#reqHideState").attr("data-dismiss", "modal");
			});
		});
		
		
		
		// 숙소문의 내용 조회
		$(".rqstTitle").click(function()
		{
			// 에이쟉스 처리
			$.post("rqstcontentajax.do", {rqstCode:$(this).attr("id")}, function(data)
			{
				// 제이슨 이용^^
				var obj = JSON.parse(data);
				
				// 모달에 처리자와 사유 입력
				$("#adminId").html("숙소 문의내용");
				$("#modalText").val(obj.rqstContent);
				
				// 모달 속성 변경 (숨김상태변경과 모달 함께 쓰기 때문)
				$(".modal-title").html("숙소 문의제목 : " + obj.rqstTitle);
				$("#modalText").attr("readonly", "readonly");
				$("#reqHideState").html("확인");
				$("#reqHideState").attr("data-dismiss", "modal");
			});
		});
		
		
		
		// 후기 내용 조회
		$(".revName").click(function()
		{
			// 에이쟉스 처리
			$.post("revcontentajax.do", {revCode:$(this).attr("id")}, function(data)
			{
				// 제이슨 이용^^
				var obj = JSON.parse(data);
				
				// 모달에 처리자와 사유 입력
				$("#adminId").html("후기 내용");
				$("#modalText").val(obj.revContent);
				
				// 모달 속성 변경 (숨김상태변경과 모달 함께 쓰기 때문)
				$(".modal-title").html("후기 제목 : " + obj.revTitle);
				$("#modalText").attr("readonly", "readonly");
				$("#reqHideState").html("확인");
				$("#reqHideState").attr("data-dismiss", "modal");
			});
		});
		
		
		// 리뷰 숨김 사유 조회
		$(".revCause").click(function()
		{
			// 에이쟉스 처리
			$.post("revcauseajax.do", {revCode:$(this).val()}, function(data)
			{
				// 제이슨 이용^^
				var obj = JSON.parse(data);
				
				// 모달에 처리자와 사유 입력
				$("#adminId").html("처리자 : " + obj.adminId);
				$("#modalText").val(obj.hideCause);
				
				// 모달 속성 변경 (숨김상태변경과 모달 함께 쓰기 때문)
				$(".modal-title").html("후기 비공개 사유");
				$("#modalText").attr("readonly", "readonly");
				$("#reqHideState").html("확인");
				$("#reqHideState").attr("data-dismiss", "modal");
			});
		});
		
		
		// 사유 조회
		$(".cause").click(function()
		{
			// 에이쟉스 처리
			$.post("hidecauseajax.do", {rcode:$(this).val()}, function(data)
			{
				// 제이슨 이용^^
				var obj = JSON.parse(data);
				
				// 모달에 처리자와 사유 입력
				$("#adminId").html("처리자 : " + obj.adminId);
				$("#modalText").val(obj.hideCause);
				
				// 모달 속성 변경 (숨김상태변경과 모달 함께 쓰기 때문)
				$(".modal-title").html("비공개 사유");
				$("#modalText").attr("readonly", "readonly");
				$("#reqHideState").html("확인");
				$("#reqHideState").attr("data-dismiss", "modal");
			});
		});
		
		
		// 숨김상태 변경 클릭시 수행
		$(".hideState").click(function()
		{
			// 모달 속성 변경 (숨김사유조회와 모달 함께 쓰기 때문)
			if ($(this).html()=="공개")
			{
				$(".modal-title").html("비공개 사유를 입력해주세요.");
				$("#adminId").html("처리자 : <%=session.getAttribute("adminId")%>");
				$("#modalText").removeAttr("readonly");
				$("#modalText").attr("placeholder", "비공개 사유 입력");
				$("#modalText").val("");
				$("#reqHideState").html("비공개 전환");
				$("#reqHideState").removeAttr("data-dismiss");
				$("#reqHideState").attr("value", $(this).val());
			}
			else if ($(this).html()=="비공개")
			{
				if (confirm("공개로 상태를 전환하시겠습니까?"))
				{
					// 공개로 전환할 경우 사유는 파라미터값으로 보낼 필요 없음
					$(location).attr("href", "changehidestate.do?changeTo=noHide&rcode=" + $(this).val());
				}
			}
		});
		
		// 숨김상태변경 모달에서 완료버튼을 누르면 수행
		$("#reqHideState").click(function()
		{
			// 버튼 글씨가 완료면 수행 (확인은 사유조회기 때문에 수행X)
			if ($("#reqHideState").html()=="비공개 전환")
			{
				// 사유를 입력하지 않았다면 경고창 띄워주고 끝내기
				if ($("#modalText").val()=="")
				{
					alert("입력해주세요");
					return;
				}
				// 사유를 입력했다면 변경요청
				$(location).attr("href", "changehidestate.do?changeTo=hide&rcode=" + $(this).val() + "&hideCause=" + $("#modalText").val().replace(/\n/g, '<br>'));
			}
		});
		
		
		// 특정 숙소의 후기와 문의 조회
		$(".detail").click(function()
		{
			$(location).attr("href", "adminroomdetail.do?rcode=" + $(this).val());
		});
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
			
			
				<!-- 숙소목록 -->
				<div class="panel panel-headline">
					<div class="panel-heading">
						<div class="row">
							<div class="col-md-12">
								<h3 class="panel-title">숙소 목록</h3>
								<div class="right">
									<button type="button" class="btn-toggle-collapse">
										<i class="lnr lnr-chevron-down"></i>
									</button>
								</div>
							</div>
						</div>
					</div>
					<div class="panel-body">
						<p> ※ 공개/비공개 버튼을 누르면 숙소의 상태가 전환됩니다.</p>
						<table class="table">
							<thead>
								<tr>
									<th>숙소코드</th>
									<th>등급</th>
									<th>검증유효기간</th>
									<th>숙소유형</th>
									<th>호스트아이디</th>
									<th>숙소이름</th>
									<th>등록일</th>
									<th>조회</th>
									<th>공개상태</th>
									<th>사유</th>
									<th>관리자아이디</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="room" items="${roomList }">
									<tr>
										<td>${room.rcode }</td>
										<td>${room.vafterGrade }</td>
										<td>
											<c:if test="${room.effectiveDate!='-' }">
												~ ${room.effectiveDate }
											</c:if>
											<c:if test="${room.effectiveDate=='-' }">
												${room.effectiveDate }
											</c:if>
										</td>
										<td>${room.rtype }</td>
										<td>${room.memId }</td>
										<td>${room.rname }</td>
										<td>${room.rregDate }</td>
										<td><button type="button" class="btn btn-default updatebtn detail" value="${room.rcode }">조회</button></td>
										<td>
											<c:if test="${room.hideCause!=null }">
												<button value="${room.rcode }" type="button" class="btn btn-default unhidebtn hideState" style="background-color: red;">비공개</button>
											</c:if>
											<c:if test="${room.hideCause==null }">
												<button value="${room.rcode }" type="button" class="btn btn-default unhidebtn hideState" data-toggle="modal" data-target="#causeModal">공개</button>
											</c:if>
										</td>
										<td>
											<c:if test="${room.hideCause!=null }">
												<button value="${room.rcode }" type="button" class="btn btn-default unhidebtn cause" data-toggle="modal" data-target="#causeModal">사유</button>
											</c:if>
											<c:if test="${room.hideCause==null }">
												<button type="button" class="btn btn-default unhidebtn cause" disabled="disabled">사유</button>
											</c:if>
										</td>
										<td>${room.adminId }</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						<div>
							<c:if test="${pageNumber != 1 }">
								<a href="adminroom.do?pageNumber=${pageNumber-1 }"><button class="btn btn-primary">이전</button></a>
							</c:if>
							<!-- 원래는 되어야 한다. -->
							<a href="adminroom.do?pageNumber=${pageNumber+1 }"><button class="btn btn-primary">다음</button></a>
						</div>
					</div>
				</div>
				<!-- END 숙소목록 -->
				<!-- 숙소조회 -->
				<div class="panel panel-headline">
					<div class="panel-heading">
						<div class="row">
							<div class="col-md-12">
								<h3 class="panel-title">숙소 상세조회</h3>
								<div class="right">
									<button type="button" class="btn-toggle-collapse">
										<i class="lnr lnr-chevron-down"></i>
									</button>
								</div>
							</div>
							<div class="col-md-12">
							<c:if test="${roomBanner!=null }">
							<!-- RoomInfo -->
						        <div class="col-md-2"></div>
						        <div class="col-md-8 center-block" style="width:1200px; padding:0px;">
						           <div class="roomimg">
						              <div class="roomtext">
						                 <h1 class="roomtitle">
						                    <span class="label label-info">C</span>
						                    <a href="roomdetail.do?rcode=${roomBanner.rcode }">${roomBanner.rname }</a>
						                 </h1>
						                 <p>호스팅한 날짜 : ${roomBanner.rregDate }</p>
						                 <p>검증 유효기간 : 
						                 	<c:if test="${roomBanner.effectiveDate=='' }">
						                 	-
						                 	</c:if>
						                 	<c:if test="${roomBanner.effectiveDate!='' }">
						                 		${roomBanner.effectiveDate }
						                 	</c:if>
						                 </p>
						                 <div class="roomlink">
						                    <a>예약내역</a>
						                    <a>검증이력</a>
						                 </div>
						              </div>
						           </div>
						        </div>
						        <div class="col-md-2"></div>
							<!-- RoomInfo -->
							</c:if>
							</div>
						</div>
					</div>
				</div>
				<!-- 숙소조회 -->
				<!-- 숙소후기 및 문의 조회 -->
				<div class="panel panel-headline">
					<div class="panel-heading">
						<div class="row">
							<div class="col-md-12">
								<h3 class="panel-title">숙소 후기 및 문의</h3>
								<div class="right">
									<button type="button" class="btn-toggle-collapse">
										<i class="lnr lnr-chevron-down"></i>
									</button>
								</div>
							</div>
							<div class="col-md-12">
							<c:if test="${reviewList!=null }">
								<!-- 숙소 후기 / 숙소 문의 -->
							   <div class="container-fluid">
							      <ul class="nav nav-tabs">
							         <li class="active"><a data-toggle="tab" href="#review">숙소후기</a></li>
							         <li><a data-toggle="tab" href="#question">숙소문의</a></li>
							      </ul>
							
							      <div class="tab-content">
							      
							         <div id="review" class="tab-pane fade in active">
							            <span> ※ 공개/비공개 버튼을 누르면 리뷰 상태가 전환됩니다.</span><br>
							            <span> ※ 후기 제목을 누르면 내용이 조회됩니다.</span>
										<table class="table">
											<thead>
												<tr>
													<th>후기번호</th>
													<th>작성자 아이디<br>(등급)</th>
													<th>숙소이름</th>
													<th>평점</th>
													<th>후기제목</th>
													<th>등록일</th>
													<th>공개상태</th>
													<th>관리자아이디</th>
													<th>사유</th>
												</tr>
											</thead>
											<tbody>
												<c:forEach var="review" items="${reviewList }">
													<tr>
														<td>${review.revCode }</td>
														<td>${review.gid }</td>
														<td><a id="${review.revCode}" class="revName" data-toggle="modal" data-target="#causeModal">${review.rname }</a></td>
														<td>${review.point }</td>
														<td>${review.revTitle }</td>
														<td>${review.regDate }</td>
														<td>
															<c:if test="${room.revHide=='Y' }">
																<button value="${review.revCode }" type="button" class="btn btn-default unhidebtn" style="background-color: red;">비공개</button>
															</c:if>
															<c:if test="${room.revHide=='N' }">
																<button value="${review.revCode }" type="button" class="btn btn-default unhidebtn">공개</button>
															</c:if>
															${room.revHide}
														</td>
														<td>${review.adminId }</td>
														<td>
															<c:if test="${review.revHide=='N' }">
																<button class="btn btn-default unhidebtn" disabled="disabled">사유</button>
															</c:if>
															<c:if test="${review.revHide=='Y' }">
																<button value="${review.revCode }" class="btn btn-default unhidebtn revCause" data-toggle="modal" data-target="#causeModal">사유</button>
															</c:if>
														</td>
													</tr>
												</c:forEach>
											</tbody>
										</table>
							         </div>
							         <!-- END 후기 탭 조회 -->
							         
							         <!-- 문의 탭 조회 -->
							         <div id="question" class="tab-pane fade">
							            <!-- 문의 리스트 보기 -->
							            <div class="panel-group commentlist" id="qaccordion">
							               <c:set var="count" value="0"/>
							               <span> ※ 공개/비공개 버튼을 누르면 리뷰 상태가 전환됩니다.</span><br>
							           	   <span> ※ 문의제목을 누르면 내용이 조회됩니다.</span>
							               <table class="table">
								               <thead>
													<tr>
														<th>문의번호</th>
														<th>게스트아이디</th>
														<th>문의제목</th>
														<th>문의등록일</th>
														<th>호스트답변</th>
														<th>답변등록일</th>
														<th>공개상태</th>
														<th>관리자아이디</th>
														<th>사유</th>
													</tr>
												</thead>
												<tbody>
													<c:forEach var="question" items="${questionList }">
														<tr>
															<td>${question.rqstCode }</td>
															<td>${question.gid }</td>
															<td>
																<a id="${question.rqstCode}" class="rqstTitle" data-toggle="modal" data-target="#causeModal">${question.rqstTitle }</a>
															</td>
															<td>${question.rqstDate }</td>
															<td>
																<c:if test="${question.rqstCode!=null }">
																	<button value="${question.rqstCode }" class="btn btn-default unhidebtn rqstAns" data-toggle="modal" data-target="#causeModal" style="color:black;">조회</button>
																</c:if>
																<c:if test="${question.rqstCode==null }">
																	<button class="btn btn-default unhidebtn rqstAns" disabled="disabled"  style="color:black;">조회</button>
																</c:if>
															</td>
															<td>${question.rqstAnsDate }</td>
															<td>
																<c:if test="${question.hideRqstCode!='' }">
																	<button value="${question.rqstCode }" type="button" class="btn btn-default unhidebtn rqstHideBtn" style="background-color: red;">비공개</button>
																</c:if>
																<c:if test="${question.hideRqstCode=='' }">
																	<button value="${question.rqstCode }" type="button" class="btn btn-default unhidebtn rqstHideBtn"  data-toggle="modal" data-target="#causeModal" style="color:black;">공개</button>
																</c:if>
															</td>
															<td>${question.adminId }</td>
															<td>
																<c:if test="${question.hideRqstCode=='' }">
																	<button class="btn btn-default unhidebtn" disabled="disabled"  style="color:black;">사유</button>
																</c:if>
																<c:if test="${question.hideRqstCode!='' }">
																	<button value="${question.rqstCode }" class="btn btn-default unhidebtn rqstCause" data-toggle="modal" data-target="#causeModal"  style="color:black;">사유</button>
																</c:if>
															</td>
														</tr>
													</c:forEach>
											   </tbody>
											</table>
							            </div>
							         </div>
							      </div>
							   </div>
							   <!-- 리뷰 / 문의 리스트 출력 -->
							</div>
							</c:if>
						</div>
					</div>
					<div class="panel-body">
						<div class="row">
							<div class="col-md-12">
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- END MAIN -->	
	
</div>
<!-- END WRAPPER -->


<!-- 사유 모달 -->
<div id="causeModal" class="modal fade">
	<div class="modal-dialog modal-login">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="false">&times;</button>
				<h4 class="modal-title">비공개 사유</h4>
			</div>
			<div class="modal-body">
				<form id="modalForm" action="login.do" method="post">
					<div class="form-group">
						<span id="adminId"></span> 
					</div>
					<div class="form-group">
						<textarea id="modalText" class="form-control" readonly="readonly" style="height: 200px;"></textarea>
					</div>
					<div class="form-group">
						<button id="reqHideState" type="button" data-dismiss="modal" class="btn btn-primary btn-block btn-lg">확인</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>




<!-- Javascript -->
<script src="assets/vendor/jquery/jquery.min.js"></script>
<script src="assets/vendor/bootstrap/js/bootstrap.min.js"></script>
<script src="assets/vendor/jquery-slimscroll/jquery.slimscroll.min.js"></script>
<script src="assets/vendor/jquery.easy-pie-chart/jquery.easypiechart.min.js"></script>
<script src="assets/vendor/chartist/js/chartist.min.js"></script>
<script src="assets/scripts/klorofil-common.js"></script>

</body>

</html>
