<%-- 관리자 댓글 입력 시 작동하는 페이지 --%>

<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="commentMgr" class="project.Qna_commentMgr"/>

<%
	int num = Integer.parseInt( request.getParameter("num") );
	int check = Integer.parseInt( request.getParameter("check") );
	String content = request.getParameter("content");
	String managerid = request.getParameter("managerid");
	int originCount = commentMgr.getOriginCount(num);
	int pos = Integer.parseInt(request.getParameter("pos"));
	int rereplyCount = commentMgr.getRereply(num, pos);
	boolean result = false;
	
	
	if ( check == 0 ) { // 그냥 댓글
		
		result = commentMgr.managercommentInsert(check, num, content, originCount, originCount, managerid);
		
	} else if ( check == 1 ) { // 대댓글
		
		result = commentMgr.managercommentInsert(check, num, content, pos, rereplyCount, managerid);
		
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