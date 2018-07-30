package com.gaja.member;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.gaja.dto.BookableDateDTO;
import com.gaja.dto.ConstraintDTO;
import com.gaja.dto.ConvenienceDTO;
import com.gaja.dto.RoomConstraintDTO;
import com.gaja.dto.RoomConvenienceDTO;
import com.gaja.dto.RoomImageDTO;

public interface IUpdateRoomDAO
{
   // InsertRoom3. 2. 선택된 편의시설 조회
   public ConvenienceDTO pickConv(int convCode);
   
   // InsertRoom3. 3. 선택된 제한사항 조회
   public ConstraintDTO pickCons(int consCode);
   
   
   // InsertRoom3. 2.방금입력된 숙소코드 가져오기
   public int getRoomCode(@Param("memCode") int memCode);
   
   // InsertRoom3. 3.숙소 제목, 내용, 요금, 최대최소 인원수 수정
   public int updateRoom(@Param("rname") String rname, @Param("rcontent") String rcontent, @Param("adultFee") int adultFee
         , @Param("childFee") int childFee, @Param("maxHumanCount") int maxHumanCount, @Param("minHumanCount") int minHumanCount
         , @Param("rcode") int rcode);
   
   // InsertRoom3. 4.숙소 편의사항 입력
   public int insertRoomConv(RoomConvenienceDTO dto);
   
   // InsertRoom3. 5.숙소 제한사항 입력
   public int insertRoomCons(RoomConstraintDTO dto);
   
   // InsertRoom3. 6.예약가능날짜 입력
   public int insertBookableDate(BookableDateDTO dto);
   
   // InsertRoom3. 7.숙소 이미지 입력
   public int insertRoomImage(RoomImageDTO dto);


   // InsertRoom3. 4.숙소 편의사항 삭제
   public int deleteRoomConv(int rcode);
   
   // InsertRoom3. 5.숙소 제한사항 삭제
   public int deleteRoomCons(int rcode);
   
   // InsertRoom3. 6.예약가능날짜 삭제
   public int deleteBookableDate(int rcode);
   
   // InsertRoom3. 7.숙소 이미지 삭제
   public int deleteRoomImage(int rcode);

   
}