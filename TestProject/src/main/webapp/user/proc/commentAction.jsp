<%-- 댓글 입력 시 작동하는 페이지 --%>

<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="commentMgr" class="project.Qna_commentMgr"/>

<%
	int num = Integer.parseInt( request.getParameter("num") );
	int check = Integer.parseInt( request.getParameter("check") );
	String content = request.getParameter("content");
	String userid = request.getParameter("userid");
	int originCount = commentMgr.getOriginCount(num);
	int pos = Integer.parseInt(request.getParameter("pos"));
	int rereplyCount = commentMgr.getRereply(num, pos);
	boolean result = false;
	String url = request.getParameter("url");

	
	if ( check == 0 ) { // 그냥 댓글
		
		result = commentMgr.commentInsert(check, num, content, originCount, 0, userid);
		
	} else if ( check == 1 ) { // 대댓글
		
		result = commentMgr.commentInsert(check, num, content, pos, rereplyCount, userid);
		
	}
	
%>

<script>
	
	<%
		if ( result == true ) {
	%>
			window.history.back();
			window.location.reload();
	<%
		} else {
	%>
			alert("오류");
			window.history.back();
			window.location.reload();
	<%
		}
	%>
	
</script>
