

<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="scheduleMgr" class="project.ScheduleMgr"/>

<%
	String titletext = request.getParameter("titletext");
	int titlenum = Integer.parseInt( request.getParameter("titlenum") );
	boolean result = scheduleMgr.editTitleName(titletext, titlenum);
%>

<script>
	
	alert("수정 되었습니다");
	opener.parent.location.reload();
	self.close();
	
</script>