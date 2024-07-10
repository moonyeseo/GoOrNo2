package chatbot.controller;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Base64;
import java.util.Date;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
public class ChatbotController {
	private static String secretKey = "Z2RmeE5FbWhLSmlCcXRydkdMYnNFWnF6UFh0VFFUYUE=";
	private static String apiUrl = "https://s43ij4psz3.apigw.ntruss.com/chatbot-api/chatbot/";

	private final String command = "/chatbot.chatbot";
	private final String gotoPage = "chatbot";
	
	@RequestMapping(command)
	public String doAction() {
		return gotoPage;
	}
	
	 public String main(String voiceMessage) {

	        String chatbotMessage = ""; // ���� �޼���
	        try {
	        	
	            URL url = new URL(apiUrl);

	            String message = getReqMessage(voiceMessage);
	            System.out.println("getReqMessage : " + message);

	            String encodeBase64String = makeSignature(message, secretKey);

	            HttpURLConnection con = (HttpURLConnection)url.openConnection();
	            con.setRequestMethod("POST");
	            con.setRequestProperty("Content-Type", "application/json;UTF-8");
	            con.setRequestProperty("X-NCP-CHATBOT_SIGNATURE", encodeBase64String);

	            // post request
	            con.setDoOutput(true);
	            DataOutputStream wr = new DataOutputStream(con.getOutputStream());
	            wr.write(message.getBytes("UTF-8"));
	            wr.flush();
	            wr.close();
	            int responseCode = con.getResponseCode();

	            if(responseCode==200) { // Normal call
	                System.out.println(con.getResponseMessage());

	                BufferedReader in = new BufferedReader(
	                        new InputStreamReader(
	                                con.getInputStream(), "UTF-8")); // json 한글처리
	                String decodedString;
	                while ((decodedString = in.readLine()) != null) {
	                    chatbotMessage = decodedString;
	                }
	                //chatbotMessage = decodedString;
	                in.close();
	                // ���� �޼��� ���
	                System.out.println(chatbotMessage);
	              // chatbotMessage = jsonToString(chatbotMessage);
	                
	            } else {  // Error occurred
	                chatbotMessage = con.getResponseMessage();
	            }
	        } catch (Exception e) {
	            System.out.println(e);
	        }
	        
	        return chatbotMessage;
	    }

	    public static String makeSignature(String message, String secretKey) {

	        String encodeBase64String = "";

	        try {
	            byte[] secrete_key_bytes = secretKey.getBytes("UTF-8");

	            SecretKeySpec signingKey = new SecretKeySpec(secrete_key_bytes, "HmacSHA256");
	            Mac mac = Mac.getInstance("HmacSHA256");
	            mac.init(signingKey);

	            byte[] rawHmac = mac.doFinal(message.getBytes("UTF-8"));
	           // encodeBase64String = Base64.encodeToString(rawHmac, Base64.NO_WRAP);
	            encodeBase64String = Base64.getEncoder().encodeToString(rawHmac);
		        
		        System.out.println("encodeBase64String : " + encodeBase64String + "\n");

	            return encodeBase64String;

	        } catch (Exception e){
	            System.out.println(e);
	        }

	        return encodeBase64String;

	    }

	    public static String getReqMessage(String voiceMessage) {

	        String requestBody = "";

	        try {

	            JSONObject obj = new JSONObject();

	            long timestamp = new Date().getTime();

	            System.out.println("##"+timestamp);
	            
	            obj.put("version", "v2");
	            obj.put("userId", "U47b00b58c90f8e47428af8b7bddc1231heo2");
	//=> userId is a unique code for each chat user, not a fixed value, recommend use UUID. use different id for each user could help you to split chat history for users.

	            obj.put("timestamp", timestamp);

	            JSONObject bubbles_obj = new JSONObject();

	            bubbles_obj.put("type", "text");

	            JSONObject data_obj = new JSONObject();
	            data_obj.put("description", voiceMessage);

	            bubbles_obj.put("type", "text");
	            bubbles_obj.put("data", data_obj);

	            JSONArray bubbles_array = new JSONArray();
	            bubbles_array.add(bubbles_obj);

	            obj.put("bubbles", bubbles_array);
	            obj.put("event", "send");

	            requestBody = obj.toString();

	        } catch (Exception e){
	            System.out.println("## Exception : " + e);
	        }
	        
	        System.out.println("requestBody : " + requestBody + "\n");
	        
	        return requestBody; 
	    }
	
	@RequestMapping(value = "/chatbotSend.chatbot", produces = "application/text; charset=UTF-8")
	@ResponseBody
    public String chatbotSend(@RequestParam("inputText") String inputText, HttpServletResponse response) {
		
        String msg = "";
 //       msg = main( "postback text of welcome action");
        msg = main(inputText);
        
     // JSON �Ľ�
        JSONParser parser = new JSONParser();
        String description = null;
        try {
        	//bubbles ����
			JSONObject json = (JSONObject)parser.parse(msg);
			String bubbles = json.get("bubbles").toString();
			
			bubbles = bubbles.substring(1, bubbles.length()-1);
			System.out.println("bubbles : " + bubbles);
			
			// data ����
			json = (JSONObject)parser.parse(bubbles);
			String data = json.get("data").toString();
			
			System.out.println("data : " + data);
			
			// description ����
			json = (JSONObject)parser.parse(data);
			description = json.get("description").toString();
			
			System.out.println("description : " + description);
			
			if(description.equals("��ü ��� ����� Ȯ���Ͻðڽ��ϱ�?" ) ) {
				return description;
			}
			
		} catch (ParseException e) {
			e.printStackTrace();
		}
        
        return description;
    }
}
