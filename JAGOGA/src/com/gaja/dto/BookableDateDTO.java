package com.gaja.dto;

public class BookableDateDTO
{
	private int baDateCode, rcode;
	private String startDate, endDate;
	
	
	public int getBaDateCode()
	{
		return baDateCode;
	}
	public void setBaDateCode(int baDateCode)
	{
		this.baDateCode = baDateCode;
	}
	public int getRcode()
	{
		return rcode;
	}
	public void setRcode(int rcode)
	{
		this.rcode = rcode;
	}
	public String getStartDate()
	{
		return startDate;
	}
	public void setStartDate(String startDate)
	{
		this.startDate = startDate;
	}
	public String getEndDate()
	{
		return endDate;
	}
	public void setEndDate(String endDate)
	{
		this.endDate = endDate;
	}
	
	
}
