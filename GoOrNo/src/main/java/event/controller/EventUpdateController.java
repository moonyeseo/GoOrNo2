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
	// 행사 수정
    private final String command = "update.event";
    private final String getPage = "eventUpdateForm";
    private final String gotoPage = "redirect:/list.event";
    private final String mainPage = "redirect:/main.jsp";

    @Autowired
    EventDao edao;

    // 상세 수정 클릭 시, GET
    @RequestMapping(value = command, method = RequestMethod.GET)
    public String updateForm(@RequestParam("eventNo") int eventNo,
            @RequestParam(value = "whatColumn", required = false) String whatColumn,
            @RequestParam(value = "pageNumber", required = false) String pageNumber,
            @RequestParam(value = "keyword", required = false) String keyword, HttpSession session, Model model) {

        UsersBean mb = (UsersBean) session.getAttribute("loginInfo");

        // 로그인 여부 확인
        if (mb == null) {
            // 로그인하지 않은 경우 로그인 페이지로 리다이렉트
            String destination = "redirect:/update.event?eventNo=" + eventNo + "&pageNumber=" + pageNumber
                    + "&whatColumn=" + whatColumn + "&keyword=" + keyword;
            session.setAttribute("destination", destination);
            return "redirect:/login.users";
        } else if (!"admin".equals(mb.getId())) {
            // 로그인했지만 관리자가 아닌 경우 메인으로 이동
            return mainPage;
        }

        // 이벤트 정보 조회
        EventBean event = edao.getEventByEventNo(eventNo);
        model.addAttribute("event", event);
        model.addAttribute("whatColumn", whatColumn);
        model.addAttribute("keyword", keyword);
        model.addAttribute("eventNo", eventNo);
        model.addAttribute("pageNumber", pageNumber);

        return getPage;
    }

    // 수정버튼 클릭 시, POST 요청
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
