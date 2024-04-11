<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="commentMgr" class="project.Qna_commentMgr"/>

<%
	int num = Integer.parseInt(request.getParameter("num"));
	int pos = Integer.parseInt(request.getParameter("pos"));
	int ref = Integer.parseInt(request.getParameter("ref"));
	
	boolean result = commentMgr.deleteReply(num, pos, ref);
%>

<script>
	
	<%
		if ( result ) {
	%>
			window.history.back();
	<%
		} else {
	%>
			alert("오류");
			window.history.back();
	<%
		}
	%>
	
</script>