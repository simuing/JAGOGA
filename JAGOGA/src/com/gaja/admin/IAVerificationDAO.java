/*---------------------------------------
     	   IAVerificationDAO
      관리자 검증관리 탭 관련 인터페이스
 ----------------------------------------*/ 

package com.gaja.admin;


import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.gaja.dto.VverificationDTO;

public interface IAVerificationDAO
{
	// 관리자 - 검증관리조회
	public ArrayList<VverificationDTO> aVerificationList(@Param("pageNumber") int pageNumber);
	
	// 검증사유 조회
	public String verificationCause(int vcode);
	
	// 검증시작 업데이트
	public int startVerification(VverificationDTO dto);
	
	// 검증완료 업데이트
	public int endVerification(VverificationDTO dto);
	
	// 검증첨부파일 조회
	public String verificationAttach(int reqvCode);
	
	// reqvCode로 vcode 조회
	public int getVcode(int reqvCode);
	
}