package com.gaja.admin;

import java.util.ArrayList;

import com.gaja.dto.VadminRoomDTO;

public interface IAdminRoomDAO
{
	// 숙소 목록 조회 메소드
	public ArrayList<VadminRoomDTO> adminRoomList(int pageNumber);
	
	// 숙소 숨김 사유, 처리자 조회 메소드
	public VadminRoomDTO hideRoomCause(int rcode);
	
	// 숨김상태 변경 메소드
	public int hideRoom(VadminRoomDTO dto);
	public int noHideRoom(int rcode);
	
	// 숙소 리뷰목록 조회
	public ArrayList<VadminRoomDTO> roomReviewList(int rcode);
	
	// 숙소 문의목록 조회
	public ArrayList<VadminRoomDTO> roomQuestionList(int rcode);
	
	// 숙소리뷰 숨김 사유 조회
	public VadminRoomDTO roomHideCause(int revCode);
	
	// 특정 리뷰 조회
	public VadminRoomDTO roomReview(int revCode);
	
	// 특정 문의내용 조회
	public VadminRoomDTO roomQuestion(int rqstCode);
	
	// 특정 문의답변 조회
	public String roomQuestionAnswer(int rqstCode);
	
	// 특정 문의 숨김 사유 조회
	public VadminRoomDTO roomQstHideCause(int rqstCode);
	
	// 숙소문의 비공개처리
	public int rqstHide(VadminRoomDTO dto);
	
	// 숙소문의 공개처리
	public int noRqstHide(int rqstCode);
	
	// 숙소 배너 정보 조회
	public VadminRoomDTO roomBanner(int rcode);
}
