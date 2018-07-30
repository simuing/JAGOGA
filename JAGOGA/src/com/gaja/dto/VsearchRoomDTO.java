package com.gaja.dto;

public class VsearchRoomDTO
{
	// 주요 변수 선언
	private int rcode, adultFee, avgPoint;
	private String rname, rimg;
	
	// getter / setter 구성
	public int getRcode()
	{
		return rcode;
	}
	public void setRcode(int rcode)
	{
		this.rcode = rcode;
	}
	public int getAdultFee()
	{
		return adultFee;
	}
	public void setAdultFee(int adultFee)
	{
		this.adultFee = adultFee;
	}
	public int getAvgPoint()
	{
		return avgPoint;
	}
	public void setAvgPoint(int avgPoint)
	{
		this.avgPoint = avgPoint;
	}
	public String getRname()
	{
		return rname;
	}
	public void setRname(String rname)
	{
		this.rname = rname;
	}
	public String getRimg()
	{
		return rimg;
	}
	public void setRimg(String rimg)
	{
		this.rimg = rimg;
	}
	
}