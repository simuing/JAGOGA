/*=============================
	MemberController.java
	- 컨트롤러
=============================*/

package com.gaja.member;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.gaja.dto.BookableDateDTO;
import com.gaja.dto.BookingDTO;
import com.gaja.dto.ConstraintDTO;
import com.gaja.dto.ConvenienceDTO;
import com.gaja.dto.MemberDTO;
import com.gaja.dto.MyRoomDTO;
import com.gaja.dto.ReqVerificationDTO;
import com.gaja.dto.ReviewDTO;
import com.gaja.dto.RoomConstraintDTO;
import com.gaja.dto.RoomConvenienceDTO;
import com.gaja.dto.RoomDTO;
import com.gaja.dto.RoomImageDTO;
import com.gaja.dto.RoomQuestionDTO;
import com.gaja.dto.RoomTypeDTO;
import com.gaja.dto.RqstAnswerDTO;
import com.gaja.dto.VfaqDTO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

@Controller
public class MemberController
{
	// mybatis 객체 의존성 (자동)주입~!!!
	@Autowired
	private SqlSession sqlSession;
	
	
	// 메인 페이지 요청
	@RequestMapping(value="/main.do", method=RequestMethod.GET)
	public String main(ModelMap model, HttpServletRequest request)
	{
		IMemberMainDAO dao = sqlSession.getMapper(IMemberMainDAO.class);
		
		// 조회할 연령대 변수 생성
		int age = 0;
		
		// 세션 처리 과정 추가 → 로그인 여부 확인 후 연령대 담기
		HttpSession session = request.getSession();
		
		if (session.getAttribute("memCode")!=null)		// 로그인 상태
		{
			// 회원 연령대 구하기
			String memCode = (String)session.getAttribute("memCode");
			age = dao.getMemberAge(memCode);
			
		} else		// 비로그인 상태
		{
			// 가장 많은 연령대 구하기
			age = dao.mostAge();
		}
		
		// 모델 객체에 연령 담기
		model.addAttribute("age", age);
		
		// 인기방 리스트 조회 후 모델 객체에 담기
		model.addAttribute("bestRoomList", dao.bestRoomList());
		
		// 연령대별 추천 리스트 조회 후 모델 객체에 담기
		model.addAttribute("ageRoomList", dao.ageRoomList(age));
		
		// 핫한키워드 리스트 조회 후 모델 객체에 담기
		model.addAttribute("bestKeywordList", dao.bestKeywordList());
		
		
		return "WEB-INF/views/memberViews/Main.jsp";
	}
	
	// 로그인
	@RequestMapping(value = "/login.do", method = RequestMethod.POST)
	public String login(ModelMap model, MemberDTO dto, HttpServletRequest request)
	{
		IMemberDAO dao = sqlSession.getMapper(IMemberDAO.class);

		// 회원코드, 이름, 아이디 변수선언
		int loginCheck = 0;
		String memCode = null;
		String name = null;

		// 회원코드 얻어내기
		loginCheck = dao.loginCheck(dto);

		// 로그인 성공
		if (loginCheck == 1)
		{
			// 회원코드, 회원이름 추출
			memCode = Integer.toString(dao.login(dto).getMemCode());
			name = dao.login(dto).getMemName();

			// 세션 설정 - 회원코드, 이름, 아이디를 세션 값으로 부여
			HttpSession session = request.getSession();
			session.setAttribute("memCode", memCode);
			session.setAttribute("name", name);
			session.setAttribute("memId", request.getParameter("memId"));
		}

		// 로그인 실패
		return "redirect:main.do";
	}
	
	// 로그아웃
	@RequestMapping(value="/logout.do", method=RequestMethod.GET)
	public String logout(HttpServletRequest request)
	{
		// 현재 세션값 얻어오기
		HttpSession session = request.getSession();
		
		// 세션값 삭제
		session.removeAttribute("memCode");
		session.removeAttribute("name");
		
		return "redirect:main.do";
	}
	
	// 비밀번호 일치 확인 (AJAX)
	@RequestMapping(value="/logincheck.do", method=RequestMethod.POST)
	public String logincheck(ModelMap model, String memId, String memPw)
	{
		IMemberDAO dao = sqlSession.getMapper(IMemberDAO.class);

		// 입력된 비밀번호와 아이디가 데이터와 일치하는지 확인하여 모델 객체에 담기
		// (비밀번호로 조회하여 COUNT 하고 일치된 데이터이 있으면 1, 아니면 0)
		model.addAttribute("result", dao.checkLoginPw(memId, memPw));
		
		return "WEB-INF/views/memberViews/AjaxDuplicateId.jsp";
	}
	
	
	// 연령대별 추천숙소 조회
	// (메인에서 보이는 페이지가 아니라 더보기 했을 때 보이는 전체 리스트 페이지)
	@RequestMapping(value="/ageroom.do", method=RequestMethod.GET)
	public String ageRoom(ModelMap model)
	{
		IMemberMainDAO dao = sqlSession.getMapper(IMemberMainDAO.class);
		
		// 모델 객체에 반환된 리스트 담기
		model.addAttribute("ageRoomList20", dao.ageRoomList(20));
		model.addAttribute("ageRoomList30", dao.ageRoomList(30));
		model.addAttribute("ageRoomList40", dao.ageRoomList(40));
		model.addAttribute("ageRoomList50", dao.ageRoomList(50));
		
		return "WEB-INF/views/memberViews/AgeRoom.jsp";
	}
	
	// 인기방 리스트 조회
	// (메인에서 보이는 페이지가 아니라 더보기 했을 때 보이는 전체 리스트 페이지)
	@RequestMapping(value="/bestroom.do", method=RequestMethod.GET)
	public String bestRoom(ModelMap model)
	{
		IMemberMainDAO dao = sqlSession.getMapper(IMemberMainDAO.class);
		
		// 모델 객체에 반환된 리스트 담기
		model.addAttribute("bestRoomList", dao.bestRoomList());
		
		return "WEB-INF/views/memberViews/BestRoom.jsp";
	}
	
   // 숙소 검색 페이지 요청
   // (검색창에 키워드 검색 시 조회되는 페이지)
   @RequestMapping(value="/searchroom.do", method=RequestMethod.GET)
   public String search(ModelMap model, HttpServletRequest request)
   {
      ISearchRoomDAO dao = sqlSession.getMapper(ISearchRoomDAO.class);

      String word = request.getParameter("search");
      
      // 기본 페이지 넘버는 1
      int pageNumber = 1;
      
      // 페이지넘버를 넘겨받았다면
      if (request.getParameter("pageNumber") != null)
      {
         // 페이지넘버 변수에 넘겨받은 페이지넘버 값을 담는다
         pageNumber = Integer.parseInt(request.getParameter("pageNumber")); 
      }
      
      // 검색어 테이블에 검색내용 추가
      dao.insertWord(word);
      
      // 모델 객체에 반환된 리스트 담기
      model.addAttribute("searchRoomList", dao.searchRoomList(word, pageNumber));
      model.addAttribute("search", word);
      
      // 변경된 페이지 넘버를 모델 객체에 담기
      model.addAttribute("pageNumber", pageNumber);
      
      return "/WEB-INF/views/memberViews/SearchRoom.jsp";
   }
	
	// 고객센터 페이지 요청
	// (FAQ, 내 문의)
	@RequestMapping(value="/question.do", method=RequestMethod.GET)
	public String question(ModelMap model, HttpServletRequest request)
	{
		IMemberQuestionDAO dao = sqlSession.getMapper(IMemberQuestionDAO.class);

		// 로그인되어 있을 경우 내문의 조회
		HttpSession session = request.getSession();
		
		if (session.getAttribute("memCode")!=null)
		{
			// 세션에서 회원코드 가져오기
			int memCode = Integer.parseInt((String)session.getAttribute("memCode")); 
			
			// 해당 회원의 문의내역 조회
			model.addAttribute("myQuestionList", dao.myQuestionList(memCode));
		}
		
		// 여러 모델 객체에 반환된 각각의 리스트 담기
		model.addAttribute("useFaqList", dao.faqList(1));
		model.addAttribute("bookingFaqList", dao.faqList(2));
		model.addAttribute("verificationFaqList", dao.faqList(3));
		model.addAttribute("payFaqList", dao.faqList(4));
		model.addAttribute("memberFaqList", dao.faqList(5));
		model.addAttribute("etcFaqList", dao.faqList(6));

		return "WEB-INF/views/memberViews/MemberQuestion.jsp";
	}
	
	
	// 예약내역 페이지 요청
	@RequestMapping(value="/bookinglist.do", method=RequestMethod.GET)
	public String bookingList(ModelMap model, HttpServletRequest request)
	{
		IMyBookingListDAO dao = sqlSession.getMapper(IMyBookingListDAO.class);

		// 로그인되어 있을 경우 내문의 조회
		HttpSession session = request.getSession();
		int memCode = 0;
		
		if (session.getAttribute("memCode")!=null)	// 로그인 상태면
		{
			// 세션에서 회원코드 가져오기
			memCode = Integer.parseInt((String)session.getAttribute("memCode")); 
		}
		else	// 비로그인 상태면(사실상 일어날 일 없음)
		{
			// 모델 객체에 안내문구 담고 메인페이지 재요청
			model.addAttribute("errMsg", "로그인상태가 아닙니다!");
			return "redirect:main.do";
		}
		
		// 모델 객체에 반환된 예약내역 리스트 담기
		model.addAttribute("bookingList", dao.bookingList(memCode));

		return "WEB-INF/views/memberViews/MyBookingList.jsp";
	}
	
