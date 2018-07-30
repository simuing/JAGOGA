package com.gaja.dto;

public class VmyRoomBookingDTO
{
   // 내 셰어하우스 관련 변수 선언
   //-- realCheckInDate -> 실제 체크아웃날짜  , byMemberCode - 예약취소시 누가취소하였는지 담는 컬럼
   //--ulistCode -> 이용 내역 코드
   
   private int bcode, gmemCode, bpay, refund, cancelCode, byMemberCode, ulistCode;
   private String rname, bdate, startDate, endDate,  cancelDate, cancelCheck, realCheckInDate;
   private String realCheckOutDate, adultCount, childCount, babyCount, specialNote, ulistregDate;
   private String gmemId, memEtiquette, status, checkPoints;
   
   // getter , setter

   public int getBcode()
   {
      return bcode;
   }
   public String getCheckPoints()
   {
      return checkPoints;
   }
   public void setCheckPoints(String checkPoints)
   {
      this.checkPoints = checkPoints;
   }
   public String getStatus()
   {
      return status;
   }
   public void setStatus(String status)
   {
      this.status = status;
   }
   public void setBcode(int bcode)
   {
      this.bcode = bcode;
   }
   public int getGmemCode()
   {
      return gmemCode;
   }
   public void setGmemCode(int gmemCode)
   {
      this.gmemCode = gmemCode;
   }
   public int getBpay()
   {
      return bpay;
   }
   public void setBpay(int bpay)
   {
      this.bpay = bpay;
   }
   public int getRefund()
   {
      return refund;
   }
   public void setRefund(int refund)
   {
      this.refund = refund;
   }
   public int getCancelCode()
   {
      return cancelCode;
   }
   public void setCancelCode(int cancelCode)
   {
      this.cancelCode = cancelCode;
   }
   public int getByMemberCode()
   {
      return byMemberCode;
   }
   public void setByMemberCode(int byMemberCode)
   {
      this.byMemberCode = byMemberCode;
   }
   public int getUlistCode()
   {
      return ulistCode;
   }
   public void setUlistCode(int ulistCode)
   {
      this.ulistCode = ulistCode;
   }
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
   public String getStartDate()
   {
      return startDate;
   }
   public void setStartDate(String startDate)
   {
      this.startDate = startDate;
   }
   public String getEndDate()
   {
      return endDate;
   }
   public void setEndDate(String endDate)
   {
      this.endDate = endDate;
   }
   public String getCancelDate()
   {
      return cancelDate;
   }
   public void setCancelDate(String cancelDate)
   {
      this.cancelDate = cancelDate;
   }
   public String getCancelCheck()
   {
      return cancelCheck;
   }
   public void setCancelCheck(String cancelCheck)
   {
      this.cancelCheck = cancelCheck;
   }
   public String getRealCheckInDate()
   {
      return realCheckInDate;
   }
   public void setRealCheckInDate(String realCheckInDate)
   {
      this.realCheckInDate = realCheckInDate;
   }
   public String getRealCheckOutDate()
   {
      return realCheckOutDate;
   }
   public void setRealCheckOutDate(String realCheckOutDate)
   {
      this.realCheckOutDate = realCheckOutDate;
   }
   public String getAdultCount()
   {
      return adultCount;
   }
   public void setAdultCount(String adultCount)
   {
      this.adultCount = adultCount;
   }
   public String getChildCount()
   {
      return childCount;
   }
   public void setChildCount(String childCount)
   {
      this.childCount = childCount;
   }
   public String getBabyCount()
   {
      return babyCount;
   }
   public void setBabyCount(String babyCount)
   {
      this.babyCount = babyCount;
   }
   public String getSpecialNote()
   {
      return specialNote;
   }
   public void setSpecialNote(String specialNote)
   {
      this.specialNote = specialNote;
   }
   public String getUlistregDate()
   {
      return ulistregDate;
   }
   public void setUlistregDate(String ulistregDate)
   {
      this.ulistregDate = ulistregDate;
   }
   
   public String getGmemId()
   {
      return gmemId;
   }
   public void setGmemId(String gmemId)
   {
      this.gmemId = gmemId;
   }
   public String getMemEtiquette()
   {
      return memEtiquette;
   }
   public void setMemEtiquette(String memEtiquette)
   {
      this.memEtiquette = memEtiquette;
   }
}