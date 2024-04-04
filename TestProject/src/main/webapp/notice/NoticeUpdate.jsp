<!-- update.jsp -->
<%@page import="project.NoticeMgr"%>
<%@page import="project.NoticeFileuploadBean"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="project.NoticeBean"%>
<% 
	  int num = Integer.parseInt(request.getParameter("num"));
	  String nowPage = request.getParameter("nowPage");
	  String numPerPage = request.getParameter("numPerPage");
	  NoticeBean bean = (NoticeBean)session.getAttribute("bean");
	  String title = bean.getNotice_title();
	  String content = bean.getNotice_content(); 
	  NoticeMgr mgr = new NoticeMgr();
	  NoticeFileuploadBean fbean = mgr.getFile(num);
	  String filename = fbean.getNotice_fileupload_name();
	  if(filename!=null&&!filename.equals(""))
	  	filename += "." + fbean.getNotice_fileupload_extension();
%>
<html>
<head>
<title>JSP Board</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script>
	function check() {
	   document.updateFrm.submit();
	}
</script>
</head>
<body bgcolor="#FFFFCC">
<div align="center"><br/><br/>
<table width="600" cellpadding="3">
  <tr>
   <td bgcolor="#FF9018"  height="21" align="center">수정하기</td>
  </tr>
</table>
<form name="updateFrm" method="post" action="noticeUpdate" enctype="multipart/form-data">
<table width="600" cellpadding="7">
 <tr>
  <td>
   <table>
    <tr>
     <td width="20%">성 명</td>
     <td width="80%">
	  <input name="name" value="<%="관리자"%>" size="30" maxlength="20">
	 </td>
	</tr>
	<tr>
     <td>제 목</td>
     <td>
	  <input name="title" size="50" value="<%=title%>" maxlength="50">
	 </td>
    <tr>
     <td>내 용</td>
     <td>
	  <textarea name="content" rows="10" cols="50"><%=content%></textarea>
	 </td>
    </tr>
    <tr>
    <td>첨부파일</td>
     <td>
     	<%=filename!=null?filename:"첨부된 파일이 없습니다."%>
     	<input type="file" name="filename" size="50" maxlength="50">
     </td>
    </tr>
	<tr>
     <td>비밀 번호</td> 
     <td><input type="password" name="pass" size="15" maxlength="15">
      수정 시에는 비밀번호가 필요합니다.</td>
    </tr>
	<tr>
     <td colspan="2" height="5"><hr/></td>
    </tr>
	<tr>
     <td colspan="2">
	  <input type="button" value="수정완료" onClick="check()">
      <input type="reset" value="다시수정"> 
      <input type="button" value="뒤로" onClick="history.go(-1)">
	 </td>
    </tr> 
   </table>
  </td>
 </tr>
</table>
 <input type="hidden" name="nowPage" value="<%=nowPage %>">
 <input type='hidden' name="num" value="<%=num%>">
 <input type='hidden' name="numPerPage" value="<%=numPerPage%>">
</form> 
</div>
</body>
</html>