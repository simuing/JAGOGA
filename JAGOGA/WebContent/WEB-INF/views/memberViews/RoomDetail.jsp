<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
<title>RoomDetail.jsp</title>

<!-- 부트스트랩 CDN -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<!-- 달력 -->
<!-- <script src="https://code.jquery.com/jquery-3.2.1.js"></script>
<script type='text/javascript' src='//code.jquery.com/jquery-1.8.3.js'></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.5.0/css/bootstrap-datepicker3.min.css">
<script type='text/javascript' src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.5.0/js/bootstrap-datepicker.min.js"></script>
<script src="/js/bootstrap-datepicker.kr.js" charset="UTF-8"></script> -->

<link type="text/css" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" rel="stylesheet">
<script type="text/javascript" src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script type="text/javascript" src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>


<link rel="stylesheet" href="<%= cp%>/memberAssets/css/Member.css">
<link rel="stylesheet" href="<%= cp%>/memberAssets/css/MemberLogin.css">
<link rel="stylesheet" href="<%= cp%>/memberAssets/css/RoomDetail.css">
<style>@import url('https://fonts.googleapis.com/css?family=Do+Hyeon');</style>

<script type="text/javascript">
   $(function()
   {
      // 별점 출력
      $.fn.generateStars = function() 
      {
          return this.each(function(i,e){$(e).html($('<span/>').width($(e).text()*8));});
      };
      
      // 숫자 평점을 별로 변환하도록 호출하는 함수
      $('.star-prototype').generateStars();
      
      $(".btn-search").click(function()
      {
         if ($("#search").val()=="") 
         {
            alert("검색어를 입력해주세요");
            return;
         }
         $(location).attr("href", "searchroom.do?search=" + $("#search").val());
      });
   });
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
<div class="image">
	<img src="<%=cp %>/memberAssets/img/mainimg.jpg" class="img-responsive">
</div>

