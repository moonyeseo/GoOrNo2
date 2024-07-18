package report.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import report.model.ReportDao;

@Controller
public class ReportDeleteController {
	private final String command = "/delete.report";
	private final String gotoPage = "redirect:/list.report";
	
	@Autowired
	private ReportDao reportDao;
	
	@RequestMapping(command)
	public String doAction(@RequestParam(value = "re_no") int re_no,
													@RequestParam(value = "whatColumn", required = false) String whatColumn,
													@RequestParam( value = "keyword", required = false) String keyword,
													@RequestParam(value = "pageNumber", required = false) String pageNumber,
													Model model) {
		
		reportDao.deleteReport(re_no);
		
		model.addAttribute("pageNumber", pageNumber);
		model.addAttribute("whatColumn", whatColumn);
		model.addAttribute("keyword", keyword);
		
		return gotoPage;
	}
}
