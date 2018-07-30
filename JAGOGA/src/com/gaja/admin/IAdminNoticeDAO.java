package com.gaja.admin;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.gaja.dto.GuideDTO;
import com.gaja.dto.VadminNoticeDTO;

public interface IAdminNoticeDAO
{
	// 공지 전체목록 조회
	public ArrayList<VadminNoticeDTO> adminNoticeList(@Param("pageNumber") int pageNumber);
	
	// 공지 제목으로 검색조회
	public ArrayList<VadminNoticeDTO> adminTitleNoticeList(String gTitle);
	
	// 공지 작성자아이디로 검색조회
	public ArrayList<VadminNoticeDTO> adminIdNoticeList(String adminId);

	// 공지 숨김여부 확인  -- 관리자(?)
	//public ArrayList<NoticeDTO> adminHideNotice();
	
	// 공지 숨김상태 변경  -- 관리자
	public int adminHideChange(@Param("ntHideCheck")String ntHideCheck, @Param("ntCode")int ntCode);
	
	// 이용가이드 조회
	public ArrayList<GuideDTO> adminGuide();
	
	// 공지 등록
	public int noticeInsert(VadminNoticeDTO dto);
	
	// 특정 공지 조회
	public VadminNoticeDTO noticeInfo(int ntCode);
	
	// 공지 수정
	public int noticeUpdate(VadminNoticeDTO dto);

}