<!-- 숙소 상세 정보 -->
<div class="col-md-8 content" id="content">
	
	<!-- 숙소 개요 -->
	<div class="container-fluid">
		<div class="col-md-2" style="padding:0px;">
	         <img src="memberProfile/${fn:substringAfter(roomInfo.memProfile, 'memberProfile/') }"
	          onerror="this.src='http://via.placeholder.com/150x190'" class="profile">
	    </div>
		<div class="col-md-10">
			<!-- 숙소이름 -->
			<div class="roomtitle">
				${roomInfo.rname }
			</div>
			<!-- 숙소평점 -->
			<form action="insertroompoint.do" method="get" id="pointForm">
				<div><span class="star-prototype">${roomInfo.avgPoint }</span>${roomInfo.avgPoint }
					<select name="point" id="point">
						<option value="10">10</option>
						<option value="9">9</option>
						<option value="8">8</option>
						<option value="7">7</option>
						<option value="6">6</option>
						<option value="5">5</option>
						<option value="4">4</option>
						<option value="3">3</option>
						<option value="2">2</option>
						<option value="1">1</option>
					</select>
					<% if (memCode == null) { %><!-- 비로그인 상태에서 리뷰를 누를 경우 로그인모달창 호출 -->
					<a href="#" data-toggle="modal" data-target="#loginModal" class="mainbar">
					<button type="button" class="btn nextbtn" id="pointCheck" 
					style="width: 60px; height: 25px; margin: 0px; padding: 0px;">별점주기</button></a>
					<% } else { %>
					<button type="button" class="btn nextbtn" id="pointCheck" 
					style="width: 60px; height: 25px; margin: 0px; padding: 0px;">별점주기</button>
					<% } %>
					
					<input type="hidden" name="rcode" value="${roomInfo.rcode }">
				</div>
			</form>
			<a href="like.do?rcode=${roomInfo.rcode }">
				<button type="button" class="btn btn-primary">
					<span class="glyphicon glyphicon-heart"></span>&nbsp;찜하기
				</button>
			</a>
			<!-- 숙소주소 -->
			<p>${roomInfo.rbasicAddr } ${roomInfo.rdetailAddr }</p>
			<!-- 숙소상세설명 -->
			<p>${roomInfo.rcontent }</p>
		</div>
		
	
	</div>

	<hr>
	   <!-- 숙소 사진 -->
   <div id="myCarousel" class="carousel slide" data-ride="carousel">
      <!-- Indicators -->
      <ol class="carousel-indicators">
         <c:forEach var="roomImage" items="${roomImg }" varStatus="index">
            <c:choose>
               <c:when test="${index.index eq 0}">
                  <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
               </c:when>
               <c:otherwise>
                  <li data-target="#myCarousel" data-slide-to="${index.index }"></li> 
                 </c:otherwise>
            </c:choose>
         </c:forEach>
      </ol>

      <!-- Wrapper for slides -->
      <div class="carousel-inner">
         <c:forEach var="roomImage" items="${roomImg }" varStatus="index">
            <c:choose>
               <c:when test="${index.index eq 0}">
                  <div class="item active">
                     <img src="roomImage/${fn:substringAfter(roomImage, 'roomImage/') }" alt="#">
                  </div>
               </c:when>
               <c:otherwise>
                  <div class="item">
                     <img src="roomImage/${fn:substringAfter(roomImage, 'roomImage/') }" alt="#">
                  </div>
                 </c:otherwise>
            </c:choose>
         </c:forEach>
      </div>

      <!-- Left and right controls -->
      <a class="left carousel-control" href="#myCarousel"   data-slide="prev">
         <span class="glyphicon glyphicon-chevron-left"></span> 
         <span class="sr-only">Previous</span>
      </a> 
      <a class="right carousel-control" href="#myCarousel" data-slide="next"> 
         <span class="glyphicon glyphicon-chevron-right"></span> 
         <span class="sr-only">Next</span>
      </a>
   </div>
	
	<div class="roominfo">
	<hr>
		<h3>편의 시설</h3>
		<ul>
			<c:forEach var="roomConvenience" items="${roomConvenience }">
				<li>${roomConvenience.convContent }</li>
			</c:forEach>
		</ul>
	<hr>
		<h3>제한 사항</h3>
		<ul>
			<c:forEach var="roomConstraint" items="${roomConstraint }">
				<li>${roomConstraint.consContent }</li>
			</c:forEach>
		</ul>
	<hr>
	</div>
	
	
	<!-- 숙소지도 -->
   <div class="form-group">
   <h3>숙소 지도</h3>
   <div id="map" style="width:100%;height:350px;"></div>
      <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c36ff5dca6e5ee292093ec6d2a7680ef&libraries=services"></script>
      <script>
      var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
          mapOption = {
              center: new daum.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
              level: 3 // 지도의 확대 레벨
          };  
      
      // 지도를 생성합니다    
      var map = new daum.maps.Map(mapContainer, mapOption); 
      
      // 주소-좌표 변환 객체를 생성합니다
      var geocoder = new daum.maps.services.Geocoder();
      
      // 주소로 좌표를 검색합니다
       geocoder.addressSearch('${roomInfo.rbasicAddr}', function(result, status) {

          // 정상적으로 검색이 완료됐으면 
           if (status === daum.maps.services.Status.OK) {
      
              var coords = new daum.maps.LatLng(result[0].y, result[0].x);
      
              // 결과값으로 받은 위치를 마커로 표시합니다
              var marker = new daum.maps.Marker({
                  map: map,
                  position: coords
              });
      
              // 인포윈도우로 장소에 대한 설명을 표시합니다
              var infowindow = new daum.maps.InfoWindow({
                  content: '<div style="width:150px; text-align:center; padding:6px 0;">${roomInfo.rname }</div>'
              });
              infowindow.open(map, marker);
      
              // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
              map.setCenter(coords);
          } 
      });    
      </script>
   </div>
   <hr>
	
	<!-- 숙소 후기 / 숙소 문의 -->
	<div class="container-fluid">
		<ul class="nav nav-tabs">
			<li class="active"><a data-toggle="tab" href="#review">후기</a></li>
			<li><a data-toggle="tab" href="#question">숙소문의</a></li>
		</ul>

		<div class="tab-content">
		
			<div id="review" class="tab-pane fade in active">
				<form action="insertreview.do" method="get" id="reviewForm">
				<table class="table commenttable">
					<tr>
						<td colspan="2">제목</td>
						<td><input type="text" id="revTitle" name="revTitle" class="form-control"></td>
						<td>
							<input type="text" id="fileName" class="file_input_textbox" readonly="readonly">
							<div class="file_input_div">
								<input type="button" value="files" class="file_input_button">
								<input type="file" class="file_input_hidden" onchange="javascript:document.getElementById('fileName').value = this.value">
							</div>
						</td>
						<% if (memCode == null) { %><!-- 비로그인 상태에서 리뷰를 누를 경우 로그인모달창 호출 -->
						<td rowspan="2" width="130px;">
							<a href="#" data-toggle="modal" data-target="#loginModal" class="mainbar">
							<button type="button" class="btn writebtn" >REVIEW</button></a>
						</td>
						<% } else { %>
						<td rowspan="2" width="130px;"><button type="button" class="btn writebtn" id="insertReview">REVIEW</button></td>
						<% } %>
					</tr>
					<tr>
						<td colspan="4"><textarea rows="4" class="form-control" id="revContent" name="revContent" style="resize:none;"></textarea></td>
					</tr>
					<tr><td><input type="hidden" name="rcode" value="${roomInfo.rcode }"></td></tr>
				</table>
				</form>
				
				<!-- 후기 리스트 보기 -->
				<div class="panel-group commentlist" id="accordion">
					<c:set var="count" value="0"/>
					<c:forEach var="roomReview" items="${roomReview }">
						<c:set var="count" value="${count+1 }"/>
						<div class="panel panel-default">
							<div class="panel-heading">
								<h4 class="panel-title" style="width: 300px; float:left;">
									<a data-toggle="collapse" data-parent="#accordion" href="#rcollapse${count }">${roomReview.revTitle }</a>
								</h4>
								<div style="text-align: right;">
									<span>${roomReview.gid }</span> /
									<span>${roomReview.regDate }</span>
									<button type="button" class="deletebtn"
									 onclick="window.location.href='deletereview.do?revCode=${roomReview.revCode }&rcode=${roomInfo.rcode }'">X</button>
								</div>
							</div>
							<div id="rcollapse${count }" class="panel-collapse collapse">
								<div class="panel-body">${roomReview.revContent }</div>
								
								<!-- 후기 사진 -->
								<div id="myCarouselreview" class="carousel slide" data-ride="carousel">
									<!-- Indicators -->
									<ol class="carousel-indicators">
										<li data-target="#myCarouselreview" data-slide-to="0"
											class="active"></li>
										<li data-target="#myCarouselreview" data-slide-to="1"></li>
										<li data-target="#myCarouselreview" data-slide-to="2"></li>
									</ol>
	
									<!-- Wrapper for slides -->
									<div class="carousel-inner">
										<div class="item active">
											<img src="http://via.placeholder.com/800x400" alt="#">
										</div>
	
										<div class="item">
											<img src="http://via.placeholder.com/800x400" alt="#">
										</div>
	
										<div class="item">
											<img src="http://via.placeholder.com/800x400" alt="#">
										</div>
									</div>
	
									<!-- Left and right controls -->
									<a class="left carousel-control" href="#myCarouselreview"
										data-slide="prev"> <span
										class="glyphicon glyphicon-chevron-left"></span> <span
										class="sr-only">Previous</span>
									</a> <a class="right carousel-control" href="#myCarouselreview"
										data-slide="next"> <span
										class="glyphicon glyphicon-chevron-right"></span> <span
										class="sr-only">Next</span>
									</a>
								</div>
								
								<div class="container-fluid">
									<table class="table table-striped">
										<tr>
											<td>${roomReview.hid }</td>
											<td>${roomReview.revAns }</td>
											<td>${roomReview.revAnsDate }</td>
											<td style="text-align: right;"><button type="button" class="deletebtn">X</button></td>
										</tr>
									</table>
								</div>
								
								<div class="container-fluid">
									<textarea class="form-control" placeholder="내용을 입력해주세요" style="resize:none;"></textarea>
									<button type="button" class="btn btn-primary">답변등록</button>
								</div>
							</div>
						</div>
					</c:forEach>

				</div>
				
			</div>
			<!-- END 후기 탭 조회 -->
			
			<!-- 문의 탭 조회 -->
			<div id="question" class="tab-pane fade">
				<form action="insertrqst.do" method="get" id="rqstForm">
					<table class="table commenttable">
						<tr>
							<td>문의 제목</td>
							<td colspan="2"><input type="text" name="rqstTitle" class="form-control"></td>
							<td><label for="closeCheck"><input type="checkbox" name="closeCheck" class="closeCheck" id="closeCheck" value="N"> 비공개</label></td>
							<% if (memCode == null) { %><!-- 비로그인 상태에서 숙소문의를 누를 경우 로그인모달창 호출 -->
							<td rowspan="2" width="130px;">
								<a href="#" data-toggle="modal" data-target="#loginModal" class="mainbar">
								<button type="button" class="btn writebtn" >REVIEW</button></a>
							</td>
							<% } else { %>
							<td rowspan="2" width="130px;"><button type="button" class="btn writebtn" id="insertRoomQuestion">QUESTION</button></td>
							<% } %>
						</tr>
						<tr>
							<td colspan="4">
								<textarea rows="4" class="form-control" name="rqstContent" style="resize:none;"></textarea>
							</td>
						</tr>
						<tr><td><input type="hidden" name="rcode" value="${roomInfo.rcode }"></td></tr>
					</table>
				</form>
				
				<label for="myquestion"><input type="checkbox" class="myquestion" id="myquestion"> 내 문의 목록</label>
				
				<!-- 문의 리스트 보기 -->
				<div class="panel-group commentlist" id="qaccordion">
					<c:set var="count" value="0"/>
					<c:forEach var="roomQuestion" items="${roomQuestion }">
					<!-- RCODE, RQSTTITLE, RQSTCONTENT, GID, MEMETIQUETTE,  RQSTDATE, CLOSECHECK, HID, HIDEDATE, HIDECAUSE, ADMINID -->
					
					<c:set var="count" value="${count+1 }"/>
					<div class="panel panel-default">
						<div class="panel-heading">
							<h4 class="panel-title" style="width: 300px; float:left;">
								<a data-toggle="collapse" data-parent="#qaccordion" href="#qcollapse${count}">${roomQuestion.rqstTitle }</a>
							</h4>
							<div style="text-align: right;">
								<span>${roomQuestion.gid }</span> /
								<span>${roomQuestion.rqstDate }</span>
								<button type="button" class="deletebtn">X</button>
							</div>
						</div>
						<!-- 숙소답변 -->
						<div id="qcollapse${count}" class="panel-collapse collapse">
							<div class="panel-body">${roomQuestion.rqstContent }</div>
								<div class="container-fluid">
									<table class="table">
										<tr>
											<td>${roomQuestion.hid }</td>
											<td>${roomQuestion.rqstAns }</td>
											<td>${roomQuestion.rqstAnsDate }</td>
											<td style="text-align: right;">
											<button type="button" class="deletebtn"
											onclick="window.location.href='deleterqstans.do?rqstAnsCode=${roomQuestion.rqstAnsCode}&rcode=${roomInfo.rcode }'">
											X</button></td>
										</tr>
									</table>
								</div>
							<div class="container-fluid">
								<textarea class="form-control" placeholder="내용을 입력해주세요" style="width: 580px; float: left;"></textarea>
								<button type="button" class="btn btn-primary">답변등록</button>
							</div>
						</div>
						<!-- END 숙소답변 -->
					</div>
					</c:forEach>
					
				</div>
				
			</div>
		</div>
	</div>
	<!-- 리뷰 / 문의 리스트 출력 -->

