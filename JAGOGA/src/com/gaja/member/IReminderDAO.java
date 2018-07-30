package com.gaja.member;

import java.util.ArrayList;

import com.gaja.dto.ReminderDTO;

public interface IReminderDAO
{
	// 알림 리스트 조회 - 알람 기간, 내용출력
	public ArrayList<ReminderDTO> reminderList(int memCode);
	
	// 예약 취소 알림 출력
	public ReminderDTO cancelreminderList(int memCode);
	
	// 알람 삭제
	public int deleteReminder(int memCode);

	// 예약 취소 알림 삭제
	public int cancelReserve(int memCode);

}
