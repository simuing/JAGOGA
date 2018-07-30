package com.gaja.dto;

public class CancelDTO
{
	private int cancelCode, bcode;
	private String cancelDate, cancelCheck;
	
	
	public int getCancelCode()
	{
		return cancelCode;
	}
	public void setCancelCode(int cancelCode)
	{
		this.cancelCode = cancelCode;
	}
	public int getBcode()
	{
		return bcode;
	}
	public void setBcode(int bcode)
	{
		this.bcode = bcode;
	}
	public String getCancelDate()
	{
		return cancelDate;
	}
	public void setCancelDate(String cancelDate)
	{
		this.cancelDate = cancelDate;
	}
	public String getCancelCheck()
	{
		return cancelCheck;
	}
	public void setCancelCheck(String cancelCheck)
	{
		this.cancelCheck = cancelCheck;
	}
	
	
}
