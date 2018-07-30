package com.gaja.member;

import java.util.ArrayList;

import com.gaja.dto.VnoticeDTO;

public interface INoticeDAO
{
   
   // -- 회원 공지 리스트 보기
   public ArrayList<VnoticeDTO> noticeList(int pageNumber);
   
   // -- 회원 공지 검색 리스트 보기
   public ArrayList<VnoticeDTO> searchNotice(String search);
   
   // -- 회원 공지클릭시 내용과 같이보기
   public VnoticeDTO detailNotice(int ntCode);
   
   // -- 카운트수 증가
   public int upCount(int ntCode);
   
   // -- 이용가이드
   public ArrayList<VnoticeDTO> useGuide();
   
   // -- 정책 및 이용약관
   public VnoticeDTO terms();
      
   // -- 개인정보 취급 방침
   public VnoticeDTO termsPrivateInfo();
      
}