	// 예약 취소 요청
	@RequestMapping(value="/deletebooking.do", method=RequestMethod.GET)
	public String bookingCancel(ModelMap model, HttpServletRequest request)
	{
		IMyBookingListDAO dao = sqlSession.getMapper(IMyBookingListDAO.class);
		
		// GET 방식으로 넘어온 예약코드 받아서 취소 쿼리문 실행
		int bcode = Integer.parseInt(request.getParameter("bcode"));
		dao.bookingCancel(bcode);

		return "redirect:bookinglist.do";
	}
	
	// 내 숙소 예약 취소하기
	
	// 예약 내역 상세 조회
	@RequestMapping(value="/bookingdetail.do", method=RequestMethod.GET)
	public String bookingDetail(ModelMap model, HttpServletRequest request)
	{
		IMyBookingListDAO dao = sqlSession.getMapper(IMyBookingListDAO.class);
		
		HttpSession session = request.getSession();
		
		// GET 방식으로 넘어온 예약코드와 세션의 회원번호 받기
		int bcode = Integer.parseInt(request.getParameter("bcode"));
		int gmemCode = Integer.parseInt((String)session.getAttribute("memCode"));
		
		// 예약 상세 내역을 조회해서 모델 객체에 담기
		model.addAttribute("bookingDetail", dao.bookingDetail(gmemCode, bcode));
		
		return "WEB-INF/views/memberViews/MyBookingDetail.jsp";
	}
	
	// 달력을 통해 검색한 예약내역 조회
    @RequestMapping(value="/mybookingDateCheck.do", method=RequestMethod.GET)
    public String myBookingDateCheck(ModelMap model, HttpServletRequest request, String startCheck, String endCheck, String tempStart, String tempEnd)
    {
       IMyBookingListDAO dao = sqlSession.getMapper(IMyBookingListDAO.class);
      
       HttpSession session = request.getSession();
      
       if (session.getAttribute("memCode")!=null)   // 로그인 상태면
       {
          int memCode = Integer.parseInt((String)session.getAttribute("memCode"));
          //System.out.println("test");
            
          model.addAttribute("bookingList", dao.dateBookingList(memCode, startCheck, endCheck));
          model.addAttribute("tempStart", tempStart);
          model.addAttribute("tempEnd", tempEnd);
         
       }
       else  // 비로그인 상태면(사실상 일어날 일 없음)
       {
          // 모델 객체에 안내문구 담고 메인페이지 재요청
          model.addAttribute("errMsg", "로그인상태가 아닙니다!");
          return "redirect:main.do";
       }
      
       return "WEB-INF/views/memberViews/MyBookingList.jsp";
    }
	
	
	// 내 정보(비밀번호확인) 페이지 요청
	@RequestMapping(value="/trymyinfo.do", method=RequestMethod.GET)
	public String tryMyInfo(ModelMap model, HttpServletRequest request)
	{
		HttpSession session = request.getSession();
		
		//
		String memId = (String)session.getAttribute("memId");
		
		// 세션에서 아이디를 얻어서 모델 객체에 담기
		model.addAttribute("memId", memId);
		
		return "WEB-INF/views/memberViews/TryMyInfo.jsp";
	}
	
	
	// 내 정보 페이지 요청
	// 회원번호와 입력한 비밀번호가 정확해야 페이지 요청!
	@RequestMapping(value="/myinformation.do", method=RequestMethod.POST)
	public String myInformation(ModelMap model, HttpServletRequest request)
	{
		IMemberDAO dao = sqlSession.getMapper(IMemberDAO.class);
		
		HttpSession session = request.getSession();
		
		// 세션에서 회원코드, 아이디 얻어내기
		int memCode = Integer.parseInt((String)session.getAttribute("memCode"));

		if (request.getParameter("memPw")!="")
		{
			// POST 방식으로 넘어온 비밀번호받기
			String memPw = request.getParameter("memPw");
			
			// 로그인메소드로 조회된 회원번호와 세션에 저장된 회원번호가 다르면 돌려보내기
			if (dao.getMemberPw(memCode, memPw)!=1)
			{
				model.addAttribute("errMsg", "비밀번호가 정확하지 않습니다.");
				return "redirect:trymyinfo.do";
			}
		
		}
		
		// 비밀번호가 맞다면(조건문에 걸리지 않는다면)
		// 회원정보 조회하여 모델 객체에 담기
		model.addAttribute("memInfo", dao.memInfo(memCode));
		
		
		return "WEB-INF/views/memberViews/MyInformation.jsp";
	}
	
	
	// 내 정보 수정 페이지 요청
	@RequestMapping(value="/updatemyinfoform.do", method=RequestMethod.GET)
	public String updateMyInfoForm(ModelMap model, HttpServletRequest request)
	{
		IMemberDAO dao = sqlSession.getMapper(IMemberDAO.class);
		
		HttpSession session = request.getSession();
		
		// 세션에서 회원번호 받기
		int memCode = Integer.parseInt((String)session.getAttribute("memCode"));
		
		// 회원정보 조회하여 모델 객체에 담기
		model.addAttribute("memInfo", dao.memInfo(memCode));
		
		
		return "WEB-INF/views/memberViews/UpdateMyInfoForm.jsp";
	}
	
	
   // 내 정보 수정
   @RequestMapping(value="/updatemyinfo.do", method=RequestMethod.POST)
   public String updateMyInfo(ModelMap model, MemberDTO member, HttpServletRequest request) throws IOException
   {
      IMemberDAO dao = sqlSession.getMapper(IMemberDAO.class);
      
      HttpSession session = request.getSession();
      
      // 파일 업로드를 위한 환경설정-------------------------------------------------

      // 최대 용량 (10MB)
      int maxSize  = 1024*1024*10;       
       
       // 업로드 폴더명
       String uploadPath = request.getServletContext().getRealPath("/memberProfile");
       
       File f = new File(uploadPath);
       if (!f.exists())
       {
          // 폴더가 존재하지 않으면 폴더 생성
          f.mkdirs();
       }
       
       // 인코딩 방식
       String encType="UTF-8";
       
       // MultipartRequest 객체 생성
       MultipartRequest multi = new MultipartRequest(request, uploadPath, maxSize, encType, new DefaultFileRenamePolicy());
        
       //------------------------------------------------------------- 파일 업로드를 위한 환경설정
            
      
      // 세션에서 회원코드 얻어내서 dto에 담기
      String getMemCode = (String)session.getAttribute("memCode");
      int memCode = Integer.parseInt(getMemCode);

      // 비밀번호
      String memPw = multi.getParameter("memPw");
      
      // 이메일
      String memEmail = multi.getParameter("memEmail");
      
      // 휴대폰번호
      String memTel = multi.getParameter("memTel");
      
      // 프로필 사진
      String getMemProfile = multi.getFilesystemName("memProfile");   // 첨부파일

      String memProfile = uploadPath + "/" + getMemProfile;         // 첨부파일의 실제 저장 경로
      
      
      // member 객체에 set 하기
      member.setMemCode(memCode);
      member.setMemPw(memPw);
      member.setMemTel(memTel);
      member.setMemEmail(memEmail);
      member.setMemProfile(memProfile);
      
      
      // 회원 정보 수정 메소드 호출
      dao.memModify(member);
      
      // 회원정보 조회하여 모델 객체에 담기
      model.addAttribute("memInfo", dao.memInfo(memCode));
      
      return "WEB-INF/views/memberViews/UpdateMyInfoComplete.jsp";
   }
	
	
	// 회원탈퇴 약관 페이지 요청
	@RequestMapping(value="/leaveterms.do", method=RequestMethod.GET)
	public String leaveTerms(ModelMap model, HttpServletRequest request)
	{
		HttpSession session = request.getSession();
		
		// 세션에서 회원 아이디 받아와 모델 객체로 넘기기
		model.addAttribute("memId", session.getAttribute("memId"));
		
		
		return "WEB-INF/views/memberViews/LeaveTerms.jsp";
	}
	
	// 회원탈퇴 비밀번호 입력 페이지 요청
	@RequestMapping(value="/leavepwform.do", method=RequestMethod.GET)
	public String leavePwForm()
	{
		return "WEB-INF/views/memberViews/LeavePwForm.jsp";
	}
	
	// 회원탈퇴 (수정본)
	@RequestMapping(value="/leave.do", method=RequestMethod.POST)
	public String leave(HttpServletRequest request)
	{
		IMemberDAO dao = sqlSession.getMapper(IMemberDAO.class);
		
		HttpSession session = request.getSession();
		
		// 세션에서 회원코드 얻어내기
		int memCode = Integer.parseInt((String)session.getAttribute("memCode"));
		
		// 회원이 입력한 비밀번호 얻어내기
		String memPw = request.getParameter("memPw");
		
		// 비밀번호 틀리면 되돌려보내기
		if (dao.getMemberPw(memCode, memPw)!=1)
		{
			return "WEB-INF/views/memberViews/LeaveFail.jsp";
		}
		
		// 비밀번호가 맞다면(조건문에 걸리지 않는다면)
		// 탈퇴 가능 여부 검사		

		// 1. 등록한 숙소가 있는가
		
		if (dao.roomCount(memCode) != 0)
		{
			return "WEB-INF/views/memberViews/LeaveFail.jsp";
		}
	
		// 2. 진행 중인 예약내역이 있는가
		
		else if (dao.bookingCheck(memCode) != 0)
		{
			return "WEB-INF/views/memberViews/LeaveFail.jsp";
		}
	
		// 탈퇴 가능하다면(조건문에 걸리지 않는다면)
		// 세션 삭제 -> 탈퇴 진행
		session.removeAttribute("memCode");
		session.removeAttribute("name");
		
		dao.leaveMember(memCode);
		
		return "WEB-INF/views/memberViews/LeaveComplete.jsp";
	}
	
