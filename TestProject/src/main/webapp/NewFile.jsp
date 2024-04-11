<%@page import="java.util.Vector"%>
<%@page import="project.NoticeBean"%>
<jsp:useBean id="mgr" class="project.NoticeMgr"/>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	String abc = "헤치웠나?";
	Vector<NoticeBean> vlist = mgr.testList();
	for(int i=0; i<vlist.size(); i++) {
		NoticeBean bean = vlist.get(i);
		int num = bean.getNotice_num();
		String title = bean.getNotice_title();
		String content = bean.getNotice_content();
		String date = bean.getNotice_date();
		int count = bean.getNotice_count();
%>
		num<br>
		<%=title%><br>
		<%=content%><br>
		<%=date%><br>
		<%=count%><br>
<%}%>