</div>


<!-- 예약하기 박스 -->
<div class="col-md-4">

	<!-- 바깥쪽 박스 -->
	<div id="shadowbox">
	
		<!-- 안쪽 박스 -->
		<div class="bookingBox">
			<form action="booking1.do" method="post">
			
				<input type="hidden" id="rcode" name="rcode" value="${roomInfo.rcode }">
			
				<div>
					<h3 style="text-align: right">1일 숙박요금</h3>
					<h5 style="text-align: right">성인 : ${roomInfo.adultFee }원</h5>
					<h5 style="text-align: right">어린이 : ${roomInfo.childFee }원</h5>
				</div>
				
				<!-- 증가, 감소 버튼을 통한 인원수 설정 -->
				<div style="text-align: right;">
					
					<div>
						<p class="kind">성인</p>
						<button type="button" class="countbtn" onclick='javascript_:Achange(-1);'>-</button>
						<input type="text" id="adultCount" name="adultCount" value="1" size="3" readonly="readonly" style="text-align: center;">
						<button type="button" class="countbtn" onclick='javascript_:Achange(1);'>+</button>
					</div>
					<div>
						<p class="kind">어린이</p>
						<button type="button" class="countbtn" onclick='javascript_:Cchange(-1);'>-</button>
						<input type="text" id="childCount" name="childCount" value="0" size="3" readonly="readonly" style="text-align: center;">
						<button type="button" class="countbtn" onclick='javascript_:Cchange(1);'>+</button>
					</div>
					<div>
						<p class="kind">유아</p>
						<button type="button" class="countbtn" onclick='javascript_:Bchange(-1);'>-</button>
						<input type="text" id="babyCount" name="babyCount" value="0" size="3" readonly="readonly" style="text-align: center;">
						<button type="button" class="countbtn" onclick='javascript_:Bchange(1);'>+</button>
					</div>
				</div>
				
				<!-- 예상 금액 -->			
				<div class="pay">
					1박 2일 : 
					<span id="resultPay">
						<input type="text" id="bpay" name="bpay" value="${roomInfo.adultFee }" style="border:none; width:90px; text-align:right;">
					</span> 원
				</div>
	
				<!-- 달력을 통한 날짜 설정 -->
				<div class="form-group row">
					<div class="col-md-12">
						<div class="input-group col-md-6" style="float:left;">
							<input type="text" class="form-control date" placeholder=" Check in" id="startDate" name="checkInDate">
							<span class="input-group-addon">
								<i class="glyphicon glyphicon-pushpin"></i>
							</span>
						</div>
						<div class="input-group col-md-6" style="float:right;">
							<input type="text" class="form-control date" placeholder=" Check out" id="endDate" name="checkOutDate">
							<span class="input-group-addon">
								<i class="glyphicon glyphicon-pushpin"></i>
							</span>
						</div>
					</div>
				</div>
				
				<button type="submit" class="btn bookingbtn" style="width:100%;">예약하기</button>
				
			</form>
		</div>
		</div>
	</div>
