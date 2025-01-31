<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<style type="text/css">
.chatbot {
	float: left;
	background-color: #F6F6F6;
	color: black;
	border-radius: 10px;
	width: 60%;
	text-align: left;
	margin: 10px;
	padding: 5px;
	border-radius: 10px;
} 
 
.user {
	float: right;
	/* background-color: #EAEAEA; */
	border: 1px solid #EAEAEA;
	width: 60%;
	text-align: left;
	border-radius: 10px;
	margin: 10px;
	padding: 5px;
	width: 60%;
}

/* 노멀라이즈 */
body {
	margin: 0;
	padding: 0;
}

.side-bar {
	position: fixed; /* 스크롤을 따라오도록 지정 */
	background-color: white;
	color: black;
	width: 300px;
	right: 0;
	margin-top: calc(( 100vh - var(- -side-bar-height))/2);
	/* 사이드바 위와 아래의 마진을 동일하게 지정 */
	z-index: 2; /*사이드바 맨 앞에 보이게 설정*/
	padding-top: 10px; 
	border-radius: 10px;
}

input {
	padding: 5px;
	display: inline;
	border-radius: 20px;
	border: 1px solid #EAEAEA;
}

input:focus {
	outline: none;
}
</style>

<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
   $(document).ready(
         function() {

            /*  챗봇 */
            $('#chatSend').on(
                  'submit',
                  function(event) {
                     event.preventDefault();
                     
                     $("#chatting").append("<span class='user'>"+ $("#inputText").val() +"</span>");
                     $("#inputText").focus(); 

                     $.ajax({
                        type : "post",
                        url : "chatbotSend.chatbot",
                        data : ({
                           inputText : $("#inputText").val()
                        }),
                        success : function(data) {
                        	$("#chatting").append("<span class='chatbot'>" + data +"</span>"); // 답변 띄우기
                         	$("#chatArea").scrollTop($("#chatArea")[0].scrollHeight); // 스크롤 하단 고정

                           $("#inputText").val(""); 
                         	
                         	if(data == "전체 행사 목록을 보여드릴게요!"){
                             	
                             	setTimeout(function() {
                             		 location.href = "list.event";
                             		}, 2000);
                         	}
                       	else if(data.indexOf("👍") != -1){
                       		const  keyword = data.split(' ', 1);
                         		
                             	setTimeout(function() {
                             		//alert(keyword);
                            		 location.href = "list.event?whatColumn=performance_type&keyword=" + keyword;
                            		}, 2000);
                         	} 
                       	else if(data.indexOf("👌") != -1){
                       		setTimeout(function() {
                       			// 날짜 정보 가져오기
                       			date = new Date(); // 현재 날짜(로컬 기준) 가져오기
                       			utc = date.getTime() + (date.getTimezoneOffset() * 60 * 1000); // uct 표준시 도출
                       			kstGap = 9 * 60 * 60 * 1000; // 한국 kst 기준시간 더하기
                       			today = new Date(utc + kstGap); // 한국 시간으로 date 객체 만들기(오늘)
                       			todayDate = today.getDate();
                       			
                				var popupW = 900;
                		    	var popupH = 700;
                		    	var left = (document.body.offsetWidth - popupW) / 2;
                		    	var top = (window.screen.height - popupH) / 2;
                		    	
                		    	popup = window.open("calendar.event?year="+today.getFullYear()+ "&month=" + (today.getMonth()+1) + "&day=" + today.getDate(), "calendar", "width=" + popupW + ",height =" + popupH +", left=" + left + ",top=" + top + ",scrollbars=yes,resizable=no,toolbar=no,titlebar=no,menubar=no,location=no");
                			
                        		}, 2000);
                       		} 
                        },
                        error : function(request, status, error) {
                         /*   alert("error : " + request.status
                                 + "\n msg : "
                                 + request.responseText); */
                                 
                        	 $("#chatting").append("<span class='chatbot'>오류 발생<br> 다시 시도 해주세요.</span>");
                        }
                     });
                  });
         });
</script>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<aside class="side-bar" style="height: 60%; box-shadow: 0 14px 28px rgba(0,0,0,0.25), 0 10px 10px rgba(0,0,0,0.22);bottom : 100px">
	<div style = "text-align:center;">
		<strong>GoOrNo</strong>
			<button  class="btn btn-outline-light"
				style="color: black; font-size: 9pt; border: 1px solid #F6F6F6; float:right" id = "close">닫기</button>
	</div>
	<div id = "chatArea" style="font-size: 9pt; height: 85%; overflow-y: auto; background-color: white; margin-top : 10px">
		<span class="chatbot">안녕하세요.<br>서울 행사의 모든 것을 담다, 갈까말까?
			입니다.<br>궁금한 사항을 입력하세요😊
		</span>
		<div id="chatting"></div>
		<br> <br>
	</div>
	<div style="margin-top:5px; weight : 100%; padding-left : 5px">
		<form id="chatSend">
			<input type="text" name="inputText" id="inputText" placeholder=""
				autocomplete="on" required size = "23">
			<button type="submit" class="btn btn-outline-light"
				style="color: black; font-size: 9pt; border: 1px solid #F6F6F6">전송</button>
		</form>
	</div>
</aside>