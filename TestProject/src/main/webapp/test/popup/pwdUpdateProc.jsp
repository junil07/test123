<%-- 비밀번호를 업데이트 하는 jsp --%>

<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="userMgr" class="project.UserMgr"/>
<%
	String sess = (String) session.getAttribute("idKey"); 	// 세션에 로그인 되어있는 사람 아이디 가져옴
	String pwd = request.getParameter("userpwd");			// pwdUpdate.jsp에서의 비밀번호 입력값
	boolean flag = userMgr.updateUserInfo(2, pwd, sess);	// db 수정
%>
<script>
	alert("비밀번호가 변경되었습니다");
	opener.parent.location.reload();						// 수정 후 부모창 리로드(그래야 실시간으로 비밀번호가 바뀐게 보임)
	self.close();
</script>