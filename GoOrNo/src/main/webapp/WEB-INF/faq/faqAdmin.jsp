<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file = "../adminCommon/adminHeader.jsp" %> <!--  admin header 부분 -->
	<main id="main" class="main">
	 <div class="pagetitle">
      <h1>Faq</h1>
      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="index.html">FAQ</a></li>
          <li class="breadcrumb-item active">List</li>
        </ol>
      </nav>
    </div><!-- End Page Title -->
    
	<section class="section dashfaq">
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
							<form action="list.faq">
								<!-- 글작성 및 바로가기 버튼 -->
								<button onclick="insertFaq()" class="btn btn-secondary" style="float: left;">글작성</button>
								<input type="button" class="btn btn-light" value="FAQ 바로가기" onclick="return listFaq()" style="float: left;">
								
								<input type="hidden" name="isAdmin" value="yes">
								<select name="whatColumn" class="form-select" style="width : 15%; display:inline;">
									<option value="all">전체 검색</option>
									<option value="question">제목</option>
									<option value="answer">내용</option>
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
						<th scope="col" width="20%" style="text-align: center">작성일</th>
						<th scope="col" width="10%" style="text-align: center">조회수</th>
					</tr>
				</thead>
				<!-- 글 목록 -->
				<tbody>
					<!-- 게시판 글 0개 -->
					<c:if test="${ fn:length(flists) eq 0 }">
						<tr>
							<td colspan="5" align="center">글이 존재하지 않습니다.</td>
						</tr>
					</c:if>
					<!-- 게시판 글 1개 이상 -->
					<c:if test="${ fn:length(flists) > 0 }">
						<c:forEach var="i" begin="0" end="${ fn:length(flists)-1 }" varStatus="status">
							<tr>
								<!-- 글번호 -->
								<td align="center">${ pageInfo.totalCount - pageInfo.beginRow - status.index + 1}</td>
								<!-- 제목. 클릭 시 옆에 내용 띄어짐 -->
								<td align="left">
									<a onclick="viewAnswer('${ flists[i].answer }','${ flists[i].faq_no }','${ status.index }')" style="cursor : pointer;" id="clicked${ status.index }">${ flists[i].question }</a> &nbsp;
								</td>
								<!-- 작성일 -->
								<td align="center">
									<fmt:parseDate var="parsedDate" pattern="yyyy-MM-dd">${ fn:substring(flists[i].regdate,0,10) }</fmt:parseDate>
									<fmt:formatDate value="${ parsedDate }" pattern="yyyy/MM/dd"/>
								</td>
								<!-- 조회수 -->
								<td align="center">${ flists[i].readcount }</td>
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
					<form action="delete.faq">
						<input type="hidden" name="faq_no" id="faq_no">
						<input type="hidden" name="isAdmin" value="yes">
						<input type="hidden" name="pageNumber" value="${ pageInfo.pageNumber }">
						<input type="hidden" name="whatColumn" value="${ pageInfo.whatColumn }">
						<input type="hidden" name="keyword" value="${ pageInfo.keyword }">
						<table class="table table-borderless" style="margin-top :10px;">
							<tr>
								<td align="right">
									<input type="button" class="btn btn-light" id="updateBtn" value="글수정" onclick="return updateFaq()" disabled>
									<input type="submit" class="btn btn-secondary" id="deleteBtn" value="글삭제" onclick="return deleteFaq()" disabled>
								</td>
							</tr>
							<tr>
								<th>글내용</th>
							</tr>
							<tr>
								<td id="answer" style="overflow:hidden; word-break:break-all;"></td>
							</tr>
						</table>
					</form>
					
				</div>
			</div>
		</div>

     </div>
   </section>

  </main>
<!-- 자바 스크립트 -->
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/vendor/jquery/jquery.js"></script>
<script type="text/javascript">
var faq_no = document.getElementById("faq_no").value;
//게시글 내용 띄우기
function viewAnswer(answer, no, index){
	$('#answer').html(answer);
	document.getElementById("faq_no").value = no;
	faq_no = no;
	$('td a').css("color", "black");
	$('#clicked' + index).css("color", "#8F89E9");
	document.getElementById("deleteBtn").disabled = false;
	document.getElementById("updateBtn").disabled = false;
}

//FAQ 바로가기
function listFaq(){
	location.href="list.faq?faq_no="+faq_no;
}

//게시글 삭제
function deleteFaq(){
	if(!confirm('삭제하면 복구할수 없습니다.\n정말로 삭제하시겠습니까?')){
	    return false;
	}
}

//팝업창 크기
var _width = 500;
var _height = 600;

//게시글 수정
function updateFaq(){
	// 팝업창을 중앙에 생성하기
	var _top = Math.ceil(( window.screen.height - _height )/2);
	var _left = Math.ceil(( window.screen.width - _width )/2);
	var url = 'update.faq?faq_no='+faq_no;
	var name = 'FAQ 수정';
	var options = 'width = ' + _width + ', height = ' + _height + ', location = no, top = '+ _top + ', left = ' + _left;
	var windowPopup = window.open(url, name, options);
}

//게시글 작성
function insertFaq(){
	// 팝업창을 중앙에 생성하기
	var _top = Math.ceil(( window.screen.height - _height )/2);
	var _left = Math.ceil(( window.screen.width - _width )/2);
	var url = 'insert.faq';
	var name = 'FAQ 작성';
	var options = 'width = ' + _width + ', height = ' + _height + ', location = no, top = '+ _top + ', left = ' + _left;
	var windowPopup = window.open(url, name, options);
}
</script>

<%@include file = "../adminCommon/adminFooter.jsp" %> <!--  admin footer 부분 -->