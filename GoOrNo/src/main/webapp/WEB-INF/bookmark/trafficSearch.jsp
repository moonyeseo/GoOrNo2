<%@page import="org.springframework.web.context.request.RequestScope"%> 
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file = "../userCommon/userHeader.jsp" %>

	<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
	<script
		src="https://apis.openapi.sk.com/tmap/jsv2?version=1&appKey=50L76VhFwD5nr7iApd9gS7yiECxEoMnd8y4QD4Vl"></script>
	<script type="text/javascript">
		$(document).ready(function(){ // initTamp() 호출 -> 지도 불러오기
			var searchParams = new URLSearchParams(location.search); // 위도, 경도 파라미터 값 가져오기
			var urlParams = new URL(location.href).searchParams;
			
			 eventLat = urlParams.get("lat");
			 eventLon =  urlParams.get("lot");
			 
			initTmap(eventLat, eventLon);
		});
		
		function getAddr(obj, addr){ // 집, 회사, 즐겨찾기 아이콘 클릭
			var getId = $(obj).attr('id');
			
			if(getId != "house"){
				
				$("#house").html("<img src = '<%=request.getContextPath() %>/resources/image/house_before.png' style = 'opacity:0.5'>");
			}
			
			if( getId != "company"){
				
				$("#company").html("<img src = '<%=request.getContextPath() %>/resources/image/company_before.png' alt = 'company_img'>");
			}
			
			if( getId != "star"){
				
				$("#star").html("<img src = '<%=request.getContextPath() %>/resources/image/star_before.png' alt = 'star_img' style = 'opacity:0.5'>");
			}
			
			$(obj).html("<img src = '<%=request.getContextPath() %>/resources/image/" + getId + "_after.png'>");

			$("#startAddr").val(addr); // 출발지 주소 -> bookmark 테이블에서 가져온 주소로 변경
			 $("#startAddr").trigger("change"); // 값 변경 이벤트 강제 발생
		}
		
		function keyDown(){
			// 출발지 입력 시, 아이콘 모두 회색으로 변경
			$("#house").html("<img src = '<%=request.getContextPath() %>/resources/image/house_before.png' style = 'opacity:0.5'>");
			$("#company").html("<img src = '<%=request.getContextPath() %>/resources/image/company_before.png' alt = 'company_img'>");
			$("#star").html("<img src = '<%=request.getContextPath() %>/resources/image/star_before.png' alt = 'star_img' style = 'opacity:0.5'>");
			
		}

		var flag = false; // 분홍 화살표 <-> 회색 화살표
		function addrChange(obj){
			if(!flag){
				$("#change").html("<img src = '<%=request.getContextPath() %>/resources/image/change_after.png'>");
				
				flag = true;
			}
			else{
				$("#change").html("<img src = '<%=request.getContextPath() %>/resources/image/change_before.png'>");
				
				flag = false;
			}
			
			var temp = $("#startAddr").val(); // 출발지로 입력한 주소 저장
			
			$("#startAddr").val($("#endAddr").val()); // 출발지 주소 -> 목적지에 입력한 주소로 변경
			 $("#startAddr").trigger("change"); // 값 변경 이벤트 강제 발생
			
			$("#endAddr").val(temp); // 목적지 주소 -> 출발지에 입력한 주소로 변경
			 $("#endAddr").trigger("change");
		}
	
		// 지도 생성, 마커찍기
		var map;
		var markerInfo;
		//출발지,도착지 마커
		var marker_s, marker_e, marker_p;
		//경로그림정보
		var drawInfoArr = [];
		var drawInfoArr2 = [];

		var chktraffic = [];
		var resultdrawArr = [];
		var resultMarkerArr = [];

		// 출발지, 목적지 설정
		var slon, slat; // start : 위경도 좌표()
		var elon, elat; // end : 위경도 좌표()

		// 혼잡도 표시
		var InfoWindow, marker;
		var content, content1, content2, content3, rect;
		var url, lat, lon, name;
		var Clicklat, Clicklon;
		var result, resultDiv;
		var poiId, color;
		var poiId2, color2;
		
		// 혼잡도 단계 표시(moonyeseo_div 영역에 적을 코드)
		var congestion_msg = "<span style = 'font-weight: bold;'>장소혼잡도 단계</span><br><br>" +
		"<table style = 'width : 40%; table-layout: fixed; margin-left: 0px'>" +
		"<tr style = 'text-align: left'><td>1</td><td>여유</td><td style = 'background-color: #9FC93C; opacity : 0.5; width: 20%''></td></tr>" +
		"<tr style = 'text-align: left'><td>2</td><td>보통</td><td style = 'background-color: #8F89E9; opacity : 0.5; width: 20%'></td></tr>" + 
		"<tr  style = 'text-align: left'><td>3</td><td>혼잡</td><td style = 'background-color: #FBD2BD; opacity : 0.5; width: 20%'></td></tr>" + 
		"<tr  style = 'text-align: left'><td>4</td><td>매우혼잡</td><td style = 'background-color: #FA64B0; opacity : 0.5; width: 20%'></td></tr></table>"; 
		function initTmap(eventLat, eventLon) {

			// 1. 지도 띄우기
			map = new Tmapv2.Map("map_div", {
				center : new Tmapv2.LatLng(37.49241689559544,
						127.03171389453507),
				width : "100%",
				height : "800px",
				zoom : 11,
				zoomControl : true,
				scrollwheel : true
			});

			$("#moonyeseo_div").empty();	 // moonyese_div 영역 비우기

			$("#moonyeseo_div").html(congestion_msg); // moonyese_div 영역에 혼잡도 단계 표시 코드	

			// 마커 초기화
			marker_s = new Tmapv2.Marker(
					{
						icon : "<%=request.getContextPath()%>/resources/image/start_marker.png",
						iconSize : new Tmapv2.Size(64, 78),
						map : map
					});

			marker_e = new Tmapv2.Marker(
					{
						icon : "<%=request.getContextPath()%>/resources/image/destination_marker.png",
						iconSize : new Tmapv2.Size(64, 78),
						map : map
					});

			
			if(eventLat != null){ // event 상세보기에서 바로 길찾기로 넘어온 경우
				elat = eventLat;
				elon = eventLon;

				var markerPosition = new Tmapv2.LatLng(
						Number(elat),
						Number(elon));
				
				marker_e = new Tmapv2.Marker(
						{
							position : markerPosition,
							icon : "<%=request.getContextPath()%>/resources/image/destination_marker.png",
							iconSize : new Tmapv2.Size(64, 78),
							map : map
						});

				map
						.setCenter(markerPosition);
			}

			$("#startAddr")
					.change(
							function() {
								marker_s.setMap(null);
								resettingMap();

								// 2. API 사용요청
								var fullAddr = $("#startAddr").val();
								var headers = {};
								headers["appKey"] = "50L76VhFwD5nr7iApd9gS7yiECxEoMnd8y4QD4Vl";
								$
										.ajax({
											method : "GET",
											headers : headers,
											url : "https://apis.openapi.sk.com/tmap/geo/fullAddrGeo?version=1&format=json&callback=result",
											async : false,
											data : {
												"coordType" : "WGS84GEO",
												"fullAddr" : fullAddr
											},
											success : function(response) {

												var resultInfo = response.coordinateInfo; // .coordinate[0];
												console.log(resultInfo);

												// 기존 마커 삭제
												marker_s.setMap(null);

												// 3.마커 찍기
												// 검색 결과 정보가 없을 때 처리
												if (resultInfo.coordinate.length == 0) {
													$("#result")
															.text(
																	"요청 데이터가 올바르지 않습니다.");
												} else {
													var resultCoordinate = resultInfo.coordinate[0];
													if (resultCoordinate.lon.length > 0) {
														// 구주소
														slon = resultCoordinate.lon;
														slat = resultCoordinate.lat;
													} else {
														// 신주소
														slon = resultCoordinate.newLon;
														slat = resultCoordinate.newLat;
													}

													var slonEntr, slatEntr;

													if (resultCoordinate.lonEntr == undefined
															&& resultCoordinate.newLonEntr == undefined) {
														slonEntr = 0;
														slatEntr = 0;
													} else {
														if (resultCoordinate.lonEntr.length > 0) {
															slonEntr = resultCoordinate.lonEntr;
															slatEntr = resultCoordinate.latEntr;
														} else {
															slonEntr = resultCoordinate.newLonEntr;
															slatEntr = resultCoordinate.newLatEntr;
														}
													}

													var markerPosition = new Tmapv2.LatLng(
															Number(slat),
															Number(slon));

													// 마커 올리기
													marker_s = new Tmapv2.Marker(
															{
																position : markerPosition,
																icon : "<%=request.getContextPath()%>/resources/image/start_marker.png",
																iconSize : new Tmapv2.Size(64, 78),
																map : map
															});

													map
															.setCenter(markerPosition);
												}
											},
											error : function(request, status,
													error) {
												console.log(request);
												console.log("code:"
														+ request.status
														+ "\n message:"
														+ request.responseText
														+ "\n error:" + error);
												// 에러가 발생하면 맵을 초기화함
												// markerStartLayer.clearMarkers();
												// 마커초기화
												map
														.setCenter(new Tmapv2.LatLng(
																37.570028,
																126.986072));
												$("#result").html("");

											}
										});
							});

			$("#endAddr")
					.change(
							function() {
								marker_e.setMap(null);
								resettingMap();

								// 2. API 사용요청
								var fullAddr = $("#endAddr").val();
								var headers = {};
								headers["appKey"] = "50L76VhFwD5nr7iApd9gS7yiECxEoMnd8y4QD4Vl";
								$
										.ajax({
											method : "GET",
											headers : headers,
											url : "https://apis.openapi.sk.com/tmap/geo/fullAddrGeo?version=1&format=json&callback=result",
											async : false,
											data : {
												"coordType" : "WGS84GEO",
												"fullAddr" : fullAddr
											},
											success : function(response) {

												var resultInfo = response.coordinateInfo; // .coordinate[0];
												console.log(resultInfo);

												// 기존 마커 삭제
												marker_e.setMap(null);

												// 3.마커 찍기
												// 검색 결과 정보가 없을 때 처리
												if (resultInfo.coordinate.length == 0) {
													$("#result")
															.text(
																	"요청 데이터가 올바르지 않습니다.");
												} else {
													var resultCoordinate = resultInfo.coordinate[0];
													if (resultCoordinate.lon.length > 0) {
														// 구주소
														elon = resultCoordinate.lon;
														elat = resultCoordinate.lat;
													} else {
														// 신주소
														elon = resultCoordinate.newLon;
														elat = resultCoordinate.newLat;
													}

													var elonEntr, elatEntr;

													if (resultCoordinate.lonEntr == undefined
															&& resultCoordinate.newLonEntr == undefined) {
														elonEntr = 0;
														elatEntr = 0;
													} else {
														if (resultCoordinate.lonEntr.length > 0) {
															elonEntr = resultCoordinate.lonEntr;
															elatEntr = resultCoordinate.latEntr;
														} else {
															elonEntr = resultCoordinate.newLonEntr;
															elatEntr = resultCoordinate.newLatEntr;
														}
													}

													var markerPosition = new Tmapv2.LatLng(
															Number(elat),
															Number(elon));

													// 마커 올리기
													marker_e = new Tmapv2.Marker(
															{
																position : markerPosition,
																icon : "<%=request.getContextPath()%>/resources/image/destination_marker.png",
																iconSize : new Tmapv2.Size(64, 78),
																map : map
															});

													map
															.setCenter(markerPosition);
												}
											},
											error : function(request, status,
													error) {
												console.log(request);
												console.log("code:"
														+ request.status
														+ "\n message:"
														+ request.responseText
														+ "\n error:" + error);
												// 에러가 발생하면 맵을 초기화함
												// markerStartLayer.clearMarkers();
												// 마커초기화
												map
														.setCenter(new Tmapv2.LatLng(
																37.570028,
																126.986072));
												$("#result").html("");

											}
										});
							});

			// 3. 경로탐색 API 사용요청
			$("#btn_route")
					.click(
							function() {

								//기존 맵에 있던 정보들 초기화
								marker_s.setMap(null);
								marker_e.setMap(null);
								resettingMap();

								var searchOption = $("#selectLevel").val();

								var trafficInfochk = $("#year").val();
								var headers = {};
								headers["appKey"] = "50L76VhFwD5nr7iApd9gS7yiECxEoMnd8y4QD4Vl";

								//JSON TYPE EDIT [S]
								$
										.ajax({
											type : "POST",
											headers : headers,
											url : "https://apis.openapi.sk.com/tmap/routes?version=1&format=json&callback=result&appKey=50L76VhFwD5nr7iApd9gS7yiECxEoMnd8y4QD4Vl",
											async : false,
											data : {
												"startX" : slon,
												"startY" : slat,
												"endX" : elon,
												"endY" : elat,
												"reqCoordType" : "WGS84GEO",
												"resCoordType" : "EPSG3857",
												"searchOption" : searchOption,
												"trafficInfo" : trafficInfochk
											},
											success : function(response) {

												var resultData = response.features;

												var tDistance =  (resultData[0].properties.totalDistance / 1000)
																.toFixed(1)
														+ "km";
												var tTime =  (resultData[0].properties.totalTime / 60)
																.toFixed(0)
														+ "분";
												var tFare = resultData[0].properties.totalFare + " 원";
												var taxiFare =  resultData[0].properties.taxiFare + " 원";
												
												$("#moonyeseo_div").empty(); 
												
											// 경로 상세 정보 (moonyeseo_div 영역에 적을 코드)
												var route_msg = "<span style = 'font-weight: bold;'>경로 상세 정보</span><br><br>" +
												"<table style = 'width : 70%; margin-left: 0px'>" +
												"<tr style = 'text-align: left'><td>▷</td><td>총 거리</td><th>"+ tDistance + "</th></tr>" +
												"<tr style = 'text-align: left'><td>▷</td><td>총 시간</td><th>"+ tTime + "</th></tr>" + 
												"<tr  style = 'text-align: left'><td>▷</td><td>총 요금</td><th>" + tFare + "</th></tr>" + 
												"<tr  style = 'text-align: left'><td>▷</td><td>예상 택시 요금</td><th>" +  taxiFare  + "</th></tr>" + 
											"</table>"; 


												$("#moonyeseo_div").html(route_msg);

												//교통정보 표출 옵션값을 체크
												if (trafficInfochk == "Y") {
													for ( var i in resultData) { //for문 [S]
														var geometry = resultData[i].geometry;
														var properties = resultData[i].properties;

														if (geometry.type == "LineString") {
															//교통 정보도 담음
															chktraffic
																	.push(geometry.traffic);
															var sectionInfos = [];
															var trafficArr = geometry.traffic;

															for ( var j in geometry.coordinates) {
																// 경로들의 결과값들을 포인트 객체로 변환 
																var latlng = new Tmapv2.Point(
																		geometry.coordinates[j][0],
																		geometry.coordinates[j][1]);
																// 포인트 객체를 받아 좌표값으로 변환
																var convertPoint = new Tmapv2.Projection.convertEPSG3857ToWGS84GEO(
																		latlng);

																sectionInfos
																		.push(convertPoint);
															}

															drawLine(
																	sectionInfos,
																	trafficArr);
														} else {

															var markerImg = "";
															var pType = "";

															if (properties.pointType == "S") { //출발지 마커
																markerImg = "<%=request.getContextPath()%>/resources/image/start_marker.png";
																pType = "S";
															} else if (properties.pointType == "E") { //도착지 마커
																markerImg =   "<%=request.getContextPath()%>/resources/image/destination_marker.png",
																pType = "E";
															} else { //각 포인트 마커
																markerImg = "http://topopen.tmap.co.kr/imgs/point.png";
																pType = "P"
															}

															// 경로들의 결과값들을 포인트 객체로 변환 
															var latlon = new Tmapv2.Point(
																	geometry.coordinates[0],
																	geometry.coordinates[1]);
															// 포인트 객체를 받아 좌표값으로 다시 변환
															var convertPoint = new Tmapv2.Projection.convertEPSG3857ToWGS84GEO(
																	latlon);

															var routeInfoObj = {
																markerImage : markerImg,
																lng : convertPoint._lng,
																lat : convertPoint._lat,
																pointType : pType
															};
															// 마커 추가
															addMarkers(routeInfoObj);
														}
													}//for문 [E]

												} else {

													for ( var i in resultData) { //for문 [S]
														var geometry = resultData[i].geometry;
														var properties = resultData[i].properties;

														if (geometry.type == "LineString") {
															for ( var j in geometry.coordinates) {
																// 경로들의 결과값들을 포인트 객체로 변환 
																var latlng = new Tmapv2.Point(
																		geometry.coordinates[j][0],
																		geometry.coordinates[j][1]);
																// 포인트 객체를 받아 좌표값으로 변환
																var convertPoint = new Tmapv2.Projection.convertEPSG3857ToWGS84GEO(
																		latlng);
																// 포인트객체의 정보로 좌표값 변환 객체로 저장
																var convertChange = new Tmapv2.LatLng(
																		convertPoint._lat,
																		convertPoint._lng);
																// 배열에 담기
																drawInfoArr
																		.push(convertChange);
															}
															drawLine(
																	drawInfoArr,
																	"0");
														} else {

															var markerImg = "";
															var pType = "";

															if (properties.pointType == "S") { //출발지 마커
																markerImg = "<%=request.getContextPath()%>/resources/image/start_marker.png";
																pType = "S";
															} else if (properties.pointType == "E") { //도착지 마커
																markerImg = "<%=request.getContextPath()%>/resources/image/destination_marker.png",
																pType = "E";
															} else { //각 포인트 마커
																markerImg = "http://topopen.tmap.co.kr/imgs/point.png";
																pType = "P"
															}

															// 경로들의 결과값들을 포인트 객체로 변환 
															var latlon = new Tmapv2.Point(
																	geometry.coordinates[0],
																	geometry.coordinates[1]);
															// 포인트 객체를 받아 좌표값으로 다시 변환
															var convertPoint = new Tmapv2.Projection.convertEPSG3857ToWGS84GEO(
																	latlon);

															var routeInfoObj = {
																markerImage : markerImg,
																lng : convertPoint._lng,
																lat : convertPoint._lat,
																pointType : pType
															};

															// Marker 추가
															addMarkers(routeInfoObj);
														}
													}//for문 [E]
												}
											},
											error : function(request, status,
													error) {
												console.log("code:"
														+ request.status + "\n"
														+ "message:"
														+ request.responseText
														+ "\n" + "error:"
														+ error);
											}
										});
								//JSON TYPE EDIT [E]
							});
			map.addListener("click", onClick);
		}

		function addComma(num) {
			var regexp = /\B(?=(\d{3})+(?!\d))/g;
			return num.toString().replace(regexp, ',');
		}

		//마커 생성하기
		function addMarkers(infoObj) {
			var size = new Tmapv2.Size(64, 78);//아이콘 크기 설정합니다.

			if (infoObj.pointType == "P") { //포인트점일때는 아이콘 크기를 줄입니다.
				size = new Tmapv2.Size(8, 8);
			}

			marker_p = new Tmapv2.Marker({
				position : new Tmapv2.LatLng(infoObj.lat, infoObj.lng),
				icon : infoObj.markerImage,
				iconSize : size,
				map : map
			});

			resultMarkerArr.push(marker_p);
		}

		//라인그리기
		function drawLine(arrPoint, traffic) {
			var polyline_;

			if (chktraffic.length != 0) {

				// 교통정보 혼잡도를 체크
				// strokeColor는 교통 정보상황에 다라서 변화
				// traffic :  0-정보없음, 1-원활, 2-서행, 3-지체, 4-정체  (black, green, yellow, orange, red)

				var lineColor = "";

				if (traffic != "0") {
					if (traffic.length == 0) { //length가 0인것은 교통정보가 없으므로 검은색으로 표시

						lineColor = "#06050D";
						//라인그리기[S]
						polyline_ = new Tmapv2.Polyline({
							path : arrPoint,
							strokeColor : lineColor,
							strokeWeight : 6,
							map : map
						});
						resultdrawArr.push(polyline_);
						//라인그리기[E]
					} else { //교통정보가 있음

						if (traffic[0][0] != 0) { //교통정보 시작인덱스가 0이 아닌경우
							var trafficObject = "";
							var tInfo = [];

							for (var z = 0; z < traffic.length; z++) {
								trafficObject = {
									"startIndex" : traffic[z][0],
									"endIndex" : traffic[z][1],
									"trafficIndex" : traffic[z][2],
								};
								tInfo.push(trafficObject)
							}

							var noInfomationPoint = [];

							for (var p = 0; p < tInfo[0].startIndex; p++) {
								noInfomationPoint.push(arrPoint[p]);
							}

							//라인그리기[S]
							polyline_ = new Tmapv2.Polyline({
								path : noInfomationPoint,
								strokeColor : "#06050D",
								strokeWeight : 6,
								map : map
							});
							//라인그리기[E]
							resultdrawArr.push(polyline_);

							for (var x = 0; x < tInfo.length; x++) {
								var sectionPoint = []; //구간선언

								for (var y = tInfo[x].startIndex; y <= tInfo[x].endIndex; y++) {
									sectionPoint.push(arrPoint[y]);
								}

								if (tInfo[x].trafficIndex == 0) {
									lineColor = "#06050D";
								} else if (tInfo[x].trafficIndex == 1) {
									lineColor = "#61AB25";
								} else if (tInfo[x].trafficIndex == 2) {
									lineColor = "#FFFF00";
								} else if (tInfo[x].trafficIndex == 3) {
									lineColor = "#E87506";
								} else if (tInfo[x].trafficIndex == 4) {
									lineColor = "#D61125";
								}

								//라인그리기[S]
								polyline_ = new Tmapv2.Polyline({
									path : sectionPoint,
									strokeColor : lineColor,
									strokeWeight : 6,
									map : map
								});
								//라인그리기[E]
								resultdrawArr.push(polyline_);
							}
						} else { //0부터 시작하는 경우

							var trafficObject = "";
							var tInfo = [];

							for (var z = 0; z < traffic.length; z++) {
								trafficObject = {
									"startIndex" : traffic[z][0],
									"endIndex" : traffic[z][1],
									"trafficIndex" : traffic[z][2],
								};
								tInfo.push(trafficObject)
							}

							for (var x = 0; x < tInfo.length; x++) {
								var sectionPoint = []; //구간선언

								for (var y = tInfo[x].startIndex; y <= tInfo[x].endIndex; y++) {
									sectionPoint.push(arrPoint[y]);
								}

								if (tInfo[x].trafficIndex == 0) {
									lineColor = "#06050D";
								} else if (tInfo[x].trafficIndex == 1) {
									lineColor = "#61AB25";
								} else if (tInfo[x].trafficIndex == 2) {
									lineColor = "#FFFF00";
								} else if (tInfo[x].trafficIndex == 3) {
									lineColor = "#E87506";
								} else if (tInfo[x].trafficIndex == 4) {
									lineColor = "#D61125";
								}

								//라인그리기[S]
								polyline_ = new Tmapv2.Polyline({
									path : sectionPoint,
									strokeColor : lineColor,
									strokeWeight : 6,
									map : map
								});
								//라인그리기[E]
								resultdrawArr.push(polyline_);
							}
						}
					}
				} else {

				}
			} else {
				polyline_ = new Tmapv2.Polyline({
					path : arrPoint,
					strokeColor : "#FA64B0",
					strokeWeight : 6,
					map : map
				});
				resultdrawArr.push(polyline_);
			}

		}

		//초기화 기능
		function resettingMap() {
			//기존마커는 삭제
			//marker_s.setMap(null);
			//marker_e.setMap(null);

			if (resultMarkerArr.length > 0) {
				for (var i = 0; i < resultMarkerArr.length; i++) {
					resultMarkerArr[i].setMap(null);
				}
			}

			if (resultdrawArr.length > 0) {
				for (var i = 0; i < resultdrawArr.length; i++) {
					resultdrawArr[i].setMap(null);
				}
			}

			chktraffic = [];
			drawInfoArr = [];
			resultMarkerArr = [];
			resultdrawArr = [];
		}

		function onClick(e) {
			$("#moonyeseo_div").empty();	

			$("#moonyeseo_div").html(congestion_msg);		

			Clicklat = e.latLng._lat;
			Clicklon = e.latLng._lng;

			reverseLabel(Clicklon, Clicklat);
		}

		function reverseLabel(Clicklon, Clicklat) {
			zoomLevel = map.getZoom()
			if (zoomLevel < 15)
				zoomLevel = 15
			var headers = {};
			headers["appKey"] = "50L76VhFwD5nr7iApd9gS7yiECxEoMnd8y4QD4Vl";

			$.ajax({
						method : "GET",
						headers : headers,
						url : "https://apis.openapi.sk.com/tmap/geo/reverseLabel?version=1&format=json&callback=result",
						async : false,
						data : {
							"reqLevel" : zoomLevel,
							"centerLon" : Clicklon,
							"centerLat" : Clicklat,
							"reqCoordType" : "WGS84GEO",
							"resCoordType" : "WGS84GEO"
						},
						success : function(response) {
							var resultInfo = response.poiInfo;
							lat = resultInfo.poiLat;
							lon = resultInfo.poiLon;
							poiId = resultInfo.id;
							name = resultInfo.name;

							var selectLevel = "주변 + 장소 혼잡도";

							if (selectLevel == "장소 혼잡도") {
								url = "https://apis.openapi.sk.com/tmap/puzzle/pois/"
										+ poiId
										+ "?format=json&appKey="
										+ "50L76VhFwD5nr7iApd9gS7yiECxEoMnd8y4QD4Vl";
							} else {
								url = "https://apis.openapi.sk.com/tmap/puzzle/pois/"
										+ poiId
										+ "?format=json&appKey="
										+ "50L76VhFwD5nr7iApd9gS7yiECxEoMnd8y4QD4Vl"
										+ "&lat="
										+ Clicklat
										+ "&lng="
										+ Clicklon;
							}

							reset();
							puzzle(url, lon, lat, Clicklon, Clicklat);
						},

						error : function(request, status, error) {
							console.log("code:" + request.status + "\n"
									+ "message:" + request.responseText + "\n"
									+ "error:" + error);
						}
					});

		}

		function puzzle(url, lon, lat) {
			var selectLevel = "주변 + 장소 혼잡도";

			$.ajax({
						method : "GET",
						url : url,
						async : false,
						data : {},
						success : function(response) {
							//파라미터 초기화
							var congest, congestion, congestionLevel, datetime;
							var congest2, congestion2, congestionLevel2, datetime2;

							var rltm = response.contents.rltm;

							const totalCount = rltm.length;
							if (selectLevel == "장소 혼잡도") {
								for (var i = 0; i < rltm.length; i++) {
									if (rltm[i].type == 1) {
										congestion = (Number(rltm[i].congestion) * 100)
												.toFixed(2);
										congestionLevel = rltm[i].congestionLevel;
										datetime = rltm[i].datetime;
									}
								}
							} else if (selectLevel == "주변 혼잡도") {
								for (var i = 0; i < rltm.length; i++) {
									if (rltm[i].type == 2) {
										congestion = (Number(rltm[i].congestion) * 100)
												.toFixed(2);
										congestionLevel = rltm[i].congestionLevel;
										datetime = rltm[i].datetime;
									}
								}
							} else {
								for (var i = 0; i < rltm.length; i++) {
									if (rltm[i].type == 1) {
										congestion = (Number(rltm[i].congestion) * 100)
												.toFixed(2);
										congestionLevel = rltm[i].congestionLevel;
										datetime = rltm[i].datetime;
									} else if (rltm[i].type == 2) {
										congestion2 = (Number(rltm[i].congestion) * 100)
												.toFixed(2);
										congestionLevel2 = rltm[i].congestionLevel;
										datetime2 = rltm[i].datetime;
									}
								}
							}

							//혼잡도 별 분기 처리
							if (selectLevel == "장소 혼잡도"
									|| selectLevel == "주변 혼잡도") {
								const colorObj = congestionLevelColor(congestionLevel)
								color = colorObj.color
								congest = colorObj.congest
							} else {
								if (totalCount < 2) {
									const colorObj2 = congestionLevelColor(congestionLevel2)
									color2 = colorObj2.color
									congest2 = colorObj2.congest
								} else {
									const colorObj = congestionLevelColor(congestionLevel)
									color = colorObj.color
									congest = colorObj.congest

									const colorObj2 = congestionLevelColor(congestionLevel2)
									color2 = colorObj2.color
									congest2 = colorObj2.congest
								}
							}

							// 주변 혼잡도일때만 격자 표출
							if (selectLevel == "주변 혼잡도") {
								rect = new Tmapv2.Rectangle(
										{
											bounds : new Tmapv2.LatLngBounds(
													new Tmapv2.LatLng(
															Number(Clicklat) + 0.0014957,
															Number(Clicklon) - 0.0018867),
													new Tmapv2.LatLng(
															Number(Clicklat) - 0.0014957,
															Number(Clicklon) + 0.0018867)),// 사각형 영역 좌표
											strokeColor : "#000000", //테두리 색상
											strokeWeight : 2.5,
											strokeOpacity : 1,
											fillColor : color, // 사각형 내부 색상
											fillOpacity : 0.5,
											map : map
										// 지도 객체
										});
							} else if (selectLevel == "주변 + 장소 혼잡도") {
								rect = new Tmapv2.Rectangle(
										{
											bounds : new Tmapv2.LatLngBounds(
													new Tmapv2.LatLng(
															Number(Clicklat) + 0.0014957,
															Number(Clicklon) - 0.0018867),
													new Tmapv2.LatLng(
															Number(Clicklat) - 0.0014957,
															Number(Clicklon) + 0.0018867)),// 사각형 영역 좌표
											strokeColor : "#000000", //테두리 색상
											strokeWeight : 2.5,
											strokeOpacity : 1,
											fillColor : color2, // 사각형 내부 색상
											fillOpacity : 0.5,
											map : map
										// 지도 객체
										});
							}

							if (selectLevel == "주변 + 장소 혼잡도") {
								if (totalCount < 2) {

								} else {
									//글자수에 따라 width 설정
									var wordsLength = name.length;
									var puzzle = "[" + congest + ", "
											+ congestion + "명/100m²]";

									var puzzleLength = puzzle.length;
									var infoWindowWidth;
									var gap
									if (wordsLength - 10 > puzzleLength - 17) {
										gap = wordsLength - 10
										infoWindowWidth = 125 + (11 * gap)
									} else {
										gap = puzzleLength - 17

										if (congestionLevel == 4) {
											infoWindowWidth = 128 + (8 * gap)
										} else {
											infoWindowWidth = 125 + (8 * gap)
										}
									}

									content1 = "<div style='width:" + infoWindowWidth + "px;height:40px;background:#000000; color:#ffffff; border : 1px solid #000000;border-radius: 5px' >"
											+ "<div style='margin-left:5px'>"
											+ name
											+ "</div>"
											+ "<div style='margin-left:5px'>"
											+ puzzle + "</div></div>"

									content2 = "<div style='background:#000000; color:#ffffff; border : 1px solid #000000;border-radius: 5px;height:40px;width:150px'>"
											+ "<div style='margin-left:5px'>"
											+ name
											+ "</div>"
											+ "<div style='margin-left:5px'>["
											+ congest
											+ ", "
											+ congestion
											+ "명/100m²]</div></div>"

									content3 = "<div style='width:125px;height:40px;background:#000000; color:#ffffff; border : 1px solid #000000;border-radius: 5px' >"
											+ "<div style='margin-left:5px'>"
											+ name
											+ "</div>"
											+ "<div style='margin-left:5px'>["
											+ congest
											+ ", "
											+ congestion
											+ "명/100m²]</div></div>"

									if (wordsLength > 12) {
										content = content1;
									} else if (wordsLength > 10) {
										if (congestionLevel == 4) {
											content = content2;
										} else {
											content = content1;
										}
									} else {
										if (congestionLevel == 4) {
											content = content2;
										} else {
											content = content3;
										}
									}
									InfoWindow = new Tmapv2.InfoWindow({
										position : new Tmapv2.LatLng(lat, lon),
										type : 2,
										content : content,
										border : '0px solid #FFFFFF',
										background : false,
										offset : new Tmapv2.Point(50, 76),
										map : map
									});

									marker = new Tmapv2.Marker(
											{
												position : new Tmapv2.LatLng(
														lat, lon), //Marker의 중심좌표 설정.
												iconHTML : "<div style='border-left : solid #000000; height : 32px;'></div>",
												iconSize : new Tmapv2.Size(20,
														20),
												offset : new Tmapv2.Point(1, 36),
												map : map
											//Marker가 표시될 Map 설정..
											});
								}
							} else if (selectLevel == "주변 혼잡도") {

							} else {
								//글자수에 따라 width 설정
								var wordsLength = name.length;
								var puzzle = "[" + congest + ", " + congestion
										+ "명/100m²]";
								var puzzleLength = puzzle.length;
								var infoWindowWidth;
								var gap
								if (wordsLength - 10 > puzzleLength - 17) {
									gap = wordsLength - 10
									infoWindowWidth = 125 + (11 * gap)
								} else {
									gap = puzzleLength - 17

									if (congestionLevel == 4) {
										infoWindowWidth = 128 + (8 * gap)
									} else {
										infoWindowWidth = 125 + (8 * gap)
									}
								}

								content1 = "<div style='width:" + infoWindowWidth + "px;height:40px;background:#000000; color:#ffffff; border : 1px solid #000000;border-radius: 5px' >"
										+ "<div style='margin-left:5px'>"
										+ name
										+ "</div>"
										+ "<div style='margin-left:5px'>"
										+ puzzle + "</div></div>"

								content2 = "<div style='background:#000000; color:#ffffff; border : 1px solid #000000;border-radius: 5px;height:40px;width:150px'>"
										+ "<div style='margin-left:5px'>"
										+ name
										+ "</div>"
										+ "<div style='margin-left:5px'>["
										+ congest
										+ ", "
										+ congestion
										+ "명/100m²]</div></div>"

								content3 = "<div style='width:125px;height:40px;background:#000000; color:#ffffff; border : 1px solid #000000;border-radius: 5px' >"
										+ "<div style='margin-left:5px'>"
										+ name
										+ "</div>"
										+ "<div style='margin-left:5px'>["
										+ congest
										+ ", "
										+ congestion
										+ "명/100m²]</div></div>"

								if (wordsLength > 12) {
									content = content1;
								} else if (wordsLength > 10) {
									if (congestionLevel == 4) {
										content = content2;
									} else {
										content = content1;
									}
								} else {
									if (congestionLevel == 4) {
										content = content2;
									} else {
										content = content3;
									}
								}
								InfoWindow = new Tmapv2.InfoWindow({
									position : new Tmapv2.LatLng(lat, lon),
									type : 2,
									content : content,
									border : '0px solid #FFFFFF',
									background : false,
									offset : new Tmapv2.Point(50, 76),
									map : map
								});

								marker = new Tmapv2.Marker(
										{
											position : new Tmapv2.LatLng(lat,
													lon), //Marker의 중심좌표 설정.
											iconHTML : "<div style='border-left : solid #000000; height : 32px;'></div>",
											iconSize : new Tmapv2.Size(20, 20),
											offset : new Tmapv2.Point(1, 36),
											map : map
										//Marker가 표시될 Map 설정..
										});
							}

							var year, month, day, hour, min, sec, date;
							var year2, month2, day2, hour2, min2, sec2, date2

							if (selectLevel == "주변 + 장소 혼잡도") {
								if (totalCount < 2) {
									year2 = datetime2.substr(0, 4);
									month2 = datetime2.substr(4, 2);
									day2 = datetime2.substr(6, 2);
									hour2 = datetime2.substr(8, 2);
									min2 = datetime2.substr(10, 2);
									sec2 = datetime2.substr(12, 2);
									date2 = year2 + "년 " + month2 + "월 " + day2
											+ "일 " + hour2 + "시 " + min2 + "분 "
											+ sec2 + "초";

									result = "[장소] POI ID : "
											+ poiId
											+ ", "
											+ name
											+ ", 해당 좌표는 실시간 장소 혼잡도를 지원하고 있지 않습니다."
											+ "</br>";
									result += "[주변] POI ID : " + poiId + ", "
											+ name + ", [" + congest2 + ", "
											+ congestion2 + "명/100m²], "
											+ date2
								} else {
									year = datetime.substr(0, 4);
									month = datetime.substr(4, 2);
									day = datetime.substr(6, 2);
									hour = datetime.substr(8, 2);
									min = datetime.substr(10, 2);
									sec = datetime.substr(12, 2);
									date = year + "년 " + month + "월 " + day
											+ "일 " + hour + "시 " + min + "분 "
											+ sec + "초";

									year2 = datetime2.substr(0, 4);
									month2 = datetime2.substr(4, 2);
									day2 = datetime2.substr(6, 2);
									hour2 = datetime2.substr(8, 2);
									min2 = datetime2.substr(10, 2);
									sec2 = datetime2.substr(12, 2);
									date2 = year2 + "년 " + month2 + "월 " + day2
											+ "일 " + hour2 + "시 " + min2 + "분 "
											+ sec2 + "초";

									result = "[장소] POI ID : "
											+ response.contents.poiId + ", "
											+ name + ", [" + congest + ", "
											+ congestion + "명/100m²], " + date
											+ "</br>"

									result += "[주변] POI ID : "
											+ response.contents.poiId + ", "
											+ name + ", [" + congest2 + ", "
											+ congestion2 + "명/100m²], "
											+ date2
								}

							} else {
								//년월일 시분초 시간 나누기 
								year = datetime.substr(0, 4);
								month = datetime.substr(4, 2);
								day = datetime.substr(6, 2);
								hour = datetime.substr(8, 2);
								min = datetime.substr(10, 2);
								sec = datetime.substr(12, 2);
								date = year + "년 " + month + "월 " + day + "일 "
										+ hour + "시 " + min + "분 " + sec + "초";

								result = "POI ID : " + response.contents.poiId
										+ ", " + name + ", [" + congest + ", "
										+ congestion + "명/100m²], " + date
							}

							//$("#result").text(result);
							var resultDiv = document.getElementById("result");
							resultDiv.innerHTML = result;

						},
						error : function(request, status, error) {
							if (request.status == "404") {
								result = 'POI ID : ' + poiId + ", " + name
										+ ', 해당 좌표는 실시간 장소 혼잡도를 지원하고 있지 않습니다.';
								$("#result").text(result);
							} else {

								console.log("code:" + request.status + "\n"
										+ "message:" + request.responseText
										+ "\n" + "error:" + error);
							}
						}
					});

		}

		//혼잡도별 색상, 혼잡도 표시 함수
		function congestionLevelColor(congestionLevel) {
			var congest = ""
			var color = ""

			switch (congestionLevel) {
			case 1:
				congest = "여유";
				color = '#9FC93C';
				break;
			case 2:
				congest = "보통";
				color = '#8F89E9';
				break;
			case 3:
				congest = "혼잡";
				color = '#FBD2BD';
				break;
			case 4:
				congest = "매우 혼잡";
				color = '#FA64B0';
				break;
			}
			return {
				"color" : color,
				"congest" : congest
			}
		}

		function reset() {
			if (InfoWindow != undefined) {
				InfoWindow.setMap(null);
				InfoWindow = undefined;
			}
			if (marker != undefined) {
				marker.setMap(null);
			}
			if (rect != undefined) {
				rect.setMap(null);
				rect = undefined;
			}
		}
		
	</script>
	
	<!-- 챗봇 -->
