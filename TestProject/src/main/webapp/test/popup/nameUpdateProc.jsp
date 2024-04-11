<%-- USER_NAME DB 업데이트 --%>

<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="userMgr" class="project.UserMgr"/>
<%
	String sess = (String) session.getAttribute("idKey");
	String name = request.getParameter("username");
	boolean flag = userMgr.updateUserInfo(3, name, sess);
%>
<script>
	alert("이름이 변경되었습니다");
	opener.parent.location.reload();
	self.close();
</script>