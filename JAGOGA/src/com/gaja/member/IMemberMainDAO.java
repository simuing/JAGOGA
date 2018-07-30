package com.gaja.member;

import java.util.ArrayList;

import com.gaja.dto.VsearchRoomDTO;

public interface IMemberMainDAO
{
	// 인기방 리스트 출력
	public ArrayList<VsearchRoomDTO> bestRoomList();
	
	// 비회원 → 가장 많은 연령대 추출
	public int mostAge();
	
	// 회원 → 로그인된 회원 연령대 구하기
	public int getMemberAge(String memCode);
	
	// 연령대별 추천 리스트 출력
	public ArrayList<VsearchRoomDTO> ageRoomList(int age);
	
	// 인기키워드 추천 리스트 출력
	public ArrayList<String> bestKeywordList();
	
}