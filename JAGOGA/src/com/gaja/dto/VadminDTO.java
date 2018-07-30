package com.gaja.dto;

public class VadminDTO
{
	// 관리자 계정 목록 조회 view
	private int adminCode, atCode;
	private String adminName, adminId, adminPw, atNames, atCodes;
	
	// getter / setter 구성
	
	public int getAtCode()
	{
		return atCode;
	}
	public void setAtCode(int atCode)
	{
		this.atCode = atCode;
	}
	public int getAdminCode()
	{
		return adminCode;
	}
	public void setAdminCode(int adminCode)
	{
		this.adminCode = adminCode;
	}
	public String getAdminName()
	{
		return adminName;
	}
	public void setAdminName(String adminName)
	{
		this.adminName = adminName;
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
	public String getAtNames()
	{
		return atNames;
	}
	public void setAtNames(String atNames)
	{
		this.atNames = atNames;
	}
	public String getAtCodes()
	{
		return atCodes;
	}
	public void setAtCodes(String atCodes)
	{
		this.atCodes = atCodes;
	}
	

	
	

	
	
	
}
