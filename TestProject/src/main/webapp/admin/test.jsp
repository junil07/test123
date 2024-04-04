<%@page import="project.BoardBean"%>
<%@page import="project.UtilMgr"%>
<%@page import="project.PaypostBean"%>
<%@page import="java.util.Vector"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="Mgr" class="project.BoardMgr" />
<%
	int totalRecord = 0;
	int numPerPage = 10;
	int pagePerBlock = 5;
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
	String keyWord = "";
	if(request.getParameter("keyWord") != null){
		keyField = request.getParameter("keyField");
		keyWord = request.getParameter("keyWord");
	}
	
	if(request.getParameter("nowPage")!=null){
		nowPage = UtilMgr.parseInt(request, "nowPage");
	}
	
	//sql에 들어갈 start랑 cnt
	int start = (nowPage * numPerPage) - numPerPage;
	int cnt = numPerPage;
	
	//검색 후에 다시 초기화 요청
	if(request.getParameter("reload")!=null && request.getParameter("reload").equals("true")){
		keyWord = " "; keyField = " ";
	}
	
	totalRecord = Mgr.getTotalCount(keyField, keyWord);
	

	
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
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<link href="./css/admin_paypost_list.css" rel="stylesheet" type="text/css">
<title>관리자-유료글 관리 페이지</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<script src="https://kit.fontawesome.com/cd8a19c45f.js"
	crossorigin="anonymous"></script>
<script type="text/javascript">
	//입력값 확인
	function check() {
		if(document.searchFrm.keyWord.value==""){
			alert("검색어를 입력하세요.");
			document.searchFrm.keyWord.focus();
			return;
		}
		document.searchFrm.submit();
	}
	
	//페이징 처리
	function list() {
		document.listFrm.action = "admin_post_list.jsp";
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
	    document.readFrm.action = "admin_post_rm.jsp";
	    document.readFrm.submit();
	}
	
</script>
</head>
<body id="body">
	<!-- 사이드바(나중에 링크 연결 및 아이콘 수정 혹은 성진쌤껄로 변경)  -->
	<section id="sidebar" class="sidebar">
		<header class="sidebar_head">
			<img src="">
		</header>
		<main class="sidebar_main">
			<div class="ex_manage">
				<div class="ex_button">기출문제 관리</div>
				<a class="fa-solid fa-house">기출문제 관리</a>
			</div>
			<div class="user_manage">
				<div class="user_button">회원관리</div>
				<a class="fa-solid fa-house">회원정보</a><br> <a
					class="fa-solid fa-house">회원 구매 내역</a>
			</div>
			<div class="post_manage">
				<div class="post_button">게시글 관리</div>
				<a class="fa-solid fa-house">QnA</a><br> <a
					class="fa-solid fa-house">FAQ</a><br> <a
					class="fa-solid fa-house">자유게시판</a><br> <a
					class="fa-solid fa-house">공지사항</a><br> <a
					class="fa-solid fa-house">유로 게시글 검토 승인</a>
			</div>
		</main>
	</section>
	
	<!-- 본문 내용(유로글 리스트 출력) -->
	<section id="maincontent" class="maincontent">
		<header class="main_head">
			<div class="head_top">
				<a class="head_txt">게시글 관리</a>
			</div>
			<div class="head_under">
				<form name = "searchFrm">
					<select name = "keyField" size = 1>
						<option value = "u.user_name">작성자</option>
						<option value = "p.PAYPOST_TITLE">제목</option>
						<option value = "p.PAYPOST_PAY">가격</option>
					</select>
					<input name="keyWord" placeholder="">
					<input type="button" value="검색" onClick = "javascript:check()">
				</form>
			</div>
		</header>
		<main class="main_content">
			<table class="main_list">
				<tr>
					<th class="num">번호</th>
					<th class="name">작성자</th>
					<th class="title">제목</th>
					<th class="date">날짜</th>
					<th class="count">조회수</th>
				</tr>
				<%
				Vector<BoardBean> vlist = Mgr.allboardList(keyField, keyWord, start, cnt);
				for(int i = 0; i < vlist.size(); i++) {
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
				<tr class="paypost_list">
					<th><%= displayNum %></th>
					<th><%= name %></th>
					<th><a id="btn-read" href="javascript:read('<%=num %>')" class="href"><%=title %></a></th>
					<th><%= date %></th>
					<th><%= count %></th>
				</tr>
				<%}%>
			</table>
		</main>
		
		<!-- 하단 페이징 처리 -->
		<footer class = "bottom">
			<table class = "bottom_num">
				<tr>
					<td class ="style_a">
						<%if(nowBlock>1) {%> 
						<a href="javascript:block('<%=nowBlock-1 %>')">이전</a> 
						<%}%> 
						<%
							int pageStart = (nowBlock - 1) * pagePerBlock + 1;
							int pageEnd = (pageStart + pagePerBlock < totalPage? pageStart + pagePerBlock : totalPage + 1);
							for(; pageStart < pageEnd; pageStart++){
						%> 
						<a href="javascript:pageing('<%=pageStart %>')">
							<%if(nowPage == pageStart){%><font color = "blue"><%}%>
							<%=pageStart%>
							<%if(nowPage == pageStart){%></font><%}%>
						</a> 
						<%}%>
						<%if(nowBlock < totalBlock){%>
							<a href = "javascript:block('<%=nowBlock+1%>')">다음</a>
						<%}%>	
					</td>
				</tr>
				<tr>
					<td class ="first">
							<a href="javascript:list()">처음으로</a>
					</td>
				</tr>
			</table>
		</footer>
	</section>
	<!-- 페이징 처리에 필요한 정보값 -->
	<form name="listFrm" method="post">
		<input type="hidden" name="reload" value="true"> 
		<input type="hidden" name="nowPage" value="1">
	</form>
	<form name="readFrm" id="readFrm">
		<input type="hidden" name="nowPage" value="<%=nowPage%>"> 
		<input type="hidden" name="numPerPage" value="<%=numPerPage%>">
		<input type="hidden" name="keyWord" value="<%=keyWord%>">
		<input type="hidden" name="keyField" value="<%=keyField%>">		
		<input type="hidden" name="num" value="">
	</form>
</body>
</html>