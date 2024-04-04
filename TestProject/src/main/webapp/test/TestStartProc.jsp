<%@page import="java.util.Vector"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="testMgr" class="project.TestMgr"/>
<%
	request.setCharacterEncoding("UTF-8");
	String title = (String)request.getParameter("title");
	String year = (String)request.getParameter("year");
	String sess[] = request.getParameterValues("checkbox[]");
	Integer sss = 0 ;
	if ( sess != null && sess.length > 0 ) {
		sss = sess.length;
	}
	int[] sessNum = new int[sss];
	String[] test_num = new String[sss];
	String location = "Test.jsp";
	for(int i=0;i<sss;i++){
		sessNum[i] = Integer.parseInt(sess[i]);
		test_num[i] = testMgr.testNum(title, year,sessNum[i]);
	}
	
%>

<form method="post" name = "testNum">
	<%for(int i=0;i<sss;i++){ %>
	<input type="hidden" name="test_num[]" value="<%=test_num[i]%>">
	<%} %>
</form>
<script type="text/javascript">
		if(confirm("시험을 시작하시겠습니까?")){
			document.testNum.action = "Test.jsp";
			document.testNum.submit();
		}else{
			alert("제출실패");
		}
</script>