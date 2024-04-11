<%@page import="project.UserBean"%>
<%@page import="project.PaypostBean"%>
<%@page import="java.util.Vector"%>
<%@page import="project.UtilMgr"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="mgr" class="project.PaypostMgr"/>
<jsp:useBean id="userMgr" class="project.UserMgr"/>
<jsp:useBean id="commentMgr" class="project.PaypostCommentMgr"/>
<%
	String sess = (String) session.getAttribute("idKey");
	String sessManager = (String) session.getAttribute("adminKey");
	Vector<UserBean> uvlist = userMgr.showUserInfo(sess);
	
	String infoId = "", infoGrade = "", infoPoint = "";

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
	
%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="../inc/head.jsp" %>
		<title>Paypost</title>
		<link href="css/paypost.css" rel="stylesheet">
<script>
	<%
	// System.out.println("!!" + sess);						// 내 정보는 로그인을 해야 볼 수 있음. 세션에 idKey값 없을 시 login.jsp로 이동
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
	
	
	function check() {
		if(document.searchFrm.keyWord.value==""){
			alert("검색어를 입력하세요.");
			document.searchFrm.keyWord.focus();
			return;
		}
		document.searchFrm.submit();
		}
		
	function list() {
		document.listFrm.action = "PayPost.jsp";
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
		document.readFrm.action="PaypostRead.jsp";
		document.readFrm.submit();
	}
	function numPerFn(numPerPage) {
		document.readFrm.action="Paypost.jsp";
		document.readFrm.numPerPage.value=numPerPage;
		document.readFrm.submit();
	}
	function blockprev(block) {
		if ( <%=nowBlock%> === 1 ) {
			alert("처음입니다.");
			return;
		}
		document.readfrm.nowPage.value = <%=pagePerBlock%> * ( block - 1 ) + 1;
		document.readfrm.action = "Paypost.jsp";
		document.readfrm.submit();
	}
	
	function blocknext(block) {
		if ( <%=nowBlock%> === <%=totalBlock%> ) {
			alert("끝입니다.");
			return;
		}
		document.readfrm.nowPage.value = <%=pagePerBlock%> * ( block - 1 ) + 1;
		document.readfrm.action = "Paypost.jsp";
		document.readfrm.submit();
	}
	function reload() {
		document.listfrm.action = "Paypost.jsp";
		document.listfrm.submit();
	}
	
	function upload() {
		
		<%
			if ( sess == null ) {
		%>
				alert("로그인이 필요합니다.");
				location.href = "login.jsp";
		<%
			} else {
		%>
				location.href = "PaypostPost.jsp";
		<%
			}
		%>
		
	}
</script>
</head>
<body>
		
		<div id="grandpadiv" style="position:fixed; width: 100%;">
		
			<div id="wrapper">
				
				<%@ include file="../inc/menu.jsp" %>
					
				<div id="content-wrapper" class="d-flex flex-column">
		            <!-- Main Content -->
		            <div id="content" class="bg-white">
		                <!-- // 최상단 Top 영역 -->
						<%@ include file="../inc//top.jsp" %>
						<!-- Begin Page Content -->
		                <div class="container-fluid">
		                	<!-- // 컨텐츠 입력 start  -->
		                	<%@ include file="../inc/footer.jsp" %>
		
		<h1 style="position:absolute; left: 250px; top:100px;">유료글 게시판</h1>
		
		<!-- 시작 -->
		<div class="parantdiv">
			<div align="center">
			<table>
				
				<tr>
					
					<td align="center">
						
						<table style="border-collapse: collapse">
							
							<tr class="subjecttitle" align="center">
					<td width="100">번 호</td>
					<td width="700">제 목</td>
					<td width="200">날 짜</td>
					<td width="110">추천수</td>
					<td width="110">포인트</td>
				</tr>	
				<%
					Vector<PaypostBean> vlist = mgr.getPaypostList(keyField, keyWord, start, cnt);
					int listSize = vlist.size();
					
					for(int i=0; i<numPerPage; i++){
						if(i==listSize) break;
						PaypostBean bean = vlist.get(i);
						int num = bean.getPaypost_num();
						String title = bean.getPaypost_title();
						String regdate = bean.getPaypost_date();
						int count = bean.getPaypost_pay();
						int good = bean.getPaypost_good();
						
						int commentCount = commentMgr.getCountComment(num);
						
				%>
				<tr class="subjecttitle" align="center">
					<td><%=totalRecord - start - i%></td>
					<%
						if ( commentCount == 0 ) {
					%>
					<td><a href="javascript:read('<%=num%>')"><%=title%></a></td>
					<%
						} else {
					%>									
					<td><a href="javascript:read('<%=num%>')"><%=title%> <font color="red">(<%=commentCount%>)</font></a></td>
					<%
						}
					%>
					<td><%=regdate%></td>
					<td><%=good%></td>
					<td><%=count%></td>
				</tr>
				<%}//--for%>
				
				<tr align="center">
				
				<%
					if ( listSize == 0 ) {
				%>
					
						<td colspan="4">정보가 없습니다.</td>
					
				<%
					} else {
				%>
				<td colspan="4" style="height: 70px;">
				
				<a href="javascript:blockprev('<%=nowBlock - 1%>')">&#60;</a>
				
				<!-- 이전블럭 -->
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
					<a href="javascript:blocknext('<%=nowBlock + 1%>')">&#62;</a>
				</td>
			<%
				}
			%>
				</tr>
			</table>
		</td>
	</tr>
</table>

<form name="searchFrm">
			
				<div class="bottomcpn">
				
					<select name="keyField">
						<option value="PAYPOST_TITLE">제목</option>
						<option value="PAYPOST_USER_ID">작성자</option>
					</select>
					
					<input name="keyWord" style="width: 30%;">
					<button class="searchbtn" type="button" onclick="check(event)">검색</button>
					<button class="reloadbtn" type="button" onclick="reload()">새로고침</button>
					<button class="newpostbtn" type="button" onclick="upload()">글 쓰기</button>
					
				</div>
				
			</form>
			
			<div style="width: 100%; height: 100px;"></div>
			
		</div>
		
		<hr width="750">
		                	
		   	  			</div>
		   	  
		            </div>
		            
		        </div>
				
			</div>
		
		</div>
		
		
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


