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
public class EventUpdateController {
	// 관리자
    private final String command = "update.event";
    private final String getPage = "eventUpdateForm";
    private final String gotoPage = "redirect:/AdminList.event";
    private final String mainPage = "redirect:/AdminDetail.event";

    @Autowired
    EventDao edao;
    
    @Autowired
	ServletContext servletContext;

    // 관리자 상세보기 수정 클릭 시, GET
    @RequestMapping(value = command, method = RequestMethod.GET)
    public String updateForm(@RequestParam("eventNo") int eventNo,
            @RequestParam(value = "whatColumn", required = false) String whatColumn,
            @RequestParam(value = "pageNumber", required = false) String pageNumber,
            @RequestParam(value = "keyword", required = false) String keyword, HttpSession session, Model model) {

        UsersBean mb = (UsersBean) session.getAttribute("loginInfo");

       // 로그인 x
        if (mb == null) {
            String destination = "redirect:/update.event?eventNo=" + eventNo + "&pageNumber=" + pageNumber
                    + "&whatColumn=" + whatColumn + "&keyword=" + keyword;
            session.setAttribute("destination", destination);
            return "redirect:/login.users";
        } else if (!"admin".equals(mb.getId())) {
            return mainPage;
        }

        EventBean event = edao.getEventByEventNo(eventNo);
        model.addAttribute("event", event);
        model.addAttribute("whatColumn", whatColumn);
        model.addAttribute("keyword", keyword);
        model.addAttribute("eventNo", eventNo);
        model.addAttribute("pageNumber", pageNumber);

        return getPage;
    }

    // 업뎃폼 수정 클릭 시, POST 
    @RequestMapping(value = command, method = RequestMethod.POST)
    public ModelAndView update(
    		@ModelAttribute("event")
            @Valid EventBean event, BindingResult result,
            @RequestParam(value = "whatColumn", required = false) String whatColumn,
            @RequestParam(value = "pageNumber", required = false) String pageNumber,
            @RequestParam(value = "keyword", required = false) String keyword, HttpServletResponse response) {
    	ModelAndView mav = new ModelAndView();
    	
        if (result.hasErrors()) {
        	mav.addObject("whatColumn", whatColumn);
        	mav.addObject("keyword", keyword);
        	mav.addObject("pageNumber", pageNumber);
        	mav.addObject("event", event);
        	mav.setViewName(getPage);
        	if (event.getFimg() == null || event.getFimg().equals("")) {
                event.setFimg(event.getUpload2());
            }
            return mav;
        }
        int cnt = -1;
        cnt = edao.updateEvent(event);
        
        
        mav.addObject("whatColumn", whatColumn);
    	mav.addObject("keyword", keyword);
    	mav.addObject("pageNumber", pageNumber);
    	mav.addObject("event", event);
    	mav.setViewName(gotoPage);
    	MultipartFile multi = event.getUpload();
    	String uploadPath = servletContext.getRealPath("/resources/uploadImage/");
    	
    	if(cnt != -1 && multi != null && !multi.isEmpty()) {
    		System.out.println("test");
    		String deletePath = servletContext.getRealPath("/resources/uploadImage/");
    		File file = new File(deletePath + File.separator + event.getUpload2());
    		System.out.println("File : " + file);
    		
    		if(file.exists()) {
    			file.delete();
    		}
    		
    		mav.setViewName(gotoPage);
    		File destination = new File(uploadPath + File.separator + multi.getOriginalFilename());
    		try {
    			multi.transferTo(destination);
    		} catch (IllegalStateException e) {
    			e.printStackTrace();
    		} catch (IOException e) {
    			e.printStackTrace();
    		}
    	}
    	
    	else {
    		mav.setViewName(getPage);
    	}
    	
    	mav.addObject("whatColumn", whatColumn);
    	mav.addObject("keyword", keyword);
    	mav.addObject("pageNumber", pageNumber);
    	mav.addObject("event", event);
    	
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		if(cnt > 0) {
			out.append("<script>alert('행사 정보가 수정되었습니다.')</script>");
	    	mav.addObject("isUpdate", "yes");
	    	
		}else {
			out.append("<script>alert('행사 정보 수정 실패했습니다.')</script>");
		}
		
		out.flush();
    	mav.setViewName(getPage);
    	return mav;
    }
}
