<!-- read.jsp -->
<%@page import="project.Paypost_fileuploadBean"%>
<%@page import="project.PaypostBean"%>
<%@page import="project.UserBean"%>
<%@page import="java.util.Vector"%>
<%@page import="project.UtilMgr"%>
<%@page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="mgr" class="project.PaypostMgr"/>
<jsp:useBean id="userMgr" class="project.UserMgr"/>
<%
		String sess = (String) session.getAttribute("idKey");
		String sessManager = (String) session.getAttribute("adminKey");
		Vector<UserBean> uvlist = userMgr.showUserInfo(sess);

		String infoId = "", infoGrade = "", infoPoint = "";

		//read.jsp?nowPage=1&numPerPage=10&keyField=&keyWord=&num=3
		String nowPage = request.getParameter("nowPage");
		String numPerPage = request.getParameter("numPerPage");
		String keyField = request.getParameter("keyField");
		String keyWord = request.getParameter("keyWord");
		int num= UtilMgr.parseInt(request, "num");

		PaypostBean pbean = mgr.getlist(num);
		Paypost_fileuploadBean fbean = mgr.getFile(num);
		UserBean ubean = new UserBean();
		
		String id = pbean.getPaypost_user_id();
		String title = pbean.getPaypost_title();
		String content = pbean.getPaypost_content();
		String date = pbean.getPaypost_date();
		int good = pbean.getPaypost_good();	
		int pay = pbean.getPaypost_pay();
		String filename = fbean.getPaypost_fileupload_name();
		if(filename!=null&&!filename.equals(""))
			filename += "." + fbean.getPaypost_fileupload_extension();
		int filesize = fbean.getPaypost_fileupload_size();
		//읽어온 게시물을 수정, 삭제를 위해서 세션에 저장
		session.setAttribute("pbean", pbean);
%>
<!DOCTYPE html>
<html>
<head>
<title>JSP Board</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
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
		for ( int i = 0; i < uvlist.size(); i++ ) {
			UserBean bean = uvlist.get(i);
			infoId = bean.getUser_id();
			infoPoint = Integer.toString(bean.getUser_point());
			infoGrade = Integer.toString(bean.getUser_grade());
			}
	} else if ( sess == null && sessManager != null ) {
		
	} 
	%>
	
	function list() {
		document.listFrm.action = "Paypost.jsp";
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
	function goodUp() {
		document.goodFrm.submit();
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
  <td bgcolor="#FFFFE8"><%=id%></td>
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
    <td align="center" bgcolor="#DDDDDD">가 격</td>
    <td bgcolor="#FFFFE8" colspan="3">
		<%=pay%>
    </td>
   </tr>
   <tr> 
    <td colspan="4"><br/><pre><%=content%></pre><br/></td>
   </tr>
   <tr>
    <td colspan="4" align="right">
     추천수  <%=good%>
     <%if(mgr.goodCheck(infoId, num)) {%>
     	[ <a href="#">추천완료</a> ]
     <%} else{%>
     	[ <a href="javascript:goodUp()">추천</a> ]  	
     <%}%>
    </td>
   </tr>
   </table>
  </td>
 </tr>
 <tr>
  <td align="center" colspan="2">
 
 [ <a href="javascript:list()" >리스트</a> 
 <%if(id == infoId){ %>
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

<form name="goodFrm" action="GoodUpProc.jsp" method="post">
	<input type="hidden" name="num" value="<%=num%>">
	<input type="hidden" name="infoId" value="<%=infoId%>">
	<input type="hidden" name="nowPage" value="<%=nowPage%>">
	<input type="hidden" name="numPerPage" value="<%=numPerPage%>"> 
</form>
</body>
</html>






