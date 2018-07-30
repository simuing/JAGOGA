/*----------------------------------
     	 IAdminQuestionDAO
      관리자 고객센터관리 탭  
    및 모든 정책,약관 사항 관련 
            인터페이스
 -----------------------------------*/ 

package com.gaja.admin;
import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.gaja.dto.TermsDTO;
import com.gaja.dto.VfaqDTO;
import com.gaja.dto.VquestionDTO;

public interface IAdminQuestionDAO
{
	// 문의목록 조회
	public ArrayList<VquestionDTO> questionList(@Param("pageNumber") int pageNumber);

	// 문의목록 조회 (답변대기상태만)
	public ArrayList<VquestionDTO> waitingQuestionList();
	
	// 선택문의 상세조회 (답변포함)
	public VquestionDTO selectQuestion(int qstCode);
	
	// FAQ 문의분류별 조회
	public ArrayList<VfaqDTO> faqList();
	
	// FAQ 등록
	public int faqInsert(VfaqDTO dto);
	
	// FAQ 수정
	public int faqUpdate(VfaqDTO dto);
	
	// FAQ 삭제
	public int faqDelete(int faqCode);
	
	// 정책및이용약관 조회  
	public TermsDTO policiesTerms();
	
	// 정책및이용약관 수정
	// public int policiesTermsUpdate(TermsDTO dto);
	
	// 개인정보취급방침 조회
	public TermsDTO privacyTerms();
	
	// 개인정보취급방침 수정
	// public int privacyTermsUpdate(TermsDTO dto);
	public int TermsUpdate(TermsDTO dto);

	// 결제 약관 조회
	public TermsDTO bookingTerms();
	
	// 결제 약관 수정
	public int bookingTermsUpdate(TermsDTO dto);
	
	// 문의 답변
	public int registAnswer(VquestionDTO dto);
	
	// 관리자코드 조회
	public int adminCode(String adminId);
	
	
}