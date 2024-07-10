<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/common.jsp" %>
updateForm.jsp<br>
<h2>회원 수정</h2>
<form:form commandName="member" action="update.users" method="post">
	<input type="hidden" name="user_no" value="${ member.user_no }">
	<input type="hidden" name="pageNumber" value="${ param.pageNumber }">
	<input type="hidden" name="whatColumn" value="${ param.whatColumn }">
	<input type="hidden" name="keyword" value="${ param.keyword }">
	
	<table border="1">
		<tr>
			<th>아이디</th>
			<td>
				<input type="hidden" name="id" value="${ member.id }">
				<input type="text" name="id" value="${ member.id }" disabled>
			</td>
		</tr>
		<tr>
			<th>비밀번호</th>
			<td>
				<input type="password" name="pw" value="${ member.pw }">
				<form:errors path="pw" cssClass="err"></form:errors>
			</td>
		</tr>
		<tr>
			<th>이메일</th>
			<td>
				<input type="text" name="email" value="${ member.email }">
				<form:errors path="email" cssClass="err"></form:errors>
			</td>
		</tr>
		<tr>
			<th>성별</th>
			<td>
				<input type="radio" name="gender" value="여자"
					<c:if test="${ member.gender eq '여자' }">checked</c:if>
				>여자
				<input type="radio" name="gender" value="남자"
					<c:if test="${ member.gender eq '남자' }">checked</c:if>
				>남자
				<form:errors path="gender" cssClass="err"></form:errors>
			</td>
		</tr>
		<tr>
			<th>주소</th>
			<td>
				<input type="text" name="address" value="${ member.address }">
				<form:errors path="address" cssClass="err"></form:errors>
			</td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<input type="submit" value="수정하기">
				<input type="button" onClick="location.href='list.users?pageNumber=${param.pageNumber}&whatColumn=${ param.whatColumn }&keyword=${ param.keyword }'" value="회원 화면">
			</td>
		</tr>
	</table>
</form:form>