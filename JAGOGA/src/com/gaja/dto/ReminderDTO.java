package com.gaja.dto;

public class ReminderDTO
{
	private int remCode, memCode, adminCode;
	private String remContent, remDate;
	
	
	public int getRemCode()
	{
		return remCode;
	}
	public void setRemCode(int remCode)
	{
		this.remCode = remCode;
	}
	public int getMemCode()
	{
		return memCode;
	}
	public void setMemCode(int memCode)
	{
		this.memCode = memCode;
	}
	public int getAdminCode()
	{
		return adminCode;
	}
	public void setAdminCode(int adminCode)
	{
		this.adminCode = adminCode;
	}
	public String getRemContent()
	{
		return remContent;
	}
	public void setRemContent(String remContent)
	{
		this.remContent = remContent;
	}
	public String getRemDate()
	{
		return remDate;
	}
	public void setRemDate(String remDate)
	{
		this.remDate = remDate;
	}
	
	
}
