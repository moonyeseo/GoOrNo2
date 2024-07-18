<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>  
<%@ include file = "../userCommon/userHeader.jsp" %>
<!-- 챗봇 -->
<div id="asideChatbot" class="asideChatbot " style="heigth: 80%">
	<%@include file="../chatbot/chatbot.jsp"%>
</div>

<div id="chatbotIcon" style="heigth: 20%">
	<%@include file="../chatbot/chatbotIcon.jsp"%>
</div>

<!-- 캘린더 아이콘 -->
<div id="calendarIcon" style="heigth: 20%">
	<%@include file="../event/calendarIcon.jsp"%>
</div>

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
						<a href="list.board" style="color:inherit;"><em>자유</em>게시판</a>
					</h4>
					<div class="line-dec"></div>
				</div>
			</div>
			
			<!-- 테두리 안 본문 내용 -->
			<div class="col-lg-12 wow fadeInUp" data-wow-duration="0.5s"
				data-wow-delay="0.25s" align="center">
				<section class="section">
					<div class="row">
						<div class="col-lg-12">
							<div class="card">
								<div class="card-body">
									
									<!-- 글 내용 감싸는 테두리 -->
									<div class="container border border-secondary-subtle rounded" style="width: 80%; margin-top: 30px; margin-bottom:10px;">

									<!-- 글 내용 시작 -->
									<table class="table table-borderless" style="text-align:center; width: 80%; margin-top: 50px;">
										<tr>
											<!-- 제목 -->
											<td colspan="2" width="70%" style="text-align: left;"><font size="4px"><b>${ board.subject }</b></font></td>
											<!-- 글 신고 버튼 -->
											<td align="right" width="30%"><input type="button" id="report" class="btn btn-light btn-sm" value="신고"></td>
										</tr>
										<tr>
											<!-- 작성자 ID -->
											<td align="left" style="width: 30%">
												<c:if test="${ board.user_no eq '' }">
													<font color="gray">탈퇴한 회원</font>
												</c:if>
												<c:if test="${ board.user_no ne '' }">
													${ board.user_id }
												</c:if>
											</td>
											<!-- 작성일  -->
											<td align="left" style="width: 70%">
												<fmt:parseDate var="parsedDate" pattern="yyyy-MM-dd">${ fn:substring(board.regdate,0,10) }</fmt:parseDate>
												<fmt:formatDate value="${ parsedDate }" pattern="yyyy-MM-dd"/>
											</td>
											<!-- 조회수 -->
											<td align="right" style="width: 10%">${ board.readcount }</td>
										</tr>
										<tr>
											<!-- 글 내용 -->
											<td colspan="3" style="padding:20px; text-align:left; overflow:hidden; word-break:break-all;">
												${ board.content }
											</td>
										</tr>
										<tr>
											<td colspan="3" align="right" style="border-bottom:none;">
												<!-- 본인의 글일 경우에만 수정/삭제 버튼 나타남 -->
												<c:if test="${ loginInfo.user_no eq board.user_no }">
													<input type="button" class="btn btn-secondary" value="글수정" onClick="location.href='update.board?board_no=${ board.board_no }&pageNumber=${param.pageNumber}&whatColumn=${ param.whatColumn }&keyword=${ param.keyword }'" style="background-color:white; color:black;">
													<input type="button" class="btn btn-secondary" value="글삭제" id="deleteConfirm" style="background-color:white; color:black;">
												</c:if>
												<input type="button" class="btn btn-secondary" onClick="location.href='list.board?pageNumber=${param.pageNumber}&whatColumn=${ param.whatColumn }&keyword=${ param.keyword }'" value="글목록" style="background-color:white; color:black;">
											</td>
										</tr>
									</table>
									</div>
									
									<!-- 댓글 작성창 -->
									<div id="commentWrite">
										<!-- 로그인 한 경우에만 댓글창 활성화 -->
										<c:if test="${ loginInfo.id ne null }">
											<table class="table table-borderless" style="width: 70%;">
												<tr><td align="right"><textarea id="commentContents" class="form-control" placeholder="내용" style="resize:none; overflow:hidden; word-break:break-all;" maxlength="90"></textarea></td></tr>
												<tr><td align="right"><button onclick="commentWrite()" class="btn btn-secondary">댓글작성</button></td></tr>
											</table>
										</c:if>
										<!-- 비회원은 아예 댓글창이 막혀 있음 -->
										<c:if test="${ loginInfo.id eq null }">
											<table class="table table-borderless" style="width: 70%;">
												<tr><td align="right"><textarea id="commentContents" class="form-control" placeholder="로그인한 회원만 댓글을 작성할 수 있습니다." disabled="disabled"  style="resize:none;"></textarea></td></tr>
												<tr><td align="right"><button disabled="disabled" class="btn btn-secondary">댓글작성</button></td></tr>
											</table>
										</c:if>
									</div>
									
									<!-- 댓글 목록 -->
									<div id="commentView">
										<table class="table table-borderless" style="width: 80%;">
											<!-- 댓글 0개 -->
											<c:if test="${ fn:length(commentLists) < 1 }">
												<tr>
													<td align="center">댓글이 존재하지 않습니다.</td>
												</tr>
											</c:if>
											<!-- 댓글 1개 이상 -->
											<c:if test="${ fn:length(commentLists) > 0 }">
												<c:forEach var="comment" items="${ commentLists }">
													<tr>
														<!-- 작성자 -->
														<td width="15%" align="center">
															<c:if test="${ comment.user_no eq '' }">
																<font color="gray">탈퇴한 회원</font>
															</c:if>
															<c:if test="${ comment.user_no ne '' }">
																${ comment.user_id }
															</c:if>
														</td>
														<!-- 내용 -->
														<td width="65%" align="left" style="overflow:hidden; word-break:break-all;">${ comment.content }</td>
														<!-- 작성일 -->
														<!-- 숫자폭을 일정하게 하기 위해 Noto Sans 글꼴 적용 -->
														<td id="commentRegdate" width="20%" align="right" style="font-family:'Noto Sans';">
															<!-- 내 댓글이면 삭제 링크 생성 -->
															<c:if test="${ loginInfo.id eq comment.user_id }">
																<a onClick="return deleteComment('${comment.comment_no}')" style="cursor: pointer;"><font size="2px">삭제</font></a>
															</c:if>
															<!-- 작성 날짜 포맷 2000-12-12 12:12:00.0 에서 밀리초를 뺌(substring)-->
															<fmt:parseDate var="parsedRegdate" pattern="yyyy-MM-dd HH:mm:ss">${ fn:substring(comment.regdate,0,19) }</fmt:parseDate>
															<font size="2px" style="white-space: nowrap;"><fmt:formatDate value="${ parsedRegdate }" pattern="yyyy-MM-dd HH:mm:ss"/></font>
														</td>
													</tr>
												</c:forEach>
											</c:if>
										</table>
									</div>
									<!-- 테이블 끝 -->

								</div>
							</div>
						</div>
					</div>
				</section>
			</div>
			<!-- 테두리 끝 -->
		</div>
	</div>
