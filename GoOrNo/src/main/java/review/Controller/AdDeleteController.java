package review.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import review.model.ReviewDao;

@Controller
public class AdDeleteController {

	private final String command = "deleteReview.review";
	private final String getPage = "redirect:/list.review";

	@Autowired
	ReviewDao reviewDao;

	@RequestMapping(value = command)
	public ModelAndView delete(
			@RequestParam("review_no") int review_no,
			@RequestParam("pageNumber") int pageNumber,
			@RequestParam("whatColumn") String whatColumn,
			@RequestParam("keyword") String keyword) {
		
		System.out.println("AdminReview Delete Controller");
		
		int cnt = -1;
		cnt = reviewDao.deleteReview(review_no);

		ModelAndView mav = new ModelAndView();
		mav.addObject("pageNumber", pageNumber);
		mav.addObject("whatColumn", whatColumn);
		mav.addObject("keyword", keyword);

		mav.setViewName(getPage);

		return mav;

	}
}
