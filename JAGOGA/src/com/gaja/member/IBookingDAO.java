package com.gaja.member;

import com.gaja.dto.BookingDTO;

public interface IBookingDAO
{
	// booking1 - 예약, 결제 정책 및 이용약관 내용가져오기
	public String bookingTerm();
	
	// booking2 - 예약하기
	public int insertBooking(BookingDTO dto);
	
	// booking3 - 예약코드로 숙소이름 가져오기
	public String getRname(int rcode);
	
	// booking3 - 예약코드로 숙소주소 가져오기
	public String getRbasicAddr(int rcode);
	public String getRdetailAddr(int rcode);
}