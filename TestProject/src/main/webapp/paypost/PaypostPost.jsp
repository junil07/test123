<!-- post.jsp -->
<%@page import="project.UserBean"%>
<%@page import="java.util.Vector"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<jsp:useBean id="userMgr" class="project.UserMgr"/>
<%
	String sess = (String) session.getAttribute("idKey");
	String sessManager = (String) session.getAttribute("adminKey");
	Vector<UserBean> uvlist = userMgr.showUserInfo(sess);
	String infoId = "";
%>
<!DOCTYPE html>
<html>
<head>

<script>
<%
//System.out.println("!!" + sess);						// 내 정보는 로그인을 해야 볼 수 있음. 세션에 idKey값 없을 시 login.jsp로 이동
if ( sess == null && sessManager == null ) {
%>
	alert("로그인이 필요합니다.");
	location.href = "../user/login.jsp";
<%
} else if ( sess != null && sessManager != null ) {
	session.invalidate();
%>
	alert("세션이 중복되었습니다 다시 로그인을 해주세요");
	location.href = "../user/login.jsp";
<%
} else if ( sess != null && sessManager == null ) {

} else if ( sess == null && sessManager != null ) {
	
} 
%>
</script>
<title>JSP Board</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>
<body bgcolor="#FFFFCC">
<div align="center">
<br/><br/>
<table width="600" cellpadding="3">
	<tr>
		<td bgcolor="84F399" height="25" align="center">글쓰기</td>
	</tr>
</table>
<br/>
<form name="postFrm" method="post" action="paypostPost" 
enctype="multipart/form-data">
<table width="600" cellpadding="3" align="center">
	<tr>
		<td align=center>
		<table align="center">
			<tr>
				<td width="10%">아이디</td>
				<td width="90%">
				<%=sess%>
			</tr>
			<tr>
				<td>제 목</td>
				<td>
				<input name="title" size="50" maxlength="30" value="테스트"></td>
			</tr>
			<tr>
				<td>내 용</td>
				<td><textarea name="content" rows="10" cols="50">내용테스트</textarea></td>
			</tr>
			<tr>
				<td>비밀 번호</td>
				<td><input type="password" name="pass" size="15" maxlength="15" value="1234"></td>
			</tr>
			<tr>
			 <tr>
     			<td>파일찾기</td> 
     			<td><input type="file" name="filename" size="50" maxlength="50"></td>
    		</tr>
 			<tr>
 				<td>내용타입</td>
 				<td> HTML<input type=radio name="contentType" value="HTML" >&nbsp;&nbsp;&nbsp;
  			 	TEXT<input type=radio name="contentType" value="TEXT" checked>
  			 	</td>
 			</tr>
			<tr>
				<td colspan="2"><hr/></td>
			</tr>
			<tr>
				<td colspan="2">
					 <input type="submit" value="등록">
					 <input type="reset" value="다시쓰기">
					 <input type="button" value="리스트" onClick="javascript:location.href='Notice.jsp'">
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<input type="hidden" name="ip" value="<%=request.getRemoteAddr()%>">
</form>
</div>
</body>
</html>