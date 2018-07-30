package com.gaja.dto;

public class CancelReminderDTO
{
	private int cremCode, cancelCode;
	private String cremContent, cremDate;
	
	
	public int getCremCode()
	{
		return cremCode;
	}
	public void setCremCode(int cremCode)
	{
		this.cremCode = cremCode;
	}
	public int getCancelCode()
	{
		return cancelCode;
	}
	public void setCancelCode(int cancelCode)
	{
		this.cancelCode = cancelCode;
	}
	public String getCremContent()
	{
		return cremContent;
	}
	public void setCremContent(String cremContent)
	{
		this.cremContent = cremContent;
	}
	public String getCremDate()
	{
		return cremDate;
	}
	public void setCremDate(String cremDate)
	{
		this.cremDate = cremDate;
	}
	
	
}