	// 회원가입 요청
	@RequestMapping(value="/memberjointerms.do", method=RequestMethod.GET)
	public String memberJoinTerms()
	{
		return "WEB-INF/views/memberViews/MemberJoinTerms.jsp";
	}
	
	// 회원가입 페이지 요청
	@RequestMapping(value="/memberjoininput.do", method=RequestMethod.GET)
	public String memberJoinInput()
	{
		return "WEB-INF/views/memberViews/MemberJoinInput.jsp";
	}
	
	// 회원가입 요청
	@RequestMapping(value="/memberjoinwelcome.do", method=RequestMethod.POST)
	public String memberJoinWelcome(MemberDTO member)
	{
		IMemberDAO dao = sqlSession.getMapper(IMemberDAO.class);
		
		dao.addMemCode();
		dao.addMember(member);
		
		return "WEB-INF/views/memberViews/MemberJoinWelcome.jsp";
	}
	
	// 아이디 중복 확인 (AJAX)
	@RequestMapping(value="/duplicateid.do", method=RequestMethod.POST)
	public String duplicateId(ModelMap model, String memId)
	{
		IMemberDAO dao = sqlSession.getMapper(IMemberDAO.class);
		
		// 중복된 아이디인지 확인해서 모델 객체에 담기
		// (아이디로 조회하기 COUNT 하기 때문에 중복이면 1, 아니면 0)
		model.addAttribute("result", dao.checkDuplicate(memId));
		
		return "WEB-INF/views/memberViews/AjaxDuplicateId.jsp";
	}
	
	// 찜목록 페이지 요청
	@RequestMapping(value="/likelist.do", method=RequestMethod.GET)
	public String likeList(ModelMap model, HttpServletRequest request)
	{
		ILikeDAO dao = sqlSession.getMapper(ILikeDAO.class);
		
		// 세션에서 회원코드 얻어오기
		HttpSession session = request.getSession();
		int memCode = Integer.parseInt((String)session.getAttribute("memCode"));
		
		// 찜 목록 조회하는 메소드 호출
		model.addAttribute("likeList", dao.likeList(memCode));
		
		return "WEB-INF/views/memberViews/LikeList.jsp";
	}
	
	// 찜 등록 --> 스토리보드에서 찜하는 버튼이 없음ㅋㅋ
	@RequestMapping(value="/like.do", method=RequestMethod.GET)
	public String like(HttpServletRequest request, int rcode)
	{
		ILikeDAO dao = sqlSession.getMapper(ILikeDAO.class);
		
		HttpSession session = request.getSession();
		
		// 세션에서 회원코드 얻어오기
		int memCode = Integer.parseInt((String)session.getAttribute("memCode"));
		
		// 찜 등록 기능 수행하는 메소드 호출
		dao.addLike(memCode, rcode);
		
		return "redirect:likelist.do";
	}
	
	
	// 찜 삭제
	@RequestMapping(value="/deletelike.do", method=RequestMethod.GET)
	public String deleteLike(HttpServletRequest request, int likeCode)
	{
		ILikeDAO dao = sqlSession.getMapper(ILikeDAO.class);
		
		dao.deleteLike(likeCode);
		
		return "redirect:likelist.do";
	}
	
	// 알림 페이지 요청
	@RequestMapping(value="/reminderlist.do", method=RequestMethod.GET)
	public String reminderList(ModelMap model, HttpServletRequest request)
	{
		IReminderDAO dao = sqlSession.getMapper(IReminderDAO.class);
		
		// 세션에서 회원번호 받아오기
		HttpSession session = request.getSession();
		int memCode = Integer.parseInt((String)session.getAttribute("memCode"));
		
		// 알림 리스트 조회해서 모델 객체에 담기
		model.addAttribute("reminderList", dao.reminderList(memCode));
		
		return "WEB-INF/views/memberViews/Reminder.jsp";
	}
	
	// 알림 삭제
	@RequestMapping(value="/deletereminder.do", method=RequestMethod.GET)
	public String deleteReminder(int remCode)
	{
		IReminderDAO dao = sqlSession.getMapper(IReminderDAO.class);
		
		// GET 방식으로 넘어온 알림 번호 수신하여 삭제 메소드 호출
		dao.deleteReminder(remCode);
		
		return "redirect:reminderlist.do";
	}
	
	// 공지 목록 페이지 요청
   @RequestMapping(value="/noticelist.do", method=RequestMethod.GET)
   public String noticeList(ModelMap model, HttpServletRequest request)
   {
      INoticeDAO dao = sqlSession.getMapper(INoticeDAO.class);
      
      // 기본 페이지 넘버는 1
      int pageNumber = 1;
      
      // 페이지넘버를 넘겨받았다면
      if (request.getParameter("pageNumber") != null)
      {
         // 페이지넘버 변수에 넘겨받은 페이지넘버 값을 담는다
         pageNumber = Integer.parseInt(request.getParameter("pageNumber")); 
      }
      
      // 공지 전체 목록 조회하여 모델객체에 넘겨주기
      model.addAttribute("noticeList", dao.noticeList(pageNumber));
      model.addAttribute("useGuideList", dao.useGuide());
      model.addAttribute("terms", dao.terms());
      model.addAttribute("termsPrivateInfo", dao.termsPrivateInfo());

      // 변경된 페이지 넘버를 모델 객체에 담기
      model.addAttribute("pageNumber", pageNumber);

      
      return "WEB-INF/views/memberViews/Notice.jsp";
   }
   
   // 공지 내용 조회 페이지 요청
   @RequestMapping(value="/noticedetail.do", method=RequestMethod.GET)
   public String noticeDetail(ModelMap model, HttpServletRequest request)
   {
      INoticeDAO dao = sqlSession.getMapper(INoticeDAO.class);
      
      int ntCode = Integer.parseInt(request.getParameter("ntCode"));
      
      // 공지 전체 목록 조회하여 모델객체에 넘겨주기
      dao.upCount(ntCode);
      model.addAttribute("noticeDetail", dao.detailNotice(ntCode));
      
      return "WEB-INF/views/memberViews/MemberNoticeDetail.jsp";
   }
   
   // 공지 첨부파일 다운로드
   @RequestMapping(value="mntattachdownload.do", method=RequestMethod.GET)
   public String ntAttachDownload(ModelMap model, HttpServletRequest request, HttpServletResponse response) throws IOException
   {
      String ntAttach = request.getParameter("ntAttach");
      String savePath = "noticeAttach";
      
      // 파일의 실제 경로 얻기
      String realPath = request.getServletContext().getRealPath(savePath + "/" + ntAttach);
      
      // 파일 다운로드를 위한 헤더 정보 수정 (파일이름 문자열 다시 인코딩)
      response.setHeader("Content-Disposition",
            "attachment;filename="+new String(ntAttach.getBytes(), "ISO8859_1"));
      
      FileInputStream fin = new FileInputStream(realPath);
      ServletOutputStream sout = response.getOutputStream();
      
        byte[] buf = new byte[1024];
        int size = 0;
        
        while((size = fin.read(buf)) != -1)
        {
            sout.write(buf,0,size);
        }
        
        fin.close();
        sout.close();
      
      return "redirect:/";
   }
	
	// 아이디 찾기 페이지 요청
	@RequestMapping(value="/findid.do", method=RequestMethod.GET)
	public String findId()
	{
		return "WEB-INF/views/memberViews/FindId.jsp";
	}
	
	// 등록된 번호인지 확인 - 아이디/비밀번호 찾기 (AJAX)
	@RequestMapping(value="/checkvalidTel.do", method=RequestMethod.POST)
	public String checkValidTel(ModelMap model, String memTel)
	{
		IMemberDAO dao = sqlSession.getMapper(IMemberDAO.class);
		
		// 회원번호 유요한지 확인하여 결과를 모델 객체에 담기
		model.addAttribute("result", dao.checkValidTel(memTel));
		
		return "WEB-INF/views/memberViews/AjaxValidTel.jsp";
	}
	
	// 등록된 아이디인지 확인 - 비밀번호 찾기 (AJAX)
	@RequestMapping(value="/checkvalidId.do", method=RequestMethod.POST)
	public String checkValidId(ModelMap model, String memId)
	{
		IMemberDAO dao = sqlSession.getMapper(IMemberDAO.class);
		
		// 회원번호 유요한지 확인하여 결과를 모델 객체에 담기
		model.addAttribute("result", dao.checkValidId(memId));
		
		return "WEB-INF/views/memberViews/AjaxValidTel.jsp";
	}
	
