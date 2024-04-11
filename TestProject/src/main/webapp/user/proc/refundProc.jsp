<%@page import="project.UserBean"%>
<%@page import="java.util.Vector"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="userMgr" class="project.UserMgr"/>
<%
	String sess = (String) session.getAttribute("idKey");
	
	Vector<UserBean> vlist = userMgr.showUserInfo(sess);
	UserBean bean = vlist.get(0);
	
	int userpoint = bean.getUser_point();
	int refundpoint = Integer.parseInt(request.getParameter("totalprice"));
	
	boolean flag = userMgr.pointCharge(sess, userpoint, refundpoint, 2);
%>

<script>
	<%
		if ( flag ) {
	%>
			alert("환불 되었습니다");
			location.href = "../pointUsageHistory_old.jsp";
	<%
		} else {
	%>
			alert("환불 실패");
			location.href = "../pointUsageHistory_old.jsp";
	<%
		}
	%>
</script>