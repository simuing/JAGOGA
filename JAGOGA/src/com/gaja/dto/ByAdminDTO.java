package com.gaja.dto;

public class ByAdminDTO
{
	private int byAdminCode, cancelCode, adminCode;
	private String cancelCause;
	
	
	public int getByAdminCode()
	{
		return byAdminCode;
	}
	public void setByAdminCode(int byAdminCode)
	{
		this.byAdminCode = byAdminCode;
	}
	public int getCancelCode()
	{
		return cancelCode;
	}
	public void setCancelCode(int cancelCode)
	{
		this.cancelCode = cancelCode;
	}
	public int getAdminCode()
	{
		return adminCode;
	}
	public void setAdminCode(int adminCode)
	{
		this.adminCode = adminCode;
	}
	public String getCancelCause()
	{
		return cancelCause;
	}
	public void setCancelCause(String cancelCause)
	{
		this.cancelCause = cancelCause;
	}
	
	
}
