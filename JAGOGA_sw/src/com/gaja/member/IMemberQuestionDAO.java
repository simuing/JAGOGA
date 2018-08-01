package com.gaja.member;

import java.util.ArrayList;
import com.gaja.dto.VfaqDTO;
import com.gaja.dto.VquestionDTO;

public interface IMemberQuestionDAO
{	
	// 자주묻는문의 (FAQ) 문의분류별조회
	public ArrayList<VfaqDTO> faqList(int qstcCode);
	
	// 자주묻는문의 상세조회
	public VfaqDTO faq(int faqCode);
	
	// 내 문의 목록조회
	public ArrayList<VquestionDTO> myQuestionList(int memCode);
	
	// 내 문의 상세조회 (답변포함)
	public VquestionDTO myQuestion(int qstCode);
	
	
	// 내 문의 등록
	public int myQuestionInsert(VfaqDTO dto);
	
	// 카테고리 조회
	public ArrayList<VfaqDTO> categorySearch();

}