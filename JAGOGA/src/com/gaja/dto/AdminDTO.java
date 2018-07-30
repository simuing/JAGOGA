package com.gaja.dto;

public class AdminDTO
{
	private int adminCode;
	private String adminId, adminPw, adminName;
	
	
	public int getAdminCode()
	{
		return adminCode;
	}
	public void setAdminCode(int adminCode)
	{
		this.adminCode = adminCode;
	}
	public String getAdminId()
	{
		return adminId;
	}
	public void setAdminId(String adminId)
	{
		this.adminId = adminId;
	}
	public String getAdminPw()
	{
		return adminPw;
	}
	public void setAdminPw(String adminPw)
	{
		this.adminPw = adminPw;
	}
	public String getAdminName()
	{
		return adminName;
	}
	public void setAdminName(String adminName)
	{
		this.adminName = adminName;
	}
	
	
}
