<%@page import="table.CreateMgr"%>
<%@ page contentType="text/html; charset=UTF-8"%>


<%
	String tablename = request.getParameter("tablename");
	String[] op = request.getParameterValues("op");
	CreateMgr mgr = new CreateMgr();
	mgr.createTable(op, tablename);
%>
<% 
	System.out.println(tablename);
	for(int i=0;i<op.length;i++){%><%=op[i] %><br><%}%>
	
	<%mgr.updateTableName(tablename, "bbb"); %>
	
	
	
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<form action="Table.jsp" name="f1">
<%-- 관리자만 사용 가능 / 사용자도 사용 가능 --%>


<input type="submit" value="전송">
</form>
</body>
</html>