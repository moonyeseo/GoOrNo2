package users.Controller;

import java.util.HashMap;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

@Controller
public class PhoneController {

	@RequestMapping(value = "/phoneCheck.users", method = RequestMethod.GET)
	@ResponseBody
	public String sendSMS(@RequestParam("phoneNum") String phoneNum) { 

		int randomNumber = (int) ((Math.random() * (9999 - 1000 + 1)) + 1000);

		System.out.println("PhoneController");
		System.out.println("randomNumber:" + randomNumber);

		String api_key = "";
		String api_secret = "";
		Message coolsms = new Message(api_key, api_secret);

		HashMap<String, String> params = new HashMap<String, String>();

		params.put("to", phoneNum); // 수신전화번호
		params.put("from", ""); // 발신전화번호. 테스트시에는 발신,수신 둘다 본인 번호로 하면 된다.
		params.put("type", "SMS");
		params.put("text", "인증번호는" + "[" + randomNumber + "]" + "입니다."); // 문자 내용 입력
		params.put("app_version", "test app 1.2"); // application name and version
		
		System.out.println("phoneNum: " + phoneNum);
		System.out.println(params);

		try {
			JSONObject obj = (JSONObject) coolsms.send(params);
			System.out.println("toString:" + obj.toString());
		} catch (CoolsmsException e) {
			System.out.println("getMessage:" + e.getMessage());
			System.out.println("getCode:" + e.getCode());
			// 예외 처리 - 여기서 예외가 발생하면 클라이언트에게 어떤 메시지를 보낼지 결정할 수 있음
		}

		return Integer.toString(randomNumber);
	}
}