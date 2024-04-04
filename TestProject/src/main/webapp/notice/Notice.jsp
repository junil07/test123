<%@page import="project.UserBean"%>
<%@page import="project.NoticeBean"%>
<%@page import="java.util.Vector"%>
<%@page import="project.UtilMgr"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="mgr" class="project.NoticeMgr"/>
<%
	int totalRecord = 0; //총게시물수
	int numPerPage = 10; //페이지당 레코드 개수(5,10,20,30)
	int pagePerBlock = 15; //블럭당 페이지 개수
	int totalPage = 0; //총 페이지 개수
	int totalBlock = 0; //총 블럭 개수
	int nowPage = 1; //현재페이지
	int nowBlock = 1; //현재블럭
	
	//요청된 numPerPage 처리
	if(request.getParameter("numPerPage")!=null){
		numPerPage = UtilMgr.parseInt(request, "numPerPage");
	}
	
	//검색에 필요한 변수 name,subject,content
	String keyField="", keyWord="";
	if(request.getParameter("keyWord")!=null) {
		keyField = request.getParameter("keyField");
		keyWord = request.getParameter("keyWord");
	}
	
	//검색 후에 다시 초기화 요청
	if(request.getParameter("reload")!=null &&
		request.getParameter("reload").equals("true")){
		keyField=""; keyWord="";
	}
	
	totalRecord = mgr.getTotalCount(keyField, keyWord);
	//out.print(totalRecord);
	
	if(request.getParameter("nowPage")!=null){
			nowPage = UtilMgr.parseInt(request, "nowPage");
		}
	//sql에 들어갈 start랑 cnt가 필요
	int start = (nowPage*numPerPage)-numPerPage;
	int cnt = numPerPage;
	
	//전체페이지 개수
	totalPage = (int)Math.ceil((double)totalRecord/numPerPage);
	//전체블럭 개수
	totalBlock = (int)Math.ceil((double)totalPage/pagePerBlock);
	//현재블럭
	nowBlock = (int)Math.ceil((double)nowPage/pagePerBlock);
	
	UserBean ubean = new UserBean();
%>
<!DOCTYPE html>
<html>
<head>
	<title>JSP Board</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
function check() {
	if(document.searchFrm.keyWord.value==""){
		alert("검색어를 입력하세요.");
		document.searchFrm.keyWord.focus();
		return;
	}
	document.searchFrm.submit();
	}
	
function list() {
	document.listFrm.action = "Notice.jsp";
	document.listFrm.submit();
}
function pageing(page) {
	document.readFrm.nowPage.value=page;
	document.readFrm.submit();
}
function block(block) {
	document.readFrm.nowPage.value=<%=pagePerBlock%>*(block-1)+1;
	document.readFrm.submit();
}
function read(num) {
	document.readFrm.num.value=num;
	document.readFrm.action="NoticeRead.jsp";
	document.readFrm.submit();
}
function numPerFn(numPerPage) {
	document.readFrm.action="Notice.jsp";
	document.readFrm.numPerPage.value=numPerPage;
	document.readFrm.submit();
}
</script>
</head>
<body bgcolor="#FFFFCC" >
<div align="center"><br/>
<h2>JSP Board</h2><br/>
<table>
	<tr>
		<td width="600">
		Total : <%=totalRecord%>Articles(<font color="red"><%=nowPage+"/"+totalPage%></font>)
		</td>
		<td align="right">
			<form name="npFrm" method="post">
				<select name="numPerPage" size="1" onchange="numPerFn(this.form.numPerPage.value)">
    				<option value="5">5개 보기</option>
    				<option value="10" selected>10개 보기</option>
    				<option value="15">15개 보기</option>
    				<option value="30">30개 보기</option>
   				</select>
   				<script>document.npFrm.numPerPage.value=<%=numPerPage%></script>
   			</form>
		</td>
	</tr>
</table>
<table>
	<tr>
		<td align="center" colspan="2">
		<%
			Vector<NoticeBean> vlist = mgr.getNoticeList(keyField, keyWord, start, cnt);
			int listSize = vlist.size();
			//out.print(listSize);
			if(vlist.isEmpty()) {
				out.print("등록된 게시물이 없습니다.");
			}else{
		%>
		<table cellspacing="0">
				<tr align="center" bgcolor="#D0D0D0">
					<td width="100">번 호</td>
					<td width="250">제 목</td>
					<td width="150">날 짜</td>
					<td width="100">조회수</td>
				</tr>	
				<%
					for(int i=0; i<numPerPage; i++){
						if(i==listSize) break;
						NoticeBean bean = vlist.get(i);
						int num = bean.getNotice_num();
						String title = bean.getNotice_title();
						String regdate = bean.getNotice_date();
						int count = bean.getNotice_count();
				%>
				<tr align="center">
					<td><%=totalRecord-start-i%></td>
					<td><a href="javascript:read('<%=num%>')"><%=title%></a></td>
					<td><%=regdate%></td>
					<td><%=count%></td>
				</tr>
				<%}//--for%>
		</table>
		<%}%>
		</td>
	</tr>
	<tr>
		<td colspan="2"><br><br></td>
	</tr>
	<tr>
		<td>
		<!-- 이전블럭 -->
		<%if(nowBlock>1) {%>
			<a href="javascript:block('<%=nowBlock-1%>')">prev...</a>
		<%}%>
		<!-- 페이징 -->
		<%
			int pageStart = (nowBlock-1)*pagePerBlock+1;
			int pageEnd = (pageStart+pagePerBlock)<totalPage?
					pageStart+pagePerBlock:totalPage+1;
			for(;pageStart<pageEnd;pageStart++){
		%>
		<a href="javascript:pageing('<%=pageStart%>')">
		<!-- 현재 페이지와 동일한 페이지는 font color=value 세팅 -->
		<%if(nowPage==pageStart){%><font color="blue"><%}%>
		[<%=pageStart%>]
		<%if(nowPage==pageStart){%></font><%}%>
		</a>
		<%}//--for%>
		<!-- 다음블럭 -->
		<%if(totalBlock>nowBlock) {%>
			<a href="javascript:block('<%=nowBlock+1%>')">...next</a>
		<%}%>
		</td>
		<td align="right">
			<%--관리자일 경우에 글쓰기 버튼 생성 4일때 관리자 상태--%>
			<%if(ubean.getUser_grade() == 0){ %>
				<a href="NoticePost.jsp">[글쓰기]</a>
			<%} %>
			<a href="javascript:list()">[처음으로]</a>
		</td>
	</tr>
</table>
<hr width="750">
<form  name="searchFrm">
	<table  width="600" cellpadding="4" cellspacing="0">
 		<tr>
  			<td align="center" valign="bottom">
   				<select name="keyField" size="1" >
    				<option value="notice_title"> 제 목</option>
    				<option value="notice_date"> 날 짜</option>
   				</select>
   				<input size="16" name="keyWord">
   				<input type="button"  value="찾기" onClick="javascript:check()">
   				<input type="hidden" name="nowPage" value="1">
  			</td>
 		</tr>
	</table>
</form>

<form name="listFrm" method="post">
	<input type="hidden" name="reload" value="true">
	<input type="hidden" name="nowPage" value="1">
</form>

<form name="readFrm">
	<input type="hidden" name="nowPage" value="<%=nowPage%>">
	<input type="hidden" name="numPerPage" value="<%=numPerPage%>">
	<input type="hidden" name="keyField" value="<%=keyField%>">
	<input type="hidden" name="keyWord" value="<%=keyWord%>">
	<input type="hidden" name="num">
</form>
</div>
</body>
</html>


