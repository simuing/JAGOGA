package com.gaja.member;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.gaja.dto.BookableDateDTO;
import com.gaja.dto.ConstraintDTO;
import com.gaja.dto.ConvenienceDTO;
import com.gaja.dto.RoomDTO;
import com.gaja.dto.MyRoomDTO;
import com.gaja.dto.VmyRoomBookingDTO;

public interface IMyRoomListDAO
{
	// 내 숙소 목록 조회 (대표이미지 : rimg)
	public ArrayList<MyRoomDTO> myRoomList(int memCode);
	
	
	
	/* 숙소 수정하기 / 삭제하기 */
	
	// 예약중인 게스트 세기
	public int countPeople(int rcode);
	
	// 숙소 기존 정보 조회
	public MyRoomDTO roomDetail(int rcode);
	
	// 숙소 기존 제한사항 조회
	public ArrayList<ConstraintDTO> roomConstraint(int rcode);
	
	// 숙소 기존 편의사항 조회
	public ArrayList<ConvenienceDTO> roomConvenience(int rcode);
	
	// 숙소 기존 예약가능날짜 조회
	public ArrayList<BookableDateDTO> roomBookableDate(int rcode);
	
	// 숙소 정보 수정
	public int modifyRoom(@Param("rcode")int rcode, RoomDTO dto);
	
	// 숙소 예약가능날짜 수정하기
	public int modifyBookableDate();
	
	// 숙소 편의시설 수정 (기존 데이터 지우고 새로 추가)
	public int modifyRoomConvenience();
	
	// 숙소 제한사항 수정 (기존 데이터 지우고 새로 추가)
	public int modifyRoomConstraint();
	
	// 숙소 삭제하기
	//public int deleteRoom(int rcode);
	
	
	
	/* 숙소 예약내역 */
	
	// 숙소 예약내역 조회
	public ArrayList<VmyRoomBookingDTO> roomBookingList(int rcode);
	
	// 에티켓 평가(보류)
	
	
	
	/* 숙소 검증요청 */
	
	
	
}
