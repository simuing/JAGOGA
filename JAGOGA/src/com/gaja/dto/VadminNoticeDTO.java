package com.gaja.dto;

public class VadminNoticeDTO
{
	// 관리자 공지와 고객 공지 동시에 사용하는 dto
	
	private String gcContent, gtitle, gcontent, gregDate, gmodifyDate, adminId, adminName;
	private String ntHideCheck, ntCode;
	private int gcode, gcCode, adminCode, ntHitCount;
	
	// 정책 및 이용약관 , 개인정보 취급방침
	private String termsTitle, termsContent, termsRegDate;
	private int termsCode;
	
	// 고객 부분
	private String ntTitle, ntRegDate, ntContent, ntAttach;
	
	
	// getter , setter
	public String getGcContent()
	{
		return gcContent;
	}
	public String getTermsTitle()
	{
		return termsTitle;
	}
	public void setTermsTitle(String termsTitle)
	{
		this.termsTitle = termsTitle;
	}
	public String getTermsContent()
	{
		return termsContent;
	}
	public void setTermsContent(String termsContent)
	{
		this.termsContent = termsContent;
	}
	public String getTermsRegDate()
	{
		return termsRegDate;
	}
	public void setTermsRegDate(String termsRegDate)
	{
		this.termsRegDate = termsRegDate;
	}
	public int getTermsCode()
	{
		return termsCode;
	}
	public void setTermsCode(int termsCode)
	{
		this.termsCode = termsCode;
	}
	public int getAdminCode()
	{
		return adminCode;
	}
	public String getNtCode()
	{
		return ntCode;
	}
	public void setNtCode(String ntCode)
	{
		this.ntCode = ntCode;
	}
	public String getNtTitle()
	{
		return ntTitle;
	}
	public void setNtTitle(String ntTitle)
	{
		this.ntTitle = ntTitle;
	}
	public String getNtRegDate()
	{
		return ntRegDate;
	}
	public void setNtregDate(String ntRegDate)
	{
		this.ntRegDate = ntRegDate;
	}
	public int getNtHitCount()
	{
		return ntHitCount;
	}
	public void setNtHitCount(int ntHitCount)
	{
		this.ntHitCount = ntHitCount;
	}
	public void setAdminCode(int adminCode)
	{
		this.adminCode = adminCode;
	}
	public void setGcContent(String gcContent)
	{
		this.gcContent = gcContent;
	}
	public String getGtitle()
	{
		return gtitle;
	}
	public void setGtitle(String gtitle)
	{
		this.gtitle = gtitle;
	}
	public String getGcontent()
	{
		return gcontent;
	}
	public void setGcontent(String gcontent)
	{
		this.gcontent = gcontent;
	}
	public String getGregDate()
	{
		return gregDate;
	}
	public void setGregDate(String gregDate)
	{
		this.gregDate = gregDate;
	}
	public String getGmodifyDate()
	{
		return gmodifyDate;
	}
	public void setGmodifyDate(String gmodifyDate)
	{
		this.gmodifyDate = gmodifyDate;
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
	public String getNtHideCheck()
	{
		return ntHideCheck;
	}
	public void setNtHideCheck(String ntHideCheck)
	{
		this.ntHideCheck = ntHideCheck;
	}
	public int getGcode()
	{
		return gcode;
	}
	public void setGcode(int gcode)
	{
		this.gcode = gcode;
	}
	public int getGcCode()
	{
		return gcCode;
	}
	public void setGcCode(int gcCode)
	{
		this.gcCode = gcCode;
	}
	public String getNtContent()
	{
		return ntContent;
	}
	public void setNtContent(String ntContent)
	{
		this.ntContent = ntContent;
	}
	public String getNtAttach()
	{
		return ntAttach;
	}
	public void setNtAttach(String ntAttach)
	{
		this.ntAttach = ntAttach;
	}
	public void setNtRegDate(String ntRegDate)
	{
		this.ntRegDate = ntRegDate;
	}
	
	
}