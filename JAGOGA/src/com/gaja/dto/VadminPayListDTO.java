package com.gaja.dto;

public class VadminPayListDTO
{
	//BCODE 예약(결제)코드, RNAME 숙소이름, 결제일 BDATE, 호스트아이디 hostId
	//게스트아이디 guestId, 거래상태 status
	// 숙소번호 rcode, 예약날짜 bookingDate, 숙박시작일 checkinDate, 숙박종료일 checkoutDate, 
	// 이미지경로 imgpath
	
	private String rname, bdate, checkInDate, checkOutDate, memSsn, memTel, memEtiquette, status, hmemId, gmemId, idcard, rtype, cancelCause;
	private int bcode, rcode, hmemCode, gmemCode, adultCount, childCount, babyCount, totalFee, rarea, rfdCode, cancelCode, refund;
	
	// getter, setter
	public String getRname()
	{
		return rname;
	}
	public void setRname(String rname)
	{
		this.rname = rname;
	}
	public String getBdate()
	{
		return bdate;
	}
	public void setBdate(String bdate)
	{
		this.bdate = bdate;
	}
	public String getCheckInDate()
	{
		return checkInDate;
	}
	public void setCheckInDate(String checkInDate)
	{
		this.checkInDate = checkInDate;
	}
	public String getCheckOutDate()
	{
		return checkOutDate;
	}
	public void setCheckOutDate(String checkOutDate)
	{
		this.checkOutDate = checkOutDate;
	}
	public String getMemSsn()
	{
		return memSsn;
	}
	public void setMemSsn(String memSsn)
	{
		this.memSsn = memSsn;
	}
	public String getMemTel()
	{
		return memTel;
	}
	public void setMemTel(String memTel)
	{
		this.memTel = memTel;
	}
	public String getMemEtiquette()
	{
		return memEtiquette;
	}
	public void setMemEtiquette(String memEtiquette)
	{
		this.memEtiquette = memEtiquette;
	}
	public int getBcode()
	{
		return bcode;
	}
	public void setBcode(int bcode)
	{
		this.bcode = bcode;
	}
	public int getRcode()
	{
		return rcode;
	}
	public void setRcode(int rcode)
	{
		this.rcode = rcode;
	}
	public int getHmemCode()
	{
		return hmemCode;
	}
	public void setHmemCode(int hmemCode)
	{
		this.hmemCode = hmemCode;
	}
	public int getGmemCode()
	{
		return gmemCode;
	}
	public void setGmemCode(int gmemCode)
	{
		this.gmemCode = gmemCode;
	}
	public String getStatus()
	{
		return status;
	}
	public void setStatus(String status)
	{
		this.status = status;
	}
	public String getHmemId()
	{
		return hmemId;
	}
	public void setHmemId(String hmemId)
	{
		this.hmemId = hmemId;
	}
	public String getGmemId()
	{
		return gmemId;
	}
	public void setGmemId(String gmemId)
	{
		this.gmemId = gmemId;
	}
	public String getIdcard()
	{
		return idcard;
	}
	public void setIdcard(String idcard)
	{
		this.idcard = idcard;
	}
	public int getAdultCount()
	{
		return adultCount;
	}
	public void setAdultCount(int adultCount)
	{
		this.adultCount = adultCount;
	}
	public int getChildCount()
	{
		return childCount;
	}
	public void setChildCount(int childCount)
	{
		this.childCount = childCount;
	}
	public int getBabyCount()
	{
		return babyCount;
	}
	public void setBabyCount(int babyCount)
	{
		this.babyCount = babyCount;
	}
	public int getTotalFee()
	{
		return totalFee;
	}
	public void setTotalFee(int totalFee)
	{
		this.totalFee = totalFee;
	}
	public String getRtype()
	{
		return rtype;
	}
	public void setRtype(String rtype)
	{
		this.rtype = rtype;
	}
	public int getRarea()
	{
		return rarea;
	}
	public void setRarea(int rarea)
	{
		this.rarea = rarea;
	}
	public String getCancelCause()
	{
		return cancelCause;
	}
	public void setCancelCause(String cancelCause)
	{
		this.cancelCause = cancelCause;
	}
	public int getRfdCode()
	{
		return rfdCode;
	}
	public void setRfdCode(int rfdCode)
	{
		this.rfdCode = rfdCode;
	}
	public int getCancelCode()
	{
		return cancelCode;
	}
	public void setCancelCode(int cancelCode)
	{
		this.cancelCode = cancelCode;
	}
	public int getRefund()
	{
		return refund;
	}
	public void setRefund(int refund)
	{
		this.refund = refund;
	}
	

	
}
