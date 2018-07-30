package com.gaja.dto;

public class VfaqDTO
{
	private int qstcCode, faqCode, adminCode;                 //문의분류코드, FAQ코드, 관리자코드
	private String qstcContent, faqTitle, faqContent, faqAns; //문의분류내용, FAQ제목, FAQ내용, FAQ답변
	private String faqRegDate, faqModifyDate;                 //문의등록일, 문의수정일
	private String adminId, adminName;               		  //관리자아이디, 관리자패스워드, 관리자이름

	 
	// getter / setter 구성
	public int getQstcCode()
	{
		return qstcCode;
	}
	public void setQstcCode(int qstcCode)
	{
		this.qstcCode = qstcCode;
	}
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
	public String getQstcContent()
	{
		return qstcContent;
	}
	public void setQstcContent(String qstcContent)
	{
		this.qstcContent = qstcContent;
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
	public String getFaqRegDate()
	{
		return faqRegDate;
	}
	public void setFaqRegDate(String faqRegDate)
	{
		this.faqRegDate = faqRegDate;
	}
	public String getFaqModifyDate()
	{
		return faqModifyDate;
	}
	public void setFaqModifyDate(String faqModifyDate)
	{
		this.faqModifyDate = faqModifyDate;
	}
	public String getAdminId()
	{
		return adminId;
	}
	public void setAdminId(String adminId)
	{
		this.adminId = adminId;
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