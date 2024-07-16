<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ include file = "../userCommon/userHeader.jsp" %>
<!-- font awesome icon 추가 -->
<script src="https://kit.fontawesome.com/792ff227d5.js" crossorigin="anonymous"></script>

<!-- 본문 시작 -->
<div id="contact" class="contact-us section">
	<div class="container">
		<div class="row">
			<!-- 본문 제목 -->
			<div class="col-lg-6 offset-lg-3">
				<div class="section-heading wow fadeIn" data-wow-duration="1s"
					data-wow-delay="0.5s">
					<br>
					<h6>community</h6>
					<h4>
			 			<a href="list.board" style="color:inherit;"><em>채팅</em>게시판</a>
					</h4>
					<div class="line-dec"></div>
				</div>
			</div>
			
			<!-- 테두리 안 본문 내용 -->
			<div class="col-lg-12 wow fadeInUp" data-wow-duration="0.5s" data-wow-delay="0.25s">
				<section class="section">
					<div class="row">
						<div class="col-lg-10 offset-lg-1">
							<div class="card" style="border: none;">
								<div class="card-body">
									
									<!-- 채팅방 생성 아이콘-->
									<div align="right" style="margin-bottom: 10px">
							    	<span class='fa-stack fa-lg' onclick="popInsertForm()">
								        <i class='fa-solid fa-comment fa-stack-2x' style="color: #FBD2BD;"></i>
										<i class="fa-solid fa-plus fa-stack-1x fa-inverse"></i>
									</span>
									</div>
									
									<!-- 채팅 리스트 -->
									<div class="row row-cols-1 row-cols-md-3 g-4">
										<c:forEach var="chat" items="${ clists }">
										  <div class="col">
										    <div class="card h-100">
										     <div class="card-header bg-transparent">${ chat.alias }</div>
										      <div class="card-body">
										        <p class="card-text">${ chat.lastChat }</p>
										      </div>
										      <div class="card-footer text-center bg-transparent border-white">
										      	<a onClick="popChatRoom('${ chat.chat_no }')" class="btn" style="background-color: #FA64B0; color: white;">채팅방 입장</a>
										      </div>
										    </div>
										  </div>
									  	</c:forEach>
									</div>
									<div align="center" style="margin-top: 20px;">
										${ pageInfo.pagingHtml }
									</div>
										
								</div>
							</div>
						</div>
					</div>
				</section>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript" src="<%= request.getContextPath() %>/resources/vendor/jquery/jquery.js"></script>
<script type="text/javascript">

const id = '${ sessionScope.id }';

//채팅방 다 찬 경우 alert
function alertFull(){
	alert("채팅방 정원이 다 찼습니다.");
}

//채팅방 입력폼 띄우기
function popInsertForm(){
	//alert(id);
	
	if(id == ""){
		alert("로그인한 회원만 채팅방을 생성할 수 있습니다.");
		return;
	}
	
	//팝업창 크기
	var _width = 350;
	var _height = 250;

	var _top = Math.ceil(( window.screen.height - _height )/2) - 100;
	var _left = Math.ceil(( window.screen.width - _width )/2);
	var url = 'insert.chat';
	var name = '채팅방 생성';
	var options = 'width = ' + _width + ', height = ' + _height + ', location = no, top = '+ _top + ', left = ' + _left;
	var windowPopup = window.open(url, name, options);
} 

function popChatRoom(chat_no){
	if(id == ""){
		alert("로그인한 회원만 채팅방에 입장할 수 있습니다.");
		return;
	}
	
	//팝업창 크기
	var _width = 400;
	var _height = 700;

	var _top = Math.ceil(( window.screen.height - _height )/2-50);
	var _left = Math.ceil(( window.screen.width - _width )/2);
	var url = 'room.chat?chat_no='+chat_no;
	var name = '채팅방 입장';
	var options = 'width = ' + _width + ', height = ' + _height + ', location = no status = no, toolbar = no, top = '+ _top + ', left = ' + _left;
	var windowPopup = window.open(url, name, options);
}

</script>
<!-- 본문 끝 -->
<%@include file = "../userCommon/userFooter.jsp" %> <!--  user header 부분 -->