</div>



<!--
<script type="text/javascript">
/* 	//달력을 통한 날짜 선택 함수
	$(function(){
		
		var unableDateList = ["2018-07-29", "2018-07-24"];
		var unableDate = "";
		for (var i=0; i<unableDateList.length; i++)
		{
			if (i==0)
			{
				unableDate += unableDateList[i].toString();
				continue;
			}
			unableDate += ', ' + unableDateList[i].toString();
		}
		alert(unableDate); */
	
    $('#startDate').datepicker({

    	// 주 옆에 번호 뜨는거
        //calendarWeeks: false,

        // 오늘 날짜에 강조
        todayHighlight: true,

        // 날짜 선택하면 창 종료
        autoclose: true,

        // 날짜 포맷
        //format: "yyyy-mm-dd",

        // 달력 언어
        //language: "kr",
        
        // 선택할 수 있는 최소 날짜
        //minDate: 0,
        
        // 이거는 예시
		//datesDisabled: [unableDate.toString(), "2018-07-25"],	// 예약중인 날짜를 매개변수로 넣어서 처리한다.
		
		// 오늘 이전 날짜 선택 불가
		startDate: 'today',
		
		// 종료일 예시
		endDate: '+3y',
		
		multidate: false,
		
    });

    $('#endDate').datepicker({
    	
        //calendarWeeks: false,

        // 오늘 날짜에 강조
        todayHighlight: true,

        // 날짜 선택하면 창 종료
        autoclose: true,

        // 날짜 포맷
        //format: "yyyy-mm-dd",

        // 달력 언어
        //language: "kr",
        
        // 선택할 수 있는 최소 날짜
        //minDate: 0,
        
        // 이거는 예시
		//datesDisabled: ['2018-07-31'],	// 예약중인 날짜를 매개변수로 넣어서 처리한다.
		
		// 오늘 이전 날짜 선택 불가
		startDate: 'today',
		
		// 종료일 예시
		endDate: '+3y', // 3년후까지만 받는다.
		
		multidate: false,
    });
});
</script> -->
<script type="text/javascript">
	jQuery(function($){
	    $.datepicker.regional['ko'] = {closeText: '닫기',prevText: '이전달',nextText: '다음달',currentText: '오늘'
	    		,monthNames: ['1월(JAN)','2월(FEB)','3월(MAR)','4월(APR)','5월(MAY)','6월(JUN)','7월(JUL)','8월(AUG)','9월(SEP)','10월(OCT)','11월(NOV)','12월(DEC)']
	    		,monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],dayNames: ['일','월','화','수','목','금','토']
	    		,dayNamesShort: ['일','월','화','수','목','금','토'],dayNamesMin: ['일','월','화','수','목','금','토'],weekHeader: 'Wk', dateFormat: 'yy-mm-dd'
	    		,firstDay: 0,isRTL: false,showMonthAfterYear: true,yearSuffix: ''};
	    $.datepicker.setDefaults($.datepicker.regional['ko']);
	    $('#startDate').datepicker({changeMonth: true,changeYear: true,showButtonPanel:true,yearRange: 'c-99:c+99',constrainInput: true,maxDate: '+1y',beforeShowDay: disableAllTheseDays   });
	    $('#endDate').datepicker({changeMonth: true,changeYear: true,showButtonPanel:true,yearRange: 'c-99:c+99',constrainInput: true,maxDate: '+1y',beforeShowDay: disableAllTheseDays   });
	});
	
	
	var disabledDays = ["2018-7-24","2018-7-25","2013-7-26"];
	
	// 특정일 선택막기
	function disableAllTheseDays(date) {
	    var m = date.getMonth(), d = date.getDate(), y = date.getFullYear();
	    for (i = 0; i < disabledDays.length; i++) {
	        if($.inArray(y + '-' +(m+1) + '-' + d,disabledDays) != -1) {
	            return [false];
	        }
	    }
	    return [true];
	}

