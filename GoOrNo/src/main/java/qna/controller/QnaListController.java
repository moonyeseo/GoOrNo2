package qna.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import qna.model.QnaBean;
import qna.model.QnaDao;
import utility.Paging;

@Controller
public class QnaListController {
	private final String command = "list.qna";
	private final String getPage = "qnaList";
	
	@Autowired
	QnaDao qnaDao;
	
	@RequestMapping(value=command)
	public String list(
			Model model,
			HttpServletRequest request,
			@RequestParam(value="isAdmin", required = false) String isAdmin,
			@RequestParam(value="pageNumber", required = false) String pageNumber,
			@RequestParam(value="whatColumn", required = false) String whatColumn,
			@RequestParam(value="keyword", required = false) String keyword
			) {
		Map<String,String> map = new HashMap<String,String>();
		map.put("keyword", "%"+keyword+"%");
		map.put("whatColumn", whatColumn);
		
		System.out.println(whatColumn+"/"+keyword);
		
		//사용자 페이지의 경우 질문글+답글 전부 띄움
		if( isAdmin == null) {
			int totalCount = qnaDao.getTotalCount(map);
			String url = request.getContextPath()+"/" +this.command;
			Paging pageInfo = new Paging(pageNumber,null,totalCount,url,whatColumn,keyword);
			
			List<QnaBean> qlists = qnaDao.getQnaList(map,pageInfo);
			model.addAttribute("qlists",qlists);
			model.addAttribute("pageInfo",pageInfo);
			
			return getPage;
		}else{ //관리자 페이지의 경우 질문글만 띄움
			int totalCount = qnaDao.getOrgTotalCount(map);
			String url = request.getContextPath()+"/" +this.command;
			Paging pageInfo = new Paging(pageNumber,null,totalCount,url,whatColumn,keyword);
			
			List<QnaBean> qlists = qnaDao.getOrgQnaList(map,pageInfo);
			model.addAttribute("qlists",qlists);
			
			String html = pageInfo.getPagingHtml();
			html = html.replaceAll("\\?", "\\?isAdmin=yes&");
			pageInfo.setPagingHtml(html);
			model.addAttribute("pageInfo",pageInfo);
			return "qnaAdmin";	
		}
	}
	
}
