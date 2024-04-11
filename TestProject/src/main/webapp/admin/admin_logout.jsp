<%@ page contentType="text/html; charset=UTF-8"%>
<%
	String url=request.getParameter("url");
	session.invalidate();
%>
<script>
	alert("로그아웃 되었습니다.");
	location.href = "../test/Mainpage.jsp";
</script>