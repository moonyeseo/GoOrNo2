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
		// 1�ܰ�
		// �ΰ��ڵ� �ޱ�.

		// 2�ܰ�
		// ��ū �ޱ�.
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
			// POST ��û�� ���� �⺻���� false�� setDoOutput�� true��
			
			conn.setRequestMethod("POST");
			conn.setDoOutput(true);
			// POST ��û�� �ʿ�� �䱸�ϴ� �Ķ���� ��Ʈ���� ���� ����
			
			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream(), "UTF-8"));
			StringBuilder sb = new StringBuilder();
			sb.append("grant_type=authorization_code");
			sb.append("&client_id="); // ������ �߱޹��� key
			sb.append("&redirect_uri=http://localhost:8080/kakaoLogin.users"); // ������ ������ �ּ�
			sb.append("&code=" + authorize_code);
			bw.write(sb.toString());
			bw.flush();
			// ��� �ڵ尡 200�̶�� ����
			int responseCode = conn.getResponseCode();
			System.out.println("responseCode : " + responseCode);
			// ��û�� ���� ���� JSONŸ���� Response �޼��� �о����
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
			String line = "";
			String result = "";
			while ((line = br.readLine()) != null) {
				result += line;
			}
			System.out.println("response body : " + result);
			// Gson ���̺귯���� ���Ե� Ŭ������ JSON�Ľ� ��ü ����
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

            // ��û�� �ʿ��� Header�� ���Ե� ����
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
		// result�� null�̸� ������ ������ �ȵ��ִ°ŹǷ� ������ ����.
			usersDao.kakaoinsert(loginInfo);
			// �� �ڵ尡 ������ �����ϱ� ���� Repository�� ������ �ڵ���. [ȸ������ ó��]
			return usersDao.findkakao(loginInfo);
			// �� �ڵ�� ���� ���� �� ��Ʈ�ѷ��� ������ ������ �ڵ���.
			//  result�� �������� ������ null�� ���ϵǹǷ� �� �ڵ带 ���.
		} else {
			return result; //�̹� ȸ���̱⿡ �ٷ� �α��� ����.
			// ������ �̹� �ֱ� ������ result�� ������.
		}
	}
}