package report.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import report.model.ReportBean;
import report.model.ReportDao;

@Controller
public class ReportDetailController {
	private final String command = "/detail.report";
	private final String gotoPage = "reportDetailAdmin";
	
	@Autowired
	private ReportDao reportDao;
	
	@RequestMapping(command)
	public String doAction(@RequestParam("board_no") int board_no,
													@RequestParam("re_no") int re_no, 
													@RequestParam("user_no") int user_no,
													Model model,
													@RequestParam(value = "whatColumn") String whatColumn,
													@RequestParam(value = "keyword") String keyword,
													@RequestParam(value = "pageNumber") String pageNumber) {
		
		ReportBean rb = new ReportBean();
		rb.setBoard_no(board_no);
		rb.setRe_no(re_no);
		rb.setUser_no(user_no);

		ReportBean report = reportDao.getReport(rb);
		reportDao.updateCheck(re_no);
		
		model.addAttribute("report", report);
		
		model.addAttribute("pageNumber", pageNumber);
		model.addAttribute("whatColumn", whatColumn);
		model.addAttribute("keyword", keyword);
		
		return gotoPage;
	}
}
