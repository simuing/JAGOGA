package com.gaja.member;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.gaja.dto.BookableDateDTO;
import com.gaja.dto.ConstraintDTO;
import com.gaja.dto.ConvenienceDTO;
import com.gaja.dto.RoomConstraintDTO;
import com.gaja.dto.RoomConvenienceDTO;
import com.gaja.dto.RoomDTO;
import com.gaja.dto.RoomImageDTO;
import com.gaja.dto.RoomTypeDTO;
import com.gaja.dto.TermsDTO;

public interface IInsertRoomDAO
{
	// 숙소 개수 카운트 (10일 경우 등록 불가)
	public int roomCount(int memCode);
	
	// InsertRoom1. 호스트 서비스 정책 및 이용약관 조회
	public TermsDTO hostTerms();
	
	// InsertRoom2. 숙소유형 목록 조회
	public ArrayList<RoomTypeDTO> roomTypeList();
	
	// InsertRoom2. 편의시설 목록 조회
	public ArrayList<ConvenienceDTO> convList();
	
	// InsertRoom2. 제한사항 목록 조회
	public ArrayList<ConstraintDTO> consList();

	
	// InsertRoom3. 1. 선택된 숙소유형 조회
	public RoomTypeDTO pickRoomType(int rtypeCode);
	
	// InsertRoom3. 2. 선택된 편의시설 조회
	public ConvenienceDTO pickConv(int convCode);
	
	// InsertRoom3. 3. 선택된 제한사항 조회
	public ConstraintDTO pickCons(int consCode);
	
	
	// InsertRoom3. 1.숙소코드 입력
	public int insertRoomCode(@Param("memCode") int memCode);
	
	// InsertRoom3. 2.방금입력된 숙소코드 가져오기
	public int getRoomCode(@Param("memCode") int memCode);
	
	// InsertRoom3. 3.숙소 입력
	public int insertRoom(RoomDTO dto);
	
	// InsertRoom3. 4.숙소 편의사항 입력
	public int insertRoomConv(RoomConvenienceDTO dto);
	
	// InsertRoom3. 5.숙소 제한사항 입력
	public int insertRoomCons(RoomConstraintDTO dto);
	
	// InsertRoom3. 6.예약가능날짜 입력
	public int insertBookableDate(BookableDateDTO dto);
	
	// InsertRoom3. 7.숙소 이미지 입력
	public int insertRoomImage(RoomImageDTO dto);
}