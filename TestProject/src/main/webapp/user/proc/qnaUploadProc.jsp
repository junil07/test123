<%-- 게시글 등록중 --%>

<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="qnaMgr" class="project.QnaMgr"/>

<%
	String sess = (String) session.getAttribute("idKey");
	String titlename = request.getParameter("titlename");
	String content = request.getParameter("content");
	boolean result = qnaMgr.qnaUpload(titlename, content, sess);
%>

<script>
	
	<%
		if ( result ) {
	%>
			alert("등록되었습니다.");
			location.href = "../qna.jsp";
	<%
		} else {
	%>
			alert("오류");
			location.href = "../qna.jsp";
	<%
		}
	%>
	
</script>