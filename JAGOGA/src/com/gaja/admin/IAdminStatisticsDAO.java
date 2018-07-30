package com.gaja.admin;

import java.util.ArrayList;

import com.gaja.dto.VstatisticsDTO;

public interface IAdminStatisticsDAO
{
	// 전날 새로운 회원가입 수
	public int newMemberCount();
	
	// 전날 새로운 호스팅 수
	public int newRoomCount();
	
	// 전날 매출 (수수료 총액)
	public int yesterdaySales();
	
	// 전월 대비 매출 추이
	public int salesRate();
	
	// 매출추이 조회(최근 세달)
	public VstatisticsDTO recentSales();
	
	// 이번달 매출액
	public int thisMonthSales();
	
	// 연령대별 회원 수 
	public int[] ageGroupCount();
	
	// 에티켓등급별 회원 수
	public VstatisticsDTO etqMemCount();
	
	// 지역별 매출 통계
	public ArrayList<VstatisticsDTO> regionSales();
	
	// 면적별 매출 통계
	public ArrayList<VstatisticsDTO> areaSales();
	
	// 사용자별 회원 통계
	public VstatisticsDTO memCateCount();
	
	// 회원 성별 통계
	public VstatisticsDTO memGenderCount();
	
	// 인기 검색어 통계
	public ArrayList<VstatisticsDTO> searchWord();
	
}
