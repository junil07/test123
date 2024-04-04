<%@page import="project.UserBean"%>
<%@page import="java.util.Vector"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="userMgr" class="project.UserMgr"/>
<%
	String sess = (String) session.getAttribute("idKey");
	String apply_num = request.getParameter("apply_num");
	String paid_amount = request.getParameter("paid_amount");
	String msg = "승인 금액 : " + paid_amount;
	
	Vector<UserBean> vlist = userMgr.showUserInfo(sess);
	UserBean bean = vlist.get(0);
	int userpoint = bean.getUser_point();
	int chargepoint = Integer.parseInt(paid_amount);
	// System.out.println("\n--userpoint--\n" + userpoint + "\n--userpoint--\n");
	
	
	
	boolean flag = userMgr.pointCharge(sess, userpoint, chargepoint * 1000, 1);
%>
<script>
	alert("<%=msg%>");
	location.href = "<%=request.getContextPath()%>/user/pointUsageHistory_old.jsp";
</script>