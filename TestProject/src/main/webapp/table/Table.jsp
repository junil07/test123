<%@page import="table.CreateMgr"%>
<%@page contentType="text/html; charset=UTF-8"%>
<%
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<form action="TableProc.jsp" name="f1">
<%-- 관리자만 사용 가능 / 사용자도 사용 가능 --%>
<input type="checkbox" name="op" value="basic">선택 없음<br> 
<input type="checkbox" name="op" value="col_user">사용자 권한<br> 
<input type="checkbox" name="op" value="col_pay">유료글<br> 
<input type="checkbox" name="op" value="likey">추천수<br> 
<input type="checkbox" name="op" value="comment">댓글<br> 
<input type="checkbox" name="op" value="fileupload">첨부파일<br>

<textarea name="tablename" rows="10" cols="50"></textarea>

<input type="submit" value="전송">


</form>
</body>
</html>