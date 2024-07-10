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
	// DB 저장
	private final String command = "api.event"; 
	private final String gotoPage = "redirect:/list.event";

	@Autowired
	private EventDao edao;

	@RequestMapping(command)
	public String insert(EventBean event) {
		StringBuilder urlBuilder = new StringBuilder("http://openapi.seoul.go.kr:8088");
		urlBuilder.append("/").append(URLEncoder.encode("434472644d776a6435387a694c6e45", StandardCharsets.UTF_8)); // 인증키
		urlBuilder.append("/").append(URLEncoder.encode("json", StandardCharsets.UTF_8)); // 요청 파일 타입
		urlBuilder.append("/").append(URLEncoder.encode("culturalEventInfo", StandardCharsets.UTF_8)); // 서비스명
		urlBuilder.append("/").append(URLEncoder.encode("1", StandardCharsets.UTF_8)); // 요청 시작 위치
		urlBuilder.append("/").append(URLEncoder.encode("1000", StandardCharsets.UTF_8)); // 요청 종료 위치
		urlBuilder.append("/").append(URLEncoder.encode(" ", StandardCharsets.UTF_8)); // 분류
		urlBuilder.append("/").append(URLEncoder.encode(" ", StandardCharsets.UTF_8)); // 공연/행사명
		urlBuilder.append("/").append(URLEncoder.encode("2024-07", StandardCharsets.UTF_8)); // 요청 일자

		URL url;

		StringBuilder sb = new StringBuilder();

		try {
			url = new URL(urlBuilder.toString());

			HttpURLConnection conn = (HttpURLConnection) url.openConnection(); // HTTP 연결 객체 생성
			conn.setRequestMethod("GET"); // GET 방식으로 요청 설정
			conn.setRequestProperty("Content-type", "application/json"); // 요청 속성 설정

			BufferedReader rd;
			// 응답 코드가 200~300 사이일 경우 정상 처리
			if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
				rd = new BufferedReader(new InputStreamReader(conn.getInputStream(), StandardCharsets.UTF_8));
			} else {
				rd = new BufferedReader(new InputStreamReader(conn.getErrorStream(), StandardCharsets.UTF_8));
			}
			String line;
			while ((line = rd.readLine()) != null) { // 응답 내용을 한 줄씩 읽어와서 StringBuilder에 추가
				sb.append(line);
			}
			rd.close(); // BufferedReader 닫기
			conn.disconnect(); // HTTP 연결 닫기

		} catch (MalformedURLException e) {
			e.printStackTrace();
		} // 완성된 URL 생성
		catch (ProtocolException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}

		String resultString = sb.toString(); // 응답 내용을 문자열로 변환
		System.out.println("result : " + resultString);

		JsonObject jsonObject = JsonParser.parseString(resultString).getAsJsonObject(); // 문자열을 JSON 객체로 변환
		JsonObject culturalEventInfo = jsonObject.getAsJsonObject("culturalEventInfo"); // 특정 JSON 객체 추출
		JsonArray row = culturalEventInfo.getAsJsonArray("row"); // JSON 배열 추출
		
		edao.truncateEvent();
		for (int i = 0; i < row.size(); i++) {
			JsonObject eventJson = row.get(i).getAsJsonObject(); // 배열 내 각 JSON 객체 추출

			event.setEvent_no(100);
			event.setPerformance_type(eventJson.get("CODENAME").getAsString()); // 공연 유형 설정
			event.setTitle(eventJson.get("TITLE").getAsString()); // 제목 설정
			event.setPlace(eventJson.get("PLACE").getAsString()); // 장소 설정
			event.setEvent_period(eventJson.get("DATE").getAsString()); // 기간 설정
			event.setImg(eventJson.get("MAIN_IMG").getAsString()); // 이미지 설정
			event.setLot(eventJson.get("LOT").getAsString()); // 위도 설정
			event.setLat(eventJson.get("LAT").getAsString()); // 경도 설정

			System.out.println("event()============================================");

			System.out.println("Event: " + (i + 1));
			System.out.println("event_no : " + event.getEvent_no());
			System.out.println("CODENAME: " + event.getPerformance_type());
			System.out.println("TITLE: " + event.getTitle());
			System.out.println("PLACE: " + event.getPlace());
			System.out.println("DATE: " + event.getEvent_period());

			System.out.println("img : " + event.getImg());
			System.out.println("위도 : " + event.getLot());
			System.out.println("경도 : " + event.getLat());
			System.out.println();

			edao.insertEvent(event);

		}
		return gotoPage;

		

	}
}
