<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="table.TableQueryMgr"%>
<%@ page contentType="text/html; charset=UTF-8"%>


<%
	List<String> opList = new ArrayList<>();
	opList.add(request.getParameter("user_op"));
	opList.add(request.getParameter("pay_op"));
	opList.add(request.getParameter("likey_op"));
	opList.add(request.getParameter("uploadfile_op"));
	opList.add(request.getParameter("comment_op"));
	
	response.sendRedirect("ShowTable.jsp");
%>