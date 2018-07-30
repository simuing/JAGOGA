package com.gaja.dto;

public class FaqDTO
{
	private int faqCode, adminCode, qstcCode;
	private String faqTitle, faqContent, faqAns, faqRegdate, faqModifyDate;
	
	
	public int getFaqCode()
	{
		return faqCode;
	}
	public void setFaqCode(int faqCode)
	{
		this.faqCode = faqCode;
	}
	public int getAdminCode()
	{
		return adminCode;
	}
	public void setAdminCode(int adminCode)
	{
		this.adminCode = adminCode;
	}
	public int getQstcCode()
	{
		return qstcCode;
	}
	public void setQstcCode(int qstcCode)
	{
		this.qstcCode = qstcCode;
	}
	public String getFaqTitle()
	{
		return faqTitle;
	}
	public void setFaqTitle(String faqTitle)
	{
		this.faqTitle = faqTitle;
	}
	public String getFaqContent()
	{
		return faqContent;
	}
	public void setFaqContent(String faqContent)
	{
		this.faqContent = faqContent;
	}
	public String getFaqAns()
	{
		return faqAns;
	}
	public void setFaqAns(String faqAns)
	{
		this.faqAns = faqAns;
	}
	public String getFaqRegdate()
	{
		return faqRegdate;
	}
	public void setFaqRegdate(String faqRegdate)
	{
		this.faqRegdate = faqRegdate;
	}
	public String getFaqModifyDate()
	{
		return faqModifyDate;
	}
	public void setFaqModifyDate(String faqModifyDate)
	{
		this.faqModifyDate = faqModifyDate;
	}
	
	
}
