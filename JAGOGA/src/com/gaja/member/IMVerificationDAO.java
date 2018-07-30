package com.gaja.member;

import java.sql.SQLException;
import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.gaja.dto.VverificationDTO;

public interface IMVerificationDAO
{
   /* 검증내역 전체목록 */
   
   // 회원 - 검증내역 전체목록 조회
   public ArrayList<VverificationDTO> mVerificationList(int memCode) throws SQLException;
   
   // 검증사유 조회
   public String verificationCause(int vcode) throws SQLException;
   
   // 숙소 검증상태 조회
   public String vState(int rcode) throws SQLException;
   
   
   
   /* 내 숙소 검증신청 */
   
   // 검증신청
   public int verificationReq(@Param("rcode") int rcode, @Param("reqvAttach") String reqvAttach) throws SQLException;

}