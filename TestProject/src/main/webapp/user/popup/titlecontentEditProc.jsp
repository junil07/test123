
<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="scheduleMgr" class="project.Schedule_columnMgr"/>

<%
	String content1 = request.getParameter("content1");
	String content2 = request.getParameter("content2");
	String content3 = request.getParameter("content3");
	String content4 = request.getParameter("content4");
	String content5 = request.getParameter("content5");
	String content6 = request.getParameter("content6");
	String content7 = request.getParameter("content7");
	int num = Integer.parseInt( request.getParameter("num") );
	int fknum = Integer.parseInt( request.getParameter("fknum") );
	
	boolean result = scheduleMgr.editExamSchedule(num, fknum, content1, content2, content3, content4, content5, content6, content7);
	
%>

<script>
	alert("수정 되었습니다.");
	opener.parent.location.reload();
	self.close();
</script>