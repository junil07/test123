<%@page import="project.BoardBean"%>
<%@page import="project.UtilMgr"%>
<%@page import="project.PaypostBean"%>
<%@page import="java.util.Vector"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="Mgr" class="project.BoardMgr" />

<!-- // session 정보 확인하는 내용 -->
<%@ include file="../inc/session.jsp" %>
<%
   String keyWord="";
   String url="../test/Mainpage.jsp";
	if ( request.getParameter("keyWord") != null ) {
		keyWord = request.getParameter("keyWord");
	}
	
	// 검색 후에 다시 초기화 요청
	if ( request.getParameter("reload") != null &&
			request.getParameter("reload").equals("true") ) {
		keyWord = "";
	}
	
	int totalRecord = 0;
	int numPerPage = 2;
	int pagePerBlock = 10;
	int totalPage = 0;
	int totalBlock = 0;
	int nowPage = 1;
	int nowBlock = 1;
	
	//요청된 numPerPage 처리
	if(request.getParameter("numPerPage")!= null){
		numPerPage = UtilMgr.parseInt(request, "numPerPage");
	}
	
	//에 필요한 변수
	String keyField = "";
	String keytext = "";
	if(request.getParameter("keytext") != null){
		keyField = request.getParameter("keyField");
		keytext = request.getParameter("keytext");
	}
	
	if(request.getParameter("nowPage")!=null){
		nowPage = UtilMgr.parseInt(request, "nowPage");
	}
	
	//sql에 들어갈 start랑 cnt
	int start = (nowPage * numPerPage) - numPerPage;
	int cnt = numPerPage;
	
	//검색 후에 다시 초기화 요청
	if(request.getParameter("reload")!=null && request.getParameter("reload").equals("true")){
		keytext = " "; keyField = " ";
	}
	
	totalRecord = Mgr.getTotalCount(keyField, keytext);
	

	
	//전체 페이지 개수
	totalPage = (int)Math.ceil((double)totalRecord / numPerPage);
	//전체 블럭 개수
	totalBlock = (int)Math.ceil((double)totalPage / pagePerBlock);
	//현재 블럭 개수
	nowBlock = (int)Math.ceil((double)nowPage / pagePerBlock);
%>
<!DOCTYPE html>
<html>
<head>
<!-- // 공통 Head  -->
<%@ include file="../inc/head.jsp" %>	
<link href="../user/css/qna.css" rel="stylesheet">
<script type="text/javascript">
//입력값 확인
function check() {
	if(document.searchFrm.keytext.value==""){
		alert("검색어를 입력하세요.");
		document.searchFrm.keytext.focus();
		return;
	}
	document.searchFrm.submit();
}
	
function reload() {
	document.listFrm.action = "post_list.jsp";
	document.listFrm.submit();
}	

function upload() {

<%
	if ( sess == null ) {
%>
		alert("로그인이 필요합니다.");
		location.href = "../user/login.jsp";
<%
	} else {
%>
		location.href = "newpost.jsp";
<%
	}
%>
	
}

//페이징 처리
function list() {
	document.listFrm.action = "post_list.jsp";
	document.listFrm.submit();
}
function pageing(page) {
	document.readFrm.nowPage.value = page;
	document.readFrm.submit();
}
function block(block) {
	document.readFrm.nowPage.value = <%=pagePerBlock%> * (block - 1) + 1;
	document.readFrm.submit();
}

