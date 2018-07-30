/*------------------------------------
     	      IAdminDAO
 - 관리자계정관리 탭 관련 인터페이스-
 -------------------------------------*/ 

package com.gaja.admin;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.gaja.dto.VadminDTO;
import com.gaja.dto.AdminDTO;
import com.gaja.dto.AuthorityDTO;

public interface IAdminDAO
{	
	// 관리자 코드 조회
	public int adminCode(String adminId);
	
	// 관리자 계정 전체 목록 조회
	public ArrayList<VadminDTO> adminList();
	
	// 특정 관리자 계정 전체 목록 조회
	public VadminDTO adminInfo(int adminCode);
	
	// 권한 목록 조회
	public ArrayList<AuthorityDTO> authorityList();
	
	// 관리자 계정 등록
	public int adminAdd(VadminDTO dto);

	// 관리자코드 가져오기
	public int getAdminCode(String adminId);
	
	// 관리자 계정 권한 등록 & 수정시 필요
	public int adminAtAdd(@Param("adminCode") int adminCode,@Param("atCode") int atCode);
	
	// 관리자 계정 수정
	public int adminModify(VadminDTO dto);
	
	// 관리자 계정 권한 삭제
	public int adminAtRemove(int adminCode);
	

	// 관리자 계정 활성화/비활성화
	public int adminChangeActive(@Param("adminCode") int adminCode, @Param("active") String active);
	
	// 관리자 로그인 확인
	public String adminLogin(AdminDTO admin);
	
	// 해당 관리자의 보유 권한 조회
	public String[] adminAuthority(int adminCode);
	
	// 관리자 아이디 중복검사
	public int duplicateAdminId(String adminId);
	
	
}
