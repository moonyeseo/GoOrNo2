<%@ page language="java" contentType="text/html; charset=UTF-8" 
    pageEncoding="UTF-8"%>
<%@include file = "../adminCommon/adminHeader.jsp" %> <!--  admin header 부분 -->
	<main id="main" class="main">
	 <div class="pagetitle">
      <h1>Comunity</h1>
      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="index.html">Board</a></li>
          <li class="breadcrumb-item active">List</li>
        </ol>
      </nav>
    </div><!-- End Page Title -->
    
	<section class="section dashboard">
     <div class="row" style="display : flex;">
       <div class="col-lg-8">

         <div class="card h-100">
           <div class="card-body">
             
             <!-- Active Table -->
               <table class="table table-borderless" style="margin-top :10px;">
				<thead>
					<!-- 게시판 검색 -->
					<tr>
						<td colspan="5" align="right">
							<form action="list.board">
								<input type="hidden" name="isAdmin" value="yes">
								<select name="whatColumn" class="form-select" style="width : 15%; display:inline;">
									<option value="all">전체 검색</option>
									<option value="subject">제목</option>
									<option value="content">내용</option>
								</select>
								<input type="text" name="keyword" class="form-control" style="width : 15%; display:inline;">
								<input type="submit" value="검색" class="btn btn-secondary">
							</form>
						</td>
					</tr>
					<!-- 컬럼 제목 -->
					<tr>
						<th scope="col" width="10%" style="text-align: center">글번호</th>
						<th scope="col" width="50%" style="text-align: center">제목</th>
						<th scope="col" width="10%" style="text-align: center">작성자</th>
						<th scope="col" width="20%" style="text-align: center">작성일</th>
						<th scope="col" width="10%" style="text-align: center">조회수</th>
					</tr>
				</thead>
				<!-- 글 목록 -->
				<tbody>
					<!-- 게시판 글 0개 -->
					<c:if test="${ fn:length(blists) eq 0 }">
						<tr>
							<td colspan="5" align="center">글이 존재하지 않습니다.</td>
						</tr>
					</c:if>
					<!-- 게시판 글 1개 이상 -->
					<c:if test="${ fn:length(blists) > 0 }">
						<c:forEach var="i" begin="0" end="${ fn:length(blists)-1 }" varStatus="status">
							<tr>
								<!-- 글번호 -->
								<td align="center">${ pageInfo.totalCount - pageInfo.beginRow - status.index + 1}</td>
								<!-- 제목. 클릭 시 옆에 내용 띄어짐 -->
								<td align="left">
									<a onclick="viewContent('${ blists[i].content }','${ blists[i].board_no }','${ status.index }')" style="cursor : pointer;" id="clicked${ status.index }">${ blists[i].subject }</a> &nbsp;
									<!-- 댓글 표시 -->
									<c:if test="${ blists[i].commentCount > 0 }">
										<svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" fill="currentColor" class="bi bi-chat-left" viewBox="0 0 16 16">
										  <path d="M14 1a1 1 0 0 1 1 1v8a1 1 0 0 1-1 1H4.414A2 2 0 0 0 3 11.586l-2 2V2a1 1 0 0 1 1-1zM2 0a2 2 0 0 0-2 2v12.793a.5.5 0 0 0 .854.353l2.853-2.853A1 1 0 0 1 4.414 12H14a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2z"/>
										</svg>
										<font size="1em" color="gray">${ blists[i].commentCount }</font>
									</c:if>
								</td>
								<!-- 작성자 -->
								<td align="center">${ blists[i].user_id }</td>
								<!-- 작성일 -->
								<td align="center">
									<fmt:parseDate var="parsedDate" pattern="yyyy-MM-dd">${ fn:substring(blists[i].regdate,0,10) }</fmt:parseDate>
									<fmt:formatDate value="${ parsedDate }" pattern="yyyy/MM/dd"/>
								</td>
								<!-- 조회수 -->
								<td align="center">${ blists[i].readcount }</td>
							</tr>
						</c:forEach>
					</c:if>
					<!-- 페이지 넘기기 -->
					<tr>
						<td colspan="5" align="center">${ pageInfo.pagingHtml }</td>
					</tr>
				</tbody>
			</table>
			<!-- 테이블 끝 -->
            <!-- End Tables without borders -->
           </div>
		</div>
	</div>

		<div class="col-lg-4">
			<div class="card h-100">
				<div class="card-body">
					<form action="delete.board">
						<input type="hidden" name="board_no" id="board_no">
						<input type="hidden" name="isAdmin" value="yes">
						<input type="hidden" name="pageNumber" value="${ pageInfo.pageNumber }">
						<input type="hidden" name="whatColumn" value="${ pageInfo.whatColumn }">
						<input type="hidden" name="keyword" value="${ pageInfo.keyword }">
						<table class="table table-borderless" style="margin-top :10px;">
							<tr>
								<td align="right">
									<input type="button" class="btn btn-light" id="detailBtn" value="글 바로가기" onclick="return detailBaord()" disabled>
									<input type="submit" class="btn btn-secondary" id="deleteBtn" value="글삭제" onclick="return deleteBaord()" disabled>
								</td>
							</tr>
							<tr>
								<th>글내용</th>
							</tr>
							<tr>
								<td id="content"></td>
							</tr>
						</table>
					</form>
					<div id="commentView"></div>
				</div>
			</div>
		</div>

     </div>
   </section>

  </main>
<!-- 자바 스크립트 -->
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/vendor/jquery/jquery.js"></script>
<script type="text/javascript">
//게시글 제목 클릭시 내용 보기
function viewContent(content, board_no, index){
	$('#content').html(content);
	$('td a').css("color", "black");
	$('#clicked' + index).css("color", "#8F89E9");
	document.getElementById("board_no").value = board_no;
	document.getElementById("detailBtn").disabled = false;
	document.getElementById("deleteBtn").disabled = false;
	getCommentList(board_no);
}
//게시글 바로가기
function detailBaord(){
	var board_no = document.getElementById("board_no").value;
	location.href="detail.board?board_no="+board_no;
}
//게시글 삭제
function deleteBaord(){
	if(!confirm('삭제하면 복구할수 없습니다.\n정말로 삭제하시겠습니까?')){
	    return false;
	}
}

//댓글 목록 불러오기
function getCommentList(board_no){ 
	
	$.ajax({
		type : "post",
		url : "list.comments",
		data : {
			board_no : board_no
		},
		dataType : "json",
		success : function(commentLists){
			//alert("성공");
			let output = "<table class='table table-borderless' style='width: 100%;'>";
			output += "<tr><th colspan='3'>댓글</th></tr>";
			for(let i in commentLists){
				output += "<tr>";
				output += "<td width='15%' align='center'>"+commentLists[i].user_id+"</td>";
				output += "<td width='65%' align='left'>"+commentLists[i].content+"</td>";
				output += "<td id='commentRegdate' width='20%' align='right'><font size='2px' style='white-space: nowrap;'>";
				output += commentLists[i].regdate.substr(0,19)+"</font></td>";
				output += "</tr>";
			}
			output += "</table>";
			document.getElementById("commentView").innerHTML = output;
			
		},
		error : function(request,status,error){
			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	});
}//댓글 작성&목록 불러오기
</script>

<%@include file = "../adminCommon/adminFooter.jsp" %> <!--  admin footer 부분 -->