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
<title>MyRoomVerification.jsp</title>

<!-- 부트스트랩 CDN -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="<%= cp%>/memberAssets/css/Member.css">
<link rel="stylesheet" href="<%= cp%>/memberAssets/css/MemberLogin.css">

</head>
<body>

<!-- 회원 상단 메뉴바 영역 -->
<% if (memCode == null) { %>
<c:import url="../source/MemberLoginMainbar.jsp"></c:import>
<% } else { %>
<c:import url="../source/MemberMainbar.jsp"></c:import>
<% } %>



<!-- 신청숙소 등급이 B일 경우 A등급신청 -->
<c:if test="${myRoom.vafterGrade eq 'B' }">
<div class="container" style="padding-left:120px; padding-right:120px;">
   <div class="row">
   
      <div class="col-md-12">
         <h1>[${myRoom.rname}] 검증신청 B → A</h1>
      </div>
      
      <!-- 구분선 -->
      <div class="col-md-12"><hr></div>
      <br><br><br><br>
      
      <div class="col-md-12">
         <!-- 등록된 숙소정보 조회 -->
         <div class="col-md-2"></div>
         <div class="col-md-8" style="border: 1px solid lightgray;">
            <form action="verificationreq.do" method="POST" enctype="multipart/form-data">
               
               <br><br>
               
               <div class="form-group col-md-12">
                  <h3>현장 실사 점검 안내</h3>
                  <textarea rows="15" style="resize:none; width:100%;">
                  Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer hendrerit quam eget tellus commodo aliquet. Vestibulum ut condimentum dui, at suscipit turpis. Aliquam rutrum venenatis purus ut commodo. Donec eleifend pharetra iaculis. Ut faucibus dignissim leo sed posuere. Nunc dignissim sagittis lectus, sed finibus arcu efficitur nec. Phasellus tempor congue eros at scelerisque. Etiam dapibus consectetur nisl at porttitor. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut nec odio efficitur, mattis risus ut, tincidunt massa. Praesent sit amet tincidunt turpis. Nunc purus erat, dapibus sit amet euismod id, fringilla quis arcu. Aenean pharetra id arcu id tempor. Etiam orci diam, ultricies ut molestie sit amet, volutpat ac dolor. Proin vel dui ac quam pharetra suscipit.
                  </textarea>
               </div>
               
               <div class="form-group col-md-12">
                  <label><input type="checkbox"> 예, 현장 실사 점검에 대해 동의합니다.</label>
               </div>
               
               <!-- 숙소코드 보내기 -->
               <input type="hidden" name="rcode" value="${myRoom.rcode }">
               
               <!-- 신분증 사본 업로드 -->
               <div class="form-group col-md-12">
                  <div class="col-md-1"></div>
                  <div class="col-md-5">
                     <h4>등기부 등본 사본 업로드</h4>
                  </div>
                  <div class="col-md-5">
                     <input type="text" id="roomfile" class="file_input_textbox" readonly="readonly" style="width: 200px;">
                     <div class="file_input_div">
                        <input type="button" value="files" class="file_input_button">
                        <input type="file" class="file_input_hidden" name="reqvAttach" onchange="javascript:document.getElementById('roomfile').value = this.value">
                     </div>
                  </div>
                  <div class="col-md-1"></div>
               </div>
               <!-- END 신분증 사본 업로드 -->
               
               <br><br>
               
	         <div class="col-md-2"></div>
	         <!-- END 등록된 숙소정보 조회 -->
	         
	         <!-- 다음으로 버튼 -->
	         <div class="col-md-12">
	            <div class="col-md-2"></div>
	            <div class="col-md-4">
	               <button type="button" class="btn nextbtn" onclick="window.location.href='myroomlist.do'">돌아가기</button>
	            </div>
	            <div class="col-md-4">
	               <button type="submit" class="btn nextbtn">검증요청</button>
	            </div>
	            <div class="col-md-2"></div>
	         </div>
	         </form>
         </div>
      </div>
   </div>
</div>

</c:if>
<!-- END 신청숙소 등급이 B일 경우 A등급신청 -->

<!-- 신청숙소 등급이 C일 경우 B등급 검증신청 -->
<c:if test="${myRoom.vafterGrade eq 'C' }">
<div class="container" style="padding-left:120px; padding-right:120px;">
   <div class="row">
   
      <div class="col-md-12">
         <h1>[${myRoom.rname}] 검증신청 C → B</h1>
      </div>
      
      <!-- 구분선 --><div class="col-md-12"><hr></div>
      <br><br><br><br>
      
      <div class="col-md-12">
         <!-- 등록된 숙소정보 조회 -->
         <div class="col-md-2"></div>
         <div class="col-md-8" style="border: 1px solid lightgray;">
            <form action="verificationreq.do" method="POST" encType="multipart/form-data">
               
               <br><br>
               
               <div class="form-group col-md-12">
                  <h3>보험정책약관</h3>
                  <textarea rows="15" style="resize:none; width:100%;">
                  Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer hendrerit quam eget tellus commodo aliquet. Vestibulum ut condimentum dui, at suscipit turpis. Aliquam rutrum venenatis purus ut commodo. Donec eleifend pharetra iaculis. Ut faucibus dignissim leo sed posuere. Nunc dignissim sagittis lectus, sed finibus arcu efficitur nec. Phasellus tempor congue eros at scelerisque. Etiam dapibus consectetur nisl at porttitor. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut nec odio efficitur, mattis risus ut, tincidunt massa. Praesent sit amet tincidunt turpis. Nunc purus erat, dapibus sit amet euismod id, fringilla quis arcu. Aenean pharetra id arcu id tempor. Etiam orci diam, ultricies ut molestie sit amet, volutpat ac dolor. Proin vel dui ac quam pharetra suscipit.
                  </textarea>
               </div>
               
               <div class="form-group col-md-12">
                  <label><input type="checkbox"> 예, 이용약관에 동의합니다.</label>
               </div>
               
               <!-- 숙소코드 보내기 -->
               <input type="hidden" name="rcode" value="${myRoom.rcode }">
               
               <!-- 첨부파일 업로드 -->
               <div class="form-group col-md-12">
                  <div class="col-md-1"></div>
                  <div class="col-md-5">
                     <h4>보험 증명 서류 / 신분증 사본 업로드</h4>
                  </div>
                  <div class="col-md-5">
                     <input type="text" id="insurance" class="file_input_textbox" readonly="readonly" style="width: 200px;">
                     <div class="file_input_div">
                        <input type="button" value="files" class="file_input_button">
                        <input type="file" class="file_input_hidden" name="reqvAttach">
                     </div>
                  </div>
                  <div class="col-md-1"></div>
               </div>
               <!-- END 보험 증명 서류 업로드 -->
               
               <br><br>
               
               
               <div class="col-md-2"></div>
               <!-- END 등록된 숙소정보 조회 -->
               
               <!-- 다음으로 버튼 -->
               <div class="col-md-12">
                  <div class="col-md-2"></div>
                  <div class="col-md-4">
                     <button type="button" class="btn nextbtn" onclick="window.location.href='myroomlist.do'">돌아가기</button>
                  </div>
                  <div class="col-md-4">
                     <button type="submit" class="btn nextbtn">검증요청</button>
                  </div>
                  <div class="col-md-2"></div>
               </div>
            </form>
         </div>
      </div>
   </div>
</div>
</c:if>
<!-- END 신청숙소 등급이 C일 경우 B등급 검증신청 -->

<!-- 푸터 영역 -->
<c:import url="../source/MemberFooter.jsp"></c:import>
</body>
</html>