package report.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import report.model.ReportBean;
import report.model.ReportDao;
import utility.Paging;

@Controller
public class ReportListController {
	private final String command = "/list.report";
	private final String gotoPage = "reportListAdmin";
	
	@Autowired
	private ReportDao reportDao;
	
	@RequestMapping(command)
	public String doAction(Model model,
													@RequestParam(value = "whatColumn", required = false) String whatColumn,
													@RequestParam(value = "keyword", required = false) String keyword,
													@RequestParam(value = "pageNumber", required = false) String pageNumber,
													HttpServletRequest request) {
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("whatColumn", whatColumn);
		map.put("keyword", "%" + keyword + "%");
		
		int totalCount = reportDao.getTotalCount(map);
		String url = request.getContextPath() + command;
		
		Paging pageInfo = new Paging(pageNumber, null, totalCount, url, whatColumn, keyword);
		
		List<ReportBean> reportLists = reportDao.getAllReport(map, pageInfo);
		
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("reportLists", reportLists);
		
		return gotoPage;
	}
}
