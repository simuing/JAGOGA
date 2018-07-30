/*------------------------------------
     	 IAdminInsuranceDAO
 - 관리자 보험관리 탭 관련 인터페이스-
 -------------------------------------*/ 

package com.gaja.admin;


import com.gaja.dto.TermsDTO;
import com.gaja.dto.VinsuranceDTO;

public interface IAdminInsuranceDAO
{
	// 게스트 보험 정보 조회
	public VinsuranceDTO guestInsu();
	
	// 호스트 보험 정보 조회
	public VinsuranceDTO hostInsu();
		
	// 보험 정보 수정
	public int insuUpdate(VinsuranceDTO dto);
	
	// 게스트 보험료 비율 조회
	public int guestInsuRate();
	
	// 호스트 보험료 비율 조회
	public int hostInsuRate();	
	
	// 보험료 비율 수정
	public int iRateUpdate(VinsuranceDTO dto);
	
	// 게스트 보험약관 조회
	public TermsDTO guestInsuTerms();
	
	// 호스트 보험약관 조회
	public TermsDTO hostInsuTerms();
	
	// 보험약관 수정
	public int insuTermsUpdate(TermsDTO dto);
	
	
}
