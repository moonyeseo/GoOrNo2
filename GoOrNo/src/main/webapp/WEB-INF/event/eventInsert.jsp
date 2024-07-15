<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%@include file = "../adminCommon/adminHeader.jsp" %> <!--  admin header 부분 -->
<%@ include file = "../common/common.jsp" %>


Admin add<br>
<%
	String[] typeArray = {"축제-문화/예술","기타","국악","뮤지컬/오페라","교육/체험","전시/미술","무용","콘서트","클래식","영화","연극","독주/독창회","축제-기타"};
%>


<form:form commandName="event" action="insert.event" method="post">
				<input type="hidden" name="event_no" value="${event.event_no }">
				<input type="hidden" name="pageNumber" value="${ param.pageNumber }">
				<input type="hidden" name="whatColumn" value="${ param.whatColumn }">
				<input type="hidden" name="keyword" value="${ param.keyword }">
	<table border="1">
		<tr>
			<th>분류</th>
			<td>
	            <select name="performance_type">
	                <option value="">선택</option>
	                <c:forEach var="type" items="<%= typeArray %>">
	                    <option value="${type}" <c:if test="${event.performance_type eq type}">selected</c:if>>${type}</option>
	                </c:forEach>
	            </select>
	            <form:errors path="performance_type" cssClass="err"/>
			</td>
		</tr>
		
		<tr>
			<th>공연/행사</th>
			<td>
				<input type="text" name="title" value="${event.title }">
				<form:errors path="title" cssClass="err"/>
			</td>
		</tr>
		
		<tr>
			<th>장소</th>
			<td>
				<input type="text" name="place" value="${event.place }">
				<form:errors path="place" cssClass="err"/>
			</td>
		</tr>
		
		<tr>
			<th>기간</th>
			<td>
				<input type="text" name="event_period" value="${event.event_period}">
				<form:errors path="event_period" cssClass="err"/>
			</td>
		</tr>
		
		<tr>
			<th>사진</th>
			<td>
				<input type="file" name="img">
			</td>
		</tr>
		
		<tr>
			<th>위도</th>
			<td>
				<input type="text" name="lot" value="${event.lot }">
				<form:errors path="lot" cssClass="err"/>
			</td>
		</tr>
		
		<tr>
			<th>경도</th>
			<td>
				<input type="text" name="lat" value="${event.lat }">
				<form:errors path="lat" cssClass="err"/>
			</td>
		</tr>
		
		<tr>
			<td colspan="2">
				<input type="submit" value="추가">
			</td>
		</tr>
	</table>
</form:form>
<%@include file = "../adminCommon/adminFooter.jsp" %> <!--  admin footer 부분 -->