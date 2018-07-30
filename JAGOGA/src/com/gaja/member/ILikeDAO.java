package com.gaja.member;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.gaja.dto.LikeDTO;

public interface ILikeDAO
{
	// 찜 목록 조회
	public ArrayList<LikeDTO> likeList(int memCode);
	
	// 찜 하기
	public int addLike(@Param("memCode") int memCode, @Param("rcode") int rcode);
	
	// 찜 삭제
	public int deleteLike(int likeCode);
}
