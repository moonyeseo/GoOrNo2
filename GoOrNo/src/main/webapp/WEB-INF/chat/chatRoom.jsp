<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%> 

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" 
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@100;200;300;400;500;600;700;800;900&display=swap"
	rel="stylesheet">

<!-- Bootstrap core CSS -->
<link
	href="<%=request.getContextPath()%>/resources/vendor/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">


<!-- Additional CSS Files -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/assets/css/fontawesome.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/assets/css/templatemo-digimedia-v1.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/assets/css/animated.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/assets/css/owl.css">
<!--

TemplateMo 568 DigiMedia

https://templatemo.com/tm-568-digimedia

-->

<!-- 한글 글씨체(추가) -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap"
	rel="stylesheet">
<title>Simple Chat</title>

<!-- font awesome icon 추가 -->
</head>
<style type="text/css">
body {
	background-color: #FFE6EB;
}

#middle{
	height: 70%;
	overflow-y: scroll;
}

#middle::-webkit-scrollbar {
    background-color: inherit;
  }
#middle::-webkit-scrollbar-thumb {
    background-color: white;
  }

#top{
	height: 10%;
	padding: 10px;
} 

#bottom{
	height: 20%;
	background-color: white;
	padding: 10px;
}

#me, #you{
	background-color: white;
	padding: 10px;
	margin: 3px;
	font-size: small;
}
#me{
	margin-left: 50px;
}
#you{
	margin-right: 50px;
}
textarea:focus {
  outline: none !important;
  box-shadow: none !important;
}
.form-control:disabled{
background-color : white;
}
#confirmPopup {
  position:absolute;
  border: 1px solid #F6F6F6;
  border-radius: 10px;
  height: 150px;
  width: 300px;
  text-align: center;
  top:10%;
  left:10%;
  padding-top:20px;
  background-color: white;
}
#modal_background{
  position: fixed;
  top:0; left: 0; bottom: 0; right: 0;
  background: rgba(0, 0, 0, 0.2);
}
</style>
<script src="https://kit.fontawesome.com/792ff227d5.js" crossorigin="anonymous"></script>

<body>
<jsp:useBean id="now" class="java.util.Date"/>
<fmt:formatDate value="${now}" pattern="yyyy-MM-dd HH:mm:ss" var="now" />

<!-- 모달 배경 -->
<div id="modal_background" style="display: none;">
	<!-- 모달창 -->
	<div id="confirmPopup" class="popup-wrap" aria-modal="true" >
	  <div class="popup-inner">
	    <div class="popup-header" style="height: 30%">
	      <h3 class="popup-title">${ chatInfo.alias }</h3>
	    </div>
	    <div class="popup-body" style="height: 40%">
	      <p>채팅방을 나가시겠습니까?</p>
	    </div>
	    <div class="popup-footer" style="height: 30%">
	      <div class="btn-area">
	        <button type="button" class="btn btn-light btn-sm" id="btn-close">취소</button>
	        <button type="button" class="btn btn-secondary btn-sm" id="btn-confirm">나가기</button>
	      </div>
	    </div>
	  </div>
	</div>
</div>

