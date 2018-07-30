<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
	<title>공지관리</title>
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
	<link rel="apple-touch-icon" sizes="76x76" href="adminAssets/img/apple-icon.png">
	<link rel="icon" type="image/png" sizes="96x96" href="adminAssets/img/favicon.png">
	<!-- jquery -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	
<script type="text/javascript">
	
	$(function()
	{
		// 공개/비공개 버튼 클릭시 숨김상태 변경
		$(".deletebtn").click(function()
		{
			if ($(this).html()=='비공개')
			{
				$(location).attr("href", "noticehide.do?ntHideCheck=Y&ntCode=" + $(this).val());
			}
			else if ($(this).html()=='공개')
			{
				$(location).attr("href", "noticehide.do?ntHideCheck=N&ntCode=" + $(this).val());
			}
		});
		
		// 공지 등록 버튼 클릭시
		$(".insertbtn").click(function()
		{
			if ($(".insertbtn").html()=="등록")
			{
				if ($("[name=ntTitle]").val()=="")
				{
					alert("제목을 입력해주세요.");
				}
				else if ($("[name=ntContent]").val()=="")
				{
					alert("내용을 입력해주세요.");
				}
				else
				{
					// 개행처리 하기 위해서 replace 처리
					$("[name=ntContent]").attr("value", $("[name=ntContent]").val().replace(/\n/g, '<br>'));
					$("#insertForm").attr("action", "noticeinsert.do");
					$("#insertForm").submit();
				}
			}
			else if($(".insertbtn").html()=="수정")
			{
				if ($("[name=ntTitle]").val()=="")
				{
					alert("제목을 입력해주세요.");
				}
				else if ($("[name=ntContent]").val()=="")
				{
					alert("내용을 입력해주세요.");
				}
				else
				{
					// $("[name=ntContent]").attr("value", $("[name=ntContent]").val().replace(/\n/g, '<br>'));
					$("#insertForm").attr("action", "noticeupdate.do");
					// $("#insertForm").submit();
					
					$(location).attr("href", "noticeupdate.do?ntCode="+$(this).val()
														  + "&ntTitle="+$("[name=ntTitle]").val()
														  + "&ntContent="+$("[name=ntContent]").val().replace(/\n/g, '<br>') );
				}
				
			}
			
		});
		
		
		// 공지 수정 버튼 클릭시
		
		$(".modifybtn").click(function()
		{
			var btnVal = $(this).val();
			
			// 에이쟉스로 해당 공지 정보 가져오기
			$.post("updatenotice.do", {ntCode:$(this).val()}, function(data)
			{
				// 제이슨 이용^^
				var obj = JSON.parse(data);
				
				// 모달에 처리자와 사유 입력
				$("#attachMent").html("※ 공지 수정시에는 첨부파일 등록/삭제가 불가능하오니 새로운 첨부파일 등록을 위해선 공지사항을 재등록해주시기 바랍니다.<br>※ 한번 등록된 첨부파일은 수정 후에도 사라지지 않습니다.");
				$(".insertbtn").html("수정");
				$("[name=ntTitle]").val(obj.ntTitle);
				$("[name=ntContent]").val(obj.ntContent);
				$("[name=ntAttach]").css("display", "none");
				$(".ntInsertForm").html("공지 수정");
				$(".insertbtn").attr("value", btnVal);
			});
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
			
				<!-- 공지목록 -->
				<div class="panel panel-headline">
					<div class="panel-heading">
						<div class="row">
							<div class="col-md-12">
								<h3 class="panel-title">공지 목록</h3>
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
					        <div class="col-md-8">
							    <div class="input-group">
					                <div class="input-group-btn search-panel">
					                    <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
					                    	<span id="search_concept">전체공지</span> <span class="caret"></span>
					                    </button>
					                    <ul class="dropdown-menu" role="menu">
					                      <li><a href="#noticeTitle">공지제목</a></li>
					                      <li><a href="#adminId">작성자아이디</a></li>
					                    </ul>
					                </div>
					                <input type="hidden" name="search_param" value="all" id="search_param">         
					                <input type="text" class="form-control" name="x" placeholder="Search...">
					                <span class="input-group-btn">
					                    <button class="btn btn-default" type="button">
					                    	<span class="glyphicon glyphicon-search"></span>
					                    </button>
					                </span>
					            </div>
					        </div>
						</div>
						<table class="table">
							<thead>
								<tr>
									<th>공지코드</th>
									<th>공지제목</th>
									<th>등록일</th>
									<th>첨부파일</th>
									<th>조회수</th>
									<th>비공개상태</th>
									<th>상태변경</th>
									<th>관리자아이디</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="notice" items="${noticeList }">
									<tr>
										<td>${notice.ntCode }</td>
										<td>${notice.ntTitle }</td>
										<td>${notice.ntRegDate }</td>
										<td>
										<a href="ntattachdownload.do?ntAttach=${fn:substringAfter(notice.ntAttach, 'noticeAttach/') }">
											${fn:substringAfter(notice.ntAttach, 'noticeAttach/') }
										</a>
										</td>
										<td>${notice.ntHitCount }</td>
										<td>${notice.ntHideCheck }</td>
										<td>
											<button type="button" class="btn btn-default updatebtn modifybtn" value="${notice.ntCode }">수정</button>
											<c:if test="${notice.ntHideCheck=='공개' }">
												<button type="button" class="btn btn-default deletebtn" value="${notice.ntCode }" onclick="">비공개</button>
											</c:if>
											<c:if test="${notice.ntHideCheck=='비공개' }">
												<button type="button" class="btn btn-default deletebtn" value="${notice.ntCode }">공개</button>
											</c:if>
										</td>
										<td>${notice.adminId }</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						<div>
							<c:if test="${pageNumber != 1 }">
								<a href="adminnotice.do?pageNumber=${pageNumber-1 }"><button class="btn btn-primary">이전</button></a>
							</c:if>
							<!-- 원래는 되어야 한다. -->
							<a href="adminnotice.do?pageNumber=${pageNumber+1 }"><button class="btn btn-primary">다음</button></a>
						</div>
					</div>
				</div>
				<!-- END 공지목록 -->
				<!-- 공지등록 -->
				<div class="panel panel-headline">
					<div class="panel-heading">
						<div class="row">
							<div class="col-md-12">
								<h3 class="panel-title ntInsertForm">공지등록</h3>
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
						<form id="insertForm" action="noticeinsert.do" method="post" enctype="multipart/form-data">
							<div class="col-md-12">
								<div class="form-group col-md-12">
									공지제목
									<input name="ntTitle" type="text" class="form-control"><br>
									공지내용
									<textarea name="ntContent" class="form-control" rows="10" style="resize:none;"></textarea><br>
									<span id="attachMent">첨부파일</span>
									<input name="ntAttach" type="file"><br>
									<!-- 숨김여부<input type="checkbox"> -->
								</div>
								<button type="button" class="btn btn-default insertbtn" style="width:100%; height: 30px;">등록</button>
							</div>
						</form>
						</div>
					</div>
				</div>
				<!-- END 공지등록 -->
				<!-- 이용가이드 -->
				<div class="panel panel-headline">
					<div class="panel-heading">
						<div class="row">
							<div class="col-md-12">
								<h3 class="panel-title">이용가이드</h3>
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
								<div class="form-group col-md-6">
									1<input type="text" class="form-control" value="1. 안전을 바탕으로 한 커뮤니티"><br>
									<input type="text" class="form-control" value="안전을 최우선으로"><br>
									2<input type="text" class="form-control" value="2. 신뢰할 수 있는 서비스"><br>
									<input type="text" class="form-control" value="신뢰를 최우선으로"><br>
									3<input type="text" class="form-control" value="3. 검증된 서비스"><br>
									<input type="text" class="form-control" value="검증을 통한 안전성 확보"><br>
								</div>
								<div class="form-group col-md-6">
									4<input type="text" class="form-control" value="4. 다양한 숙소"><br>
									<input type="text" class="form-control" value="다양한 숙소"><br>
									5<input type="text" class="form-control" value=""><br>
									<input type="text" class="form-control" value=""><br>
									6<input type="text" class="form-control" value=""><br>
									<input type="text" class="form-control" value=""><br>
								</div>
								<button type="button"  class="btn btn-default updatebtn" style="width:100%; height: 30px;">수정</button>
							</div>
						</div>
					</div>
				</div>
				<!-- END 이용가이드 -->
			</div>
		</div>
	</div>
	<!-- END MAIN -->	
	
</div>
<!-- END WRAPPER -->

<!-- Javascript -->
<script src="adminAssets/vendor/jquery/jquery.min.js"></script>
<script src="adminAssets/vendor/bootstrap/js/bootstrap.min.js"></script>
<script src="adminAssets/vendor/jquery-slimscroll/jquery.slimscroll.min.js"></script>
<script src="adminAssets/vendor/jquery.easy-pie-chart/jquery.easypiechart.min.js"></script>
<script src="adminAssets/vendor/chartist/js/chartist.min.js"></script>
<script src="adminAssets/scripts/klorofil-common.js"></script>

</body>

</html>