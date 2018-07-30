package com.gaja.member;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.gaja.dto.VsearchRoomDTO;

public interface ISearchRoomDAO
{
   // 키워드 검색 리스트 출력
   public ArrayList<VsearchRoomDTO> searchRoomList(@Param("word") String word, @Param("pageNumber") int pageNumber);
   
   // 키워드 테이블에 INSERT
   public int insertWord(String word);
}