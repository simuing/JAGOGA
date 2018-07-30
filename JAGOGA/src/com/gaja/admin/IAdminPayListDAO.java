package com.gaja.admin;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.gaja.dto.MemberDTO;
import com.gaja.dto.VadminPayListDTO;

public interface IAdminPayListDAO
{
	// 전체 리스트 출력
	public ArrayList<VadminPayListDTO> adminPayList(@Param("pageNumber") int pageNumber);
	
	
	
	// 결제번호로 결제목록검색
	public ArrayList<VadminPayListDTO> adminPayNumBooking(int payCode);
	// 숙소번호로 결제목록검색
	public ArrayList<VadminPayListDTO> adminRoomNumBooking(int rcode);
	// 호스트아이디로 결제목록검색
	public ArrayList<VadminPayListDTO> adminHostIdBooking(String hostId);
	// 게스트아이디로 결제목록검색
	public ArrayList<VadminPayListDTO> adminGuestIdBooking(String guestId);
	
	// 예약번호로 상세내역 조회
	public VadminPayListDTO detailBooking(int bcode);

	// 결제번호와 거래상태에따른 리스트 출력
	public ArrayList<VadminPayListDTO> adminPayNumstatusBooking(@Param("payCode")int payCode, @Param("status")String status);
	// 숙소번호와 거래상태에따른 리스트 출력
	public ArrayList<VadminPayListDTO> adminRoomNumstatusBooking(@Param("roomCode")int roomCode, @Param("status")String status); 
	// 호스트아이디와 거래상태에따른 리스트 출력
	public ArrayList<VadminPayListDTO> adminHostIdstatusBooking(@Param("hostId")String hostId, @Param("status")String status);
	// 게스트아이디와 거래상태에따른 리스트 출력
	public ArrayList<VadminPayListDTO> adminGuestIdstatusBooking(@Param("GuestId")String GuestId, @Param("status")String status);
	
	// 거래상태에따른 리스트 출력
	public ArrayList<VadminPayListDTO> statusBooking(String status);

	// 해당숙소 전체 예약내역 조회
	public ArrayList<VadminPayListDTO> adminBookingList(int rCode);

	// 회원 정보조회
	public ArrayList<MemberDTO> memberList(int memCode);
	
	// 관리자 취소 신청
	public int requestCancel(int bcode);
	
	// 관리자 취소 완료
	public int adminCancel(@Param("cancelCode") int cancelCode,@Param("adminCode") int adminCode,@Param("cancelCause") String cancelCause);
	
	// 환불내역
	public int refundList(@Param("cancelCode") int cancelCode, @Param("refund") int refund);
	
	// 취소코드 조회
	public int getCancelCode(int bcode);
	
}
