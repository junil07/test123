<%@page import="table.TableListMgr"%>
<%@page import="project.UtilMgr"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8"%>

<%
	TableListMgr mgr = new TableListMgr();	

	List<String> opList = new ArrayList<>();
	int line = UtilMgr.parseInt(request, "line");
	opList.add(request.getParameter("table"+line));
	opList.add(request.getParameter("tablename"+line));
	opList.add(request.getParameter("user_op"+line));
	opList.add(request.getParameter("pay_op"+line));
	opList.add(request.getParameter("likey_op"+line));
	opList.add(request.getParameter("uploadfile_op"+line));
	opList.add(request.getParameter("comment_op"+line)); 
	
	mgr.deleteTable(opList, line);
	
	response.sendRedirect("ShowTable.jsp");
%>