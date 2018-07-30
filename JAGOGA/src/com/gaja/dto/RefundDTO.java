package com.gaja.dto;

public class RefundDTO
{
	private int rfdCode, cancelCode, refund;
	private String rfdDate;
	
	
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
	public String getRfdDate()
	{
		return rfdDate;
	}
	public void setRfdDate(String rfdDate)
	{
		this.rfdDate = rfdDate;
	}
	
	
}
