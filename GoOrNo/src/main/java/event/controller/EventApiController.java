package event.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.ProtocolException;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import event.model.EventBean;
import event.model.EventDao;

@Controller
public class EventApiController {
	// DB ����
	private final String command = "api.event"; 
	private final String gotoPage = "redirect:/list.event";

	@Autowired
	private EventDao edao;

	@RequestMapping(command)
	public String insert(EventBean event) {
		StringBuilder urlBuilder = new StringBuilder("http://openapi.seoul.go.kr:8088");
		urlBuilder.append("/").append(URLEncoder.encode("434472644d776a6435387a694c6e45", StandardCharsets.UTF_8)); // ����Ű
		urlBuilder.append("/").append(URLEncoder.encode("json", StandardCharsets.UTF_8)); // ��û ���� Ÿ��
		urlBuilder.append("/").append(URLEncoder.encode("culturalEventInfo", StandardCharsets.UTF_8)); // ���񽺸�
		urlBuilder.append("/").append(URLEncoder.encode("1", StandardCharsets.UTF_8)); // ��û ���� ��ġ
		urlBuilder.append("/").append(URLEncoder.encode("1000", StandardCharsets.UTF_8)); // ��û ���� ��ġ
		urlBuilder.append("/").append(URLEncoder.encode(" ", StandardCharsets.UTF_8)); // �з�
		urlBuilder.append("/").append(URLEncoder.encode(" ", StandardCharsets.UTF_8)); // ����/����
		urlBuilder.append("/").append(URLEncoder.encode("2024-07", StandardCharsets.UTF_8)); // ��û ����

		URL url;

		StringBuilder sb = new StringBuilder();

		try {
			url = new URL(urlBuilder.toString());

			HttpURLConnection conn = (HttpURLConnection) url.openConnection(); // HTTP ���� ��ü ����
			conn.setRequestMethod("GET"); // GET ������� ��û ����
			conn.setRequestProperty("Content-type", "application/json"); // ��û �Ӽ� ����

			BufferedReader rd;
			// ���� �ڵ尡 200~300 ������ ��� ���� ó��
			if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
				rd = new BufferedReader(new InputStreamReader(conn.getInputStream(), StandardCharsets.UTF_8));
			} else {
				rd = new BufferedReader(new InputStreamReader(conn.getErrorStream(), StandardCharsets.UTF_8));
			}
			String line;
			while ((line = rd.readLine()) != null) { // ���� ������ �� �پ� �о�ͼ� StringBuilder�� �߰�
				sb.append(line);
			}
			rd.close(); // BufferedReader �ݱ�
			conn.disconnect(); // HTTP ���� �ݱ�

		} catch (MalformedURLException e) {
			e.printStackTrace();
		} // �ϼ��� URL ����
		catch (ProtocolException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}

		String resultString = sb.toString(); // ���� ������ ���ڿ��� ��ȯ
		System.out.println("result : " + resultString);

		JsonObject jsonObject = JsonParser.parseString(resultString).getAsJsonObject(); // ���ڿ��� JSON ��ü�� ��ȯ
		JsonObject culturalEventInfo = jsonObject.getAsJsonObject("culturalEventInfo"); // Ư�� JSON ��ü ����
		JsonArray row = culturalEventInfo.getAsJsonArray("row"); // JSON �迭 ����
		
		edao.truncateEvent();
		
		for (int i = 0; i < row.size(); i++) {
			JsonObject eventJson = row.get(i).getAsJsonObject(); // �迭 �� �� JSON ��ü ����

			event.setEvent_no(100);
			event.setPerformance_type(eventJson.get("CODENAME").getAsString()); // ���� ���� ����
			event.setTitle(eventJson.get("TITLE").getAsString()); // ���� ����
			event.setPlace(eventJson.get("PLACE").getAsString()); // ��� ����
			event.setEvent_period(eventJson.get("DATE").getAsString()); // �Ⱓ ����
			event.setImg(eventJson.get("MAIN_IMG").getAsString()); // �̹��� ����
			event.setLot(eventJson.get("LOT").getAsString()); // ���� ����
			event.setLat(eventJson.get("LAT").getAsString()); // �浵 ����

			System.out.println("event()============================================");

			System.out.println("Event: " + (i + 1));
			System.out.println("event_no : " + event.getEvent_no());
			System.out.println("CODENAME: " + event.getPerformance_type());
			System.out.println("TITLE: " + event.getTitle());
			System.out.println("PLACE: " + event.getPlace());
			System.out.println("DATE: " + event.getEvent_period());

			System.out.println("img : " + event.getImg());
			System.out.println("lot : " + event.getLot());
			System.out.println("lat : " + event.getLat());
			System.out.println();

			edao.insertEvent(event);

		}
		return gotoPage;

		

	}
}