<!-- 본문 -->
<div class="container">
	<!-- 상단부 -->
	<div class="row" id="top">
		<div class="col-lg-12">
			<!-- 채팅방 이름 -->
			<b>${ chatInfo.alias }</b>
			<!-- 채팅 나가기 -->
			<div style="float: right">
				<font size="2px"><a id="btn-showPopup" style="cursor : pointer;">나가기</a></font>
			</div>
		</div>
		<!-- 채팅방 인원/정원 -->
		<div class="col-lg-12" style="margin-top: -5px;">
			<svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" fill="currentColor" class="bi bi-person-fill" viewBox="0 0 16 16">
			  <path d="M3 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6"/>
			</svg>
			<font size="2px">${ chatInfo.headcount } / ${ chatInfo.maxcount }</font>
		</div>
	</div>
	
	<!-- 중앙부 -->
	<div class="row" id="middle">
		<div class="col-lg-12" id="display">
			<!-- 채팅 화면 시작 -->
				<!-- Server responses get written here -->
				<table id="messages" width="100%">
					<c:forEach var="message" items="${ mlists }">
						<fmt:parseDate var="pSendTime" pattern="yyyy-MM-dd HH:mm:ss.sss" value="${ message.sendTime }"/>
						<fmt:formatDate var="fSendTime" value="${ pSendTime }" pattern="yyyy-MM-dd HH:mm:ss"/>
						<c:if test="${ fn:substring(now, 0, 10) eq fn:substring(fSendTime, 0, 10) }">
							<fmt:formatDate var="fSendTime" value="${ pSendTime }" pattern="HH:m"/>
						</c:if>
						<tr>
							<!-- 내가 보낸 메세지 -->
							<c:if test="${ message.user_id eq loginInfo.id }">
								<td align="right">
									<font size="1px">${ fSendTime }</font>
									<div id="me"><font>${ message.content }</font></div>
								</td>
							</c:if>
							<c:if test="${ message.user_id ne loginInfo.id }">
								<!-- 채팅 시스템 메시지 -->
								<c:if test="${ message.user_id eq 'info' }">
									<td align="center" style="padding: 3px;">
										<div><font size="2px">${ message.content }</font></div>
									</td>
								</c:if>
								<!-- 상대가 보낸 메시지 -->
								<c:if test="${ message.user_id ne 'info' }">
									<!-- 탈퇴한 회원인 경우 -->
									<c:if test="${ message.user_no eq '' }">
										<td align="left">
											<font size="1px"><b>탈퇴한 회원</b> ${ fSendTime }</font><br>
											<div id="you"><font>${ message.content }</font></div>
										</td>
									</c:if>
									<c:if test="${ message.user_no ne '' }">
										<td align="left">
											<font size="1px"><b>${ message.user_id }</b> ${ fSendTime }</font><br>
											<div id="you"><font>${ message.content }</font></div>
										</td>
									</c:if>
								</c:if>
							</c:if>
						</tr>
					</c:forEach>
				</table>
				<div id="here"></div>
		    <!-- 채팅 화면 끝 -->
		    
		</div>
	</div>
	<!-- 하단부 -->
	<div class="row" id="bottom">
        <!-- 채팅 입력창 -->
		<div class="col-lg-10">
	        <input type="text" id="sender" value="${sessionScope.id}" style="display: none;">
	        <textarea onkeyup="validate()" class="form-control border-0 focus-ring-0" id="messageinput" rows="2" style="resize : none;" maxlength="60"></textarea>
		</div>
		<!-- 전송 버튼 -->
		<div class="col-lg-2">
	        <button type="button" class="btn" id="sendBtn" onclick="send();" style="float: right; background-color: #FBD2BD;" disabled="disabled">전송</button>
		</div>
	</div>					
</div>
<!-- 본문 끝 -->

</body>

