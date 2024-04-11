<%-- USER_PHONE DB 업데이트 --%>

<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="userMgr" class="project.UserMgr"/>
<%
	String sess = (String) session.getAttribute("idKey");
	String name = request.getParameter("userphone");
	boolean flag = userMgr.updateUserInfo(4, name, sess);
%>
<script>
	alert("번호가 변경되었습니다");
	opener.parent.location.reload();
	self.close();
</script>