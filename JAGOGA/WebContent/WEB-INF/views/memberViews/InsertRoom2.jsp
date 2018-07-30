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
	<h1>숙소 등록</h1>
	<hr>
</div>

<div class="container" style="padding-left:120px; padding-right:120px;">
<form action="insertroom3.do" method="post" onsubmit="return formCheck();" enctype="multipart/form-data">
	<!-- 숙소내용기입 -->
	<div class="row">
		<!-- 숙소유형 -->
		<div class="form-group col-md-6">
			<h4>숙소유형</h4>
			<select class="form-control" id="rtypeCode" name="rtypeCode">
				<c:forEach var="roomType" items="${roomTypeList }">
					<option value="${roomType.rtypeCode }">${roomType.rtype }</option>
				</c:forEach>
			</select>
		</div>
		<!-- END 숙소유형 -->
		<!-- 숙소면적 -->
		<div class="form-group col-md-6">
			<h4>숙소면적(㎡)</h4>
			<input class="form-control" type="text" id="rarea" name="rarea">
		</div>
		<!-- END 숙소면적 -->
		<!-- 숙박이름 -->
		<div class="form-group col-md-12">
			<h4>숙소이름</h4>
			<input class="form-control" type="text" id="rname" name="rname">
			<h4>상세설명</h4>
			<textarea class="form-control" name="rcontent" rows="6" style="resize: none;"></textarea>
		</div>
		<!-- END 숙박이름 -->
		<!-- 숙박주소 -->
		<div class="form-group col-md-12">
			<h4>숙소주소</h4>
			<div>
				<input type="text" class="form-control" id="zipCode" name="rzipCode" placeholder="우편번호" readonly="readonly" style="width: 100px; float: left;">
				<button type="button" class="btn btn-primary" onclick="execDaumPostcode()">우편번호 찾기</button><br>
				<input type="text" class="form-control" id="roadAddress" name="rbasicAddr" placeholder="기본주소" readonly="readonly">
				<input type="text" class="form-control" id="detailAddress" name="rdetailAddr" placeholder="상세주소">
				<span id="guide" style="color:#999"></span>
			</div>
		</div>
		<!-- END 숙박 주소 -->
		
		<!-- 구분선 --><div class="col-md-12"><hr></div>
		
		<!-- 숙박 인원 -->
		<div class="form-group col-md-12">
			<div class="col-md-6">
				<div class="col-md-6">
					<div class="col-md-12">
						<h4>숙박 인원</h4>
					</div>
					<div class="form-group col-md-12">
						<h5>최소</h5>
						<div>
							<button type="button" class="countbtn" onclick='javascript_:minChange(-1);'>-</button>
							<input type="text" id="minCount" name="minHumanCount" value="1" size="3" readonly="readonly" style="text-align: center;">
							<button type="button" class="countbtn" onclick='javascript_:minChange(1);'>+</button>
						</div>
					</div>
					<div class="form-group col-md-12">
						<h5>최대</h5>
						<div>
							<button type="button" class="countbtn" onclick='javascript_:maxChange(-1);'>-</button>
							<input type="text" id="maxCount" name="maxHumanCount" value="1" size="3" readonly="readonly" style="text-align: center;">
							<button type="button" class="countbtn" onclick='javascript_:maxChange(1);'>+</button>
						</div>
					</div>
				</div>
				<div class="col-md-6">
					<div class="col-md-12">
						<h4>1박 요금</h4>
					</div>
					<div class="col-md-12">
						<h5>성인요금</h5>
						<input class="form-control" type="text" id="adultFee" name="adultFee">
					</div>
					<div class="col-md-12">
						<h5>어린이요금</h5>
						<input class="form-control" type="text" id="childFee" name="childFee">
					</div>
				</div>
			</div>
			<div class="col-md-1"></div>
			<div class="col-md-5">
				<h4>숙소사진</h4>
				<h5>최소 4장 등록</h5>
				<input type="text" id="fileName1" class="file_input_textbox" readonly="readonly" style="width: 250px;">
				<div class="file_input_div">
					<input type="button" value="files" class="file_input_button">
					<input type="file" class="file_input_hidden" name="rimg1" onchange="javascript:document.getElementById('fileName1').value = this.value">
				</div>
				<input type="text" id="fileName2" class="file_input_textbox" readonly="readonly" style="width: 250px;">
				<div class="file_input_div">
					<input type="button" value="files" class="file_input_button">
					<input type="file" class="file_input_hidden" name="rimg2" onchange="javascript:document.getElementById('fileName2').value = this.value">
				</div>
				<input type="text" id="fileName3" class="file_input_textbox" readonly="readonly" style="width: 250px;">
				<div class="file_input_div">
					<input type="button" value="files" class="file_input_button">
					<input type="file" class="file_input_hidden" name="rimg3" onchange="javascript:document.getElementById('fileName3').value = this.value">
				</div>
				<input type="text" id="fileName4" class="file_input_textbox" readonly="readonly" style="width: 250px;">
				<div class="file_input_div">
					<input type="button" value="files" class="file_input_button">
					<input type="file" class="file_input_hidden" name="rimg4" onchange="javascript:document.getElementById('fileName4').value = this.value">
				</div>
			</div>
		</div>
		<!-- END 숙박 인원 -->
		
		<!-- 구분선 --><div class="col-md-12"><hr></div>

		<!-- 편의시설 -->
		<div class="form-group col-md-12">
			<h4>편의시설</h4>
			<div>
				<c:set var="count" value="0"/>
				<c:forEach var="conv" items="${convList }">
					<div class="col-md-3"><label><input type="checkbox" name="convCode" value="${conv.convCode}"> ${conv.convContent }</label></div>
					<c:set var="count" value="${count +1 }"/>
				</c:forEach>
			</div>
		</div>
		<!-- END 편의시설 -->
		
		<div class="col-md-12"><hr></div>
		
		<!-- 제한사항 -->
		<div class="form-group col-md-12">
			<h4>제한사항</h4>
			<div>
				<c:set var="count" value="0"/>
				<c:forEach var="cons" items="${consList }">
					<div class="col-md-3"><label><input type="checkbox" name="consCode" value="${cons.consCode}"> ${cons.consContent }</label></div>
					<c:set var="count" value="${count +1 }"/>
				</c:forEach>
			</div>
		</div>
		<!-- END 제한사항 -->
		
		<!-- 구분선 --><div class="col-md-12"><hr></div>
		
		<!-- 예약가능날짜 -->
		<div class="form-group col-md-6">
			<div class="col-md-5"></div>
			<div class="col-md-7" style="padding-right:0px;">
				<h4>체크인날짜</h4>
				<div class="input-group">
					<input type="text" class="form-control date" placeholder=" Check in" id="startDate">
					<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
				</div>
			</div>
		</div>
		<div class="form-group col-md-6">
			<div class="col-md-7" style="padding-right:0px;">
				<h4>체크아웃날짜</h4>
				<div class="input-group">
					<input type="text" class="form-control date" placeholder=" Check out" id="endDate">
					<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
				</div>
			</div>
			<div class="col-md-5"></div>
		</div>
		<div class="col-md-12">
			<div class="col-md-2"></div>
			<div class="col-md-8">
				<button type="button" class="form-control" style="background-color: #1BB3C8; color:white" onclick="javascript:datePlus()">
				예약가능날짜 추가하기</button>
			</div>
			<div class="col-md-2"></div>
		</div>
		<div class="form-group col-md-12">
			<div class="col-md-2"></div>
			<div class="col-md-8">
				<table class="table" id="dateTable">
					<tr>
						<th>시작날짜</th>
						<th>종료날짜</th>
						<th style="width:100px;">삭제하기</th>
					</tr>
				</table>
			</div>
			<div class="col-md-2"></div>
		</div>
		<!-- END 예약가능날짜 -->
		
		<!-- 구분선 --><div class="col-md-12"><hr></div>
		
		<!-- 휴대폰인증 -->
		<div class="form-group col-md-12">
			<div class="col-md-3"></div>
			<div class="col-md-6">
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
			<div class="col-md-3"></div>
		</div>
		<div class="form-group col-md-12">
			<div class="col-md-3"></div>
			<div class="col-md-6">
				<div class="col-md-8" style="padding:0px;">
					<input type="text" id="telCheckNum" name="telCheckNum" class="form-control">
					<input type="checkbox" id="tel_ok" disabled="disabled">
					인증여부
				</div>
				<div class="col-md-3">
					<button type="button" class="btn" onclick="checkNum();" style="background-color: #1BB3C8; color:white">인증번호 확인</button>
				</div>
			</div>
			<div class="col-md-3"></div>
		</div>
		<!-- END 휴대폰인증 -->
		
		<!-- 구분선 --><div class="col-md-12"><hr style="margin-bottom: 100px;"></div>
	</div>
	<!-- END 숙소내용기입 -->
	
	<!-- 취소 / 등록 버튼 -->
	<div class="form-group col-md-12">
		<div class="col-md-6">
			<button type="button" class="btn" onclick="window.location.href='myroomlist.do'"
			style="background-color: #408080; color:white; width:100%;">취소하기</button>
		</div>
		<div class="col-md-6">
			<button type="submit" class="btn" style="background-color: #1BB3C8; color:white; width:100%;">등록하기</button>
		</div>
	</div>
	<!-- END 취소 / 등록 버튼 -->
	<!-- 구분선 --><div class="col-md-12"><hr></div>
	</form>
