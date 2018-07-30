package com.gaja.dto;

public class HideRoomQuestionDTO
{
	private int hideRqstCode, rqstCode, adminCode;
	private String hideDate, hideCause;
	
	
	public int getHideRqstCode()
	{
		return hideRqstCode;
	}
	public void setHideRqstCode(int hideRqstCode)
	{
		this.hideRqstCode = hideRqstCode;
	}
	public int getRqstCode()
	{
		return rqstCode;
	}
	public void setRqstCode(int rqstCode)
	{
		this.rqstCode = rqstCode;
	}
	public int getAdminCode()
	{
		return adminCode;
	}
	public void setAdminCode(int adminCode)
	{
		this.adminCode = adminCode;
	}
	public String getHideDate()
	{
		return hideDate;
	}
	public void setHideDate(String hideDate)
	{
		this.hideDate = hideDate;
	}
	public String getHideCause()
	{
		return hideCause;
	}
	public void setHideCause(String hideCause)
	{
		this.hideCause = hideCause;
	}
	
	
}
