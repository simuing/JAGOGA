package com.gaja.dto;

// 고객센터 VO
public class VquestionDTO
{
	private int qstCode, qstcCode, memcode, adminCode;	//고객센터문의코드, 문의분류코드, 회원코드, 관리자코드
	private String qstcContent, qstContent, qstTitle; 			//문의제목, 문의내용, 문의분류
	private String memId, qstDate, qstAttach;         			//문의작성자, 문의등록일, 문의첨부파일
	private String adminId, adminAns;                 			//관리자아이디, 관리자답변
	private String adminAnsDate, qstAnsState;         			//답변등록일, 답변상태
	
	// getter / setter 구성
	public int getAdminCode()
	{
		return adminCode;
	}
	public void setAdminCode(int adminCode)
	{
		this.adminCode = adminCode;
	}
	public int getQstCode()
	{
		return qstCode;
	}
	public void setQstCode(int qstCode)
	{
		this.qstCode = qstCode;
	}
	public String getQstcContent()
	{
		return qstcContent;
	}
	public int getQstcCode()
	{
		return qstcCode;
	}
	public void setQstcCode(int qstcCode)
	{
		this.qstcCode = qstcCode;
	}
	public int getMemcode()
	{
		return memcode;
	}
	public void setMemcode(int memcode)
	{
		this.memcode = memcode;
	}
	public void setQstcContent(String qstcContent)
	{
		this.qstcContent = qstcContent;
	}
	public String getQstContent()
	{
		return qstContent;
	}
	public void setQstContent(String qstContent)
	{
		this.qstContent = qstContent;
	}
	public String getQstTitle()
	{
		return qstTitle;
	}
	public void setQstTitle(String qstTitle)
	{
		this.qstTitle = qstTitle;
	}
	public String getMemId()
	{
		return memId;
	}
	public void setMemId(String memId)
	{
		this.memId = memId;
	}
	public String getQstDate()
	{
		return qstDate;
	}
	public void setQstDate(String qstDate)
	{
		this.qstDate = qstDate;
	}
	public String getQstAttach()
	{
		return qstAttach;
	}
	public void setQstAttach(String qstAttach)
	{
		this.qstAttach = qstAttach;
	}
	public String getAdminId()
	{
		return adminId;
	}
	public void setAdminId(String adminId)
	{
		this.adminId = adminId;
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
	public String getQstAnsState()
	{
		return qstAnsState;
	}
	public void setQstAnsState(String qstAnsState)
	{
		this.qstAnsState = qstAnsState;
	}
	
}