	// 번호 인증 후 아이디 출력 페이지 요청
	@RequestMapping(value="/findidcomplete.do", method=RequestMethod.GET)
	public String findId(ModelMap model, String memTel)
	{
		IMemberDAO dao = sqlSession.getMapper(IMemberDAO.class);
		
		// 번호로 아이디 확인하는 메소드 호출해서 리턴값 모델 객체에 담기
		model.addAttribute("memId", dao.findId(memTel));
		
		return "WEB-INF/views/memberViews/FindIdComplete.jsp";
	}
	
	// 비밀번호 찾기 페이지 요청
	@RequestMapping(value="/findpw.do", method=RequestMethod.GET)
	public String findPw()
	{
		return "WEB-INF/views/memberViews/FindPassword.jsp";
	}
	
	// 아이디와 전화번호가 서로 맞는지 확인
	@RequestMapping(value="/matchidtel.do", method=RequestMethod.POST)
	public String matchIdTel(MemberDTO dto, ModelMap model)
	{
		IMemberDAO dao = sqlSession.getMapper(IMemberDAO.class);
		
		model.addAttribute("result", dao.matchIdTel(dto));
		
		return "WEB-INF/views/memberViews/AjaxValidTel.jsp";
	}
	
	// 비밀번호 재설정 페이지 요청
	@RequestMapping(value="/passwordchangeform.do", method=RequestMethod.GET)
	public String passwordChangeForm(String memId, HttpServletRequest request)
	{
		// 세션에 아이디를 저장하기 위해 세션 객체 생성
		HttpSession session = request.getSession();
		
		// 세션에 아이디 임시 저장
		// (비밀번호 재설정 후 세션에서 삭제할 것)
		session.setAttribute("memId", memId);
		
		return "WEB-INF/views/memberViews/FindPasswordChange.jsp";
	}
	
	// 비밀번호 재설정 페이지 요청
	@RequestMapping(value="/passwordchange.do", method=RequestMethod.POST)
	public String passwordChange(String memPw, HttpServletRequest request)
	{
		IMemberDAO dao = sqlSession.getMapper(IMemberDAO.class);
		
		// 세션의 아이디를 호출하기 위해 세션 객체 생성
		HttpSession session = request.getSession();
		
		// 비밀번호 찾기 페이지에서 세션에 저장해두었던
		// 아이디 다시 꺼내서 매개변수에 전달
		String memId = (String)session.getAttribute("memId");
		dao.passwordChange(memId, memPw);
		
		return "WEB-INF/views/memberViews/FindPasswordComplete.jsp";
	}
	
	// 나의 숙소목록 페이지 요청
	@RequestMapping(value="/myroomlist.do", method=RequestMethod.GET)
	public String myRoomList(ModelMap model, HttpServletRequest request)
	{
		IMyRoomListDAO dao = sqlSession.getMapper(IMyRoomListDAO.class);
		
		// 세션의 회원코드를 호출하기 위해 세션 객체 생성
		HttpSession session = request.getSession();
		
		// 세션에서 회원코드 받기
		String memCode = (String)session.getAttribute("memCode");
		
		// 회원코드로 조회된 숙소목록 담기
		ArrayList<MyRoomDTO> myRoomList = dao.myRoomList(Integer.parseInt(memCode));
		
		// 내 숙소목록 추가
		model.addAttribute("myRoomList", myRoomList);
		
		return "WEB-INF/views/memberViews/MyRoomList.jsp";
	}
	
	
   // 나의 숙소 예약목록 페이지 요청 myroombookinglist.do
   @RequestMapping(value="/myroombookinglist.do", method=RequestMethod.GET)
   public String myRoomBookingList(ModelMap model, HttpServletRequest request)
   {
      IMyRoomBookingDAO dao = sqlSession.getMapper(IMyRoomBookingDAO.class);
      
      HttpSession session = request.getSession();
      
      int memCode = Integer.parseInt((String)session.getAttribute("memCode"));
      model.addAttribute("list", dao.myRoomBookingList(memCode));
      
      return "WEB-INF/views/memberViews/MyRoomBookingList.jsp";
   }
	
   // 달력을 통한 내 숙소 예약목록 검색
   @RequestMapping(value="/timeCheck.do", method=RequestMethod.GET)
   public String myRoomBookingListByDate(ModelMap model, HttpServletRequest request, String startCheck, String endCheck, String tempStart, String tempEnd)
   {
      IMyRoomBookingDAO dao = sqlSession.getMapper(IMyRoomBookingDAO.class);
      
      HttpSession session = request.getSession();
      
      if (session.getAttribute("memCode")!=null)   // 로그인 상태면
      {
         int memCode = Integer.parseInt((String)session.getAttribute("memCode"));
            
         //model.addAttribute("list", dao.myRoomBookingList(memCode, startCheck, endCheck));
         model.addAttribute("tempStart", tempStart);
         model.addAttribute("tempEnd", tempEnd);
         
      }
      else   // 비로그인 상태면(사실상 일어날 일 없음)
      {
         // 모델 객체에 안내문구 담고 메인페이지 재요청
         model.addAttribute("errMsg", "로그인상태가 아닙니다!");
         return "redirect:main.do";
      }
      
      return "WEB-INF/views/memberViews/MyRoomBookingList.jsp";
   }
   
   // 내 숙소를 이용한 게스트의 에티켓점수 올리기
   @RequestMapping(value="/pointup.do", method=RequestMethod.GET)
   public String pointUp(ModelMap model,HttpServletRequest request, int bcode)
   {
      IMyRoomBookingDAO dao = sqlSession.getMapper(IMyRoomBookingDAO.class);
      
      HttpSession session = request.getSession();
      
      if (session.getAttribute("memCode")!=null)   // 로그인 상태면
      {
         int hmemCode = Integer.parseInt((String)session.getAttribute("memCode"));
         // 점수올리는 부분
         dao.plusEtqScore(hmemCode);
         dao.endPoint(hmemCode, bcode);
         //System.out.println("test");
      }
      else   // 비로그인 상태면(사실상 일어날 일 없음)
      {
         // 모델 객체에 안내문구 담고 메인페이지 재요청
         model.addAttribute("errMsg", "로그인상태가 아닙니다!");
         return "redirect:main.do";
      }
      
      return "redirect:myroombookinglist.do";
   }
   
   // 내 숙소를 이용한 게스트의 에티켓점수 내리기
   @RequestMapping(value="/pointdown.do", method=RequestMethod.GET)
   public String pointDown(ModelMap model,HttpServletRequest request, int bcode)
   {
      IMyRoomBookingDAO dao = sqlSession.getMapper(IMyRoomBookingDAO.class);
      
      HttpSession session = request.getSession();
      
      if (session.getAttribute("memCode")!=null)   // 로그인 상태면
      {
         int hmemCode = Integer.parseInt((String)session.getAttribute("memCode"));
         dao.minusEtqScore(hmemCode);
         dao.endPoint(hmemCode, bcode);
         //System.out.println("test");
      }
      else   // 비로그인 상태면(사실상 일어날 일 없음)
      {
         // 모델 객체에 안내문구 담고 메인페이지 재요청
         model.addAttribute("errMsg", "로그인상태가 아닙니다!");
         return "redirect:main.do";
      }
      
      return "redirect:myroombookinglist.do";
   }
   
   // 숙소 상세조회 페이지 요청
   @RequestMapping(value="/roomdetail.do", method=RequestMethod.GET)
   public String roomDetail(ModelMap model, HttpServletRequest request)
   {
      IRoomDetailDAO dao = sqlSession.getMapper(IRoomDetailDAO.class);
      
      // 클릭된 숙소코드 가져오기
      int rcode = Integer.parseInt(request.getParameter("rcode")); 
      
      model.addAttribute("roomInfo", dao.roomInfo(rcode)); // 숙소 상세정보
      model.addAttribute("roomConvenience", dao.roomConvenience(rcode)); // 숙소 편의사항
      model.addAttribute("roomConstraint", dao.roomConstraint(rcode)); // 숙소 제한사항

      model.addAttribute("bookableDateList", dao.bookableDateList(rcode)); // 예약가능날짜
      model.addAttribute("unableDateList", dao.unableDateList(rcode)); // 예약불가능날짜
      
      
      model.addAttribute("roomImg", dao.roomImg(rcode)); // 숙소 이미지
      model.addAttribute("roomReview", dao.roomReview(rcode)); // 숙소 후기목록
      model.addAttribute("roomQuestion", dao.roomQuestion(rcode)); // 숙소 문의목록
      //model.addAttribute("reviewImage", dao.reviewImage(rcode, revCode)); // 숙소 후기사진목록
      
      return "WEB-INF/views/memberViews/RoomDetail.jsp";
   }
   
	
	// 내 숙소 전체 검증내역 조회 페이지 요청
	@RequestMapping(value="/verificationlist.do", method=RequestMethod.GET)
	public String verificationList(ModelMap model, HttpServletRequest request) throws SQLException
	{
	   IMVerificationDAO dao = sqlSession.getMapper(IMVerificationDAO.class);
	   
	   HttpSession session = request.getSession();

	   if (session.getAttribute("memCode") != null) // 로그인 상태면
	   {
	      String sessionMemCode = (String) session.getAttribute("memCode");
	      int memCode = Integer.parseInt(sessionMemCode);
	      
	      model.addAttribute("myVerificationList", dao.mVerificationList(memCode));
	      
	   } else // 비로그인 상태면
	   {
	      // 모델 객체에 안내문구 담고 메인페이지 재요청
	      model.addAttribute("errMsg", "로그인상태가 아닙니다!");
	      return "redirect:main.do";
	   }
	   
	   return "WEB-INF/views/memberViews/MyRoomVerificationList.jsp";
	}
	
		
	// 해당숙소 검증신청 페이지 요청
	@RequestMapping(value="/verification.do", method=RequestMethod.GET)
	public String verification(ModelMap model, MyRoomDTO myRoom, HttpServletRequest request)
	{
		// 입력값 담기
		myRoom.setRcode(Integer.parseInt(request.getParameter("rcode")));
		myRoom.setRname(request.getParameter("rname"));
		myRoom.setVafterGrade(request.getParameter("vafterGrade"));
		
		model.addAttribute("myRoom", myRoom);
		
		return "WEB-INF/views/memberViews/MyRoomVerification.jsp";
	}
	
