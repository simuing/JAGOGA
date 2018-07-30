package com.gaja.dto;

public class QuestionAnswerDTO
{
	private int qstAnsCode, qstCode, adminCode;
	private String adminAns, adminAnsDate;
	
	
	public int getQstAnsCode()
	{
		return qstAnsCode;
	}
	public void setQstAnsCode(int qstAnsCode)
	{
		this.qstAnsCode = qstAnsCode;
	}
	public int getQstCode()
	{
		return qstCode;
	}
	public void setQstCode(int qstCode)
	{
		this.qstCode = qstCode;
	}
	public int getAdminCode()
	{
		return adminCode;
	}
	public void setAdminCode(int adminCode)
	{
		this.adminCode = adminCode;
	}
	public String getAdminAns()
	{
		return adminAns;
	}
	public void setAdminAns(String adminAns)
	{
		this.adminAns = adminAns;
	}
	public String getAdminAnsDate()
	{
		return adminAnsDate;
	}
	public void setAdminAnsDate(String adminAnsDate)
	{
		this.adminAnsDate = adminAnsDate;
	}
	
	
}
