<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="qnaMgr" class="project.QnaMgr"/>
<jsp:useBean id="commentMgr" class="project.Qna_commentMgr"/>

<%
	
	int num = Integer.parseInt(request.getParameter("num"));
	boolean resultQnaComment = commentMgr.qnareplyDelete(num);
	boolean resultQna = qnaMgr.qnaDelete(num); 
%>

<script>
	<%
		if ( resultQna ) {
	%>		
			alert("삭제되었습니다");
			location.href = "../qna.jsp";
	<%
		} else {
	%>
			alert("오류");
			window.history.back();
	<%
		}
	%>
</script>