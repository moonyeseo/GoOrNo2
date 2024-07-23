package event.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import event.model.EventBean;
import event.model.EventDao;
import utility.Paging;

@Controller
public class EventAdminListController {
	// ������ ����Ʈ
	private final String command = "/AdminList.event";
	private final String getPage = "../../mainAdmin";

	@Autowired
	private EventDao edao;

	@RequestMapping(command)
	public String list(
			@RequestParam(value="isAdmin", required = false) String isAdmin,
			@RequestParam(value = "whatColumn", required = false) String whatColumn,
			@RequestParam(value = "pageNumber", required = false) String pageNumber,
			@RequestParam(value = "keyword", required = false) String keyword, HttpServletRequest request,
			HttpSession session, Model model) {
		
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("whatColumn", whatColumn);
		map.put("keyword", "%" + keyword + "%");
		
		System.out.println(whatColumn + "/" + keyword);

		int totalCount = edao.getTotalCount(map);

		String url = request.getContextPath() + this.command;
		Paging pageInfo = new Paging(pageNumber, null, totalCount, url, whatColumn, keyword);
		
		// ��� ��ȸ
		List<EventBean> lists = edao.getAllEvents(map, pageInfo);
		
		// ����
		List<String> performanceTypeList = edao.getPerformanceType();
		model.addAttribute("whatColumn", whatColumn);
		model.addAttribute("keyword", keyword);
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("pageNumber", pageNumber);
		model.addAttribute("lists", lists);
		model.addAttribute("performanceTypeList", performanceTypeList);
		
		model.addAttribute("eventListFlag", true);
		
		return getPage;
	}
}