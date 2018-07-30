package com.gaja.member;

import org.apache.ibatis.annotations.Param;

import com.gaja.dto.MemberDTO;

public interface IMemberDAO
{
	/* 회원가입 */
	
	// 등록된 전화번호인지 확인
	public int checkValidTel(String memTel);
	
	// 등록된 아이디인지 확인
	public int checkValidId(String memId);
	
	// 등록된 번호로 아이디 확인
	public String findId(String memTel);
	
	// 아이디와 전화번호가 서로 맞는 것인지 확인
	public int matchIdTel(MemberDTO dto);
	
	// 회원 가입1 - 회원코드 추가
	public int addMemCode();
	
	// 회원 가입2 - 회원 생성
	public int addMember(MemberDTO member);	
	
	
	/* 로그인 */
    
	// 로그인 유효성 검사 (영구정지: -1는 보류, 정보존재: 1, 없음: 0)
	public int loginCheck(MemberDTO dto);

	// 회원코드, 회원이름 추출
	public MemberDTO login(MemberDTO dto);

	// 비밀번호 확인
	public int getMemberPw(@Param("memCode") int memCode, @Param("memPw") String memPw);

	// 아이디 중복 확인
	public int checkDuplicate(String memId);
	
	
	/* 회원정보수정 */
	
	// 내 정보 수정 시 비밀번호 확인(회원아이디 사용)
	public int checkLoginPw(@Param("memId")String memId, @Param("memPw") String memPw);
	
	// 회원 정보조회
	public MemberDTO memInfo(int memCode);
	
	// 회원 정보수정 - 비밀번호, 전화번호, 메일수정
	public int memModify(MemberDTO member);
	
	// 회원 비밀번호 수정
	public int passwordChange(@Param("memId") String memId, @Param("memPw") String memPw);
	
	
	/* 회원탈퇴 */
	
	// 회원코드를 통해 등록한 숙소가 존재하는지 여부 확인(탈퇴시 확인)
    public int roomCount(int memCode);
	
    // 진행중인 예약내역이 있는지 확인
    public int bookingCheck(int memCode);
	
	// 회원 탈퇴 
	public int leaveMember(int memCode);
	
}