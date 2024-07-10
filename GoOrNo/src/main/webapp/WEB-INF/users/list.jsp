<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/common.jsp" %>
list.jsp<br>
<h2>회원 목록 (${ pageInfo.totalCount })</h2>
<form action="list.users">
	<select name="whatColumn">
		<option value="all">전체 검색</option>
		<option value="id">아이디</option>
		<option value="email">이메일</option>
	</select>
	<input type="text" name="keyword">
	<input type="submit" value="검색">
</form>
<table border="1" style="border-top:none;">
	<tr>
		<td colspan="11" style="border-top:none;" align="right">
			<input type="button" onClick="location.href='insert.users'" value="회원가입">
		</td>
	</tr>
	<tr>
		<th>번호</th>
		<th>아이디</th>
		<th>비밀번호</th>
		<th>이메일</th>
		<th>성별</th>
		<th>주소</th>
		<th>수정</th>
		<th>삭제</th>
	</tr>
	<c:forEach var="member" items="${ mlists }">
		<tr>
			<td>${ member.user_no }</td>
			<td>${ member.id }</td>
			<td>${ member.pw }</td>
			<td>${ member.email }</td>
			<td>${ member.gender }</td>
			<td>${ member.address }</td>
			<td><a href="update.users?user_no=${ member.user_no }&pageNumber=${ param.pageNumber }&whatColumn=${param.whatColumn}&keyword=${param.keyword}">수정</a></td>
			<td><a href="delete.users?user_no=${ member.user_no }&pageNumber=${ param.pageNumber }&whatColumn=${param.whatColumn}&keyword=${param.keyword}">삭제</a></td>
		</tr>
	</c:forEach>
</table>
	${ pageInfo.pagingHtml }
