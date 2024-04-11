<%@ page contentType="text/html; charset=UTF-8"%>
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
	
	String url=request.getParameter("url");
	session.invalidate();
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
<script>
	alert("로그아웃 되었습니다.");
	document.test_grading.action="<%=url%>"
	document.test_grading.submit();
</script>