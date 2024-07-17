package review.Controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import review.model.ReviewBean;
import review.model.ReviewDao;
import utility.Paging;

@Controller
public class ReviewListController {
	
	private final String command = "list.review";
	private final String getPage = "ReviewListAdmin";
	
	@Autowired
	ReviewDao reviewDao;
	
	@RequestMapping(value = command)
	public ModelAndView form(@RequestParam(value = "whatColumn", required = false) String whatColumn,
			@RequestParam(value = "keyword", required = false) String keyword,
			@RequestParam(value = "pageNumber", required = false) String pageNumber, HttpServletRequest request) {
		
		System.out.println("ReviewList Controller");
		
		ModelAndView mav = new ModelAndView();

		Map<String, String> map = new HashMap<String, String>();
		map.put("whatColumn", whatColumn);
		map.put("keyword", "%" + keyword + "%");

		int totalCount = reviewDao.getTotalCount(map);

		String url = request.getContextPath() + "/" + this.command;
		Paging pageInfo = new Paging(pageNumber, null, totalCount, url, whatColumn, keyword);

		List<ReviewBean> reviewList = reviewDao.getReviewList(map, pageInfo);
		
		int currentPage = pageInfo.getPageNumber();  
        int pageSize = pageInfo.getPageSize();
        int number = totalCount - (currentPage - 1) * pageSize;
		
		mav.addObject("totalCount", totalCount);
		mav.addObject("reviewList", reviewList);
		mav.addObject("pageInfo", pageInfo);
		mav.addObject("whatColumn", whatColumn);
		mav.addObject("keyword", keyword);
		mav.addObject("number", number);
		mav.setViewName(getPage);

		return mav;
	}

}