	// 검증신청 완료 페이지 요청
    @RequestMapping(value="/verificationreq.do", method=RequestMethod.POST)
    public String verificationReq(ModelMap model, ReqVerificationDTO dto, HttpServletRequest request) throws IOException, SQLException
    {
       IMVerificationDAO dao = sqlSession.getMapper(IMVerificationDAO.class);
      
       // 파일 업로드를 위한 환경설정-------------------------------------------------
      
       // 최대 용량 (10MB)
       int maxSize  = 1024*1024*10;       
       
       String vafterGrade = request.getParameter("vafterGrade");
      
       String uploadPath = "";
      
        uploadPath = request.getServletContext().getRealPath("/verificationAttach");

        File f = new File(uploadPath);
        if (!f.exists())
        {
           // 폴더가 존재하지 않으면 폴더 생성
           f.mkdirs();
        }
       
        // 인코딩 방식
        String encType="UTF-8";
       
        // MultipartRequest 객체 생성
        MultipartRequest multi = new MultipartRequest(request, uploadPath, maxSize, encType, new DefaultFileRenamePolicy());
        
        //------------------------------------------------------------- 파일 업로드를 위한 환경설정
      
       // 입력된 정보 가져오기
       String getRcode = (String)multi.getParameter("rcode");
       int rcode = Integer.parseInt(getRcode);
      
       String attachFile = multi.getFilesystemName("reqvAttach"); // 첨부파일
      
       String reqvAttach = uploadPath + "/" + attachFile;         // 첨부파일의 실제 저장 경로
      
       // 검증신청 입력
       dao.verificationReq(rcode, reqvAttach);
      
       return "WEB-INF/views/memberViews/MyRoomVerificationComplete.jsp";
    }
	
	
	// 숙소등록 페이지 요청 -1
	@RequestMapping(value="/insertroom1.do", method=RequestMethod.GET)
	public String insertRoom1(ModelMap model, HttpServletRequest request)
	{
		IInsertRoomDAO dao = sqlSession.getMapper(IInsertRoomDAO.class);
		
		// 호스트 서비스 정책 및 이용약관 조회
		model.addAttribute("hostTerms", dao.hostTerms());
		
		return "WEB-INF/views/memberViews/InsertRoom1.jsp";
	}
	
	
	// 숙소등록 페이지 요청 -2
	@RequestMapping(value="/insertroom2.do", method=RequestMethod.GET)
	public String insertRoom2(ModelMap model, HttpServletRequest request)
	{
		IInsertRoomDAO dao = sqlSession.getMapper(IInsertRoomDAO.class);
		
		// 숙소 유형 목록 조회
		model.addAttribute("roomTypeList", dao.roomTypeList());
		
		// 편의시설 목록 조회
		model.addAttribute("convList", dao.convList());
		
		// 제한사항 목록 조회
		model.addAttribute("consList", dao.consList());
		
		return "WEB-INF/views/memberViews/InsertRoom2.jsp";
	}
	
	// 숙소등록 페이지 요청 -3
	// 숙소사진, 숙소편의시설, 숙소제한사항, 숙소예약가능날짜
	@RequestMapping(value="/insertroom3.do", method=RequestMethod.POST)
	public String insertRoom3(ModelMap model, HttpServletRequest request
		 , RoomDTO room, ConvenienceDTO conv, ConstraintDTO cons, RoomConvenienceDTO roomconv, RoomConstraintDTO roomcons
		 , RoomImageDTO roomimg, BookableDateDTO bookable, RoomTypeDTO roomtype) throws IOException
	{
		IInsertRoomDAO dao = sqlSession.getMapper(IInsertRoomDAO.class);
		
		// 세션에서 회원코드 얻어오기
		HttpSession session = request.getSession();
		String sMemCode = (String)session.getAttribute("memCode");
		int memCode = Integer.parseInt(sMemCode);
		
		// 파일 업로드를 위한 환경설정-------------------------------------------------
		
		// 최대 용량 (10MB)
		int maxSize  = 1024*1024*10;       
		 
	    // 업로드 폴더명
	    String uploadPath = request.getServletContext().getRealPath("/roomImage");
	    
	    File f = new File(uploadPath);
	    if (!f.exists())
	    {
	    	// 폴더가 존재하지 않으면 폴더 생성
	    	f.mkdirs();
	    }
	    
	    // 인코딩 방식
	    String encType="UTF-8";
	    
	    // MultipartRequest 객체 생성
	    MultipartRequest multi = new MultipartRequest(request, uploadPath, maxSize, encType, new DefaultFileRenamePolicy());
        
	    //------------------------------------------------------------- 파일 업로드를 위한 환경설정
	    
	    //-- 숙소 정보 받아와 insert 하는 과정
	    
	    // 1. 숙소코드 발급 후 숙소코드 담기
	    dao.insertRoomCode(memCode); 
	    int rcode = dao.getRoomCode(memCode);
	    
	    // 2. 입력정보 받아와 숙소정보담기
		int rtypeCode = Integer.parseInt(multi.getParameter("rtypeCode")); //선택된 숙소유형코드
		RoomTypeDTO rtype = dao.pickRoomType(rtypeCode);//선택된 숙소유형
		int rarea = Integer.parseInt(multi.getParameter("rarea")); //숙소면적
		String rname = multi.getParameter("rname"); //숙소이름
		String rcontent = multi.getParameter("rcontent"); //숙소상세설명
		String rzipCode = multi.getParameter("rzipCode"); //숙소우편번호
		String rbasicAddr = multi.getParameter("rbasicAddr"); //숙소기본주소
		String rdetailAddr = multi.getParameter("rdetailAddr"); //숙소상세주소
		String minHumanCount = multi.getParameter("minHumanCount"); //숙박최소인원
		String maxHumanCount = multi.getParameter("maxHumanCount"); //숙박최대인원
		String adultFee = multi.getParameter("adultFee"); //성인요금
		String childFee = multi.getParameter("childFee"); // 어린이 요금
		String[] startDate = multi.getParameterValues("startDate"); //예약가능 시작일 목록
  		String[] endDate = multi.getParameterValues("endDate"); //예약가능 종료일 목록
  		ArrayList<BookableDateDTO> bookableList = new ArrayList<BookableDateDTO>(); //예약가능날짜 리스트를 담을 변수
		String roomImage1 = multi.getFilesystemName("rimg1"); // 숙소 이미지가 들어갈 폴더명
		String roomImage2 = multi.getFilesystemName("rimg2"); // 숙소 이미지가 들어갈 폴더명
		String roomImage3 = multi.getFilesystemName("rimg3"); // 숙소 이미지가 들어갈 폴더명
		String roomImage4 = multi.getFilesystemName("rimg4"); // 숙소 이미지가 들어갈 폴더명
		String fullPath1 = uploadPath + "/" + roomImage1; // 숙소 이미지 경로
		String fullPath2 = uploadPath + "/" + roomImage2; // 숙소 이미지 경로
		String fullPath3 = uploadPath + "/" + roomImage3; // 숙소 이미지 경로
		String fullPath4 = uploadPath + "/" + roomImage4; // 숙소 이미지 경로
		String fullPaths[] = {fullPath1, fullPath2, fullPath3, fullPath4};   // +++바꾼 부분+++
			    
		
	    // 3. 숙소정보 세팅 후 숙소등록
 		room.setRcode(rcode);
 		room.setRtypeCode(rtypeCode);
 		room.setRarea(rarea);
 		room.setRname(rname);
 		room.setRcontent(rcontent);
 		room.setRzipCode(rzipCode);
 		room.setRbasicAddr(rbasicAddr);
 		room.setRdetailAddr(rdetailAddr);
 		room.setMinHumanCount(Integer.parseInt(minHumanCount));
 		room.setMaxHumanCount(Integer.parseInt(maxHumanCount));
 		room.setAdultFee(Integer.parseInt(adultFee));
		room.setChildFee(Integer.parseInt(childFee));
		
		dao.insertRoom(room); //-- 숙소등록
		
		// 4. 숙소 편의시설 / 제한사항 등록
		String[] convCode = null; //숙소 편의시설코드를 담을 배열선언
		String[] consCode = null; //숙소 제한사항코드를 담을 배열선언
		ArrayList<ConvenienceDTO> convList = new ArrayList<ConvenienceDTO>(); //숙소 편의시설을 담을 변수선언
		ArrayList<ConstraintDTO> consList = new ArrayList<ConstraintDTO>(); //숙소 제한사항을 담을 변수선언
		
		if(multi.getParameterValues("convCode") != null)
		{
			// 선택된 편의시설들 담기
			convCode = multi.getParameterValues("convCode");
			
			for (int i=0; i<convCode.length; i++)
			{
				// 편의시설 목록에 담기
				ConvenienceDTO convDTO = new ConvenienceDTO();
				convDTO.setConvCode(Integer.parseInt(convCode[i]));
				convDTO.setConvContent(dao.pickConv(Integer.parseInt(convCode[i])).getConvContent());
				convList.add(convDTO);
				
				// 숙소편의시설 등록
				roomconv.setRcode(rcode);
				roomconv.setConvCode(dao.pickConv(Integer.parseInt(convCode[i])).getConvCode());
				dao.insertRoomConv(roomconv);
			}
		}
		
		if(multi.getParameterValues("consCode") != null)
		{
			// 선택된 숙소제한사항들 담기
			consCode = multi.getParameterValues("consCode");
			
			for (int i=0; i<consCode.length; i++)
			{
				// 숙소제한사항 목록에 담기
				ConstraintDTO consDTO = new ConstraintDTO();
				consDTO.setConsCode(Integer.parseInt(consCode[i]));
				consDTO.setConsContent(dao.pickCons(Integer.parseInt(consCode[i])).getConsContent());
				consList.add(consDTO);
				
				// 숙소제한사항 등록
				roomcons.setRcode(rcode);
				roomcons.setConsCode(dao.pickCons(Integer.parseInt(consCode[i])).getConsCode());
				dao.insertRoomCons(roomcons);
			}
		}
		
        // 5. 숙소 이미지 등록
        for (int i = 0; i <4; i++)
        {
           roomimg.setRcode(rcode);
           roomimg.setRimg(fullPaths[i]);

           dao.insertRoomImage(roomimg);
        }
		
		// 6. 예약가능날짜 등록
		for (int i=0; i<startDate.length; i++)
		{
			// 예약가능리스트에 추가(출력용)
			BookableDateDTO bookableDTO = new BookableDateDTO();
			bookableDTO.setRcode(rcode);
			bookableDTO.setStartDate(startDate[i]);
			bookableDTO.setEndDate(endDate[i]);
			bookableList.add(bookableDTO);
			
			// 예약가능날짜 등록
			dao.insertBookableDate(bookableDTO);
		}
		
		
		// ModelMap 에 숙소정보들 담기
		model.addAttribute("rtype", rtype);
		model.addAttribute("room", room);
		model.addAttribute("convList", convList);
		model.addAttribute("consList", consList);
		model.addAttribute("bookableList", bookableList);
		
		return "WEB-INF/views/memberViews/InsertRoom3.jsp";
	}

