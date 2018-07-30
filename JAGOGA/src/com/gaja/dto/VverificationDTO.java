package com.gaja.dto;

// 회원-검증내역, 관리자-검증관리 페이지에 필요한 VO 정의
public class VverificationDTO
{
	// 『회원 - 검증내역 페이지』 페이지에 필요한 변수 선언 및 초기화
	// 숙소이름, 숙소등록일, 검증요청일, 처리완료일, 검증만료일, 검증상태, 검증후등급, 검증사유, 검증만료일
	// ※ 검증만료일은 처리완료일에서 + 1년
	private String rname, rregDate, rreqDate, processingDate, vsContent, vafterGrade, vcause, effectiveDate;
	
	
	// 『관리자 - 검증관리』 페이지에 필요한 변수 선언 및 초기화
	// 호스트아이디, 숙소번호, 검증번호, 관리자이름, 숙소유형
	// ※ 숙소이름, 검증등급, 상태, 검증만료일은 회원페이지도 쓰이기 때문에 위에서 선언
	private String memId, adminId, rtype, reqvDate;
	private int rcode, reqvCode, memCode, vcode, adminCode, vsCode, rownum;
	
	
	
	// getter / setter 구성
	
	public String getRname()
	{
		return rname;
	}
	public String getReqvDate()
	{
		return reqvDate;
	}
	public void setReqvDate(String reqvDate)
	{
		this.reqvDate = reqvDate;
	}
	public String getRtype()
	{
		return rtype;
	}
	public void setRtype(String rtype)
	{
		this.rtype = rtype;
	}
	public int getRownum()
	{
		return rownum;
	}
	public void setRownum(int rownum)
	{
		this.rownum = rownum;
	}
	public void setMemCode(int memCode)
	{
		this.memCode = memCode;
	}
	public void setRname(String rname)
	{
		this.rname = rname;
	}
	public String getRregDate()
	{
		return rregDate;
	}
	public void setRregDate(String rregDate)
	{
		this.rregDate = rregDate;
	}
	public String getRreqDate()
	{
		return rreqDate;
	}
	public void setRreqDate(String rreqDate)
	{
		this.rreqDate = rreqDate;
	}
	public String getEffectiveDate()
	{
		return effectiveDate;
	}
	public void setEffectiveDate(String effectiveDate)
	{
		this.effectiveDate = effectiveDate;
	}
	public String getVsContent()
	{
		return vsContent;
	}
	public void setVsContent(String vsContent)
	{
		this.vsContent = vsContent;
	}
	public String getVafterGrade()
	{
		return vafterGrade;
	}
	public void setVafterGrade(String vafterGrade)
	{
		this.vafterGrade = vafterGrade;
	}
	public String getVcause()
	{
		return vcause;
	}
	public void setVcause(String vcause)
	{
		this.vcause = vcause;
	}
	public String getMemId()
	{
		return memId;
	}
	public void setMemId(String memId)
	{
		this.memId = memId;
	}
	public String getAdminId()
	{
		return adminId;
	}
	public void setAdminId(String adminId)
	{
		this.adminId = adminId;
	}
	public int getRcode()
	{
		return rcode;
	}
	public void setRcode(int rcode)
	{
		this.rcode = rcode;
	}
	public int getReqvCode()
	{
		return reqvCode;
	}
	public void setReqvCode(int reqvCode)
	{
		this.reqvCode = reqvCode;
	}
	public int getMemCode()
	{
		return memCode;
	}
	public void setMemcode(int memCode)
	{
		this.memCode = memCode;
	}
	public String getProcessingDate()
	{
		return processingDate;
	}
	public void setProcessingDate(String processingDate)
	{
		this.processingDate = processingDate;
	}
	public int getVcode()
	{
		return vcode;
	}
	public void setVcode(int vcode)
	{
		this.vcode = vcode;
	}
	public int getAdminCode()
	{
		return adminCode;
	}
	public void setAdminCode(int adminCode)
	{
		this.adminCode = adminCode;
	}
	public int getVsCode()
	{
		return vsCode;
	}
	public void setVsCode(int vsCode)
	{
		this.vsCode = vsCode;
	}
	
	
}
