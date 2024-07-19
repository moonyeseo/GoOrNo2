<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file = "../adminCommon/adminHeader.jsp" %> <!--  admin header 부분 -->
<style type="text/css">
    .form-container {
        margin-top: 150px;
        margin-bottom: 50px;
        margin-left: 400px;
    }
    .card {
        max-width: 600px;
        margin: 0 auto;
    }
</style>

<div class="container form-container">
    <div class="card">
        <div class="card-header text-center">
            <h2>Event Add</h2>
        </div>
        <div class="card-body">
            <%
                String[] typeArray = {"축제-문화/예술","기타","국악","뮤지컬/오페라","교육/체험","전시/미술","무용","콘서트","클래식","영화","연극","독주/독창회","축제-기타"};
            %>
            <form:form commandName="event" action="insert.event" method="post" enctype="multipart/form-data" class="form-horizontal">
                <input type="hidden" name="event_no" value="${event.event_no }">
                <input type="hidden" name="pageNumber" value="${ param.pageNumber }">
                <input type="hidden" name="whatColumn" value="${ param.whatColumn }">
                <input type="hidden" name="keyword" value="${ param.keyword }">
                
                <div class="form-group">
                    <label for="performance_type">분류</label>
                    <select name="performance_type" id="performance_type" class="form-control">
                        <option value="">선택</option>
                        <c:forEach var="type" items="<%= typeArray %>">
                            <option value="${type}" <c:if test="${event.performance_type eq type}">selected</c:if>>${type}</option>
                        </c:forEach>
                    </select>
                    <form:errors path="performance_type" cssClass="text-danger"/>
                </div>
                <div class="form-group">
                    <label for="title">공연/행사</label>
                    <input type="text" name="title" id="title" value="${event.title }" class="form-control">
                    <form:errors path="title" cssClass="text-danger"/>
                </div>
                <div class="form-group">
                    <label for="place">장소</label>
                    <input type="text" name="place" id="place" value="${event.place }" class="form-control">
                    <form:errors path="place" cssClass="text-danger"/>
                </div>
                <div class="form-group">
                    <label for="event_period">기간</label>
                    <input type="text" name="event_period" id="event_period" value="${event.event_period}" class="form-control">
                    <form:errors path="event_period" cssClass="text-danger"/>
                </div>
                <div class="form-group">
                    <label for="upload">사진</label>
                     <input class="form-control" type="file" id="formFile" name="upload" value="${event.fimg }">
                    <form:errors path="fimg" cssClass="text-danger"/>
                </div>
                <div class="form-group">
                    <label for="lot">위도</label>
                    <input type="text" name="lot" id="lot" value="${event.lot }" class="form-control">
                    <form:errors path="lot" cssClass="text-danger"/>
                </div>
                <div class="form-group">
                    <label for="lat">경도</label>
                    <input type="text" name="lat" id="lat" value="${event.lat }" class="form-control">
                    <form:errors path="lat" cssClass="text-danger"/>
                </div>
                <div class="form-group text-center">
                    <input type="submit" class="btn btn-secondary" value="추가">
                </div>
            </form:form>
        </div>
    </div>
</div>
<%@include file = "../adminCommon/adminFooter.jsp" %> <!--  admin footer 부분 -->