</div>
<!-- 본문 끝 -->
<%@include file = "../userCommon/userFooter.jsp" %> <!--  user header 부분 -->

<script type="text/javascript" src="<%= request.getContextPath() %>/resources/js/jquery.js"></script>
<script type="text/javascript">

//댓글 작성&목록 불러오기
function commentWrite(){ 
	const content = document.getElementById("commentContents").value;
	const board_no = '${board.board_no}';
	const id = '${ loginInfo.id }';
	//alert(board_no+"/"+contents);
	
	if(content.trim() == ""){
		alert("댓글 내용을 입력하세요.");
		return;
	}
	
	$.ajax({
		type : "post",
		url : "write.comments",
		data : {
			content : content,
			board_no : board_no,
			id : id
		},
		dataType : "json",
		success : function(commentLists){
			//alert("성공");
			let output = "<table class='table table-borderless' style='width: 80%;'>";
			for(let i in commentLists){
				output += "<tr>";
				output += "<td width='15%' align='center'>"+commentLists[i].user_id+"</td>";
				output += "<td width='65%' align='left' style='overflow:hidden; word-break:break-all;'>"+commentLists[i].content+"</td>";
				output += "<td id='commentRegdate' width='20%' align='right'><font size='2px' style='white-space: nowrap;'>";
				if(commentLists[i].user_id == id){
					comment_no = commentLists[i].comment_no;
					output += "<a onClick='return deleteComment("+comment_no+")' style='cursor: pointer;'><font size='2px'>삭제 </font></a>";
				}
				output += commentLists[i].regdate.substr(0,19)+"</font></td>";
				output += "</tr>";
			}
			output += "</table>";
			document.getElementById("commentView").innerHTML = output;
			document.getElementById("commentContents").value = '';
			
		},
		error : function(request,status,error){
			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	});
}//댓글 작성&목록 불러오기

$(function(){
	//게시글 삭제
    $('#deleteConfirm').click(function(){
        if(!confirm('삭제하면 복구할수 없습니다.\n정말로 삭제하시겠습니까?')){
            return false;
        }else{
        	const board_no = '${board.board_no}';
        	const pageNumber = '${ param.pageNumber }';
        	const whatColumn = '${ param.whatColumn }';
        	const keyword = '${ param.keyword }';
        	
        	location.href = "delete.board?board_no=" + board_no + "&pageNumber="
        			+ pageNumber+"&whatColumn=" + whatColumn + "&keyword=" + keyword;
        }
    });
	
});

//댓글 삭제
function deleteComment(comment_no){
	 if(!confirm('삭제하면 복구할수 없습니다.\n정말로 삭제하시겠습니까?')){
         return false;
     }else{
    	const board_no = '${board.board_no}';
		const pageNumber = '${ param.pageNumber }';
		const whatColumn = '${ param.whatColumn }';
		const keyword = '${ param.keyword }';
    	location.href = "delete.comments?comment_no=" + comment_no + "&board_no=" + board_no 
    			+ "&pageNumber=" + pageNumber + "&whatColumn=" + whatColumn + "&keyword=" + keyword;
     }
}

$(document).ready(function() {
    // 신고 버튼 동작
    var popup; // report로 insert 후 팝업창 닫기를 위한 변수
    
    $("#report").click(function(){ // 신고하기 버튼
    	$("#report").html("<img src = '<%=request.getContextPath() %>/resources/image/report_after2.png' >"); 
    	
    	var popupW = 500;
    	var popupH = 600;
    	var left = (document.body.offsetWidth - popupW) / 2;
    	var top = (window.screen.height - popupH) / 2;
    	
     	//yoon 변수 2개 추가
     	const board_no = '${board.board_no}';
    	const subject = '${board.subject}';
    	popup = window.open("insert.report?board_no="+board_no+"&subject="+subject, "report", "width=" + popupW + ",height =" + popupH +", left=" + left + ",top=" + top + ",scrollbars=yes,resizable=no,toolbar=no,titlebar=no,menubar=no,location=no");
    	popup.onbeforeunload = function(){ // 팝업창이 닫히면 아이콘 이 전 이미지로 변경
        	 $("#report").html("<img src = '<%=request.getContextPath() %>/resources/image/report_before2.png' >");
    	}
    });
	// 신고 버튼 끝
});
</script>
