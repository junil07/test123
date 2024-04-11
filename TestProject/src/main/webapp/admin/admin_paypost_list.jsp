<%@page import="project.UtilMgr"%>
<%@page import="project.PaypostBean"%>
<%@page import="java.util.Vector"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="Mgr" class="project.PaypostMgr" />
<!-- // session 정보 확인하는 내용 -->
<%@ include file="inc/session.jsp" %>
<%
int totalRecord = 0;
int numPerPage = 10;
int pagePerBlock = 10;
int totalPage = 0;
int totalBlock = 0;
int nowPage = 1;
int nowBlock = 1;

String keyWord="";
String url="adminpage.jsp";
if ( request.getParameter("keyWord") != null ) {
	keyWord = request.getParameter("keyWord");
}

// 검색 후에 다시 초기화 요청
if ( request.getParameter("reload") != null &&
		request.getParameter("reload").equals("true") ) {
	keyWord = "";
}

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

//승인된 유로게시글 전체 갯수
totalRecord = Mgr.getselectCount(keyField, keytext);



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
<%@ include file="inc/head.jsp" %>
<link href="./css/admin_paypost_list.css" rel="stylesheet" type="text/css">
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
//페이징 처리
function list() {
	document.listFrm.action = "admin_paypost_list.jsp";
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

//유로글 연결
function read(num) {
    document.readFrm.num.value = num;
    document.readFrm.action = "paypost_listview.jsp";
    document.readFrm.submit();
}

</script>
</head>
<body>
 	<!-- Page Wrapper -->
    <div id="wrapper">
	    <!-- // 사이드 메뉴 영역  -->
		<%@ include file="inc/menu.jsp" %>
        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">
            <!-- Main Content -->
            <div id="content" class="bg-white">
                <!-- // 최상단 Top 영역 -->
				<%@ include file="inc/top.jsp" %>
                <!-- Begin Page Content -->
                <div class="container-fluid">
                	<!-- // 컨텐츠 입력 start  -->
                	<section class="container-xl">
                		<header>
							<div >
								<h1 class="d-flex justify-content-center text-primary">유료게시판 관리</h1>
							</div>
							<div class="d-flex justify-content-center container-xl">
								<form class="d-flex justify-content-center container-xl" name = "searchFrm">
									<select class="form-select form-select-lg mb-3 col-2"  name = "keyField" size = 1>
										<option value = "u.user_name">작성자</option>
										<option value = "p.PAYPOST_TITLE">제목</option>
										<option value = "p.PAYPOST_PAY">가격</option>
									</select>
									<input class="form-control form-control-lg w-50 ml-1" name="keytext" placeholder="">
									<input class="btn btn-primary mb-3 ml-1 btn-outline-info text-dark" type="button" value="검색" onClick = "javascript:check()">
								</form>			
							</div>							
						</header>
						<!-- 메인내용 -->
						<main class="d-flex justify-content-center">
							<table class="table table-hover table-striped text-center">
								<tr>
									<th class="">번호</th>
									<th class="">작성자</th>
									<th class="d-flex justify-content-center"">제목</th>
									<th class="">가격</th>
									<th class="">날짜</th>
								</tr>
								<%
								Vector<PaypostBean> vlist = Mgr.allPaypost(keyField, keytext, start, cnt);
								for(int i = 0; i < vlist.size(); i++) {
								    PaypostBean bean = vlist.get(i);
								    int num = bean.getPaypost_num();
								    String userId = bean.getPaypost_user_id();
								    String name = Mgr.getUserName(userId);
								    String title = bean.getPaypost_title();
								    int pay = bean.getPaypost_pay();
								    String date = bean.getPaypost_date();
								    int displayNum = totalRecord - start - i;
									
								%>
								<tr>
									<th><%= displayNum %></th>
									<th><%= name %></th>
									<th><a id="btn-read" href="javascript:read('<%=num %>')" class="href"><%=title %></a></th>
									<th><%= pay %></th>
									<th><%= date %></th>
								</tr>
								<%}%>
							</table>
						</main>
						<!-- 하단 페이징 처리 -->
						<footer class="d-flex justify-content-center">
						    <nav aria-label="Page navigation">
						        <ul class="pagination">
						            <% if(nowBlock > 1) { %>
						                <li class="page-item">
						                    <a class="page-link" href="javascript:block('<%=nowBlock-1 %>')" aria-label="Previous">
						                        <span aria-hidden="true">&laquo;</span>
						                        <span class="sr-only">Previous</span>
						                    </a>
						                </li>
						            <% } %>
						            <% 
						                int pageStart = (nowBlock - 1) * pagePerBlock + 1;
						                int pageEnd = (pageStart + pagePerBlock < totalPage ? pageStart + pagePerBlock : totalPage + 1);
						                for(; pageStart < pageEnd; pageStart++) {
						            %>
						                <li class="page-item <%= nowPage == pageStart ? "active" : "" %>">
						                    <a class="page-link" href="javascript:pageing('<%=pageStart %>')"><%=pageStart%></a>
						                </li>
						            <% } %>
						            <% if(nowBlock < totalBlock) { %>
						                <li class="page-item">
						                    <a class="page-link" href="javascript:block('<%=nowBlock+1 %>')" aria-label="Next">
						                        <span aria-hidden="true">&raquo;</span>
						                        <span class="sr-only">Next</span>
						                    </a>
						                </li>
						            <% } %>
						        </ul>
						    </nav>
						    <!-- 
						    하단 페이징 이동 버튼
						    <a href="javascript:list()" class="btn btn-primary ml-3">처음으로</a>
						     -->
						</footer>
					</section>
               	 	<!-- // 컨텐츠 입력 end -->
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
               </div>
           </div>
       </div>
   </div>					
   <!-- // 사이드 메뉴 영역  -->
<%@ include file="inc/footer.jsp" %>
</body>      
</html>