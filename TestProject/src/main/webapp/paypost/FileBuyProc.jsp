<%@page import="project.UtilMgr"%>
<%@page import="project.BuyListMgr"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	BuyListMgr mgr = new BuyListMgr();
	
	int num = UtilMgr.parseInt(request, "num");
	int pay = UtilMgr.parseInt(request, "pay");
	String seller = request.getParameter("seller");
	String buyer = request.getParameter("buyer");
	String nowPage = request.getParameter("nowPage");
	String numPerPage = request.getParameter("numPerPage");
	String keyField = request.getParameter("keyField");
	String keyWord = request.getParameter("keyWord");
	
	
	
%>
	<%if(mgr.pointCheck(buyer, pay)) {
		mgr.insetBuylist(pay, num, buyer, seller);%>
		
		<form name="buyFrm" action="PaypostRead.jsp" method="post">
			<input type="hidden" name="num" value="<%=num%>">
			<input type="hidden" name="nowPage" value="<%=nowPage%>">
			<input type="hidden" name="numPerPage" value="<%=numPerPage%>">
			<input type="hidden" name="keyField" value="<%=keyField%>">
			<input type="hidden" name="keyWord" value="<%=keyWord%>">
		</form>
		<script>
			alert("구매 하였습니다.");
			document.buyFrm.action = "PaypostRead.jsp";
			document.buyFrm.submit();
		</script>
	<%} else {%>
		<form name="buyFrm" action="PaypostRead.jsp" method="post">
			<input type="hidden" name="num" value="<%=num%>">
			<input type="hidden" name="nowPage" value="<%=nowPage%>">
			<input type="hidden" name="numPerPage" value="<%=numPerPage%>">
			<input type="hidden" name="keyField" value="<%=keyField%>">
			<input type="hidden" name="keyWord" value="<%=keyWord%>">
		</form>
		<script>
			alert("포인트가 부족하여 구매에 실패했습니다.");
			document.buyFrm.action = "PaypostRead.jsp";
			document.buyFrm.submit();
		</script>		
	<%}%>