</div>


<!-- javascript -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script><script charset="UTF-8" type="text/javascript" src="http://t1.daumcdn.net/postcode/api/core/180619/1529384927473/180619.js"></script>
<script>
//본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
function execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
            var extraRoadAddr = ''; // 도로명 조합형 주소 변수

            // 법정동명이 있을 경우 추가한다. (법정리는 제외)
            // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                extraRoadAddr += data.bname;
            }
            // 건물명이 있고, 공동주택일 경우 추가한다.
            if(data.buildingName !== '' && data.apartment === 'Y'){
               extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
            }
            // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
            if(extraRoadAddr !== ''){
                extraRoadAddr = ' (' + extraRoadAddr + ')';
            }
            // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
            if(fullRoadAddr !== ''){
                fullRoadAddr += extraRoadAddr;
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('zipCode').value = data.zonecode; //5자리 새우편번호 사용
            document.getElementById('roadAddress').value = fullRoadAddr;

            // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
            if(data.autoRoadAddress) {
                //예상되는 도로명 주소에 조합형 주소를 추가한다.
                var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                document.getElementById('guide').innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';

            } else {
                document.getElementById('guide').innerHTML = '';
            }
        }
    }).open();
}
</script>
<script type='text/javascript'>
// 달력을 통한 날짜 선택 함수
$(function()
{
    $('.input-group.date').datepicker(
    {
    	minDate : 0,
        calendarWeeks: false,
        todayHighlight: true,
        autoclose: true,
        datesDisabled: ['2018-07-19', '2018-07-31'],
        format: "yyyy-mm-dd",
        language: "kr"
    });
});

