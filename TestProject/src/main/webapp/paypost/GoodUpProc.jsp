<%@page import="project.UtilMgr"%>
<%@page import="project.PaypostMgr"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	PaypostMgr mgr = new PaypostMgr();

	int num = UtilMgr.parseInt(request, "num");
	String infoId = request.getParameter("infoId");
	String nowPage = request.getParameter("nowPage");
	String numPerPage = request.getParameter("numPerPage");
	String keyField = request.getParameter("keyField");
	String keyWord = request.getParameter("keyWord");

	mgr.goodUp(num, infoId);

%>

<form name="goodFrm" action="PaypostRead.jsp" method="post">
	<input type="hidden" name="num" value="<%=num%>">
	<input type="hidden" name="nowPage" value="<%=nowPage%>">
	<input type="hidden" name="numPerPage" value="<%=numPerPage%>">
	<input type="hidden" name="keyField" value="<%=keyField%>">
	<input type="hidden" name="keyWord" value="<%=keyWord%>">
</form>
<script>
	alert("추천 하였습니다.");
	document.goodFrm.action = "PaypostRead.jsp";
	document.goodFrm.submit();
</script>