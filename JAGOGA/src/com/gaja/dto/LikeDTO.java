package com.gaja.dto;

public class LikeDTO
{
	private int likeCode, memCode, rcode, adultFee;
	private String likeDate, addr, rname, rtype;
	
	// getter / setter 구성
	public int getLikeCode()
	{
		return likeCode;
	}
	public void setLikeCode(int likeCode)
	{
		this.likeCode = likeCode;
	}
	public int getMemCode()
	{
		return memCode;
	}
	public void setMemCode(int memCode)
	{
		this.memCode = memCode;
	}
	public int getRcode()
	{
		return rcode;
	}
	public void setRcode(int rcode)
	{
		this.rcode = rcode;
	}
	public String getLikeDate()
	{
		return likeDate;
	}
	public void setLikeDate(String likeDate)
	{
		this.likeDate = likeDate;
	}
	public String getAddr()
	{
		return addr;
	}
	public void setAddr(String addr)
	{
		this.addr = addr;
	}
	public int getAdultFee()
	{
		return adultFee;
	}
	public void setAdultFee(int adultFee)
	{
		this.adultFee = adultFee;
	}
	public String getRname()
	{
		return rname;
	}
	public void setRname(String rname)
	{
		this.rname = rname;
	}
	public String getRtype()
	{
		return rtype;
	}
	public void setRtype(String rtype)
	{
		this.rtype = rtype;
	}
	
}
