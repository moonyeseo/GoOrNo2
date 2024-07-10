<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp" %>
login.jsp<br>

<h2>로그인</h2>
<form action="login.users" method="post">
	<input type="hidden" name="pageNumber" value="${ param.pageNumber }">
	<input type="hidden" name="whatColumn" value="${ param.whatColumn }">
	<input type="hidden" name="keyword" value="${ param.keyword }">
	<table>
		<tr>
			<td>아이디</td>
			<td>
				<input type="text" name="id">
				<span id="idMsg"></span>
			</td>
		</tr>
		<tr>
			<td>비밀번호</td>
			<td>
				<input type="password" name="pw">
				<span id="pwMsg"></span>
			</td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<input type="submit" value="로그인">
				<input type="button" onClick="location.href='insert.users'" value="회원가입">
				<input type="button" onClick="location.href='list.users'" value="회원 목록">
				<input type="button" onClick="location.href='list.board?pageNumber=${param.pageNumber}&whatColumn=${ param.whatColumn }&keyword=${ param.keyword }'" value="게시판 목록">
			</td>
		</tr>
	</table>
</form>