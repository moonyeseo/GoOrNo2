package event.controller;

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
            @RequestParam(value = "keyword", required = false) String keyword) {

    	ModelAndView mav = new ModelAndView();
    	
        if (result.hasErrors()) {
        	mav.addObject("whatColumn", whatColumn);
        	mav.addObject("keyword", keyword);
        	mav.addObject("pageNumber", pageNumber);
        	mav.addObject("event", event);
        	mav.setViewName(getPage);

            return mav;
        }

        edao.updateEvent(event);
        mav.addObject("whatColumn", whatColumn);
    	mav.addObject("keyword", keyword);
    	mav.addObject("pageNumber", pageNumber);
    	mav.addObject("event", event);
    	mav.setViewName(gotoPage);
    	
    	return mav;
    }
}
