package com.gaja.dto;

public class HideReviewDTO
{
	private int hideRevCode, revCode, adminCode;
	private String hideDate, hideCause;
	
	
	public int getHideRevCode()
	{
		return hideRevCode;
	}
	public void setHideRevCode(int hideRevCode)
	{
		this.hideRevCode = hideRevCode;
	}
	public int getRevCode()
	{
		return revCode;
	}
	public void setRevCode(int revCode)
	{
		this.revCode = revCode;
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
