package review.Controller;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import review.model.ReviewDao;

@Controller
public class DreviewController {
	private final String command = "delete.review";
	private final String getPage = "redirect:/detail.event";

	@Autowired
	ReviewDao reviewDao;

	@RequestMapping(value = command)
	public String deleteReview(
			Model model,
			@RequestParam(value = "eventNo", required = true) int eventNo,
			@RequestParam(value = "review_no", required = true) int review_no,
			@RequestParam(value = "pageNumber", required = false) String pageNumber,
			@RequestParam(value = "whatColumn", required = false) String whatColumn,
			@RequestParam(value = "keyword", required = false) String keyword
			) throws IOException {
	
		System.out.println("delete Review Controller");
		model.addAttribute("eventNo",eventNo );
		model.addAttribute("keyword", keyword);
		model.addAttribute("pageNumber", pageNumber);
		model.addAttribute("whatColumn", whatColumn);
		
		int cnt = reviewDao.deleteReview(review_no);

		return getPage;
	}	
	

}