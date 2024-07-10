package notice.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import comments.model.CommentDao;
import notice.model.NoticeBean;
import notice.model.NoticeDao;
import utility.Paging;

@Controller
public class NoticeListController {
	private final String command = "list.notice";
	private final String getPage = "noticeList";
	
	@Autowired
	NoticeDao noticeDao;
	
	@Autowired
	CommentDao commentDao;
	
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
		
		int totalCount = noticeDao.getTotalCount(map);
		String url = request.getContextPath()+"/" +this.command;
		Paging pageInfo = new Paging(pageNumber,null,totalCount,url,whatColumn,keyword);
		
		List<NoticeBean> nlists = noticeDao.getNoticeList(map,pageInfo);
		
		model.addAttribute("nlists",nlists);
		
		//관리자 요청시 관리자 페이지로 이동
		if( isAdmin != null ) {
			String html = pageInfo.getPagingHtml();
			html = html.replaceAll("\\?", "\\?isAdmin=yes&");
			pageInfo.setPagingHtml(html);
			model.addAttribute("pageInfo",pageInfo);
			return "noticeAdmin";	
		}

		model.addAttribute("pageInfo",pageInfo);
				
		return getPage;
	}
	
}