<!-- websocket javascript -->
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/vendor/jquery/jquery.js"></script>
<script type="text/javascript">
    var ws;
    var messages = document.getElementById("messages");
    var isFull = '${ isFull }';
    var input = document.getElementById("messageinput");
    var chat_no = '${ param.chat_no }';
    
    //모달
    $("#btn-showPopup").on("click", () => {
      $("#modal_background").show();
    })

    $("#btn-close").on("click", () => {
      $("#modal_background").hide();
    })
	
    $("#btn-confirm").on("click", () => {
      // 채팅창 나가기 실행
      location.href = "delete.chat?chat_no="+chat_no;
      $("#modal_background").hide();
    })
    
    //엔터키 눌러도 메세지 전송
    input.addEventListener("keyup", function (event) {
      if (event.keyCode === 13) {
        //event.preventDefault();
        document.getElementById("sendBtn").click();
      }
    });
    
	// 팝업창이 닫힐 때 함수 실행하기
    window.onbeforeunload = function() {
        // 실행할 내용
	    if(isFull == "yes"){
	    	$(opener.location).attr("href", "javascript:alertFull();"); //정원이 다 차서 닫는거면 부모창 함수 호출
	    }else{
    		window.opener.parent.location.reload(); //그냥 닫을 땐 부모창 새로고침(채팅방 생성 or 메세지 내용 업데이트)
	    }
    };
    
    //입장 버튼 눌렀는데 정원이 다 찬 경우 현재창 닫고 위의 함수에서 부모창 alert 띄우는 함수 실행
    if(isFull == "yes"){
	    window.close();
    }
    
    //openSocket
    function openSocket(){
        if(ws !== undefined && ws.readyState !== WebSocket.CLOSED ){
            writeResponse("WebSocket is already opened.");
            return;
        }
        //웹소켓 객체 만드는 코드
        ws = new WebSocket("ws://localhost:8081/echo.do");
        
        ws.onopen = function(event){
            if(event.data === undefined){
          		return;
            }
            writeResponse(event.data);
        };
        
        ws.onmessage = function(event){
            console.log('writeResponse');
            console.log(event.data)
            writeResponse(event.data);
			
            //스크롤바 맨 밑으로
			var location = document.querySelector("#here").offsetTop;
			document.getElementById("middle").scrollTo({top:location, behavior:'smooth'});
			
			//전송 버튼 비활성화
			document.getElementById("sendBtn").disabled = true;
        };
        
        ws.onclose = function(event){
            writeResponse("대화 종료");
        }
    }
    
    //메세지 보내기 & DB저장
    function send(){
       // var text=document.getElementById("messageinput").value+","+document.getElementById("sender").value;
        var content = document.getElementById("messageinput").value;
        var text = document.getElementById("messageinput").value+","+document.getElementById("sender").value;
        var chat_no = '${ chatInfo.chat_no }';
        ws.send(text);
        
        $.ajax({
    		type : "post",
    		url : "save.chat",
    		data : {
    			content : content,
    			chat_no : chat_no
    		},	
    		dataType : "json",
    		success : function(cnt){
   		        //입력창 리셋
   		        document.getElementById("messageinput").value = "";
    		},
    		error : function(request,status,error){
    			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
    		}
    	});
    }
    
    function closeSocket(){
        ws.close();
    }
    
    //메세지를 화면에 띄움
    function writeResponse(text){
        messages.innerHTML += text;
    }
    
    //전송 버튼 활성화
    function validate(){
    	var sendBtn = document.getElementById("sendBtn");
    	var inputMsg = document.getElementById("messageinput").value;
    	if(inputMsg.trim() != ""){
			sendBtn.disabled = false;    		
    	}else{
			sendBtn.disabled = true;    		
    	}
    }
    
    //채팅방 나가기
    function exitChat(chat_no){
       	location.href = "delete.chat?chat_no="+chat_no;
    }

  	//채팅방 입장시 실행
    $(function(){
	 	// 팝업 창 크기를 HTML 크기에 맞추어 자동으로 크기를 조정하는 함수
    	window.resizeTo( 400, 700 );
	 	
	 	//스크롤 맨 밑으로
	 	var location = document.querySelector("#here").offsetTop;
 		document.getElementById("middle").scrollTo({top:location});
    	
    	//웹소켓 연결
    	openSocket();
		
    	//기존 채팅방에 새 유저 입장시 실시간으로 메세지 띄우기
    	var isNew = '${ isNew }';
    	if(isNew == "new"){
    		setTimeout(function() {
	    		var text = document.getElementById("sender").value+"님이 입장했습니다.,info";
	    		ws.send(text);
  			}, 300);
    	}
    	
    	//관리자 아이디로 접속시 전송 버튼 비활성화
    	var isAdmin = '${ param.isAdmin }';
    	if(isAdmin == "yes"){
	    	document.getElementById("messageinput").disabled = true;
	    	document.getElementById("btn-showPopup").style.display = "none";
	    	document.getElementById("messageinput").value = "관리자 페이지에서는 채팅을 할 수 없습니다.";
    	}
    	
    	//채팅방 나가기 버튼 누른후 컨트롤러에서 돌아옴
	 	var isExit = '${ isExit }';
	 	if(isExit == 'yes'){
	 		setTimeout(function() {
	    		var text = document.getElementById("sender").value+"님이 나갔습니다.,info";
	    		ws.send(text);
  			}, 100);
	 		setTimeout(function() {
	 			window.close();
  			}, 150);
	 	}
    	
    });
    
</script>