<div id="asideChatbot" class="asideChatbot " style="heigth: 80%">
	<%@include file="../chatbot/chatbot.jsp"%>
</div>

<div id="chatbotIcon" style="heigth: 20%">
	<%@include file="../chatbot/chatbotIcon.jsp"%>
</div>

	<div id="contact" class="contact-us section" >
		<div class="container">
			<div class="row">
				<div class="col-lg-6 offset-lg-3">
					<div class="section-heading wow fadeIn" data-wow-duration="1s"
						data-wow-delay="0.5s">
						<h6>Navigation</h6>
						<h4><em>길</em> 찾기</h4>  
						<div class="line-dec"></div>
					</div>
				</div>
				<div class="col-lg-12 wow fadeInUp" data-wow-duration="0.5s"
					data-wow-delay="0.25s">
					<form id="contact" onSubmit="return false">
						<div class="row">
							<div class="col-lg-12">
								<div class="contact-dec">
									<img
										src="<%=request.getContextPath()%>/resources/assets/images/contact-dec.png"
										alt="">
								</div>
							</div>
							<div class="col-lg-5">
								<div id="map">
									<div id="map_wrap" class="map_wrap3">
										<div id="map_div" class="map_wrap"></div>
									</div>
								</div>
							</div>
							<div class="col-lg-7">
								<div class="fill-form">
									<div class="row ft_area">
										<div class="col-lg-12">
											<div class="ft_select_wrap">
												<div class="ft_select">
													<select id="selectLevel">
														<option value="0" selected="selected">추천 경로</option>
														<option value="1">무료 경로 우선</option>
														<option value="2">최소 소요 시간 경로</option>
														<!-- 														<option value="3">교통최적+초보</option> -->
														<option value="4">고속도로 우선 경로</option>
														<!-- 														<option value="10">최단거리+유/무료</option>
														<option value="12">이륜차도로우선</option>
														<option value="19">교통최적+어린이보호구역 회피</option> -->
													</select> &ensp; <select id="year">
														<option value="N" selected="selected">교통정보 표출 여부</option>
														<option value="Y">YES</option>
														<option value="N">NO</option>
													</select>
												</div>
													<div class="col-lg-12">
													
														<fieldset>
															<input type="text" name="startAddr" id="startAddr"
																placeholder="출발지 입력" onKeyDown = "keyDown()" autocomplete="on" required>
														</fieldset>
														
															<table style = "width : 90%; margin-left : 15px; margin-top : 20px; table-layout: fixed; ">
																<tr style = "height : 13px">
																	<td>
																		<div onClick = "getAddr(this, '${house}')" id = "house"><img src = "<%=request.getContextPath() %>/resources/image/house_before.png" alt = "house_img" style = "opacity:0.5"></div>
																	</td>
																	<td></td>
																	<td>
																		<div onClick = "getAddr(this, '${company}')" id = "company"><img src = "<%=request.getContextPath() %>/resources/image/company_before.png"  alt = "com_img"></div>
																	</td>
																	<td ></td>
																	<td>
																		<div onClick = "getAddr(this, '${star}')" id = "star"><img src = "<%=request.getContextPath() %>/resources/image/star_before.png"  alt = "star_img" style = "opacity:0.5"></div>
																	</td>
																	
																	<td style = "width : 70%"></td>
																	<td style = "width : 7%">
																		<div onClick = "addrChange(this)" id = "change"><img src = "<%=request.getContextPath() %>/resources/image/change_before.png" width = "100%" height = "100%" alt = "change_img"></div>
																	</td>
																</tr>
															</table>
															
														<fieldset>
															<input type="text" name="endAddr" id="endAddr"
																placeholder="목적지 입력"  value = "${param.place }"  required="">
														</fieldset>
													</div>
													
												<div class="col-lg-12">
													<fieldset>
														<button id="btn_route">길 찾기</button>
													</fieldset>
												</div>
												<div class = "col-lg-12" id = "moonyeseo_div"></div>
												<br><br><span style = 'font-size: 13px'>※ 장소혼잡도는 지도 확대 후 클릭 시 확인 가능</span>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

<%@include file = "../userCommon/userFooter.jsp" %> <!--  user header 부분 -->