//게시글 연결
function read(num) {
    document.readFrm.num.value = num;
    document.readFrm.action = "post_view.jsp";
    document.readFrm.submit();
}
</script>
</head>
<body>
 	<!-- Page Wrapper -->
    <div id="wrapper">
	    <!-- // 사이드 메뉴 영역  -->
		<%@ include file="../inc/menu.jsp" %>
        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">
            <!-- Main Content -->
            <div id="content" class="bg-white">
                <!-- // 최상단 Top 영역 -->
				<%@ include file="../inc/top.jsp" %>
                <!-- Begin Page Content -->
                <div class="container-fluid">
                	<!-- // 컨텐츠 입력 start  -->
                	<div class="d-flex justify-content-center fs-1 fw-bolder">자유게시판</div>
					<div class="parantdiv">
						<table>
							<tr>
								<td align="cneter">
									<table style="border-collapse: collapse">
										<tr class="subjecttitle" align="center">
											<td width="100" >번 호</td>
											<td width="100">작 성 자</td>
											<td width="600">제 목</td>
											<td width="150">등 록 일</td>
											<td width="100">조 회 수</td>
										</tr>
										<%
										Vector<BoardBean> vlist = Mgr.allboardList(keyField, keytext, start, cnt);
										int listSize = vlist.size();
										
										if ( vlist.isEmpty() ) {
											
										} else {
											
										for(int i = 0; i < vlist.size(); i++) {
											if ( i == listSize ) break;
											BoardBean bean = vlist.get(i);
										    int num = bean.getBoard_num();
										    String title = bean.getBoard_title();
										    String content = bean.getBoard_content();
										    String date = bean.getBoard_date();
										    int count = bean.getBoard_count();
										    String userId = bean.getBoard_user_id();
										    String name = Mgr.getUserName(userId);
										    int displayNum = totalRecord - start - i;
										%>
										<tr class="subjecttitle" align="center">
											<th><%= displayNum %></th>
											<th><%= name %></th>
											<th><a id="btn-read" href="javascript:read('<%=num %>')" class="href"><%=title %></a></th>
											<th><%= date %></th>
											<th><%= count %></th>
										</tr>
										<%
											} // -- for
											
											} // -- else
										%>
										<tr align="center">			
										<%
										if ( listSize == 0 ) {
										%>
										<td colspan="5">정보가 없습니다.</td>
										<%
										} else {
										%>
										<td colspan="5" style="height: 70px;">
											<a href="javascript:block('<%=nowBlock - 1%>')">&#60;</a>
											<%
											int pageStart = (nowBlock - 1) * pagePerBlock + 1;
							                int pageEnd = (pageStart + pagePerBlock < totalPage ? pageStart + pagePerBlock : totalPage + 1);
							                for(; pageStart < pageEnd; pageStart++) {
											%>	
											<a href="javascript:pageing('<%=pageStart%>')">
											<%
											if ( nowPage == pageStart ) {
											%>
											<font color="blue">
											<%}%>
											<%=pageStart%>
											<%
											if ( nowPage == pageStart ) {
											%>
											</font>
											<%}%>
											</a>	
											<%}%>
											<a href="javascript:block('<%=nowBlock + 1%>')">&#62;</a>	
										</td>
										<%}%>	
										</tr>
									</table>
									
								</td>
							</tr>
						</table>
					<form name="searchFrm">
						<div class="d-flex justify-content-end mb-3">
							<input type="button" class="reloadbtn" value="새로고침" onClick="reload()">
							<input type="button" class="newpostbtn" value="글 쓰기" onClick="upload()">
						</div>
						<div class="d-flex justify-content-end mb-3">
							<select class="mr-2" name="keyField">
								<option value="title">제목</option>
								<option value="name">작성자</option>
							</select>
							<input name="keytext" class = "justify-content-center mr-2" size="40">
							<input type="button" class="searchbtn" value="검색" onClick="check()">	
						</div>	
					</form>
				</div>
                    <!-- // 컨텐츠 입력 end -->
                    <!-- 페이징 처리에 필요한 정보값 -->
					<form name="listFrm" method="post">
						<input type="hidden" name="reload" value="true"> 
						<input type="hidden" name="nowPage" value="1">
					</form>
					<form name="readFrm" id="readFrm">
						<input type="hidden" name="nowPage" value="<%=nowPage%>"> 
						<input type="hidden" name="numPerPage" value="<%=numPerPage%>">
						<input type="hidden" name="keytext" value="<%=keytext%>">
						<input type="hidden" name="keyField" value="<%=keyField%>">		
						<input type="hidden" name="num" value="">
					</form>
                </div>
            </div>
        </div>
    </div>					
    <!-- // 사이드 메뉴 영역  -->
	<%@ include file="../inc/footer.jsp" %>
</body>      
</html>
