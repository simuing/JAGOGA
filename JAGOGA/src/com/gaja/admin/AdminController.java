/*=============================
	AdminController.java
	- 컨트롤러
=============================*/

package com.gaja.admin;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.gaja.dto.AdminDTO;
import com.gaja.dto.TermsDTO;
import com.gaja.dto.VMemberDTO;
import com.gaja.dto.VadminNoticeDTO;
import com.gaja.dto.VadminDTO;
import com.gaja.dto.VadminRoomDTO;
import com.gaja.dto.VinsuranceDTO;
import com.gaja.dto.VquestionDTO;
import com.gaja.dto.VverificationDTO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

@Controller
public class AdminController
{
	// mybatis 객체 의존성 (자동)주입~!!!
	@Autowired
	private SqlSession adminSqlSession;
	
	// 관리자 로그인 페이지 요청
	@RequestMapping(value="/adminmain.do", method=RequestMethod.GET)
	public String adminMain()
	{
		return "WEB-INF/views/adminViews/AdminLogin.jsp";
	}
	
	
	// 로그인
	@RequestMapping(value="/adminlogin.do", method=RequestMethod.POST)
	public String adminMain(HttpServletRequest request, AdminDTO dto)
	{
		IAdminDAO dao = adminSqlSession.getMapper(IAdminDAO.class);
		
		// 세션 객체 생성
		HttpSession session = request.getSession();
		
		// 관리자번호와 관리자권한 구하기
		int adminCode = dao.adminCode(dto.getAdminId());
		String[] authority = dao.adminAuthority(adminCode);
		
		// 세션 설정
		session.setAttribute("adminId", dto.getAdminId());
		session.setAttribute("adminCode", adminCode);
		
		// 권한들을 담을 스트링버퍼 객체 생성해서 권한 담아두기
		StringBuffer strBuf = new StringBuffer();
		for (int i=0; i< authority.length; i++)
		{
			if (i==0)
				strBuf.append(authority[i]);
			
			strBuf.append("/" + authority[i]);
		}
		// 세션에 권한 저장
		session.setAttribute("authority", strBuf);
		
		
		return "redirect:dashboard.do";
	}
	
	
	// 대쉬보드 페이지 요청
	@RequestMapping(value="/dashboard.do", method=RequestMethod.GET)
	public String dashBoard(ModelMap model, HttpServletRequest request)
	{
		IAdminStatisticsDAO dao = adminSqlSession.getMapper(IAdminStatisticsDAO.class);
		
		// 세션 객체 생성
		HttpSession session = request.getSession();
		
		// 로그인 상태가 아니면(로그인 시도하는 상태)
		if (session.getAttribute("adminId")==null)
		{
			return "redirect:adminmain.do";
		}
		model.addAttribute("yesterdaySales", dao.yesterdaySales());
		model.addAttribute("newMemberCount", dao.newMemberCount());
		model.addAttribute("newRoomCount", dao.newRoomCount());
		model.addAttribute("salesRate", dao.salesRate());
		model.addAttribute("recentSales", dao.recentSales());
		model.addAttribute("thisMonthSales", dao.thisMonthSales());
		model.addAttribute("ageGroupCount", dao.ageGroupCount());
		model.addAttribute("etqMemCount", dao.etqMemCount());
		
		
		return "WEB-INF/views/adminViews/AdminDashboard.jsp";
	}
	
	// 로그아웃
	@RequestMapping(value="/adminlogout.do", method=RequestMethod.GET)
	public String logout(HttpServletRequest request)
	{
		// 현재 세션값 얻어오기
		HttpSession session = request.getSession();
		
		// 세션값 삭제
		session.removeAttribute("adminId");
		
		return "adminmain.do";
	}
	
	// 관리자 관리 페이지 요청
	@RequestMapping(value="/adminlist.do", method=RequestMethod.GET)
	public String adminList(ModelMap model)
	{
		IAdminDAO dao = adminSqlSession.getMapper(IAdminDAO.class);
		
		// 관리자 계정 리스트
		model.addAttribute("adminList", dao.adminList());
		
		// 관리자 권한 리스트
		model.addAttribute("adminAtList", dao.authorityList());
		
		return "WEB-INF/views/adminViews/AdminList.jsp";
	}
	
	

	// 관리자 생성 -- ★뷰페이지 부족
	@RequestMapping(value="/admininsert.do", method=RequestMethod.POST)
	public String adminInsert(AdminDTO dto)
	{
		return "redirect:adminmenu.do";
	}
	
	
	// 관리자 삭제/복구
	@RequestMapping(value="/changeadminactive.do", method=RequestMethod.GET)
	public String adminDelete(String adminCode, String active)
	{
		IAdminDAO dao = adminSqlSession.getMapper(IAdminDAO.class);
		
		// 관리자계정권한 삭제
		// (DB 관리자계정테이블의 부모 테이블이므로 먼저 삭제 해야 계정삭제 가능)
		// dao.adminAtRemove(Integer.parseInt(adminCode));
		
		/*if (active.equals('N'))
		{
			char active_2 = 'N';
		}
		else
		*/	//char active_2 = 'Y';
		
		// 관리자계정 삭제
		// (ACTIVE 컬럼 'N'으로 변경)
		dao.adminChangeActive(Integer.parseInt(adminCode), active);
		
		return "redirect:adminlist.do";
	}
	
	// 회원관리 페이지 요청
	@RequestMapping(value="/amemberlist.do", method=RequestMethod.GET)
	public String aMemberList(ModelMap model, HttpServletRequest request)
	{
		IAdminMemberDAO dao = adminSqlSession.getMapper(IAdminMemberDAO.class);
		
		// 기본 페이지 넘버는 1
		int pageNumber = 1;
		
		// 페이지넘버를 넘겨받았다면
		if (request.getParameter("pageNumber") != null)
		{
			// 페이지넘버 변수에 넘겨받은 페이지넘버 값을 담는다
			pageNumber = Integer.parseInt(request.getParameter("pageNumber")); 
		}
		
		// 회원리스트 조회해서 모델 객체에 담기
		model.addAttribute("aMemberList", dao.aMemberList(pageNumber));
		
		// 변경된 페이지 넘버를 모델 객체에 담기
		model.addAttribute("pageNumber", pageNumber);
		
		return "WEB-INF/views/adminViews/AdminMember.jsp";
	}
	