	// 숙소등록 페이지 요청 -4
	@RequestMapping(value="/insertroom4.do", method=RequestMethod.GET)
	public String insertRoom4(HttpServletRequest request)
	{
		IInsertRoomDAO dao = sqlSession.getMapper(IInsertRoomDAO.class);
		
		return "WEB-INF/views/memberViews/InsertRoom4.jsp";
	}
	
	// 숙소정보 수정 폼 페이지 요청
   @RequestMapping(value="/updateroomform.do", method=RequestMethod.GET)
   public String updateRoomForm(ModelMap model, HttpServletRequest request)
   {
      IInsertRoomDAO dao = sqlSession.getMapper(IInsertRoomDAO.class);
      
      String getRcode = (String)request.getParameter("rcode");
      int rcode = Integer.parseInt(getRcode);
      
      model.addAttribute("rcode", rcode);
      
      // 편의시설 목록 조회
      model.addAttribute("convList", dao.convList());
      
      // 제한사항 목록 조회
      model.addAttribute("consList", dao.consList());
      
      return "WEB-INF/views/memberViews/UpdateRoomForm.jsp";
   }
   
   
   // 숙소정보 수정 완료 페이지 요청
   @RequestMapping(value="/updateroomcomplete.do", method=RequestMethod.POST)
   public String updateRoomComplete(ModelMap model, HttpServletRequest request
         , ConvenienceDTO conv, ConstraintDTO cons, RoomConvenienceDTO roomconv, RoomConstraintDTO roomcons
         , RoomImageDTO roomimg, BookableDateDTO bookable) throws IOException
   {
      IUpdateRoomDAO dao = sqlSession.getMapper(IUpdateRoomDAO.class);

      // 파일 업로드를 위한 환경설정-------------------------------------------------

      // 최대 용량 (10MB)
      int maxSize = 1024 * 1024 * 10;

      // 업로드 폴더명
      String uploadPath = request.getServletContext().getRealPath("/roomImage");

      File f = new File(uploadPath);
      if (!f.exists())
      {
         // 폴더가 존재하지 않으면 폴더 생성
         f.mkdirs();
      }

      // 인코딩 방식
      String encType = "UTF-8";

      // MultipartRequest 객체 생성
      MultipartRequest multi = new MultipartRequest(request, uploadPath, maxSize, encType,
            new DefaultFileRenamePolicy());

      // ------------------------------------------------------------- 파일 업로드를
      // 위한 환경설정

      // -- 숙소 정보 받아와 insert 하는 과정

      // 2. 입력정보 받아와 숙소정보담기
      String getRcode = multi.getParameter("rcode");   // 숙소코드
      int rcode = Integer.parseInt(getRcode);         // 숙소코드 형변환
      String rname = multi.getParameter("rname"); // 숙소이름
      String rcontent = multi.getParameter("rcontent"); // 숙소상세설명
      String getMinHumanCount = multi.getParameter("minHumanCount"); // 숙박최소인원
      int minHumanCount = Integer.parseInt(getMinHumanCount);
      String getMaxHumanCount = multi.getParameter("maxHumanCount"); // 숙박최대인원
      int maxHumanCount = Integer.parseInt(getMaxHumanCount);
      String getAdultFee = multi.getParameter("adultFee"); // 성인요금
      int adultFee = Integer.parseInt(getAdultFee);
      String getChildFee = multi.getParameter("childFee"); // 어린이 요금
      int childFee = Integer.parseInt(getChildFee);
      
      String[] startDate = multi.getParameterValues("startDate"); // 예약가능 시작일
                                                   // 목록
      String[] endDate = multi.getParameterValues("endDate"); // 예약가능 종료일 목록
      ArrayList<BookableDateDTO> bookableList = new ArrayList<BookableDateDTO>(); // 예약가능날짜
                                                               // 리스트를
                                                               // 담을
                                                               // 변수
      String roomImage1 = multi.getFilesystemName("rimg1"); // 숙소 이미지가 들어갈 폴더명
      String roomImage2 = multi.getFilesystemName("rimg2"); // 숙소 이미지가 들어갈 폴더명
      String roomImage3 = multi.getFilesystemName("rimg3"); // 숙소 이미지가 들어갈 폴더명
      String roomImage4 = multi.getFilesystemName("rimg4"); // 숙소 이미지가 들어갈 폴더명
      String fullPath1 = uploadPath + "/" + roomImage1; // 숙소 이미지 경로
      String fullPath2 = uploadPath + "/" + roomImage2; // 숙소 이미지 경로
      String fullPath3 = uploadPath + "/" + roomImage3; // 숙소 이미지 경로
      String fullPath4 = uploadPath + "/" + roomImage4; // 숙소 이미지 경로
      String fullPaths[] = { fullPath1, fullPath2, fullPath3, fullPath4 }; // +++바꾼
                                                            // 부분+++

      // 3. 숙소정보 세팅 후 숙소등록
      dao.updateRoom(rname, rcontent, adultFee, childFee, maxHumanCount, minHumanCount, rcode);
      
      // 참조하고있는 테이블의 데이터 삭제
      dao.deleteRoomImage(rcode);
      dao.deleteRoomConv(rcode);
      dao.deleteRoomCons(rcode);
      
      // 4. 숙소 편의시설 / 제한사항 등록
      String[] convCode = null; // 숙소 편의시설코드를 담을 배열선언
      String[] consCode = null; // 숙소 제한사항코드를 담을 배열선언
      ArrayList<ConvenienceDTO> convList = new ArrayList<ConvenienceDTO>(); // 숙소
                                                            // 편의시설을
                                                            // 담을
                                                            // 변수선언
      ArrayList<ConstraintDTO> consList = new ArrayList<ConstraintDTO>(); // 숙소
                                                         // 제한사항을
                                                         // 담을
                                                         // 변수선언

      if (multi.getParameterValues("convCode") != null)
      {
         // 선택된 편의시설들 담기
         convCode = multi.getParameterValues("convCode");

         for (int i = 0; i < convCode.length; i++)
         {
            // 편의시설 목록에 담기
            ConvenienceDTO convDTO = new ConvenienceDTO();
            convDTO.setConvCode(Integer.parseInt(convCode[i]));
            convDTO.setConvContent(dao.pickConv(Integer.parseInt(convCode[i])).getConvContent());
            convList.add(convDTO);

            // 숙소편의시설 등록
            roomconv.setRcode(rcode);
            roomconv.setConvCode(dao.pickConv(Integer.parseInt(convCode[i])).getConvCode());
            dao.insertRoomConv(roomconv);
         }
      }

      if (multi.getParameterValues("consCode") != null)
      {
         // 선택된 숙소제한사항들 담기
         consCode = multi.getParameterValues("consCode");

         for (int i = 0; i < consCode.length; i++)
         {
            // 숙소제한사항 목록에 담기
            ConstraintDTO consDTO = new ConstraintDTO();
            consDTO.setConsCode(Integer.parseInt(consCode[i]));
            consDTO.setConsContent(dao.pickCons(Integer.parseInt(consCode[i])).getConsContent());
            consList.add(consDTO);

            // 숙소제한사항 등록
            roomcons.setRcode(rcode);
            roomcons.setConsCode(dao.pickCons(Integer.parseInt(consCode[i])).getConsCode());
            dao.insertRoomCons(roomcons);
         }
      }

      // 5. 숙소 이미지 등록
      for (int i = 0; i < 4; i++)
      {
         roomimg.setRcode(rcode);
         roomimg.setRimg(fullPaths[i]);

         dao.insertRoomImage(roomimg);
      }

      // 6. 예약가능날짜 등록
      for (int i = 0; i < startDate.length; i++)
      {
         // 예약가능리스트에 추가(출력용)
         BookableDateDTO bookableDTO = new BookableDateDTO();
         bookableDTO.setRcode(rcode);
         bookableDTO.setStartDate(startDate[i]);
         bookableDTO.setEndDate(endDate[i]);
         bookableList.add(bookableDTO);

         // 예약가능날짜 등록
         dao.insertBookableDate(bookableDTO);
      }

      // ModelMap 에 숙소정보들 담기
      model.addAttribute("convList", convList);
      model.addAttribute("consList", consList);
      model.addAttribute("bookableList", bookableList);

      return "WEB-INF/views/memberViews/UpdateRoomComplete.jsp";
   }
	
   
    /*// 숙소 삭제
	@RequestMapping(value="/deleteroom.do", method=RequestMethod.GET)
	public String deleteRoom(ModelMap model, HttpServletRequest request)
	{
		IMyRoomListDAO dao = sqlSession.getMapper(IMyRoomListDAO.class);
		
		// 숙소 코드 가져오기
		String getRcode = request.getParameter("rcode");
		int rcode = Integer.parseInt(getRcode);
		
		dao.deleteRoom(rcode);
		
		return "redirect:myroomlist.do";
	}*/
   
	
	// 예약신청 페이지 요청 -1
	@RequestMapping(value="/booking1.do", method=RequestMethod.POST)
	public String booking1(ModelMap model, HttpServletRequest request, BookingDTO dto)
	{
		IBookingDAO dao = sqlSession.getMapper(IBookingDAO.class);
		
		// 예약, 결제 정책 및 이용약관 내용가져오기
		String bookingTerm = dao.bookingTerm();
		
		String rcode = request.getParameter("rcode");
		
		model.addAttribute("bookingTerm", bookingTerm);
		model.addAttribute("dto", dto);
		model.addAttribute("rcode", rcode);
		
		return "WEB-INF/views/memberViews/Booking1.jsp";
	}
	
	
	// 예약신청 페이지 요청 -2
	@RequestMapping(value="/booking2.do", method=RequestMethod.POST)
	public String booking2(ModelMap model, HttpServletRequest request, BookingDTO dto)
	{
		String rcode = request.getParameter("rcode");
		
		model.addAttribute("rcode", rcode);
		model.addAttribute("dto", dto);
		
		return "WEB-INF/views/memberViews/Booking2.jsp";
	}
	
	
	// 예약신청 페이지 요청 -3
	@RequestMapping(value="/booking3.do", method=RequestMethod.POST)
	public String booking3(ModelMap model, HttpServletRequest request, BookingDTO dto, MyRoomDTO myroom) throws IOException
	{
		IBookingDAO dao = sqlSession.getMapper(IBookingDAO.class);
		
		HttpSession session = request.getSession();

		// 파일 업로드를 위한 환경설정-------------------------------------------------

		// 최대 용량 (10MB)
		int maxSize = 1024 * 1024 * 10;

		// 업로드 폴더명
		String uploadPath = request.getServletContext().getRealPath("/idCard");

		File f = new File(uploadPath);
		if (!f.exists())
		{
			// 폴더가 존재하지 않으면 폴더 생성
			f.mkdirs();
		}

		// 인코딩 방식
		String encType = "UTF-8";

		// MultipartRequest 객체 생성
		MultipartRequest multi = new MultipartRequest(request, uploadPath, maxSize, encType,
				new DefaultFileRenamePolicy());

		// ------------------------------------------------------------- 파일 업로드를 위한 환경설정
		
		// 세션에서 회원코드 얻어내서 dto에 담기
		String getMemCode = (String) session.getAttribute("memCode");
		int memCode = Integer.parseInt(getMemCode);
		dto.setMemCode(memCode);
		
		// 예약자 이름 (booking3.do에서 뿌려주는 용도)
		String memName = multi.getParameter("memName");
		model.addAttribute("memName", memName);
		
		// 숙소코드 - 숙소이름, 숙소주소 등을 컨트롤하기 위한 용도
		String getRcode = multi.getParameter("rcode");
		int rcode = Integer.parseInt(getRcode);
		
		// 숙소이름
		dao.getRname(rcode);
		model.addAttribute("rname", dao.getRname(rcode));
		
		// 인원수
		String getAdultCount = multi.getParameter("adultCount");
		String getChildCount = multi.getParameter("childCount");
		String getBabyCount = multi.getParameter("babyCount");
		
		int adultCount = Integer.parseInt(getAdultCount);
		int childCount = Integer.parseInt(getChildCount);
		int babyCount = Integer.parseInt(getBabyCount);
		
		dto.setAdultCount(adultCount);
		dto.setChildCount(childCount);
		dto.setBabyCount(babyCount);
		
		int totalCount = adultCount + childCount + babyCount;
		model.addAttribute("totalCount", totalCount);
		
		// 숙박날짜
		String checkInDate = multi.getParameter("checkInDate");
		String checkOutDate = multi.getParameter("checkOutDate");
		
		dto.setCheckInDate(checkInDate);
		dto.setCheckOutDate(checkOutDate);
		
		model.addAttribute("checkInDate", checkInDate);
		model.addAttribute("checkOutDate", checkOutDate);
		
		// 숙소주소
		model.addAttribute("rbasicAddr", dao.getRbasicAddr(rcode));
		model.addAttribute("rdetailAddr", dao.getRdetailAddr(rcode));
		
		// 결제금액
		String getBpay = multi.getParameter("bpay");
		int bpay = Integer.parseInt(getBpay);
		dto.setBpay(bpay);
		
		model.addAttribute("bpay", bpay);
		
		// 신분증 사본
		String getIdCard = multi.getFilesystemName("idCard"); // 신분증 사본 첨부파일
		String idCard = uploadPath + "/" + getIdCard; // 첨부파일의 실제 저장 경로
		dto.setIdCard(idCard);
				
		
		// 숙소예약가능코드 임의생성 --- 50번이 홍대입구 15분 전력질주 숙소
		dto.setBaDateCode(1);
		
		// 예약내역 추가
		dao.insertBooking(dto);
		
		return "WEB-INF/views/memberViews/Booking3.jsp";
	}
	
