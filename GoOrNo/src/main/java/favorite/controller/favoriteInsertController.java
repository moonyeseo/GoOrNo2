package favorite.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import favorite.model.FavoriteBean;
import favorite.model.FavoriteDao;
import users.model.UsersBean;

@Controller
public class favoriteInsertController {

    @Autowired
    private FavoriteDao favoriteDao;

    private final String command = "/favoriteInsert.favorite";

    @RequestMapping(command)
    @ResponseBody
    public Map<String, String> toggleFavorite(HttpSession session,
                                              @RequestParam("event_no") int event_no,
                                              @RequestParam("user_no") int user_no) {
    	
    	System.out.println("-----favoriteInsertController()-----");

    	Map<String, String> response = new HashMap<>();

        FavoriteBean favorite = favoriteDao.getFavorite(event_no, user_no);
        
        System.out.println("event_no: " + event_no);
		System.out.println("user_no: " + user_no);

        if (favorite != null) {
            favoriteDao.deleteFavorite(favorite.getFavorite_no(), event_no, user_no);
            response.put("status", "removed");
        } else {
            FavoriteBean newFavorite = new FavoriteBean();
            newFavorite.setEvent_no(event_no);
            newFavorite.setUser_no(user_no);
            favoriteDao.insertFavorite(newFavorite);
            response.put("status", "added");
        }

        return response;
    }
}