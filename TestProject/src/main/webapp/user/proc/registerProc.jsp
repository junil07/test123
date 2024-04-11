<%-- USER 테이블에 INSERT --%>

<%@page import="project.UserBean"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="userMgr" class="project.UserMgr"/>
<%
	String id = request.getParameter("registerid");
	String name = request.getParameter("registername");
	String pwd = request.getParameter("registerpwd");
	String email = request.getParameter("registeremail");
	String phone = request.getParameter("registerphone");
	
	UserBean bean = new UserBean();
	bean.setUser_id(id);
	bean.setUser_name(name);
	bean.setUser_pw(pwd);
	bean.setUser_email(email);
	bean.setUser_phone(phone);
	boolean result = userMgr.createAccount(bean);
%>
<script>
<%
	if ( result ) {
%>
		alert("회원가입에 성공하였습니다.");
		location.href = "../login.jsp";
<%
	} else {
%>
		alert("회원가입에 실패하였습니다.");
		window.history.back();
<%
	}
%>
</script>