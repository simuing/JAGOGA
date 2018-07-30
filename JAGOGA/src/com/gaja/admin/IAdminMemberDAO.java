/*------------------------------------
     	 IAdminMemberDAO
 - 관리자 회원관리 탭 관련 인터페이스-
 -------------------------------------*/ 
 
package com.gaja.admin;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.gaja.dto.MemberDTO;
import com.gaja.dto.VMemberDTO;

public interface IAdminMemberDAO
{
	
	// 특정 회원 상세 정보
	// 관리자가 회원 정보 수정을 눌렀거나 그 외 특정 회원의 정보만이 새 창으로 조회될 때
	public ArrayList<MemberDTO> aMemberInfo(int code);
	
	// 관리자측에서 전체 회원 정보 목록 조회(회원관리탭 등에서 사용)
	public ArrayList<VMemberDTO> aMemberList(@Param("pageNumber") int pageNumber);
	
	// 특정 회원번호로 회원정보 검색 결과
	// 관리자가 회원관리 탭에서 회원번호로 검색하였을 때 결과
	public VMemberDTO aMemCodeSearch(int memCode);
	
	
	// 특정 회원아이디로 회원정보 검색 결과
	// 관리자가 회원관리 탭에서 회원아이디로 검색하였을 때 결과
	public ArrayList<VMemberDTO> aMemIdSearch(String memId);
	
	
	// 특정 회원 휴대폰번호로 회원정보 검색 결과
	// 관리자가 회원관리 탭에서 회원휴대폰번호로 검색하였을 때 결과
	public ArrayList<VMemberDTO> aMemTelSearch(String memTel);
	
	// 관리자가 회원 탈퇴(삭제)시키는 메소드
	public int adminDeleteMem(int memCode);
	
	// 회원정보 수정 메소드 (이메일, 에티켓점수)
	public int updateMemInfo(VMemberDTO dto);
		
	// 회원 영구정지 메소드
	public int blockMember(VMemberDTO dto);
	
	// 영구정지 사유 및 처리자 조회 메소드
	public VMemberDTO checkBlockCause(int memCode);
	
	// 영구정지 복구 메소드
	public int restoreBlock(int memCode);
	
	// 탈퇴계정 복구 메소드
	public int restoreLeave(int memCode);
	
	// 탈퇴테이블 레코드 제거 메소드
	public int deleteLeaveRecord(int memCode);
	
}
