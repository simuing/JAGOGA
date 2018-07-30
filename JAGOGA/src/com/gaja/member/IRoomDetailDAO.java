package com.gaja.member;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.gaja.dto.BookableDateDTO;
import com.gaja.dto.MyRoomDTO;
import com.gaja.dto.ReviewDTO;
import com.gaja.dto.RoomQuestionDTO;
import com.gaja.dto.RqstAnswerDTO;

public interface IRoomDetailDAO
{
	// 숙소 제목, 설명, 주소, 평점, 호스트사진, 요금 
	public MyRoomDTO roomInfo(int rcode);
	// 숙소 편의시설 
	public ArrayList<MyRoomDTO> roomConvenience(int rcode);
	// 숙소 제한사항 
	public ArrayList<MyRoomDTO> roomConstraint(int rcode);
	// 숙소사진 
	public ArrayList<String> roomImg(int rcode);
	// 숙소 예약가능날짜 조회 
	public ArrayList<BookableDateDTO> bookableDateList(int rcode);
	// 숙소 예약불가능날짜 조회
	public ArrayList<BookableDateDTO> unableDateList(int rcode);
	
	
	/* 숙소평점 */
	// 평점 부여 가능횟수 체크 
	public int pointCount(@Param("rcode")int rcode, @Param("memCode")int memCode);
	// 평점을 부여할 이용내역코드 추출
	public int getPointUlistCode(@Param("rcode") int rcode, @Param("memCode") int memCode);
	// 평점 주기 
	public int insertPoint(@Param("ulistCode")int ulistCode, @Param("point")int point);
	
	
	/* 숙소후기 */
	// 후기 목록 조회 
	public ArrayList<MyRoomDTO> roomReview(int rcode);
	// 후기 사진 조회 
	public ArrayList<MyRoomDTO> reviewImage(@Param("rcode")int rcode, @Param("revCode")int revCode);
	// Ajax. 해당 회원이 후기를 쓸 수 있는 횟수 조회 (한달이내는 생략함)
	public int reviewCount(@Param("rcode") int rcode, @Param("memCode") int memCode);
	// 해당 회원의 이용내역코드 중 하나를 추출 (여러개일 수 있으므로)
	public int getReviewUlistCode(@Param("rcode") int rcode, @Param("memCode") int memCode);
	// 후기 작성
	public int insertReview(ReviewDTO dto);
	// 후기답변작성 
	public int insertReviewAns(ReviewDTO dto);
	
	
	// 1. 후기 답변 삭제
	public int deleteReviewAns(int revCode);
	// 2. 후기 이미지 삭제
	public int deleteReviewImage(int revCode);
	// 3. 숨긴후기삭제
	public int deleteHideReview(int revCode);
	// 4. 후기 삭제
	public int deleteReview(int revCode);
	
	
	/* 숙소문의 */
	// 숙소문의 목록 조회  
	public ArrayList<MyRoomDTO> roomQuestion(int rcode);
	// 숙소문의 등록
	public int insertRoomQuestion(RoomQuestionDTO dto);
	// 숙소문의 답변등록
	public int insertRoomQuestionAns(RqstAnswerDTO dto);
	// 숙소문의답변 삭제
	public int deleteRoomQuestionAns(int rqstAnsCode);
	// 숙소문의 삭제
	public int deleteRoomQuestion(int rqstCode);	
	
	
	// 1. 문의 답변 삭제 
	public int delRoomQuestionAns(int rqstCode);
	// 2. 문의 삭제 
	public int delRoomQuestion(int rqstCode);
}