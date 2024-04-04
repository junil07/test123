<%-- USER_ID DB 중복체크 --%>

<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="userMgr" class="project.UserMgr"/>
<%
	String id = request.getParameter("registerid");
	String name = request.getParameter("registername");
	String pwd = request.getParameter("registerpwd");
	String pwdretype = request.getParameter("registerpwdretype");
	String email = request.getParameter("registeremail");
	String phone = request.getParameter("registerphone");
	boolean result = userMgr.checkDuplicate(id);
%>

<form method="post" name="idreturnfrm">
	<input type="hidden" name="idDuplicateChkreturn" value="<%=result%>">
	<input type="hidden" name="idreturn" value="<%=id%>">
	<input type="hidden" name="namereturn" value="<%=name%>">
	<input type="hidden" name="pwdreturn" value="<%=pwd%>">
	<input type="hidden" name="pwdretypereturn" value="<%=pwdretype%>">
	<input type="hidden" name="emailreturn" value="<%=email%>">
	<input type="hidden" name="phonereturn" value="<%=phone%>">
</form>

<script>
	<%
		if ( result == true ) {
	%>
			alert("사용 가능한 아이디입니다.");
			window.opener.name = "parentPage";
			document.idreturnfrm.target = "parentPage";
			document.idreturnfrm.action = "../register.jsp";
			document.idreturnfrm.submit();
			self.close();
	<%
		} else {
	%>
			alert("이미 존재하는 아이디입니다.");
			window.opener.name = "parentPage";
			document.idreturnfrm.target = "parentPage";
			document.idreturnfrm.action = "../register.jsp";
			document.idreturnfrm.submit();
			self.close();
	<%
		}
	%>
</script>