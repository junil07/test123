<%-- QnA 안에 페이지 --%>

<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="qnaMgr" class="project.QnaMgr"/>
<jsp:useBean id="commentMgr" class="project.Qna_commentMgr"/>

<%
	int num = Integer.parseInt( request.getParameter("num") );
	String title = qnaMgr.getTitle(num);
	String content = qnaMgr.getContent(num);
%>

<html>
	
	<head>
		
		<link href="qnaInPage.css" rel="stylesheet">
		
	</head>
	
	<body>
		
		<div class="parantdiv">
			
			<div class="titlediv">
				
				<%=title%> / <%=content%>
				
			</div>
			
		</div>
		
	</body>
	
</html>