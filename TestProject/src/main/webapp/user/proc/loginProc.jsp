<%-- USER 테이블에서 유효성 확인 후 사용자 로그인 --%>

<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="userMgr" class="project.UserMgr"/>
<%
	String beforeurl = request.getParameter("url");
	String id = request.getParameter("id");			// login.jsp에서 가져온 id
	String pwd = request.getParameter("pwd");		// login.jsp에서 가져온 pwd
	boolean result = userMgr.loginChk(id, pwd);		// 로그인 시도
	String msg = "로그인 실패하였습니다";					// 로그인 실패 시1
	String url = "../login.jsp";						// 로그인 실패 시2
    String idsave = request.getParameter("idSave"); // 아이디 저장 체크박스 체크 되어있으면 checked 넘어온다.
	
	if ( result ) {									// 성공 시 세션에 저장
		session.setAttribute("idKey", id);
		msg = "로그인 성공하였습니다";	
		url = "../myInfo.jsp";
	}
    if ( beforeurl != null ) {
    	url = beforeurl;
    }
    
%>
<script>
	alert("<%=msg%>");
	location.href = "<%=url%>";
</script>