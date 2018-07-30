package com.gaja.dto;

public class VerificationResultDTO
{
	private int vrCode, vcode, vsCode;
	private String vafterGrade, processingDate, vcause;
	
	
	public int getVrCode()
	{
		return vrCode;
	}
	public void setVrCode(int vrCode)
	{
		this.vrCode = vrCode;
	}
	public int getVcode()
	{
		return vcode;
	}
	public void setVcode(int vcode)
	{
		this.vcode = vcode;
	}
	public int getVsCode()
	{
		return vsCode;
	}
	public void setVsCode(int vsCode)
	{
		this.vsCode = vsCode;
	}
	public String getVafterGrade()
	{
		return vafterGrade;
	}
	public void setVafterGrade(String vafterGrade)
	{
		this.vafterGrade = vafterGrade;
	}
	public String getProcessingDate()
	{
		return processingDate;
	}
	public void setProcessingDate(String processingDate)
	{
		this.processingDate = processingDate;
	}
	public String getVcause()
	{
		return vcause;
	}
	public void setVcause(String vcause)
	{
		this.vcause = vcause;
	}
	
}
