<%@page import="java.util.Vector"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="testMgr" class="project.TestMgr"/>
<%
	request.setCharacterEncoding("UTF-8");
	String userId = (String)request.getParameter("sess");
	String title = (String)request.getParameter("title");
	String year = (String)request.getParameter("year");
	String sess[] = request.getParameterValues("checkbox[]");
	Integer sss = 0 ;
	if ( sess != null && sess.length > 0 ) {
		sss = sess.length;
	}
	int[] sessNum = new int[sss];
	String[] test_num = new String[sss];
	String[] test_subject = new String[sss];
	String location = "Test.jsp";
	for(int i=0;i<sss;i++){
		sessNum[i] = Integer.parseInt(sess[i]);
		test_num[i] = testMgr.testNum(title, year,sessNum[i]);
		System.out.print(test_num[i]);
		test_subject[i] = testMgr.testSubject(title, year, sessNum[i]);
	}
	
%>

<form method="get" name = "testNum">
	<%for(int i=0;i<sss;i++){ %>
	<input type="hidden" name="test_num[]" value="<%=test_num[i]%>">
	<input type="hidden" name="test_sess[]" value="<%=sess[i]%>">
	<input type="hidden" name="test_subject[]" value="<%=test_subject[i]%>">
	<%} %>
	<input type="hidden" name="sess" value="<%=userId%>">
	<input type="hidden" name="test_title" value="<%=title%>">
	<input type="hidden" name="test_year" value="<%=year%>">
</form>
<script type="text/javascript">
		if(confirm("시험을 시작하시겠습니까?")){
			document.testNum.action = "Test.jsp";
			document.testNum.submit();
		}else{
			alert("제출실패");
		}
</script>