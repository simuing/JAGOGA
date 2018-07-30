package com.gaja.member;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.gaja.dto.VmyRoomBookingDTO;


public interface IMyRoomBookingDAO
{
   //<!-- 내 숙소 예약내역 출력  -->
   //public ArrayList<IMyRoomBookingDAO> myRoomBookingList(int memCode);// 로그인한 회원 코드담기
   public ArrayList<VmyRoomBookingDTO> myRoomBookingList(int memCode);// 로그인한 회원 코드담기
   
   // 내 숙소 예약내역 출력 - 기간 검색  // - 로그인한 회원코드, 시작일 , 끝일
   //public ArrayList<VmyRoomBookingDTO> myRoomBookingSearch(@Param("memCode")int memCode, @Param("startCheck")String startCheck, @Param("endCheck")String endCheck);
  
   //에티켓 점수 부여하였는지 확인 여부
   public int checkEtq();
   
   // 에티켓 +100 점수 주기
   public int plusEtqScore(int memCode);
  
   // 에티켓 -100 점수 주기
   public int minusEtqScore(int memCode);
  
   // 예약취소하기
   public int hostCancelbooking(int bCode);
  
   // 누가 예약 취소하였는지 
   public int shareWhoCancel(int memCode);
  
   // 숙박완료시  이용완료로 변경시켜주기
   public int changeStatus(IMyRoomBookingDAO dto);
  
   // 에티켓 평가 완료로 변경
   public int endPoint(@Param("gmemCode")int gmemCode, @Param("bcode")int bcode);
   
   
}