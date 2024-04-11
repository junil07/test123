<%@ page contentType="text/html; charset=UTF-8"%>
<%
	String beforeurl = request.getParameter("url");
	session.invalidate();
	
	String url = "../user/testInfo.jsp";
	if ( beforeurl != null ) {
		url = beforeurl;
	}
%>
<script>
	alert("로그아웃 되었습니다.");
	location.href = "<%=url%>";
</script>