// 증가/감소버튼을 통한 최소인원수 설정 함수
function minChange(num)
{
	var y = Number(minCount.value) + num;
	if (y < 1)
		y = 0;
	
	if (y > Number(maxCount.value))
		y = Number(minCount.value);
	
	minCount.value = y;
}

//증가/감소버튼을 통한 최대인원수 설정 함수
function maxChange(num)
{
	var y = Number(maxCount.value) + num;
	if (y < 1)
		y = 0;
	if (y < Number(minCount.value))
		y = Number(maxCount.value);
	maxCount.value = y;
}
</script>

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
//달력을 통한 날짜 선택 함수
$(function(){
    $('#startDate').datepicker({

    	// 주 옆에 번호 뜨는거
        calendarWeeks: false,

        // 오늘 날짜에 강조
        todayHighlight: true,

        // 날짜 선택하면 창 종료
        autoclose: true,

        // 날짜 포맷
        format: "yyyy-mm-dd",

        // 달력 언어
        language: "kr",
        
        // 선택할 수 있는 최소 날짜
        minDate: 0,
        
        // 이거는 예시
		datesDisabled: ['2018-07-31'],	// 예약중인 날짜를 매개변수로 넣어서 처리한다.
		
		// 오늘 이전 날짜 선택 불가
		startDate: 'today',
		
		// 종료일 예시
		endDate: '+3y',
		
		multidate: false,
		
    });

    $('#endDate').datepicker({
        calendarWeeks: false,

        // 오늘 날짜에 강조
        todayHighlight: true,

        // 날짜 선택하면 창 종료
        autoclose: true,

        // 날짜 포맷
        format: "yyyy-mm-dd",

        // 달력 언어
        language: "kr",
        
        // 선택할 수 있는 최소 날짜
        minDate: 0,
        
        // 이거는 예시
		datesDisabled: ['2018-07-31'],	// 예약중인 날짜를 매개변수로 넣어서 처리한다.
		
		// 오늘 이전 날짜 선택 불가
		startDate: 'today',
		
		// 종료일 예시
		endDate: '+3y', // 3년후까지만 받는다.
		
		multidate: false,
    });
});
</script>

