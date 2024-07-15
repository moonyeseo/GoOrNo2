<%@ page language="java" contentType="text/html; charset=UTF-8" 
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<style type="text/css">
body{
	font-family: "맑은 고딕";
	text-align : center;
}
table{
	border-collapse : collapse;
	border-left : none;
	border-right : none;
	margin: 5px auto;
}
th{ 
	color : white;
	background-color: black; 
	padding : 3px;
}
td{
	border-left: none;
	border-right: none;
	padding: 3px;
}
input[type=button],input[type=reset],input[type=submit] {
background: black;
color: white;
cursor: pointer;
border-radius: 4px;
border: 0;
}
.err{
font-size: 7pt;
font-weight: bold;
color: red;
}
a {
  color: #868686;
  text-decoration: none;
}
</style>
<p style="text-align:right; margin: 5px;">
<a href="list.board">게시판 목록</a> |
<a href="list.users">회원 목록</a> |
<a href="main.jsp">메인 화면</a>
<br>
<c:if test="${ sessionScope.loginInfo eq null }">
	<a href="login.users">로그인</a><br>
</c:if>
<c:if test="${ sessionScope.loginInfo ne null }">
	<font size="1em">${ loginInfo.id }님 반갑습니다.</font>
	<a href="logout.jsp">로그아웃</a><br>
</c:if>
</p>