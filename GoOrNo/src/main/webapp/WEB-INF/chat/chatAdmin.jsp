<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file = "../adminCommon/adminHeader.jsp" %> <!--  admin header 부분 -->
	<main id="main" class="main">
	 <div class="pagetitle">
      <h1>Chat</h1>
      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="index.html">Chat</a></li>
          <li class="breadcrumb-item active">List</li>
        </ol>
      </nav>
    </div><!-- End Page Title -->
    
	<section class="section dashchat">
     <div class="row" style="display : flex;">
       <div class="col-lg-12">

         <div class="card h-100">
           <div class="card-body">
             
             <!-- Active Table -->
               <table class="table table-borderless" style="margin-top :10px;">
				<thead>
					<!-- 채팅방 검색 -->
					<tr>
						<td colspan="7" align="right">
							<form action="list.chat">
								<input type="hidden" name="isAdmin" value="yes">
								<select name="whatColumn" class="form-select" style="width : 15%; display:inline;">
									<option value="alias">이름</option>
								</select>
								<input type="text" name="keyword" class="form-control" style="width : 15%; display:inline;">
								<input type="submit" value="검색" class="btn btn-secondary">
							</form>
						</td>
					</tr>
					<!-- 컬럼 제목 -->
					<tr>
						<th scope="col" width="10%" style="text-align: center">번호</th>
						<th scope="col" width="30%" style="text-align: center">채팅방명</th>
						<th scope="col" width="10%" style="text-align: center">방장</th>
						<th scope="col" width="10%" style="text-align: center">정원</th>
						<th scope="col" width="10%" style="text-align: center">인원수</th>
						<th scope="col" width="20%" style="text-align: center">생성일</th>
						<th scope="col" width="10%" style="text-align: center">삭제</th>
					</tr>
				</thead>
				<!-- 글 목록 -->
				<tbody>
					<!-- 게시판 글 0개 -->
					<c:if test="${ fn:length(clists) eq 0 }">
						<tr>
							<td colspan="7" align="center">채팅이 존재하지 않습니다.</td>
						</tr>
					</c:if>
					<!-- 게시판 글 1개 이상 -->
					<c:if test="${ fn:length(clists) > 0 }">
						<c:forEach var="i" begin="0" end="${ fn:length(clists)-1 }" varStatus="status">
							<tr>
								<!-- 글번호 -->
								<td align="center">${ pageInfo.totalCount - pageInfo.beginRow - status.index + 1}</td>
								<!-- 제목. 클릭 시 옆에 내용 띄어짐 -->
								<td align="left">
									<a onclick="viewChat('${ clists[i].chat_no }')" style="cursor : pointer;">
										${ clists[i].alias }
									</a> &nbsp;
								</td>
								<!-- 방장 -->
								<td align="center">${ clists[i].user_id }</td>
								<!-- 정원 -->
								<td align="center">${ clists[i].maxcount }</td>
								<!-- 인원수 -->
								<td align="center">${ clists[i].headcount }</td>
								<!-- 생성일 -->
								<td align="center">
									<fmt:parseDate var="parsedDate" pattern="yyyy-MM-dd">${ fn:substring(clists[i].createdate,0,10) }</fmt:parseDate>
									<fmt:formatDate value="${ parsedDate }" pattern="yyyy/MM/dd"/>
								</td>
								<!-- 삭제 -->
								<td align="center">
									<button class="btn btn-secondary" onclick="deleteChat('${ clists[i].chat_no }')">삭제</button>
								</td>
							</tr>
						</c:forEach>
					</c:if>
					<!-- 페이지 넘기기 -->
					<tr>
						<td colspan="7" align="center">${ pageInfo.pagingHtml }</td>
					</tr>
				</tbody>
			</table>
			<!-- 테이블 끝 -->
            <!-- End Tables without borders -->
           </div>
		</div>
	</div>

     </div>
   </section>

  </main>
<!-- 자바 스크립트 -->
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/vendor/jquery/jquery.js"></script>
<script type="text/javascript">
function viewChat(chat_no){
	//팝업창 크기
	var _width = 400;
	var _height = 700;

	var _top = Math.ceil(( window.screen.height - _height )/2-50);
	var _left = Math.ceil(( window.screen.width - _width )/2);
	var url = "room.chat?isAdmin=yes&chat_no="+chat_no;
	var name = '채팅방 입장';
	var options = 'width = ' + _width + ', height = ' + _height + ', location = no status = no, toolbar = no, top = '+ _top + ', left = ' + _left;
	var windowPopup = window.open(url, name, options);
}

function deleteChat(chat_no){
	if(confirm("채팅을 삭제하시겠습니까?")){
		location.href = "delete.chat?chat_no="+chat_no+"&isAdmin=yes";
	}
}
</script>

<%@include file = "../adminCommon/adminFooter.jsp" %> <!--  admin footer 부분 -->