package com.gaja.dto;

public class CardDTO
{
	private int cardCode;
	private String cardNumber, cardPassword, cardYear, cardMonth, cardCVC;
	
	
	public int getCardCode()
	{
		return cardCode;
	}
	public void setCardCode(int cardCode)
	{
		this.cardCode = cardCode;
	}
	public String getCardNumber()
	{
		return cardNumber;
	}
	public void setCardNumber(String cardNumber)
	{
		this.cardNumber = cardNumber;
	}
	public String getCardPassword()
	{
		return cardPassword;
	}
	public void setCardPassword(String cardPassword)
	{
		this.cardPassword = cardPassword;
	}
	public String getCardYear()
	{
		return cardYear;
	}
	public void setCardYear(String cardYear)
	{
		this.cardYear = cardYear;
	}
	public String getCardMonth()
	{
		return cardMonth;
	}
	public void setCardMonth(String cardMonth)
	{
		this.cardMonth = cardMonth;
	}
	public String getCardCVC()
	{
		return cardCVC;
	}
	public void setCardCVC(String cardCVC)
	{
		this.cardCVC = cardCVC;
	}
	
}
