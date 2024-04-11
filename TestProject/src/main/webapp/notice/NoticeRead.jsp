<!-- read.jsp -->
<%@page import="project.UserBean"%>
<%@page import="java.util.Vector"%>
<%@page import="project.NoticeBean"%>
<%@page import="project.NoticeFileuploadBean"%>
<%@page import="project.UtilMgr"%>
<%@page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="mgr" class="project.NoticeMgr"/>
<%
		//read.jsp?nowPage=1&numPerPage=10&keyField=&keyWord=&num=3
		String nowPage = request.getParameter("nowPage");
		String numPerPage = request.getParameter("numPerPage");
		String keyField = request.getParameter("keyField");
		String keyWord = request.getParameter("keyWord");
		int num = UtilMgr.parseInt(request, "num");
		
		mgr.upCount(num);
			
		NoticeBean bean = mgr.getNotice(num);
		NoticeFileuploadBean fbean = mgr.getFile(num);
		UserBean ubean = new UserBean();
		
		String title = bean.getNotice_title();
		String content = bean.getNotice_content();
		String date = bean.getNotice_date();
		int count = bean.getNotice_count();	
		String filename = fbean.getNotice_fileupload_name();
		if(filename!=null&&!filename.equals(""))
			filename += "." + fbean.getNotice_fileupload_extension();
		int filesize = fbean.getNotice_fileupload_size();
		//읽어온 게시물을 수정, 삭제를 위해서 세션에 저장
		session.setAttribute("bean", bean);
%>
<!DOCTYPE html>
<html>
<head>
<title>JSP Board</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	function list() {
		document.listFrm.action = "Notice.jsp";
		document.listFrm.submit();
	}
	function down(num) {
		document.downFrm.num.value=num;
		document.downFrm.submit();
	}
	function delFn() {
		document.delFrm.submit();
	}
	function cInsert() {
		if(document.cFrm.comment.value==""){
			alert("댓글을 입력하세요.");
			document.cFrm.comment.focus();
			return;
		}
		document.cFrm.submit();
	}
	function cDel(cnum) {
		document.cFrm.cnum.value=cnum;
		document.cFrm.flag.value="delete";
		document.cFrm.submit();
	}
</script>
</head>
<body bgcolor="#FFFFCC">
<br/><br/>
<table align="center" width="600" cellspacing="3">
 <tr>
  <td bgcolor="#9CA2EE" height="25" align="center">글읽기</td>
 </tr>
 <tr>
  <td colspan="2">
   <table cellpadding="3" cellspacing="0" width="100%"> 
    <tr> 
  <td align="center" bgcolor="#DDDDDD" width="10%"> 이 름 </td>
  <td bgcolor="#FFFFE8"><%="관리자"%></td>
  <td align="center" bgcolor="#DDDDDD" width="10%"> 등록날짜 </td>
  <td bgcolor="#FFFFE8"><%=date%></td>
 </tr>
 <tr> 
    <td align="center" bgcolor="#DDDDDD"> 제 목</td>
    <td bgcolor="#FFFFE8" colspan="3"><%=title%></td>
   </tr>
   <tr> 
     <td align="center" bgcolor="#DDDDDD">첨부파일</td>
     <td bgcolor="#FFFFE8" colspan="3">
		<%if(filename!=null&&!filename.equals("")){%>
		<a href="javascript:down('<%=num%>')">
		<%=filename%>
		</a>
		<font color="blue">
		(<%=UtilMgr.intFormat(filesize)%>bytes)
		</font>
		<%}else{out.print("첨부된 파일이 없습니다");}%>
     </td>
   </tr>
   <tr> 
    <td align="center" bgcolor="#DDDDDD">비밀번호</td>
    <td bgcolor="#FFFFE8" colspan="3">
    	<input type="password" name="pass" id="passId">
    </td>
   </tr>
   <tr> 
    <td colspan="4"><br/><pre><%=content%></pre><br/></td>
   </tr>
   <tr>
    <td colspan="4" align="right">
     조회수  <%=count%>
    </td>
   </tr>
   </table>
  </td>
 </tr>
 <tr>
  <td align="center" colspan="2">
 
 [ <a href="javascript:list()" >리스트</a> 
 <%if(ubean.getUser_grade() == 0){ %>
 	<a href="NoticeUpdate.jsp?nowPage=<%=nowPage%>&num=<%=num%>&numPerPage=<%=numPerPage%>" >| 수 정</a> |
 	<a href="javascript:delFn()">삭 제</a>
 <%} %>
  ]<br/>
  </td>
 </tr>
</table>
<form method="post" name="downFrm" action="NoticeDownload.jsp">
	<input type="hidden" name="num">
</form>

<form name="listFrm">
	<input type="hidden" name="nowPage" value="<%=nowPage%>">
	<input type="hidden" name="numPerPage" value="<%=numPerPage%>">
	<%if(!(keyWord==null||keyWord.equals(""))){%>
	<input type="hidden" name="keyField" value="<%=keyField%>">
	<input type="hidden" name="keyWord" value="<%=keyWord%>">
	<%}%>
</form>

<form name="delFrm" action="noticeDelete" method="post">
	<input type="hidden" name="nowPage" value="<%=nowPage%>">
	<input type="hidden" name="numPerPage" value="<%=numPerPage%>">
	<%if(!(keyWord==null||keyWord.equals(""))){%>
	<input type="hidden" name="keyField" value="<%=keyField%>">
	<input type="hidden" name="keyWord" value="<%=keyWord%>">
	<%}%>
	<input type="hidden" name="pass">
</form>
</body>
</html>






