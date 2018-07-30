package com.gaja.admin;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

public class AAASampleController implements Controller
{
	/* 
	// DAO 인터페이스 자료형 멤버 구성
	private SearchRoomDAO dao;
	
	// setter 구성
	public void setDao(SearchRoomDAO dao)
	{
		this.dao = dao;
	}
	*/
	
	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		ModelAndView mav = new ModelAndView();
		
		// 세션 처리 과정 추가 → 로그인 여부만 확인 → 관리자 확인할 필요 없음. --------------------
		/*HttpSession session = request.getSession();
		
		if (session.getAttribute("name")==null)         //-- 로그인이 되어 있지 않은 상황
		{
			mav.setViewName("redirect:loginform.action");
			return mav;
		}*///--------------------------------------------------------------------- 세션 처리 과정 추가
		
		try
		{
			// 데이터 수신 → 
			//String name = request.getParameter("name");
			
			// 작업 영역
			
			// 객체저장
			mav.addObject("obj", "obj");
			
			// 추후 수정
			mav.setViewName("Main.jsp");
			//mav.setViewName("/WEB-INF/views/EmpList.jsp");
			
		}catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		return mav;
	}
}