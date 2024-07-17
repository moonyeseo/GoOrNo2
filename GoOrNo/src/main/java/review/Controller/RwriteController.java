package review.Controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import review.model.ReviewBean;
import review.model.ReviewDao;
import users.model.UsersBean;
import users.model.UsersDao;

@Controller
@ComponentScan(basePackages = { "review", "event", "users" })
public class RwriteController {

    private final String command = "commit.review";

    @Autowired
    ReviewDao reviewDao;

    @Autowired
    UsersDao usersDao;

    @RequestMapping(value = command)
    public @ResponseBody List<ReviewBean> review(@RequestParam("rating") String rating, HttpSession session,
            Model model, @ModelAttribute("review") ReviewBean review) throws IOException {

        System.out.println("RwriteController 입니다.");
        System.out.println("RwriteController:" + review.getEvent_no() + review.getId() + review.getRating());

        UsersBean users = (UsersBean) session.getAttribute("loginInfo");
        review.setUser_no(users.getUser_no());
        review.setUser_id(users.getId());

        model.addAttribute("rating", rating);

        System.out.println("users.getId():" + review.getUser_id());

        int cnt = reviewDao.insertReview(review);
        System.out.println("cnt:" + cnt);

        if (cnt > 0) {
            List<ReviewBean> reviewLists = reviewDao.getAllReview(review.getEvent_no());
            double averageRating = reviewDao.getAverageRating(review.getEvent_no());
            model.addAttribute("averageRating", averageRating);
            
            System.out.println("averageRating"+averageRating);
            
            return reviewLists;
        } else {
            return null;
        }
    }
}