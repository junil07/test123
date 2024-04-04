
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	String managerSess = (String) session.getAttribute("adminKey");
%>
<script>
	function testclick() {
		<%
		session.invalidate();
		%>
	}
</script>
<h1>ㅎㅇㅋㅋ</h1><br>
<h1><%=managerSess%></h1>
<button type="button" onclick="testclick()">버튼</button>