</script>

<script type="text/javascript">

	/* 예약박스 스크롤에 따른 위치고정 함수 */
	window.onscroll = function() {myFunction()};
	
	var shadowbox = document.getElementById("shadowbox");
	var content = document.getElementById("content");
	var sticky = content.offsetTop;
	
	function myFunction()
	{
	  if (window.pageYOffset > sticky) {
		 shadowbox.classList.add("sticky");
	  } else {
		 shadowbox.classList.remove("sticky");
	  }
	}
</script>

<script type="text/javascript">
	/* 예약박스 인원수 증감 함수 */
	function Achange(num)
	{
		var y = Number(adultCount.value) + num;
		if (y < 1)
			y = 0;
		adultCount.value = y;
	}
	function Cchange(num)
	{
		var y = Number(childCount.value) + num;
		if (y < 1)
			y = 0;
		childCount.value = y;
	}
	function Bchange(num)
	{
		var y = Number(babyCount.value) + num;
		if (y < 1)
			y = 0;
		babyCount.value = y;
	}
	$(function(){
	    $('.input-group.date').datepicker({
	        calendarWeeks: false,
	        todayHighlight: true,
	        autoclose: true,
	        format: "yyyy/mm/dd",
	        language: "kr"
	    });
	});
</script>

<script type="text/javascript">
	// 선택 요금 측정
	$(".countbtn").click(function()
	{
		var bpay = $("#adultCount").val()*${roomInfo.adultFee} + $("#childCount").val()*${roomInfo.childFee};
		
		$("#bpay").val(bpay);
	});
