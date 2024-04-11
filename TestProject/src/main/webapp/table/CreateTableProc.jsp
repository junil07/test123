<%@page import="table.TableListMgr"%>
<%@page import="project.UtilMgr"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="table.TableQueryMgr"%>
<%@ page contentType="text/html; charset=UTF-8"%>


<%
	TableListMgr mgr = new TableListMgr();
	List<String> opList = new ArrayList<>();
	
	opList.add(request.getParameter("table"));
	opList.add(request.getParameter("tablename"));
	opList.add(request.getParameter("user_op"));
	opList.add(request.getParameter("pay_op"));
	opList.add(request.getParameter("likey_op"));
	opList.add(request.getParameter("uploadfile_op"));
	opList.add(request.getParameter("comment_op"));
	
	mgr.insertTable(opList);
	
	response.sendRedirect("ShowTable.jsp");
%>