	// 회원 프로필사진 다운로드
	@RequestMapping(value="memberprofiledownload.do", method=RequestMethod.GET)
	public String memProfileDownload(ModelMap model, HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		String memProfile = request.getParameter("memProfile");
		String savePath = "memberProfile";
  
		// 파일의 실제 경로 얻기
		String realPath = request.getServletContext().getRealPath(savePath + "/" + memProfile);
  
		// 파일 다운로드를 위한 헤더 정보 수정 (파일이름 문자열 다시 인코딩)
		response.setHeader("Content-Disposition", "attachment;filename="+new String(memProfile.getBytes(), "ISO8859_1"));
  
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
	
	
	// 회원 삭제(탈퇴처리)
	@RequestMapping(value="/amemberdelete.do", method=RequestMethod.GET)
	public String aMemberDelete(int memCode)
	{
		IAdminMemberDAO dao = adminSqlSession.getMapper(IAdminMemberDAO.class);
		
		// 회원리스트 조회해서 모델 객체에 담기
		dao.adminDeleteMem(memCode);
		
		return "redirect:amemberlist.do";
	}
	
	// 특정 회원 검색(탈퇴처리)
	@RequestMapping(value="/amembersearch.do", method=RequestMethod.GET)
	public String aMemberSearch(ModelMap model, HttpServletRequest request)
	{
		IAdminMemberDAO dao = adminSqlSession.getMapper(IAdminMemberDAO.class);
		
		// 어떤 파라미터 값으로 넘어왔는지 확인해서
		// 해당 메소드로 조회해서 모델 객체에 담아서 보내기
		if (request.getParameter("memCode")!=null)			// 회원코드로 검색했을 경우
		{
			int memCode = Integer.parseInt(request.getParameter("memCode"));
			model.addAttribute("aMemberSearch", dao.aMemCodeSearch(memCode));
			model.addAttribute("searchWord", memCode);
		}
		else if (request.getParameter("memTel")!=null)		// 전화번호로 검색했을 경우
		{
			String memTel = request.getParameter("memTel");
			model.addAttribute("aMemberSearch", dao.aMemTelSearch(memTel));
			model.addAttribute("searchWord", memTel);
		}
		else if (request.getParameter("memId")!=null)		// 아이디로 검색했을 경우
		{
			String memId = request.getParameter("memId");
			model.addAttribute("aMemberSearch", dao.aMemIdSearch(memId));
			model.addAttribute("searchWord", memId);
		}
		
		return "WEB-INF/views/adminViews/AdminMember.jsp";
	}
	
	
	// 고객센터관리 페이지 요청
	@RequestMapping(value="/adminquestion.do", method=RequestMethod.GET)
	public String adminQuestionList(ModelMap model, HttpServletRequest request)
	{
		IAdminQuestionDAO dao = adminSqlSession.getMapper(IAdminQuestionDAO.class);

		// 기본 페이지 넘버는 1
		int pageNumber = 1;
				
		// 페이지넘버를 넘겨받았다면
		if (request.getParameter("pageNumber") != null)
		{
			// 페이지넘버 변수에 넘겨받은 페이지넘버 값을 담는다
			pageNumber = Integer.parseInt(request.getParameter("pageNumber")); 
		}
		
		// 문의 리스트 조회해서 모델 객체에 담기
		model.addAttribute("questionList", dao.questionList(pageNumber));
		
		// 변경된 페이지 넘버를 모델 객체에 담기
		model.addAttribute("pageNumber", pageNumber);
				
		// FAQ 리스트 조회
		model.addAttribute("faqList", dao.faqList());
		
		// 정책 및 이용약관 조회
		model.addAttribute("policiesTerms", dao.policiesTerms());
		
		// 개인정보 취급약관 조회
		model.addAttribute("privacyTerms", dao.privacyTerms());
		
		return "WEB-INF/views/adminViews/AdminQuestion.jsp";
	}
	
	// 고객센터관리 문의내용조회 요청
	@RequestMapping(value="/qstcontent.do", method=RequestMethod.GET)
	public String questionContent(ModelMap model, HttpServletRequest request)
	{
		IAdminQuestionDAO dao = adminSqlSession.getMapper(IAdminQuestionDAO.class);
		
		// GET 방식으로 넘어온 qstCode 받기
		int qstCode = Integer.parseInt(request.getParameter("qstCode"));
		
		// 특정 문의 내용 객체 받아와서 모델 객체에 넘기기 
		model.addAttribute("qstContent", dao.selectQuestion(qstCode));
		
		return "adminquestion.do";
	}
	
	// 고객센터문의 답변
	@RequestMapping(value="/questionanswer.do", method=RequestMethod.GET)
	public String questionAnswer(ModelMap model, VquestionDTO dto)
	{
		IAdminQuestionDAO dao = adminSqlSession.getMapper(IAdminQuestionDAO.class);
		
		// 관리자 아이디로 관리자코드 조회
		// GET 방식으로 넘어온 관리자 아이디를 통해 관리자코드 조회하여
		// 답변 등록에 쓰기 위해 다시 dto에 저장
		dto.setAdminCode(dao.adminCode(dto.getAdminId()));
		
		// 답변 등록
		dao.registAnswer(dto);
		
		return "redirect:adminquestion.do";
	}
	
	
	// FAQ 삭제
	@RequestMapping(value="/faqdelete.do", method=RequestMethod.GET)
	public String questionAnswer(int faqCode)
	{
		IAdminQuestionDAO dao = adminSqlSession.getMapper(IAdminQuestionDAO.class);
		
		// FAQ 삭제 메소드 호출
		dao.faqDelete(faqCode);
		
		return "redirect:adminquestion.do";
	}
	
	// 정책 및 이용약관, 개인정보 취급방침 수정
	@RequestMapping(value="/termsmodify.do", method=RequestMethod.GET)
	public String termsModify(String termsContent, int select, HttpServletRequest request)
	{
		IAdminQuestionDAO dao = adminSqlSession.getMapper(IAdminQuestionDAO.class);
		
		// 세션에서 회원코드 얻어오기
		HttpSession session = request.getSession();
		int adminCode = (Integer)session.getAttribute("adminCode");
		
		// DTO 객체 생성해서 수정쿼리에 필요한 값 담기
		TermsDTO dto = new TermsDTO();
		dto.setAdminCode(adminCode);
		dto.setTermsCode(select);
		dto.setTermsContent(termsContent.replaceAll("<br>", "\n"));
		
		
		// 수정 메소드 호출
		dao.TermsUpdate(dto);
		
		return "redirect:adminquestion.do";
	}
	
	// 관리자 공지관리 페이지 요청
	@RequestMapping(value="/adminnotice.do", method=RequestMethod.GET)
	public String adminUpdate(ModelMap model, HttpServletRequest request)
	{
		IAdminNoticeDAO dao = adminSqlSession.getMapper(IAdminNoticeDAO.class);

		// 기본 페이지 넘버는 1
		int pageNumber = 1;
		
		// 페이지넘버를 넘겨받았다면
		if (request.getParameter("pageNumber") != null)
		{
			// 페이지넘버 변수에 넘겨받은 페이지넘버 값을 담는다
			pageNumber = Integer.parseInt(request.getParameter("pageNumber")); 
		}
		
		// 공지 리스트 조회해서 모델 객체에 담기
		model.addAttribute("noticeList", dao.adminNoticeList(pageNumber));
		
		// 변경된 페이지 넘버를 모델 객체에 담기
		model.addAttribute("pageNumber", pageNumber);
		
		return "WEB-INF/views/adminViews/AdminNotice.jsp";
	}
	
	// 공지 숨김처리
	@RequestMapping(value="/noticehide.do", method=RequestMethod.GET)
	public String noticeDelete(VadminNoticeDTO dto)
	{
		IAdminNoticeDAO dao = adminSqlSession.getMapper(IAdminNoticeDAO.class);
		
		// 공지 숨김 메소드 호출
		dao.adminHideChange(dto.getNtHideCheck(), Integer.parseInt(dto.getNtCode()));
		
		return "redirect:adminnotice.do";
	}
	
	// 공지 등록
	@RequestMapping(value="/noticeinsert.do", method=RequestMethod.POST)
	public String noticeInsert(VadminNoticeDTO dto, HttpServletRequest request) throws IOException
	{
		IAdminNoticeDAO dao = adminSqlSession.getMapper(IAdminNoticeDAO.class);
		
		// 파일 업로드를 위한 환경설정
		
		
		
		// 최대 용량 (10MB)
		int maxSize  = 1024*1024*10;       
		 
	    // 업로드 폴더명
	    String uploadPath = request.getServletContext().getRealPath("/noticeAttach");
	    
	    File f = new File(uploadPath);
	    if (!f.exists())
	    {
	    	// 폴더가 존재하지 않으면 폴더 생성
	    	f.mkdirs();
	    }
	    
	    // 인코딩 방식
	    String encType="UTF-8";
	    
	    MultipartRequest multi = new MultipartRequest(request, uploadPath, maxSize, encType, new DefaultFileRenamePolicy());
        
		// 세션에서 관리자코드 얻어서 dto에 저장
 		HttpSession session = request.getSession();
 		
 		dto.setAdminCode((Integer)session.getAttribute("adminCode"));
 		
 		dto.setNtTitle(multi.getParameter("ntTitle"));
 		
 		// 개행을 위한 replace 처리
 		dto.setNtContent(multi.getParameter("ntContent").replaceAll("<br>", "\n"));
 		
 		if (multi.getFilesystemName("ntAttach")!=null)
		{
 			String ntAttach = multi.getFilesystemName("ntAttach");
 	        String fullPath = uploadPath + "/" + ntAttach;
 	        
 	        dto.setNtAttach(fullPath);
		}
 		else
 		{
 			dto.setNtAttach("");
 		}
 		
        
		// 공지 등록 메소드 호출
		dao.noticeInsert(dto);
		
		return "redirect:adminnotice.do";
	}
	
	// 공지사항 수정 (AJAX / JSON)
	@RequestMapping(value="/updatenotice.do", method=RequestMethod.POST)
	public String updateNoticeAjax(ModelMap model, int ntCode) throws JSONException
	{
		IAdminNoticeDAO dao = adminSqlSession.getMapper(IAdminNoticeDAO.class);
		
		// JASON 객체 / JASON 배열 객체 생성
		JSONObject jsonObj = new JSONObject();
		// JSONArray jsonArr = new JSONArray();
		
		// 숨김사유 및 처리자 조회
		VadminNoticeDTO dto = dao.noticeInfo(ntCode);
		
		// 제이슨 객체에 담기
		if (dto!=null)
		{
			jsonObj.put("ntTitle", dto.getNtTitle());
			jsonObj.put("ntContent", dto.getNtContent());
		}
		
		// 숨김사유 및 처리자 조회해서 model 객체에 담기
		model.addAttribute("result", jsonObj.toString());
		
		return "WEB-INF/views/adminViews/PublicAjaxPage.jsp";
	}
	
	// 공지 수정
	@RequestMapping(value="/noticeupdate.do", method=RequestMethod.GET)
	public String noticeUpdate(VadminNoticeDTO dto)
	{
		IAdminNoticeDAO dao = adminSqlSession.getMapper(IAdminNoticeDAO.class);
		
		// dto 객체 생성
		// VadminNoticeDTO dto = new VadminNoticeDTO();
		// dto.setNtTitle(ntTitle);
		
 		// 개행을 위한 replace 처리
 		dto.setNtContent(dto.getNtContent().replaceAll("<br>", "\n"));
 		
		// 공지 수정 메소드 호출
		dao.noticeUpdate(dto);
		
		return "redirect:adminnotice.do";
	}
	
	
	
	
	// 관리자 보험관리 페이지 요청
	@RequestMapping(value="/admininsurance.do", method=RequestMethod.GET)
	public String adminInsurance(ModelMap model)
	{
		IAdminInsuranceDAO dao = adminSqlSession.getMapper(IAdminInsuranceDAO.class);
		
		// 보험 정보를 조회하여 모델 객체에 담기
		// - 게스트 보험 약관
		model.addAttribute("guestInsuTerms", dao.guestInsuTerms());
		// - 호스트 보험 약관
		model.addAttribute("hostInsuTerms", dao.hostInsuTerms());
		// - 게스트 보험 비율
		model.addAttribute("guestInsuRate", dao.guestInsuRate());
		// - 호스트 보험 비율
		model.addAttribute("hostInsuRate", dao.hostInsuRate());
		// - 게스트 보험 정보
		model.addAttribute("guestInsu", dao.guestInsu());
		// - 호스트 보험 정보
		model.addAttribute("hostInsu", dao.hostInsu());
		
		
		return "WEB-INF/views/adminViews/AdminInsurance.jsp";
	}
	
	// 보험 내용 수정
	@RequestMapping(value="/insuranceupdate.do", method=RequestMethod.GET)
	public String insuranceUpdate(VinsuranceDTO dto, int select, HttpServletRequest request)
	{
		IAdminInsuranceDAO dao = adminSqlSession.getMapper(IAdminInsuranceDAO.class);
		
		// 세션에서 관리자번호 받아와서 dto에 담기
		HttpSession session = request.getSession();
		dto.setAdminCode((Integer)session.getAttribute("adminCode"));
		
		// dto 에 보험번호와 담기 
		dto.setIcode(select);
		
		// 개행을 위한 replace 처리
		dto.setIcontent(dto.getIcontent().replaceAll("<br>", "\n"));
		
		// 수정 메소드 호출
		dao.insuUpdate(dto);
		
		return "redirect:admininsurance.do";
	}
	
	// 보험 약관 수정
	@RequestMapping(value="/insurancetermsupdate.do", method=RequestMethod.GET)
	public String insuranceTermsUpdate(String termsContent, int select, HttpServletRequest request)
	{
		IAdminInsuranceDAO dao = adminSqlSession.getMapper(IAdminInsuranceDAO.class);
		
		// 매개변수로 전달할 dto 객체 생성
		TermsDTO dto = new TermsDTO();
		
		// 세션에서 관리자번호 받아와서 dto에 담기
		HttpSession session = request.getSession();
		dto.setAdminCode((Integer)session.getAttribute("adminCode"));
		
		// dto 에 약관번호와 내용 담기 
		dto.setTermsCode(select);
		dto.setTermsContent(termsContent);
		
		// 개행을 위한 replace 처리
		dto.setTermsContent(dto.getTermsContent().replaceAll("<br>", "\n"));
		
		// 수정 메소드 호출
		dao.insuTermsUpdate(dto);
		
		return "redirect:admininsurance.do";
	}
	
	// 보험료 비율 수정
	@RequestMapping(value="/insurancerateupdate.do", method=RequestMethod.GET)
	public String insuranceRateUpdate(int guestIRate, int hostIRate, HttpServletRequest request)
	{
		IAdminInsuranceDAO dao = adminSqlSession.getMapper(IAdminInsuranceDAO.class);
		
		// 매개변수로 넘길 dto 객체 생성
		VinsuranceDTO dto = new VinsuranceDTO();
		
		// 세션에서 관리자번호 받아와서 dto에 담기
		HttpSession session = request.getSession();
		dto.setAdminCode((Integer)session.getAttribute("adminCode"));
		
		// dto 에 [게스트] 약관번호와 보험비율 담아서 수정 메소드 호출
		dto.setIcode(1);
		dto.setIrate(guestIRate);
		dao.iRateUpdate(dto);
		
		// dto 에 [호스트] 약관번호와 보험비율 담아서 수정 메소드 호출
		dto.setIcode(2);
		dto.setIrate(hostIRate);
		dao.iRateUpdate(dto);
		
		return "redirect:admininsurance.do";
	}
	
	// 관리자 검증관리 페이지 요청
	@RequestMapping(value="/adminverification.do", method=RequestMethod.GET)
	public String adminVerification(ModelMap model, HttpServletRequest request)
	{
		IAVerificationDAO dao = adminSqlSession.getMapper(IAVerificationDAO.class);
		
		// 기본 페이지 넘버는 1
		int pageNumber = 1;
		
		// 페이지넘버를 넘겨받았다면
		if (request.getParameter("pageNumber") != null)
		{
			// 페이지넘버 변수에 넘겨받은 페이지넘버 값을 담는다
			pageNumber = Integer.parseInt(request.getParameter("pageNumber")); 
		}
		
		// 검증 목록 조회해서 모델 객체에 담기
		model.addAttribute("verificationList", dao.aVerificationList(pageNumber));
		
		// 변경된 페이지 넘버를 모델 객체에 담기
		model.addAttribute("pageNumber", pageNumber);
		
		return "WEB-INF/views/adminViews/AdminVerification.jsp";
	}
	
	
	// 검증 첨부파일 요청 AJAX
	@RequestMapping(value="/verifyattach.do", method=RequestMethod.POST)
	public String verifyAttach(ModelMap model, int reqvCode, HttpServletRequest request, HttpServletResponse response)
	{
		IAVerificationDAO dao = adminSqlSession.getMapper(IAVerificationDAO.class);
	
		// 검증 목록 조회해서 모델 객체에 담기
		model.addAttribute("result", dao.verificationAttach(reqvCode));
		
		return "WEB-INF/views/adminViews/PublicAjaxPage.jsp";
	}
	
	// 검증 첨부파일 다운로드
	@RequestMapping(value="/vattachdownload.do", method=RequestMethod.GET)
	public String vattachDownload(ModelMap model, HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		String verificationAttach = request.getParameter("verificationAttach");
		
		String savePath = "verificationAttach";
		
		// 파일의 실제 경로 얻기
		String realPath = request.getServletContext().getRealPath(savePath + "/" + verificationAttach);
		
		// 파일 다운로드를 위한 헤더 정보 수정 (파일이름 문자열 다시 인코딩)
		response.setHeader("Content-Disposition",
				"attachment;filename="+new String(verificationAttach.getBytes(), "ISO8859_1"));
		
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
	
	
	// 검증 시작 요청
	@RequestMapping(value="/verificationstart.do", method=RequestMethod.GET)
	public String verificationStart(ModelMap model, int reqvCode, HttpServletRequest request)
	{
		IAVerificationDAO dao = adminSqlSession.getMapper(IAVerificationDAO.class);
		
		// 세션에서 쿼리문에 필요한 관리자코드 얻어서 dto에 담기
		HttpSession session = request.getSession();
		int adminCode = (Integer)session.getAttribute("adminCode");
		
		// 메소드 호출에 필요한 객체 생성 및 속성구성
		VverificationDTO dto = new VverificationDTO();
		dto.setReqvCode(reqvCode);
		dto.setAdminCode(adminCode);
		
		
		// 검증 시작 메소드(해당 테이블에 인서트) 호출
		dao.startVerification(dto);
		
		return "redirect:adminverification.do";
	}
	
	// 검증 완료 요청
	@RequestMapping(value="/verificationcomplete.do", method=RequestMethod.GET)
	public String verificationStart(VverificationDTO dto,HttpServletRequest request)
	{
		IAVerificationDAO dao = adminSqlSession.getMapper(IAVerificationDAO.class);
		
		// 세션에서 쿼리문에 필요한 관리자코드 얻어서 dto에 담기
		HttpSession session = request.getSession();
		int adminCode = (Integer)session.getAttribute("adminCode");
		
		// 메소드 호출에 필요한 객체 생성 및 속성구성
		dto.setAdminCode(adminCode);
		dto.setVcode(dao.getVcode(dto.getReqvCode()));
		dto.setVcause(dto.getVcause().replaceAll("<br>", "\n"));
		
		// INSERT 메소드 호출
		dao.endVerification(dto);
		
		return "redirect:adminverification.do";
	}
	
	// 검증사유 요청 AJAX
	@RequestMapping(value="/verifycause.do", method=RequestMethod.POST)
	public String verifyCause(ModelMap model, int vcode)
	{
		IAVerificationDAO dao = adminSqlSession.getMapper(IAVerificationDAO.class);
		
		// 검증 목록 조회해서 모델 객체에 담기
		model.addAttribute("result", dao.verificationCause(vcode));
		
		return "WEB-INF/views/adminViews/PublicAjaxPage.jsp";
	}
	
	
	// 공지 첨부파일 다운로드
	@RequestMapping(value="ntattachdownload.do", method=RequestMethod.GET)
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
	
	// 결제관리 페이지 요청
	@RequestMapping(value="/adminbooking.do", method=RequestMethod.GET)
	public String adminBooking(ModelMap model, HttpServletRequest request)
	{
		IAdminPayListDAO dao = adminSqlSession.getMapper(IAdminPayListDAO.class);
		
		// 기본 페이지 넘버는 1
		int pageNumber = 1;
		
		// 페이지넘버를 넘겨받았다면
		if (request.getParameter("pageNumber") != null)
		{
			// 페이지넘버 변수에 넘겨받은 페이지넘버 값을 담는다
			pageNumber = Integer.parseInt(request.getParameter("pageNumber")); 
		}
		
		// 검증 목록 조회해서 모델 객체에 담기
		model.addAttribute("payList", dao.adminPayList(pageNumber));
				
		// 변경된 페이지 넘버를 모델 객체에 담기
		model.addAttribute("pageNumber", pageNumber);
		
		return "WEB-INF/views/adminViews/AdminBooking.jsp";
	}
	
	// 특정 숙소의 예약 내역 확인
	@RequestMapping(value="/paylistforroom.do", method=RequestMethod.GET)
	public String payListForRoom(ModelMap model, int rcode)
	{
		IAdminPayListDAO dao = adminSqlSession.getMapper(IAdminPayListDAO.class);
		
		// 검증 목록 조회해서 모델 객체에 담기
		model.addAttribute("payListForRoom", dao.adminRoomNumBooking(rcode));
		
		return "adminbooking.do";
	}
	
	// 특정 예약의 상세 내역
	@RequestMapping(value="/detailbooking.do", method=RequestMethod.GET)
	public String detailBooking(ModelMap model, int bcode, int rcode)
	{
		IAdminPayListDAO dao = adminSqlSession.getMapper(IAdminPayListDAO.class);
		
		// 검증 목록 조회해서 모델 객체에 담기
		model.addAttribute("detailBooking", dao.detailBooking(bcode));
		
		return "paylistforroom.do";
	}
	
	// 관리자의 예약 취소
	@RequestMapping(value="/admincancel.do", method=RequestMethod.GET)
	public String adminCancel(int bcode, HttpServletRequest request)
	{
		System.out.println(request.getParameter("bcode"));
		IAdminPayListDAO dao = adminSqlSession.getMapper(IAdminPayListDAO.class);
		
		// 세션에서 관리자 코드 얻어오기
		HttpSession session = request.getSession();
		int adminCode = (int)session.getAttribute("adminCode");
		
		// 예약 취소 신청 메소드 호출
		dao.requestCancel(bcode);
		
		// 생성된 cancelCode를 bcode 로 조회
		int cancelCode = dao.getCancelCode(bcode);
	
		// 예약 취소 메소드 호출(사유는 "관리자취소" 로 고정)
		dao.adminCancel(cancelCode, adminCode, "관리자 취소");
		
		
		// 환불 메소드 호출
		int refund = dao.detailBooking(bcode).getTotalFee();
		dao.refundList(cancelCode, refund);
		
		
		return "redirect:adminbooking.do";
	}
	
	// 숙소관리 페이지 요청
	@RequestMapping(value="/adminroom.do", method=RequestMethod.GET)
	public String adminRoom(ModelMap model, HttpServletRequest request)
	{
		IAdminRoomDAO dao = adminSqlSession.getMapper(IAdminRoomDAO.class);
		
		// 기본 페이지 넘버는 1
		int pageNumber = 1;
		
		// 페이지넘버를 넘겨받았다면
		if (request.getParameter("pageNumber") != null)
		{
			// 페이지넘버 변수에 넘겨받은 페이지넘버 값을 담는다
			pageNumber = Integer.parseInt(request.getParameter("pageNumber")); 
		}
		
		// 변경된 페이지 넘버를 모델 객체에 담기
		model.addAttribute("pageNumber", pageNumber);
		
		// 숙소리스트 조회해서 모델객체에 담기
		model.addAttribute("roomList", dao.adminRoomList(pageNumber));
		
		return "WEB-INF/views/adminViews/AdminRoom.jsp";
	}
	
	
	// 숙소 숨김 사유 조회 요청 (AJAX/JSON)
	@RequestMapping(value="/hidecauseajax.do", method=RequestMethod.POST)
	public String hideCause(ModelMap model, int rcode) throws JSONException
	{
		IAdminRoomDAO dao = adminSqlSession.getMapper(IAdminRoomDAO.class);
		
		// JASON 객체 / JASON 배열 객체 생성
		JSONObject jsonObj = new JSONObject();
		// JSONArray jsonArr = new JSONArray();
		
		// 숨김사유 및 처리자 조회
		VadminRoomDTO dto = dao.hideRoomCause(rcode);
		
		// 제이슨 객체에 담기
		if (dto!=null)
		{
			jsonObj.put("hideCause", dto.getHideCause());
			jsonObj.put("adminId", dto.getAdminId());
		}
		
		// 숨김사유 및 처리자 조회해서 model 객체에 담기
		model.addAttribute("result", jsonObj.toString());
		
		return "WEB-INF/views/adminViews/PublicAjaxPage.jsp";
	}
	
	// 숨김상태 변경
	@RequestMapping(value="/changehidestate.do", method=RequestMethod.GET)
	public String adminRoom(VadminRoomDTO dto, String changeTo, HttpServletRequest request)
	{
		IAdminRoomDAO dao = adminSqlSession.getMapper(IAdminRoomDAO.class);
		
		// 해당 숙소 숨김상태 변경하기
		if (changeTo.equals("hide"))			// 공개면 비공개로 바꾸기
		{
			// 세션에서 관리자코드 얻어오기
			HttpSession session = request.getSession();
			int adminCode = (int)session.getAttribute("adminCode");
			dto.setHideCause(dto.getHideCause().replaceAll("<br>", "\n"));
			// dto 객체 생성해서 속성구성 (rcode와 hideCause 는 파라미터로 넘어오기 때문에 설정되어 있음)
			dto.setAdminCode(adminCode);
			
			dao.hideRoom(dto);
		}
		else if (changeTo.equals("noHide"))	// 비공개면 공개로 바꾸기
		{
			dao.noHideRoom(dto.getRcode());
		}
		
		return "redirect:adminroom.do";
	}
	
	// 숙소 후기/문의 상세조회
	@RequestMapping(value="/adminroomdetail.do", method=RequestMethod.GET)
	public String roomDetail(ModelMap model, int rcode)
	{
		IAdminRoomDAO dao = adminSqlSession.getMapper(IAdminRoomDAO.class);
		
		// 숙소 배너 정보를 조회하여 모델 객체에 담기 
		model.addAttribute("roomBanner", dao.roomBanner(rcode));
		
		// 해당 숙소의 리뷰목록을 조회하여 모델 객체에 담기
		model.addAttribute("reviewList", dao.roomReviewList(rcode));
		
		// 해당 숙소의 문의목록을 조회하여 모델 객체에 담기
		model.addAttribute("questionList", dao.roomQuestionList(rcode));
		
		return "adminroom.do";
	}
	
	// 숙소후기 숨김 사유 조회 요청 (AJAX/JSON)
	@RequestMapping(value="/revcauseajax.do", method=RequestMethod.POST)
	public String revHideCause(ModelMap model, int revCode) throws JSONException
	{
		IAdminRoomDAO dao = adminSqlSession.getMapper(IAdminRoomDAO.class);
		
		// JASON 객체 / JASON 배열 객체 생성
		JSONObject jsonObj = new JSONObject();
		// JSONArray jsonArr = new JSONArray();
		
		// 숨김사유 및 처리자 조회
		VadminRoomDTO dto = dao.roomHideCause(revCode);
		
		// 제이슨 객체에 담기
		if (dto!=null)
		{
			jsonObj.put("hideCause", dto.getHideCause());
			jsonObj.put("adminId", dto.getAdminId());
		}
		
		// 제이슨 객체 model 객체에 담기
		model.addAttribute("result", jsonObj.toString());
		
		return "WEB-INF/views/adminViews/PublicAjaxPage.jsp";
	}
	
	
	// 숙소후기 숨김 사유 조회 요청 (AJAX/JSON)
	@RequestMapping(value="/revcontentajax.do", method=RequestMethod.POST)
	public String roomReview(ModelMap model, int revCode) throws JSONException
	{
		IAdminRoomDAO dao = adminSqlSession.getMapper(IAdminRoomDAO.class);
		
		// JASON 객체 / JASON 배열 객체 생성
		JSONObject jsonObj = new JSONObject();
		// JSONArray jsonArr = new JSONArray();
		
		// 숨김사유 및 처리자 조회
		VadminRoomDTO dto = dao.roomReview(revCode);
		
		// 제이슨 객체에 담기
		if (dto!=null)
		{
			jsonObj.put("revContent", dto.getRevContent());
			jsonObj.put("revTitle", dto.getRevTitle());
		}
		
		// 제이슨 객체 model 객체에 담기
		model.addAttribute("result", jsonObj.toString());
		
		return "WEB-INF/views/adminViews/PublicAjaxPage.jsp";
	}
	
	// 숙소 문의내용 조회 요청 (AJAX/JSON)
	@RequestMapping(value="/rqstcontentajax.do", method=RequestMethod.POST)
	public String roomQstContent(ModelMap model, int rqstCode) throws JSONException
	{
		IAdminRoomDAO dao = adminSqlSession.getMapper(IAdminRoomDAO.class);
		
		// JASON 객체 / JASON 배열 객체 생성
		JSONObject jsonObj = new JSONObject();
		// JSONArray jsonArr = new JSONArray();
		
		// 숙소문의 제목 및 내용 조회
		VadminRoomDTO dto = dao.roomQuestion(rqstCode);
		
		// 제이슨 객체에 담기
		if (dto!=null)
		{
			jsonObj.put("rqstContent", dto.getRqstContent());
			jsonObj.put("rqstTitle", dto.getRqstTitle());
		}
		
		// 제이슨 객체 model 객체에 담기
		model.addAttribute("result", jsonObj.toString());
		
		return "WEB-INF/views/adminViews/PublicAjaxPage.jsp";
	}
	
	// 숙소 문의 답변 조회 요청 (AJAX)
	@RequestMapping(value="/rqstanswerajax.do", method=RequestMethod.POST)
	public String roomQstAnswer(ModelMap model, int rqstCode) throws JSONException
	{
		IAdminRoomDAO dao = adminSqlSession.getMapper(IAdminRoomDAO.class);
		
		// 문의 답변 조회해서 model 객체에 담기
		model.addAttribute("result", dao.roomQuestionAnswer(rqstCode));
		
		return "WEB-INF/views/adminViews/PublicAjaxPage.jsp";
	}
	
	// 숙소 문의내용 조회 요청 (AJAX/JSON)
	@RequestMapping(value="/rqstcauseajax.do", method=RequestMethod.POST)
	public String roomQstHideCause(ModelMap model, int rqstCode) throws JSONException
	{
		IAdminRoomDAO dao = adminSqlSession.getMapper(IAdminRoomDAO.class);
		
		// JASON 객체 / JASON 배열 객체 생성
		JSONObject jsonObj = new JSONObject();
		// JSONArray jsonArr = new JSONArray();
		
		// 숙소문의 제목 및 내용 조회
		VadminRoomDTO dto = dao.roomQstHideCause(rqstCode);
		
		// 제이슨 객체에 담기
		if (dto!=null)
		{
			jsonObj.put("hideCause", dto.getHideCause());
			jsonObj.put("adminId", dto.getAdminId());
		}
		
		// 제이슨 객체 model 객체에 담기
		model.addAttribute("result", jsonObj.toString());
		
		return "WEB-INF/views/adminViews/PublicAjaxPage.jsp";
	}
	
	
	// 숨김상태 변경
	@RequestMapping(value="/changerqsthidestate.do", method=RequestMethod.GET)
	public String changeRqstHideState(VadminRoomDTO dto, String changeTo, HttpServletRequest request)
	{
		IAdminRoomDAO dao = adminSqlSession.getMapper(IAdminRoomDAO.class);
		
		// 해당 숙소 숨김상태 변경하기
		if (changeTo.equals("hide"))			// 공개면 비공개로 바꾸기
		{
			// 세션에서 관리자코드 얻어오기
			HttpSession session = request.getSession();
			int adminCode = (int)session.getAttribute("adminCode");
			dto.setHideCause(dto.getHideCause().replaceAll("<br>", "\n"));
			
			// dto 객체 생성해서 속성구성 (rqstCode와 hideCause 는 파라미터로 넘어오기 때문에 설정되어 있음)
			dto.setAdminCode(adminCode);
			
			dao.rqstHide(dto);
			
		}
		else if (changeTo.equals("noHide"))	// 비공개면 공개로 바꾸기
		{
			dao.noRqstHide(dto.getRqstCode());
		}
		
		return "redirect:adminroom.do";
	}
	
	// 관리자 아이디 중복 검사 (AJAX)
	@RequestMapping(value="/checkadminid.do", method=RequestMethod.POST)
	public String checkAdminId(ModelMap model, String adminId)
	{
		IAdminDAO dao = adminSqlSession.getMapper(IAdminDAO.class);
		
		// 검증 목록 조회해서 모델 객체에 담기
		model.addAttribute("result", dao.duplicateAdminId(adminId));
		
		return "WEB-INF/views/adminViews/PublicAjaxPage.jsp";
	}
	
	// 관리자 로그인 아이디/패스워드 확인
	@RequestMapping(value = "/checkadmin.do", method = RequestMethod.POST)
	public String checkAdmin(ModelMap model, AdminDTO dto)
	{
		IAdminDAO dao = adminSqlSession.getMapper(IAdminDAO.class);

		model.addAttribute("result", dao.adminLogin(dto));

		return "WEB-INF/views/adminViews/PublicAjaxPage.jsp";
	}
	
	// 관리자 등록
	@RequestMapping(value="/addAdmin.do", method=RequestMethod.POST)
	public String addAdmin(ModelMap model, VadminDTO dto)
	{
		IAdminDAO dao = adminSqlSession.getMapper(IAdminDAO.class);
		
		// 관리자 등록 메소드 호출
		dao.adminAdd(dto);
		
		// 등록된 관리자코드 가져와서 변수에 담기
		int adminCode = dao.getAdminCode(dto.getAdminId());
		
		// 하나의 문자열로 넘어온 관리자 권한 배열에 나눠 담기
		String atCodes[] = dto.getAtNames().split(", ");
		
		// 권한 등록 메소드 호출
		for (int i=0; i<atCodes.length; i++)
		{
			dao.adminAtAdd(adminCode, Integer.parseInt(atCodes[i]));
		}
		
		return "redirect:adminlist.do";
	}
	
	// 관리자 정보 수정 (AJAX/JSON)
	@RequestMapping(value="/updateadmininfo.do", method=RequestMethod.POST)
	public String updateAdminInfoAjax(ModelMap model, int adminCode) throws JSONException
	{
		IAdminDAO dao = adminSqlSession.getMapper(IAdminDAO.class);
		
		// JASON 객체 / JASON 배열 객체 생성
		JSONObject jsonObj = new JSONObject();
		// JSONArray jsonArr = new JSONArray();
		
		// 숨김사유 및 처리자 조회
		VadminDTO dto = dao.adminInfo(adminCode);
		
		// 제이슨 객체에 담기
		if (dto!=null)
		{
			jsonObj.put("adminId", dto.getAdminId());
			jsonObj.put("adminName", dto.getAdminName());
			jsonObj.put("adminAtCodes", dto.getAtCodes());
			jsonObj.put("adminCode", dto.getAdminCode());
		}
		
		// 숨김사유 및 처리자 조회해서 model 객체에 담기
		model.addAttribute("result", jsonObj.toString());
		
		return "WEB-INF/views/adminViews/PublicAjaxPage.jsp";
	}
	
	// 관리자 수정
	@RequestMapping(value="/updateadmin.do", method=RequestMethod.POST)
	public String updateAdmin(ModelMap model, VadminDTO dto)
	{
		IAdminDAO dao = adminSqlSession.getMapper(IAdminDAO.class);
		
		// 관리자 등록 메소드 호출
		dao.adminModify(dto);
		
		// 등록된 관리자코드 가져와서 변수에 담기
		int adminCode = dao.getAdminCode(dto.getAdminId());
		
		// 하나의 문자열로 넘어온 관리자 권한 배열에 나눠 담기
		String atCodes[] = dto.getAtNames().split(", ");
		
		// 해당 관리자의 기존 권한 지우고 새로 등록
		dao.adminAtRemove(adminCode);
		for (int i=0; i<atCodes.length; i++)
		{
			dao.adminAtAdd(adminCode, Integer.parseInt(atCodes[i]));
		}
		
		return "redirect:adminlist.do";
	}
	
	
	// 관리자 통계관리 페이지 요청
	@RequestMapping(value="/adminstatistics.do", method=RequestMethod.GET)
	public String adminStatistics(ModelMap model)
	{
		IAdminStatisticsDAO dao = adminSqlSession.getMapper(IAdminStatisticsDAO.class);
		
		// 여러 통계치 조회해서 모델 객체에 담기
		model.addAttribute("yesterdaySales", dao.yesterdaySales());
		model.addAttribute("newMemberCount", dao.newMemberCount());
		model.addAttribute("newRoomCount", dao.newRoomCount());
		model.addAttribute("salesRate", dao.salesRate());
		model.addAttribute("recentSales", dao.recentSales());
		model.addAttribute("thisMonthSales", dao.thisMonthSales());
		model.addAttribute("ageGroupCount", dao.ageGroupCount());
		model.addAttribute("etqMemCount", dao.etqMemCount());
		model.addAttribute("memCateCount", dao.memCateCount());
		model.addAttribute("memGenderCount", dao.memGenderCount());
		
		return "WEB-INF/views/adminViews/AdminStatistics.jsp";
	}
	
	
	// 회원 신분증 사본 다운로드
	@RequestMapping(value="idcarddownload.do", method=RequestMethod.GET)
	public String idcardDownload(ModelMap model, HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		String idcard = request.getParameter("idcard");
		String savePath = "idCard";
		
		// 파일의 실제 경로 얻기
		String realPath = request.getServletContext().getRealPath(savePath + "/" + idcard);
		
		// 파일 다운로드를 위한 헤더 정보 수정 (파일이름 문자열 다시 인코딩)
		response.setHeader("Content-Disposition",
				"attachment;filename="+new String(idcard.getBytes(), "ISO8859_1"));
		
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
	
	
	// 회원정보 수정 (AJAX/JSON)
	@RequestMapping(value="/memberinfo.do", method=RequestMethod.POST)
	public String updateMemInfo(ModelMap model, int memCode) throws JSONException
	{
		IAdminMemberDAO dao = adminSqlSession.getMapper(IAdminMemberDAO.class);
		
		// JASON 객체 / JASON 배열 객체 생성
		JSONObject jsonObj = new JSONObject();
		// JSONArray jsonArr = new JSONArray();
		
		// 숨김사유 및 처리자 조회
		VMemberDTO dto = dao.aMemCodeSearch(memCode);
		
		// 제이슨 객체에 담기
		if (dto!=null)
		{
			jsonObj.put("memCode", memCode);
			jsonObj.put("memId", dto.getMemId());
			jsonObj.put("memName", dto.getMemName());
			jsonObj.put("memSsn", dto.getMemSsn());
			jsonObj.put("memTel", dto.getMemTel());
			jsonObj.put("memEmail", dto.getMemEmail());
			jsonObj.put("memEtiquette", dto.getMemEtiquette());
		}
		
		// 숨김사유 및 처리자 조회해서 model 객체에 담기
		model.addAttribute("result", jsonObj.toString());
		
		return "WEB-INF/views/adminViews/PublicAjaxPage.jsp";
	}
	
	
	// 회원 정보 수정
	@RequestMapping(value="updatememinfo.do", method=RequestMethod.POST)
	public String updateMemInfo(ModelMap model, VMemberDTO dto)
	{
		IAdminMemberDAO dao = adminSqlSession.getMapper(IAdminMemberDAO.class);
		
		dao.updateMemInfo(dto);
		
		return "redirect:amemberlist.do";
	}
	
	// 회원 영구정지 시키기
	@RequestMapping(value="blockmember.do", method=RequestMethod.POST)
	public String blockMember(VMemberDTO dto, HttpServletRequest request)
	{
		IAdminMemberDAO dao = adminSqlSession.getMapper(IAdminMemberDAO.class);
		
		// 세션에서 관리자코드 얻어와 dto에 담기
		HttpSession session = request.getSession();
		dto.setAdminCode((int)session.getAttribute("adminCode"));
		
		// 개행처리
		dto.setBlockCause(dto.getBlockCause().replaceAll("<br>", "\n"));
		
		// 영구정지 메소드 호출
		dao.blockMember(dto);
		
		return "redirect:amemberlist.do";
	}
	
	
	// 영구정지 사유 및 처리자 조회
	@RequestMapping(value="/checkblockcause.do", method=RequestMethod.POST)
	public String checkBlockCause(ModelMap model, int memCode) throws JSONException
	{
		IAdminMemberDAO dao = adminSqlSession.getMapper(IAdminMemberDAO.class);
		
		// JASON 객체 / JASON 배열 객체 생성
		JSONObject jsonObj = new JSONObject();
		// JSONArray jsonArr = new JSONArray();
		
		// 정지사유 및 처리자 조회
		VMemberDTO dto = dao.checkBlockCause(memCode);
		
		// 제이슨 객체에 담기
		if (dto!=null)
		{
			jsonObj.put("blockCause", dto.getBlockCause());
			jsonObj.put("adminId", dto.getAdminId());
		}
		
		// 숨김사유 및 처리자 조회해서 model 객체에 담기
		model.addAttribute("result", jsonObj.toString());
		
		return "WEB-INF/views/adminViews/PublicAjaxPage.jsp";
	}
	
	// 영구정지 복구
	@RequestMapping(value="restoreblock.do", method=RequestMethod.GET)
	public String restoreBlock(int memCode)
	{
		IAdminMemberDAO dao = adminSqlSession.getMapper(IAdminMemberDAO.class);
		
		// 영구정지 복구 메소드 호출
		dao.restoreBlock(memCode);
		
		return "redirect:amemberlist.do";
	}
	
	// 탈퇴계정 복구
	@RequestMapping(value="restoreleave.do", method=RequestMethod.GET)
	public String restoreLeave(int memCode)
	{
		IAdminMemberDAO dao = adminSqlSession.getMapper(IAdminMemberDAO.class);
		
		// 영구정지 복구 메소드 호출
		dao.restoreLeave(memCode);
		
		// 탈퇴테이블 레코드 제거 메소드 호출
		dao.deleteLeaveRecord(memCode);
		
		return "redirect:amemberlist.do";
	}
	
	
	
	
	
}