</script>

<script type="text/javascript">
$(document).ready(function()
{
	/* 후기등록 */
	$("#insertReview").click(function()
	{ 
		// 비밀번호를 입력하지 않았을 때
	 	var revTitle = $("#revTitle").val();
	 	var revContent = $("#revContent").val();
		
	 	if ( revTitle == "" || revContent == "")
	 	{	 		
	 		alert('후기내용을 입력해주세요.');
			$('#revTitle').focus();
			
			return;			
	 	}
	 
		// AJAX 수행
	 	$.post("reviewcheck.do", {rcode:$("#rcode" ).val()}, function(data)
		{
			// AJAX 처리에서 입력가능한 후기 개수가 1 이상이라면
			if (data > 0)
			{				
				$("#reviewForm").submit();
			}
			// 반환된 COUNT 가 0이라면
			else
			{
				alert("죄송합니다. 후기를 작성할 이용내역이 조회되지 않습니다.");
			}
		});
	});
	
	/* 숙소문의등록 */
	$("#insertRoomQuestion").click(function()
	{ 
		// 비밀번호를 입력하지 않았을 때
	 	var rqstTitle = $("#rqstTitle").val();
	 	var rqstContent = $("#rqstContent").val();
		
		// 입력값이 없을 시
	 	if ( rqstTitle == "" || rqstContent == "")
	 	{	
	 		alert('문의내용을 입력해주세요.');
			$('#rqstTitle').focus();
			
			return;			
	 	}
	 	else
	 	{
	 		// 숙소문의등록
	 		$("#rqstForm").submit();
	 	}
	});
	
	/* 숙소문의 비공개여부 변경적용 */
	$("#closeCheck").change(function()
	{
		if ($('input:checkbox[id="closeCheck"]').is(":checked") == false)
		{
			// 비공개하지않음
			$("#closeCheck").val('N');
		}
		else
		{
			// 비공개함
			$("#closeCheck").val('Y');
		}
	});
	
	/* 평점 주기 */
	$("#pointCheck").click(function()
	{
		// AJAX 수행 - 평점부여 자격이 있는지 조회하기
	 	$.post("pointcheck.do", {rcode:$("#rcode" ).val()}, function(data)
		{
			// AJAX 처리에서 입력가능한 후기 개수가 1 이상이라면
			if (data > 0)
			{				
				$("#pointForm").submit();
			}
			// 반환된 COUNT 가 0이라면
			else
			{
				alert("죄송합니다. 평점부여가 가능한 이용내역이 조회되지 않습니다.");
			}
		});
	});
	
});
</script>

<!-- 푸터 영역 -->
<c:import url="../source/MemberFooter.jsp"></c:import>
</body>
</html>