<script type="text/javascript">
// 두 날짜 사이 날짜 구하는 함수 (시작날짜, 종료날짜, 담을배열변수)
function getDateRange(startDate, endDate, dateList)
{
    var dateMove = new Date(startDate);
    var strDate = startDate;

    if (startDate == endDate)
    {
        var strDate = dateMove.toISOString().slice(0,10);
        dateList.push(strDate);
    }
    else
    {
        while (strDate < endDate)
        {
            var strDate = dateMove.toISOString().slice(0, 10);
            dateList.push(strDate);
            dateMove.setDate(dateMove.getDate() + 1);
        }
    }
    return dateList;
};

// 날짜 더하기/빼기 함수
function dateAddDel(sDate, nNum, type)
{
    var yy = parseInt(sDate.substr(0, 4), 10);
    var mm = parseInt(sDate.substr(5, 2), 10);
    var dd = parseInt(sDate.substr(8), 10);
    
    if (type == "d") {
        d = new Date(yy, mm - 1, dd + nNum);
    }
    else if (type == "m") {
        d = new Date(yy, mm - 1 + nNum, dd);
    }
    else if (type == "y") {
        d = new Date(yy + nNum, mm - 1, dd);
    }
 
    yy = d.getFullYear();
    mm = d.getMonth() + 1; mm = (mm < 10) ? '0' + mm : mm;
    dd = d.getDate(); dd = (dd < 10) ? '0' + dd : dd;
 
    return '' + yy + '-' +  mm  + '-' + dd;
    
    /*
    호출시 사용법
    dateAddDel('2017-09-25', -7, 'd'); 
    dateAddDel('2017-09-25', -1, 'm'); 
    dateAddDel('2017-09-25', -1, 'y');
    */
}