	// 예약신청 페이지 요청 -4
	@RequestMapping(value="/booking4.do", method=RequestMethod.GET)
	public String booking4(HttpServletRequest request)
	{
		IInsertRoomDAO dao = sqlSession.getMapper(IInsertRoomDAO.class);
		
		return "WEB-INF/views/memberViews/Booking4.jsp";
	}
	
	// 평점부여 가능횟수 조회
	@RequestMapping(value="/pointcheck.do", method=RequestMethod.POST)
	public String pointCheck(ModelMap model, HttpServletRequest request)
	{
		IRoomDetailDAO dao = sqlSession.getMapper(IRoomDetailDAO.class);
		
		// 세션에서 회원코드 얻어오기
		HttpSession session = request.getSession();
		int memCode = Integer.parseInt((String) session.getAttribute("memCode"));

		// 숙소코드 - 숙소이름, 숙소주소 등을 컨트롤하기 위한 용도
		int rcode = Integer.parseInt(request.getParameter("rcode"));
		
		// 평점부여 가능횟수 담아 보내기
		model.addAttribute("result", dao.pointCount(rcode, memCode));
		
		return "WEB-INF/views/memberViews/AjaxDuplicateId.jsp";
	}
	
	// pointcheck.do
	@RequestMapping(value="/insertroompoint.do", method=RequestMethod.GET)
	public String insertRoomPoint(HttpServletRequest request)
	{
		IRoomDetailDAO dao = sqlSession.getMapper(IRoomDetailDAO.class);
		
		// 세션에서 회원코드 얻어오기
		HttpSession session = request.getSession();
		int memCode = Integer.parseInt((String) session.getAttribute("memCode"));

		// 숙소코드, 포인트 가져오기
		int rcode = Integer.parseInt(request.getParameter("rcode"));
		int point = Integer.parseInt(request.getParameter("point"));
		
		// 평점을 등록할 이용내역코드 가져오기
		int ulistCode = dao.getPointUlistCode(rcode, memCode);
		
		// 평점 등록
		dao.insertPoint(ulistCode, point);
		
		return "redirect:roomdetail.do?rcode="+rcode;
	}
	
