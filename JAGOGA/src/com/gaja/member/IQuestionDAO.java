package com.gaja.member;

import java.util.ArrayList;

import com.gaja.dto.VquestionDTO;

public interface IQuestionDAO
{
	// 문의목록 조회
	public ArrayList<VquestionDTO> questionList();
	
	// 문의목록 조회 (답변대기상태만)
	public ArrayList<VquestionDTO> waitingQuestionList();
	
	// 선택문의 상세조회 (답변포함)
	public VquestionDTO selectQuestion(String qstCode);
}