//예약가능날짜 추가시 목록에 추가
function datePlus()
{
	// 주요 변수 선언
	var startDate = $("#startDate").val(); //-- 현재 입력된 체크인날짜
	var endDate = $("#endDate").val();     //-- 현재 입력된 체크아웃날짜
	
	// 1.입력된 값이 없을 경우 추가불가
	if ($("#startDate").val() == null || $("#startDate").val() == "" || $("#endDate").val() == null || $("#endDate").val() == "")
	{
		$("#startDate").css("border", "1px solid red");
		$("#endDate").css("border", "1px solid red");
		alert('날짜를 선택해주세요.');
		return;
	}
	// 2.입력된 체크인날짜보다 체크아웃이 빠른날짜인 경우
	if (startDate>endDate)
	{
		$("#startDate").css("border", "1px solid red");
		$("#endDate").css("border", "1px solid red");
		alert('체크아웃날짜는 체크인보다 빠를 수 없습니다.');
		return;
	}
	// 3.등록된 체크인날짜가 없는 경우 리스트에 바로 추가
	if ($("input[name=startDate]").length == 0)
	{
		$("#startDate").css("border", "1px solid #ccc");
		$("#endDate").css("border", "1px solid #ccc");
		
		// row 추가해주기
		$("#dateTable").children().eq(0).append(
			 "<tr name='period'>"
			+"<td><input type='text' id='startDate' name='startDate' value='"+startDate+"' readonly='readonly'></td>"
			+"<td><input type='text' id='endDate' name='endDate' value='"+endDate+"' readonly='readonly'></td>"
			+"<td><button type='button' class='deletebtn' id='deletebtn' style='background-color:white;'>X</button></td>"
			+"</tr>");
		
		return;
	}
	
	// 4.등록된 체크인날짜가 있는 경우 
	
	// 현재 선택된 체크인날짜 배열에 담기
	var pickList = [];
	getDateRange(startDate, dateAddDel(endDate, -1, 'd'), pickList);

	var startDateList = document.getElementsByName("startDate"); //-- 등록된 체크인날짜 리스트
	var endDateList = document.getElementsByName("endDate");     //-- 등록된 체크아웃날짜 리스트
	var dateList = [];                                           //-- 등록된 체크인 날짜들을 담을 변수선언
	
	// 등록된 체크인날짜 리스트를 불러와 dateList 배열에 담기
	for (var i=0; i<$("input[name=startDate]").length; i++)
	{
		// 날짜 사이 날짜 담는 함수 호출 (체크아웃날짜에서 하루빼기→ 체크인날짜만 모으기위해)
		getDateRange(startDateList[i].value, dateAddDel(endDateList[i].value, -1, 'd'), dateList);
	}
	
	// 등록된 체크인날짜와 선택된 체크인날짜와 비교 후 같은 날이 있을 경우 에러메세지 출력
	for (var i=0; i<pickList.length; i++)
	{
		for (var j=0; j<dateList.length; j++)
		{
			if (pickList[i] == dateList[j])
			{
				alert("중복된 체크인날짜가 등록되어 있습니다.");
				$("#startDate").css("border", "1px solid red");
				$("#endDate").css("border", "1px solid red");
				return;
			}
		}
	}
	
	// 중복된 체크인날짜가 없을 시 리스트에 추가
	$("#startDate").css("border", "1px solid #ccc");
	$("#endDate").css("border", "1px solid #ccc");
	
	// row 추가해주기
	$("#dateTable").children().eq(0).append(
		 "<tr name='period'>"
		+"<td><input type='text' id='startDate' name='startDate' value='"+startDate+"' readonly='readonly'></td>"
		+"<td><input type='text' id='endDate' name='endDate' value='"+endDate+"' readonly='readonly'></td>"
		+"<td><button type='button' class='deletebtn' id='deletebtn' style='background-color:white;'>X</button></td>"
		+"</tr>");
	return;
}

//선택된 해당예약가능날짜 지우기
$(document).on("click","#deletebtn",function()
{ 
	$(this).closest("tr").remove();
});

$('#dpStartDate').trigger('changeDate', startDate);



</script>

