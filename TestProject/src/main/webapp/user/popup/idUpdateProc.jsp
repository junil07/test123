<%-- 
	- 파라미터값 넘길 것
	1. 중복확인 되었는 지 안되었는 지
	2. 
 --%>

<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="userMgr" class="project.UserMgr"/>
<%
	String id = request.getParameter("username");
	String msg = "";
	boolean result = userMgr.checkDuplicate(id);
	
	System.out.print("\n 하하하" + id + "\n");
	
	if ( result == true ) {
		msg = "사용 가능한 아이디 입니다.";
	} else {
		msg = "이미 존재하는 아이디 입니다.";
	}
	session.setAttribute("updateid", id);
	System.out.println(msg);
%>
<script>
	alert("<%=msg%>");
	location.href = "idUpdate.jsp";
</script>
