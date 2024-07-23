package event.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import event.model.EventBean;
import event.model.EventDao;
import users.model.UsersBean;

@Controller
public class EventInsertController {
	private final String command = "/insert.event";
	private final String getPage = "eventInsert";
	private final String gotoPage = "redirect:/AdminList.event";

	@Autowired
	EventDao edao;

	@Autowired
	ServletContext servletContext;

	// AdminList 등록 클릭 시
	@RequestMapping(value = command, method = RequestMethod.GET)
	public String insertForm(@RequestParam(value = "whatColumn", required = false) String whatColumn,
			@RequestParam(value = "keyword", required = false) String keyword,
			@RequestParam(value = "pageNumber", required = false) String pageNumber, HttpSession session, Model model) {
		UsersBean mb = (UsersBean) session.getAttribute("loginInfo");
		
		// 로그인 x
		if (mb == null) {
			model.addAttribute("keyword", keyword);
			model.addAttribute("pageNumber", pageNumber);
			model.addAttribute("whatColumn", whatColumn);

			String destination = "redirect:/insert.event?pageNumber=" + pageNumber + "&whatColumn=" + whatColumn
					+ "&keyword=" + keyword;
			session.setAttribute("destination", destination);
			return "redirect:/login.users";
		} else if (!"admin".equals(mb.getId())) {
			return gotoPage;
		}
		return getPage;
	}

	// 레코드 등록
	@RequestMapping(value = command, method = RequestMethod.POST)
	public ModelAndView insert(@ModelAttribute("event") @Valid EventBean event, BindingResult result,
			@RequestParam(value = "whatColumn", required = false) String whatColumn,
			@RequestParam(value = "keyword", required = false) String keyword,
			@RequestParam(value = "pageNumber", required = false) String pageNumber, HttpServletResponse response) {
		System.out.println("event post");
		System.out.println("event.getFimg():" + event.getFimg()); // null
		System.out.println("event.getUpload():" + event.getUpload());
		System.out.println("event.getTitle():" + event.getTitle());
		System.out.println("장소 : " + event.getPerformance_type());

		MultipartFile multi = event.getUpload();

		String uploadPath = servletContext.getRealPath("/resources/uploadImage/");
		System.out.println("uploadPath : " + uploadPath);

		ModelAndView mav = new ModelAndView();

		if (result.hasErrors()) {
			mav.addObject("whatColumn", whatColumn);
			mav.addObject("keyword", keyword);
			mav.addObject("pageNumber", pageNumber);
			mav.addObject("event", event);
			System.err.println(event.getTitle());
			System.out.println("fail");
			mav.setViewName(getPage);

			return mav;
		}

		int cnt = -1;
		cnt = edao.insertFimg(event);
		if (cnt != -1) {
			mav.setViewName(gotoPage);

			File destination = new File(uploadPath + File.separator + multi.getOriginalFilename());
			try {
				multi.transferTo(destination);
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		} else {
			mav.addObject("whatColumn", whatColumn);
			mav.addObject("keyword", keyword);
			mav.addObject("pageNumber", pageNumber);
			mav.addObject("event", event);
			System.out.println("in");
			mav.setViewName(getPage);
		}

		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		if(cnt > 0) {
			mav.addObject("isSuccess", "yes");
			mav.setViewName(getPage);
		}else {
			out.append("<script>alert('행사 정보 등록 실패했습니다.')</script>");
		}
		
		out.flush();
		return mav;
	}
}