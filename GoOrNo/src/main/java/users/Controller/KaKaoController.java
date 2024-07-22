package users.Controller;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import users.model.UsersBean;
import users.model.UsersDao;

@Controller
public class KaKaoController {

	private final String command = "kakaoLogin.users";

	@Autowired
	UsersDao usersDao;

	@RequestMapping(value = command, method = RequestMethod.GET)
	public String kakaoLogin(@RequestParam(value = "code", required = false) String code, HttpSession session,
			HttpServletResponse response) throws Exception {
		response.setCharacterEncoding("UTF-8");
		System.out.println("#########code:" + code);
		// 1단계
		// 인가코드 받기.

		// 2단계
		// 토큰 받기.
		String access_Token = getAccessToken(code);
		System.out.println("###access_Token#### : " + access_Token);

		UsersBean loginInfo = getUserInfo(access_Token);
		System.out.println("###access_Token#### : " + access_Token);
		
		
	    session.setAttribute("loginInfo", loginInfo);
        
		return "../../main";
	}

	private String getAccessToken(String authorize_code) {
		String access_Token = "";
		String refresh_Token = "";
		String reqURL = "https://kauth.kakao.com/oauth/token";

		try {
			URL url = new URL(reqURL);

			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			// POST 요청을 위해 기본값이 false인 setDoOutput을 true로
			
			conn.setRequestMethod("POST");
			conn.setDoOutput(true);
			// POST 요청에 필요로 요구하는 파라미터 스트림을 통해 전송
			
			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream(), "UTF-8"));
			StringBuilder sb = new StringBuilder();
			sb.append("grant_type=authorization_code");
			sb.append("&client_id="); // 본인이 발급받은 key
			sb.append("&redirect_uri=http://localhost:8080/kakaoLogin.users"); // 본인이 설정한 주소
			sb.append("&code=" + authorize_code);
			bw.write(sb.toString());
			bw.flush();
			// 결과 코드가 200이라면 성공
			int responseCode = conn.getResponseCode();
			System.out.println("responseCode : " + responseCode);
			// 요청을 통해 얻은 JSON타입의 Response 메세지 읽어오기
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
			String line = "";
			String result = "";
			while ((line = br.readLine()) != null) {
				result += line;
			}
			System.out.println("response body : " + result);
			// Gson 라이브러리에 포함된 클래스로 JSON파싱 객체 생성
			JsonParser parser = new JsonParser();
			JsonElement element = parser.parse(result);
			access_Token = element.getAsJsonObject().get("access_token").getAsString();
			refresh_Token = element.getAsJsonObject().get("refresh_token").getAsString();
			System.out.println("access_token : " + access_Token);
			System.out.println("refresh_token : " + refresh_Token);
			br.close();
			bw.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return access_Token;
	}

	private UsersBean getUserInfo(String access_Token) {

        HashMap<String, Object> loginInfo = new HashMap<String, Object>();
        String reqURL = "https://kapi.kakao.com/v2/user/me";

        try {
            URL url = new URL(reqURL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");

            // 요청에 필요한 Header에 포함될 내용
            conn.setRequestProperty("Authorization", "Bearer " + access_Token);

            int responseCode = conn.getResponseCode();
            System.out.println("responseCode : " + responseCode);

            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));

            String line = "";
            String result = "";

            while ((line = br.readLine()) != null) {
                result += line;
            }
            System.out.println("response body : " + result);

            JsonParser parser = new JsonParser();
            JsonElement element = parser.parse(result);

            JsonObject properties = element.getAsJsonObject().get("properties").getAsJsonObject();
            JsonObject kakao_account = element.getAsJsonObject().get("kakao_account").getAsJsonObject();

            String nickname = properties.getAsJsonObject().get("nickname").getAsString();
            String email = kakao_account.getAsJsonObject().get("email").getAsString();

            loginInfo.put("nickname", nickname);
            loginInfo.put("email", email);

        } catch (IOException e) {
            e.printStackTrace();
        }
        
        UsersBean result = usersDao.findkakao(loginInfo);
        
        System.out.println("S:" + result);
        
		if(result==null) {
		// result가 null이면 정보가 저장이 안되있는거므로 정보를 저장.
			usersDao.kakaoinsert(loginInfo);
			// 위 코드가 정보를 저장하기 위해 Repository로 보내는 코드임. [회원가입 처리]
			return usersDao.findkakao(loginInfo);
			// 위 코드는 정보 저장 후 컨트롤러에 정보를 보내는 코드임.
			//  result를 리턴으로 보내면 null이 리턴되므로 위 코드를 사용.
		} else {
			return result; //이미 회원이기에 바로 로그인 성공.
			// 정보가 이미 있기 때문에 result를 리턴함.
		}
	}
}