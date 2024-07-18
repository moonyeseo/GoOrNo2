package report.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import report.model.ReportBean;
import report.model.ReportDao;

@Controller
public class ReportInsertController {
	private final String command = "/insert.report";
	private final String gotoPage = "reportInsert";
	
	@Autowired
	private ReportDao reportDao;
	
	@RequestMapping(value = command, method = RequestMethod.GET)
	public String doAction(@RequestParam("board_no") int board_no, @RequestParam("subject") String subject ,Model model) {
		
		model.addAttribute("board_no", board_no);
		model.addAttribute("subject", subject);
		
		return gotoPage;
	}
	
	@RequestMapping(value = command, method = RequestMethod.POST)
	public String doAction(@ModelAttribute("report") ReportBean report, BindingResult result ,Model model, HttpServletResponse response) {
		
		model.addAttribute("board_no", report.getBoard_no());
		model.addAttribute("subject", report.getSubject());
		
		int cnt = -1;
		cnt = reportDao.insertReport(report);
		
		if(cnt > 0) {
			model.addAttribute("close", "close"); // �Ű� insert ���� �� close �ȿ� 'close' �����ؼ� �ٽ� �˾�â����
		}
		
		return gotoPage;
	}
}
