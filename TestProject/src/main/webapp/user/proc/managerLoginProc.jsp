<%-- MANAGER 테이블에서 유효성 확인 후 관리자 로그인 --%>

<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="managerMgr" class="project.ManagerMgr"/>
<%
	String beforeurl = request.getParameter("url");
	String id = request.getParameter("id");
	String pwd = request.getParameter("pwd");
	boolean result = managerMgr.ManagerloginChk(id, pwd);
	String msg = "관리자 로그인 실패하였습니다";
	String url = "../login.jsp";
	String idsave = request.getParameter("idSave");
	
	if ( result ) {
		session.setAttribute("adminKey", id);
		msg = "관리자 로그인 성공하였습니다";
<<<<<<<< HEAD:TestProject/src/main/webapp/admin/managerLoginProc.jsp
		url = "adminpage.jsp";
========
		url = "../myInfo.jsp";
>>>>>>>> 7a1d1adf90458dcdf2ccce87f692d0e9dfb3aafe:TestProject/src/main/webapp/user/proc/managerLoginProc.jsp
	}
	
	if ( beforeurl != null ) {
    	url = beforeurl;
    }
%>
<script>
	alert('<%=msg%>');
	location.href = "<%=url%>";
</script>