	// 후기 등록 가능 개수 조회
	@RequestMapping(value="/reviewcheck.do", method=RequestMethod.POST)
	public String reviewCheck(ModelMap model, HttpServletRequest request, String rcode)
	{
		IRoomDetailDAO dao = sqlSession.getMapper(IRoomDetailDAO.class);
		
		HttpSession session = request.getSession();
		
		// 세션에서 회원코드 가져오기
		int memCode = Integer.parseInt((String)session.getAttribute("memCode")); 
			
		// 해당 회원의 후기 등록 가능횟수 조회
		model.addAttribute("result", dao.reviewCount(Integer.parseInt(rcode), memCode));
		
		return "WEB-INF/views/memberViews/AjaxDuplicateId.jsp";
	}
	
	// 후기 등록
	@RequestMapping(value="/insertreview.do", method=RequestMethod.GET)
	public String insertReview(ReviewDTO dto, HttpServletRequest request)
	{
		IRoomDetailDAO dao = sqlSession.getMapper(IRoomDetailDAO.class);
		
		HttpSession session = request.getSession();
		
		// 숙소코드, 후기제목, 후기내용 가져오기
		int rcode = Integer.parseInt(request.getParameter("rcode"));
		String revTitle = request.getParameter("revTitle");
		String revContent = request.getParameter("revContent");
		
		// 세션에서 회원코드 가져오기
		int memCode = Integer.parseInt((String)session.getAttribute("memCode")); 

		// 후기를 등록할 이용가능코드 가져와 담기
		int ulistCode = dao.getReviewUlistCode(rcode, memCode);
		
		// ReviewDTO 준비
		dto.setUlistCode(ulistCode);
		dto.setRevTitle(revTitle);
		dto.setRevContent(revContent);
		
		// 후기등록
		dao.insertReview(dto);
		
		// 숙소페이지로 돌아가기
		return "redirect:roomdetail.do?rcode"+rcode;
	}
	
	// 후기 답변등록
	@RequestMapping(value="/insertreviewans.do", method=RequestMethod.GET)
	public String insertReviewAns(HttpServletRequest request)
	{
		IRoomDetailDAO dao = sqlSession.getMapper(IRoomDetailDAO.class);
		
		return "WEB-INF/views/memberViews/Booking4.jsp";
	}
	
	// 후기 삭제
	@RequestMapping(value="/deletereview.do", method=RequestMethod.GET)
	public String deleteReview(HttpServletRequest request)
	{
		IRoomDetailDAO dao = sqlSession.getMapper(IRoomDetailDAO.class);
		
		// 후기를 지울 자격(호스트인지) 여부 확인 (생략)
		
		// 후기코드, 숙소코드 가져오기
		int revCode = Integer.parseInt(request.getParameter("revCode"));
		int rcode = Integer.parseInt(request.getParameter("rcode"));
		
		// 후기삭제
		dao.deleteReviewAns(revCode);
		dao.deleteReviewImage(revCode);
		dao.deleteHideReview(revCode);
		dao.deleteReview(revCode);
		
		return "redirect:roomdetail.do?rcode="+rcode;
	}
	
	// 숙소문의 등록
	@RequestMapping(value="/insertrqst.do", method=RequestMethod.GET)
	public String insertRoomQuestion(RoomQuestionDTO dto, HttpServletRequest request)
	{
		IRoomDetailDAO dao = sqlSession.getMapper(IRoomDetailDAO.class);
		
		// 세션에서 회원코드 가져오기
		HttpSession session = request.getSession();
		int memCode = Integer.parseInt((String)session.getAttribute("memCode")); 
		
		// 숙소코드, 문의제목, 문의내용, 숨김여부 가져오기
		int rcode = Integer.parseInt(request.getParameter("rcode"));
		String rqstTitle = request.getParameter("rqstTitle");
		String rqstContent = request.getParameter("rqstContent");
		String closeCheck = request.getParameter("closeCheck");
		
		dto.setRcode(rcode);
		dto.setMemCode(memCode);
		dto.setRqstTitle(rqstTitle);
		dto.setRqstContent(rqstContent);
		dto.setCloseCheck(closeCheck);
		
		// 숙소문의 등록
		dao.insertRoomQuestion(dto);
		
		return "redirect:roomdetail.do?rcode=" + rcode;
	}
	
	// 숙소문의 답변등록
	@RequestMapping(value="/insertrqstans.do", method=RequestMethod.GET)
	public String insertRoomQuestionAns(RqstAnswerDTO dto, HttpServletRequest request)
	{
		IRoomDetailDAO dao = sqlSession.getMapper(IRoomDetailDAO.class);
		
		// 세션에서 회원코드 가져오기 (호스트여부확인) - 보류
		HttpSession session = request.getSession();
		int memCode = Integer.parseInt((String)session.getAttribute("memCode")); 
		
		// 숙소코드, 숙소문의코드, 답변 가져오기
		int rcode = Integer.parseInt(request.getParameter("rcode"));
		int rqstCode = Integer.parseInt(request.getParameter("rqstCode"));
		String rqstAns = request.getParameter("rqstAns");
		
		dto.setRqstCode(rqstCode);
		dto.setRqstAns(rqstAns);
		
		dao.insertRoomQuestionAns(dto);
		
		return "redirect:roomdetail.do?rcode=" + rcode;
		
	}
	
	// 숙소문의답변 삭제
	@RequestMapping(value="/deleterqstans.do", method=RequestMethod.GET)
	public String deleteRoomQuestionAns(HttpServletRequest request)
	{
		IRoomDetailDAO dao = sqlSession.getMapper(IRoomDetailDAO.class);
		
		// 호스트여부 확인 - 보류
		
		// 숙소코드, 숙소문의답변코드 가져오기
		int rcode = Integer.parseInt(request.getParameter("rcode"));
		int rqstAnsCode = Integer.parseInt(request.getParameter("rqstAnsCode"));
		
		System.out.println(rqstAnsCode);
		
		// 숙소문의 삭제
		dao.deleteRoomQuestionAns(rqstAnsCode);
		
		return "redirect:roomdetail.do?rcode=" + rcode;
		
	}
	
	// 숙소문의 삭제
	@RequestMapping(value="/deleterqst.do", method=RequestMethod.GET)
	public String deleteRoomQuestion(HttpServletRequest request)
	{
		IRoomDetailDAO dao = sqlSession.getMapper(IRoomDetailDAO.class);
		
		
		
		
		return "WEB-INF/views/memberViews/Booking4.jsp";
		
	}
	
	// 내 문의 등록하기 페이지 요청
	@RequestMapping(value="/addmyquestion.do", method=RequestMethod.GET)
	public String addMyQuestion(HttpServletRequest request, ModelMap model)
	{
		IMemberQuestionDAO dao = sqlSession.getMapper(IMemberQuestionDAO.class);
		HttpSession session = request.getSession();
		int memCode = Integer.parseInt((String)session.getAttribute("memCode"));
		
		model.addAttribute("category", dao.categorySearch());
		model.addAttribute("memCode", memCode);
		if((String)session.getAttribute("memCode") ==null)
		{
			// 모델 객체에 안내문구 담고 메인페이지 재요청
	          model.addAttribute("errMsg", "로그인상태가 아닙니다!");
	          return "redirect:main.do";
		}
		return "WEB-INF/views/memberViews/AddQuestion.jsp";
	}
	
	
	// 내 문의 등록하기
	@RequestMapping(value="/insertmyquestion.do", method={RequestMethod.GET, RequestMethod.POST})
	public String insertMyQuestion(ModelMap model, HttpServletRequest request, VfaqDTO vfaqDTO) throws IOException
	{
		
		IMemberQuestionDAO dao = sqlSession.getMapper(IMemberQuestionDAO.class);
		HttpSession session = request.getSession();
		//----------------------------[파일 업로드 환경설정]-------------------------------
		
		// 최대용량 설정
		int maxSize = 1024*1024*10;
		
		// 업로드 폴더명
		String uploadPath = request.getServletContext().getRealPath("/roomImage");
		
		// 파일 객체 생성
		File f = new File(uploadPath);
		
		if(!f.exists())
		{
			// 폴더가 존재하지 않으면 폴더 생성
			f.mkdirs();
		}
		
		// 인코딩 방싱 설정
		String encType = "UTF-8";
		
		// MultipartRequest 객체 생성
		MultipartRequest multi = new MultipartRequest(request, uploadPath, maxSize, encType, new DefaultFileRenamePolicy());
		
		//---------------------------------------------------------------------------------
		
		String questionImage1 = multi.getFilesystemName("rimg1"); // 숙소 이미지가 들어갈 폴더명
		String fullPath1 = uploadPath + "/" + questionImage1; // 숙소 이미지 경로
		String fullPaths[] = {fullPath1}; 
		int qstcCode = Integer.parseInt(multi.getParameter("qstcCode"));
		int memCode = Integer.parseInt((String)session.getAttribute("memCode"));
		String qstTitle = multi.getParameter("qstTitle");
		String qstContent = multi.getParameter("qstContent");
		
		// 숙소 이미지 등록
		for (int i = 0; i < 1; i++)
		{
			vfaqDTO.setQstAttach(fullPaths[i]);
		}
		
		// 나머지도 다 담기
		vfaqDTO.setQstcCode(qstcCode);
		vfaqDTO.setMemCode(memCode);
		vfaqDTO.setQstTitle(qstTitle);
		vfaqDTO.setQstContent(qstContent);
		
		dao.myQuestionInsert(vfaqDTO);
		
		return "redirect:/question.do";
	}
    
	
}
