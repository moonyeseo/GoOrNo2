<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>

<style>
#chatbotIcon {
	position: fixed;
	right: 20px;
	bottom: 20px;
	border-radius: 20px;
	z-index: 2;
}
</style>

<div class="container"> 
	<div class="row">
		<div class="col-lg-12">
			<div class="border-first-button">
				<a id="chatbot" href='javascript:void(0);'><img
					src="<%=request.getContextPath()%>/resources/image/chatbot.png"
					width="40px" height="40px"></a>
			</div>
		</div>
	</div>
</div>