<script type="text/javascript">
/* form check */
function formCheck()
{
	// 1. 숙소면적 입력값 유효성체크
	if ($("#rarea").val() == null || $("#rarea").val() == ""){
		
		// 숙소면적 미기입시 오류메세지 출력
		$("#rarea").css("border", "1px solid red");
		alert("숙소면적을 입력해주세요.");
		return false;
		
	} else {
		$("#rarea").css("border", "1px solid #ccc");
	}
	
	// 2. 숙소이름 입력값 유효성체크
	if ($("#rname").val() == null || $("#rname").val() == ""){
		
		// 숙소이름 미기입시 오류메세지 출력
		$("#rname").css("border", "1px solid red");
		alert("숙소이름을 입력해주세요.");
		return false;
	} else {
		$("#rname").css("border", "1px solid #ccc");
	}
	
	// 3. 숙소주소 입력값 유효성체크
	if ($("#roadAddress").val() == null || $("#roadAddress").val() == ""){
		
		// 기본주소 미기입시 오류메세지 출력
		$("#roadAddress").css("border", "1px solid red");
		alert("숙소기본주소를 입력해주세요.");
		return false;
		
	} else {
		$("#roadAddress").css("border", "1px solid #ccc");
	}
	if ($("#detailAddress").val() == null || $("#detailAddress").val() == ""){
		
		// 상세주소 미기입시 오류메세지 출력
		$("#detailAddress").css("border", "1px solid red");
		alert("숙소상세주소를 입력해주세요.");
		return false;
		
	} else {
		$("#detailAddress").css("border", "1px solid #ccc");
	}
	
	// 4. 숙박인원 입력값 유효성체크 
	if ($("#minCount").val() == 0){
		
		// 숙박 최소인원이 0명일 경우 오류메세지 출력
		$("#minCount").css("border", "1px solid red");
		alert("최소 숙박인원은 1명입니다.");
		return false;
		
	} else {
		$("#minCount").css("border", "1px solid #ccc");
	}

	// 5. 1박 요금 유효성 체크 
	if (isNaN($("#adultFee").val()) == true || isNaN($("#childFee").val()) == true){
		
		// 문자일경우 오류메세지 출력
		$("#adultFee").css("border", "1px solid red");
		$("#childFee").css("border", "1px solid red");
		
		alert("요금은 숫자로 기입해주세요.");
		return false;
		
	} 
	else if ($("#adultFee").val() < 0 || $("#childFee").val() < 0) {
		
		// 0원 미만으로 기입했을 경우 오류메세지 출력
		$("#adultFee").css("border", "1px solid red");
		$("#childFee").css("border", "1px solid red");
		
		alert("요금은 0원 이상만 기입 가능합니다.");
		return false;
	}
	else {
		$("#adultFee").css("border", "1px solid #ccc");
		$("#childFee").css("border", "1px solid #ccc");
	}
	
	// 6. 숙소사진 유효성체크
	if ($("#fileName1").val() == null || $("#fileName1").val() == "" || $("#fileName2").val() == null || $("#fileName2").val() == "" ||
		$("#fileName3").val() == null || $("#fileName3").val() == "" || $("#fileName4").val() == null || $("#fileName4").val() == "")
	{
		// 상세주소 미기입시 오류메세지 출력
		$("#fileName1").css("border", "1px solid red");
		$("#fileName2").css("border", "1px solid red");
		$("#fileName3").css("border", "1px solid red");
		$("#fileName4").css("border", "1px solid red");
		alert("숙소사진를 등록해주세요.");
		return false;
		
	} else {
		$("#fileName1").css("border", "1px solid #ccc");
		$("#fileName2").css("border", "1px solid #ccc");
		$("#fileName3").css("border", "1px solid #ccc");
		$("#fileName4").css("border", "1px solid #ccc");
	}
	
	
	// 7. 예약가능날짜목록 유효성체크
	if ($("input[name=startDate]").length == 0){
		
		// 예약가능날짜가 없을 경우 에러메세지 출력
		alert("예약가능날짜를 추가해주세요.");
		return false;
	}
	
	// 8. 휴대폰인증여부 체크
	if ($('input:checkbox[id="tel_ok"]').is(":checked") == false) {
		
		// 인증확인 체크가 안됐을 경우 에러메세지 출력
		$("#telCheckNum").css("border", "1px solid red");
		alert("휴대폰 인증이 필요합니다.");
		return false;
	} else {
		$("#telCheckNum").css("border", "1px solid #ccc");
	}
	
	// 8. 모든 유효성 통과시 전송요청
	return true;
}
</script>
 
<!-- 푸터 영역 -->
<c:import url="../source/MemberFooter.jsp"></c:import>
</body>
</html>