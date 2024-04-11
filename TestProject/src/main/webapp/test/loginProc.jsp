<%-- USER 테이블에서 유효성 확인 후 사용자 로그인 --%>

<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="userMgr" class="project.UserMgr"/>
<%
	String idkey = (String) session.getAttribute("idKey");
	String title = request.getParameter("test_title");
	String year = request.getParameter("test_year");
	String test_sec[] = request.getParameterValues("test_sess[]");
	String testNum[] = request.getParameterValues("test_num[]");
	String subject[] = request.getParameterValues("test_subject[]");
	int testNumCount=testNum.length;
	System.out.print(request.getParameter("questionCount"));
	
	String strquestionCount = request.getParameter("questionCount");
	int questionCount = Integer.parseInt(strquestionCount);
	//System.out.println(questionCount);
	int[] userCorrect = new int[questionCount];
	
	for (int i = 0; i < questionCount; i++) {
        String userCor = request.getParameter("choice" + (i));
        if (userCor != null && !userCor.isEmpty() && !"null".equals(userCor)) {
            userCorrect[i] = Integer.parseInt(userCor);
        } else {
            userCorrect[i] = 0;
        }
    }

	String id = request.getParameter("id");			// login.jsp에서 가져온 id
	String pwd = request.getParameter("pwd");		// login.jsp에서 가져온 pwd
	boolean result = userMgr.loginChk(id, pwd);		// 로그인 시도
	String msg = "로그인 실패하였습니다";					// 로그인 실패 시1
	String url = "login.jsp";						// 로그인 실패 시2
    String idsave = request.getParameter("idSave"); // 아이디 저장 체크박스 체크 되어있으면 checked 넘어온다.
	
	if ( result ) {									// 성공 시 세션에 저장
		session.setAttribute("idKey", id);
		msg = "로그인 성공하였습니다";	
		url = request.getParameter("url");
	}
%>
<form id="test_grading" name="test_grading" method="post">
					    <input type="hidden" name="sess" value="<%= idkey %>">
					    <input type="hidden" name="test_title" value="<%= title %>">
					    <input type="hidden" name="test_year" value="<%= year %>">
					    <% for (int i = 0; i < test_sec.length; i++) { %>
					        <input type="hidden" name="test_sess[]" value="<%= test_sec[i] %>">
					    <% } %>
					    <% for (int i = 0; i < testNum.length; i++) { %>
					        <input type="hidden" name="test_num[]" value="<%= testNum[i] %>">
					    <% } %>
					    <% for (int i = 0; i < subject.length; i++) { %>
					        <input type="hidden" name="test_subject[]" value="<%= subject[i] %>">
					    <% } %>
					    <% for (int i = 0; i < questionCount; i++) { %>
					        <input type="hidden" id="choice_<%= i %>" name="choice<%= i %>" value="<%=userCorrect[i]%>">
					    <% } %>
					</form>
<script type="text/javascript">
	alert("<%=msg%>");
	document.test_grading.action="<%=url%>"
	document.test_grading.submit();
</script>

