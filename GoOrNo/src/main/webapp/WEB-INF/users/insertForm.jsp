<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/common.jsp" %>
insertForm.jsp<br>
<h2>회원 가입</h2>
<form:form commandName="member" action="insert.users" method="post">
	<table border="1">
		<tr>
			<th>아이디</th>
			<td>
				<input type="text" name="id" value="${ member.id }">
				<form:errors path="id" cssClass="err"></form:errors>
			</td>
		</tr>
		<tr>
			<th>비밀번호</th>
			<td>
				<input type="password" name="pw">
				<form:errors path="passwd" cssClass="err"></form:errors>
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
				<input type="submit" value="가입하기">
				<input type="button" onClick="location.href='login.users'" value="로그인 화면">
			</td>
		</tr>
	</table>
</form:form>