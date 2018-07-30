package com.gaja.member;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.gaja.dto.VmyBookingListDTO;

public interface IMyBookingListDAO
{
   // 예약목록 조회
   public ArrayList<VmyBookingListDTO> bookingList(int gmemCode);
   
   // 예약목록 기간 조회
   public ArrayList<VmyBookingListDTO> dateBookingList(@Param("gmemCode")int gmemCode, @Param("startCheck")String startCheck, @Param("endCheck")String endCheck);
   
   // 예약 취소
   public int bookingCancel(int bcode);
   
   // 예약내역 상세조회
   public VmyBookingListDTO bookingDetail(@Param("gmemCode") int gmemCode, @Param("bcode") int bcode);
   
   // 예약 삭제
   //public int deleteBooking(int bcode);
      
   
}