package com.gaja.dto;

public class BlockListDTO
{
	private int blistCode, memCode, adminCode;
	private String blockDate, blockCause;
	
	
	public int getBlistCode()
	{
		return blistCode;
	}
	public void setBlistCode(int blistCode)
	{
		this.blistCode = blistCode;
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
	public String getBlockDate()
	{
		return blockDate;
	}
	public void setBlockDate(String blockDate)
	{
		this.blockDate = blockDate;
	}
	public String getBlockCause()
	{
		return blockCause;
	}
	public void setBlockCause(String blockCause)
	{
		this.blockCause = blockCause;
	}
	
	
	
}
