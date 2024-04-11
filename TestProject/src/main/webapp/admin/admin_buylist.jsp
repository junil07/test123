<%@page import="project.BuyListBean"%>
<%@page import="project.UserBean"%>
<%@page import="java.util.Vector"%>
<%@page import="project.UtilMgr"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="Umgr" class="project.UserMgr"/>
<jsp:useBean id="Blmgr" class="project.BuyListMgr"/>
<!-- // session 정보 확인하는 내용 -->
<%@ include file="inc/session.jsp" %>
<%
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

//검색에 필요한 변수
String keyField = "";
String okay = "";
String keytext = "";
if(request.getParameter("keytext") != null){
	keyField = request.getParameter("keyField");
	okay = request.getParameter("okay");
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
	keytext = " "; keyField = " "; okay = " ";
}

totalRecord = Blmgr.getcountlist(keyField, keytext);

int allcount = Blmgr.getallcount();



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

//화면 전체출력 = 페이지 이동
function info() {
	window.location.href = "admin_buylist.jsp";
}

//check박스 전체 선택
function allselect() {
    var checkboxes = document.getElementsByName('checkbox');
    var selectAllCheckbox = document.getElementById('selectAllCheckbox');
    for (var i = 0; i < checkboxes.length; i++) {
        checkboxes[i].checked = selectAllCheckbox.checked;
    }
}

function deletebuylist(){
    // 선택된 체크박스 요소들을 가져옵니다.
    var checkboxes = document.getElementsByName('checkbox');
    var selectedblnums = [];
    for (var i = 0; i < checkboxes.length; i++) {
        if (checkboxes[i].checked) {
            var row = checkboxes[i].parentNode.parentNode; // 체크박스의 부모의 부모(즉, tr 요소)
            var blnum = row.getElementsByClassName('blnum')[0].getAttribute('data-value'); // 'data-value' 속성 값을 가져옵니다.
            selectedblnums.push(blnum);
        }
    }
    // 선택된 체크박스가 없을 경우 경고창을 표시하고 함수를 종료합니다.
    if (selectedblnums.length === 0) {
        alert("삭제할 항목을 선택해주세요.");
        return;
    }
    // 선택된 값들을 콘솔에 출력합니다.
    console.log(selectedblnums);
    document.getElementById("blnum").value = selectedblnums.join(',');
    document.getElementById("delFrm").submit();
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
                	<header class = "d-flex justify-content-between border-bottom border-info">
						<div class="justify-content-start mt-2 mb-2">
							<div class="fs-4 fw-bolder text-black">주문 내역</div>
						</div>
						<div class="justify-content-end mt-2 mb-2">
							<input class="btn btn-dark" type="button" value="삭제" onClick="javascript:deletebuylist()">
						</div>
					</header>
					<main>
						<section class="d-flex mt-3 container-fluid">
							<input class="btn btn-primary text-black m-2" type="button" value="전체목록" onClick="javascript:info()">
							<div class="ml-3 d-flex border rounded-1 m-2 bg-info text-black p-3">
							    <div class="border-end pr-2 border-light">총 구매내역</div>
							    <div class="pl-2"><%=allcount %></div>
							</div>
						</section>
						<section class="d-flex ml-2 justify-content-between container-fluid">
						    <form name="searchFrm" class="w-100"> <!-- 가로 길이를 100%로 설정 -->
						        <div class="d-flex justify-content-start align-items-center">
						            <select class="form-select form-select-lg mb-3 col-1" name="keyField"> <!-- col-3을 사용하여 너비 조정 -->
						                <option value="buyer">구매자</option>
										<option value="title">제목</option>
										<option value="pay">가격</option>
										<option value="date">구매날짜</option>
										<option value="seller">판매자</option>			
						            </select>
						            <input class="form-control form-control-lg w-50 ml-1 mb-3" name="keytext" placeholder=""> <!-- form-control 클래스 추가 -->
						            <input type="button" class="btn btn-primary btn-lg mb-3 ml-1 btn-outline-info btn-primary" value="검색" onClick="javascript:check()">
						        </div>
						    </form>
						</section>
						<main class="d-flex justify-content-center">
							<table class="table table-hover table-striped text-center">
								<tr>
									<th>번호</th>
									<th>구매자</th>
									<th>제목</th>
									<th>가격</th>
									<th>구매날짜</th>
									<th>판매자</th>
									<th><input type="checkbox" id="selectAllCheckbox" value="전체선택" onClick="javascript:allselect()"></th>
								</tr>
								<%
								Vector<BuyListBean> Bllist = Blmgr.getBuyList(keyField, keytext, start, cnt);
								for(int i = 0; i < Bllist.size(); i++){
									BuyListBean blbean = Bllist.get(i);
									int Blnum = blbean.getBuylist_num();
									String date = blbean.getBuylist_date();
									int pay = blbean.getBuylist_pay();
									int ppnum = blbean.getBuylist_paypost_num();
									String buyer_id = blbean.getBuylist_buyer();
									String seller_id = blbean.getBuylist_seller();
									String buyer_name = Blmgr.getBuyerName(buyer_id);
									String seller_name = Blmgr.getsellerName(seller_id);
									String title = Blmgr.gettitle(ppnum);
									int displayNum = totalRecord - start - i;
								%>
								<tr>
									<th class="blnum" data-value="<%=Blnum %>"><%=displayNum %></th>
									<th><%=buyer_name %></th>
									<th><%=title %></th>
									<th><%=pay %></th>
									<th><%=date %></th>
									<th><%=seller_name %></th>
									<th><input type="checkbox" name="checkbox" onClick="updateSelectAllCheckbox()"></th>
								</tr>
								<%} %>
							</table>
						</main>
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
					<form method="post" name="delFrm" id="delFrm" action="delBuyList">
						<input type="hidden" name="blnum" id="blnum" value ="">
					</form>
                </div>
            </div>
        </div>
    </div>					
    <!-- // 사이드 메뉴 영역  -->
	<%@ include file="inc/footer.jsp" %>
</body>      
</html>
                	