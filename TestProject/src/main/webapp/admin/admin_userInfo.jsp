<%@page import="project.UtilMgr"%>
<%@page import="java.util.Vector"%>
<%@page import="project.UserBean"%>
<jsp:useBean id="Umgr" class="project.UserMgr"/>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="inc/session.jsp"%>
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

totalRecord = Umgr.getcountuser(keyField, keytext);

int allcount = Umgr.getallcount();



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
<%@ include file="inc/head.jsp"%>
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
	document.listFrm.action = "admin_userInfo.jsp";
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
	window.location.href = "admin_userInfo.jsp";
}

//check박스 전체 선택
function allselect() {
    var checkboxes = document.getElementsByName('checkbox');
    var selectAllCheckbox = document.getElementById('selectAllCheckbox');
    for (var i = 0; i < checkboxes.length; i++) {
        checkboxes[i].checked = selectAllCheckbox.checked;
    }
}

function updateSelectAllCheckbox() {
    var checkboxes = document.getElementsByName('checkbox');
    var selectAllCheckbox = document.getElementById('selectAllCheckbox');
    for (var i = 0; i < checkboxes.length; i++) {
        if (!checkboxes[i].checked) {
            selectAllCheckbox.checked = false;
            return;
        }
    }
    selectAllCheckbox.checked = true;
}

//정보 수정
function amend() {
    // 선택된 체크박스 요소들을 가져옵니다.
    var checkboxes = document.getElementsByName('checkbox');
    var selectedOptions = [];
    var selectedUserIds = [];
    var selectedEmails = [];
    var selectedPhones = [];
    
    // 체크된 항목이 있는지 확인
    var isChecked = false;
    
    // 각 체크박스들을 순회하며 선택된 값들을 배열에 추가
    for (var i = 0; i < checkboxes.length; i++) {
        if (checkboxes[i].checked) {
            isChecked = true; // 체크된 항목이 있음을 표시
            // 체크된 행의 각 열 값들을 가져와서 배열에 추가
            var row = checkboxes[i].parentNode.parentNode; // 체크박스의 부모의 부모(즉, tr 요소)
            var userId = row.getElementsByClassName('user-id')[0].innerText;
            var userEmail = row.getElementsByClassName('user-email')[0].querySelector('input').value;
            var userPhone = row.getElementsByClassName('user-phone')[0].querySelector('input').value;

            selectedUserIds.push(userId);
            selectedEmails.push(userEmail);
            selectedPhones.push(userPhone);
            
            // 등급 선택 select 요소에서 선택된 값을 가져옵니다.
            var selectElement = row.querySelector('select');
            var selectedOption = selectElement.options[selectElement.selectedIndex].value;
            selectedOptions.push(selectedOption);
        }
    }
    
    // 선택된 항목이 없으면 경고창을 띄우고 함수 종료
    if (!isChecked) {
        alert("수정할 항목을 선택하세요.");
        return;
    }
    
    // 선택된 옵션들과 회원 ID, email, phone 값을 확인하기 위해 배열을 콘솔에 출력합니다.
    console.log(selectedOptions);
    console.log(selectedUserIds);
    console.log(selectedEmails);
    console.log(selectedPhones);
    
    // hidden input 요소에 선택된 회원 정보들을 설정합니다.
	document.getElementById("user_id").value = selectedUserIds.join(',');
	document.getElementById("user_email").value = selectedEmails.join(',');
	document.getElementById("user_phone").value = selectedPhones.join(',');
	document.getElementById("user_grade").value = selectedOptions.join(',');
	
	// 폼을 서블릿으로 전송합니다.
	document.getElementById("amendFrm").submit();
}


//사용자 삭제
function deleteuser() {
    // 선택된 체크박스 요소들을 가져옵니다.
    var checkboxes = document.getElementsByName('checkbox');
    var selectedUserIds = [];
    for (var i = 0; i < checkboxes.length; i++) {
        if (checkboxes[i].checked) {
            var row = checkboxes[i].parentNode.parentNode; // 체크박스의 부모의 부모(즉, tr 요소)
            var userId = row.getElementsByClassName('user-id')[0].innerText;
            selectedUserIds.push(userId);
        }
    }
    
    // 선택된 사용자가 없을 경우 경고창을 표시하고 함수를 종료합니다.
    if (selectedUserIds.length === 0) {
        alert("삭제할 사용자를 선택해주세요.");
        return;
    }
    
    // 선택된 사용자가 있을 경우 삭제를 진행합니다.
    console.log(selectedUserIds);
    document.getElementById("tuser_id").value = selectedUserIds.join(',');
    document.getElementById("delFrm").submit();
}

</script>
</head>
<body>
	<!-- Page Wrapper -->
	<div id="wrapper">
		<!-- // 사이드 메뉴 영역  -->
		<%@ include file="inc/menu.jsp"%>
		<!-- Content Wrapper -->
		<div id="content-wrapper" class="d-flex flex-column">
			<!-- Main Content -->
			<div id="content" class="bg-white">
				<!-- // 최상단 Top 영역 -->
				<%@ include file="inc/top.jsp"%>
				<!-- Begin Page Content -->
				<div class="container-fluid">
					<!-- // 컨텐츠 입력 start  -->
					<header class = "d-flex justify-content-between border-bottom border-info">
						<div class="justify-content-start mt-2 mb-2">
							<div class="fs-4 fw-bolder text-black">회원 관리</div>
						</div>
						<div class="justify-content-end mt-2 mb-2">
							<input class="btn btn-dark" type="button" value="수정" onClick="javascript:amend()">
							<input class="btn btn-dark" type="button" value="삭제" onClick="javascript:deleteuser()">
						</div>
					</header>
					<main>
						<section class="d-flex mt-3 container-fluid">
							<input class="btn btn-primary text-black m-2" type="button" value="전체목록" onClick="javascript:info()">
							<div class="ml-3 d-flex border rounded-1 m-2 bg-info text-black p-3">
							    <div class="border-end pr-2 border-light">총 회원수</div>
							    <div class="pl-2"><%=allcount %>명</div>
							</div>
						</section>
						<section class="d-flex ml-2 justify-content-between container-fluid">
						    <form name="searchFrm" class="w-100"> <!-- 가로 길이를 100%로 설정 -->
						        <div class="d-flex justify-content-start align-items-center">
						            <select class="form-select form-select-lg mb-3 col-1" name="keyField"> <!-- col-3을 사용하여 너비 조정 -->
						                <option value="USER_NAME">이름</option>
										<option value="user_id">회원아이디</option>
										<option value="USER_EMAIL">e-mail</option>
										<option value="USER_PHONE">전화번호</option>
										<option value="USER_POINT">포인트</option>		
										<option value="USER_GRADE">등급</option>	
						            </select>
						            <input class="form-control form-control-lg w-50 ml-1 mb-3" name="keytext" placeholder=""> <!-- form-control 클래스 추가 -->
						            <input type="button" class="btn btn-primary btn-lg mb-3 ml-1 btn-outline-info btn-primary" value="검색" onClick="javascript:check()">
						        </div>
						    </form>
						</section>
						<main class="d-flex justify-content-center">
							<table class="table table-hover table-striped text-center">
								<tr>
									<th>이름</th>
									<th>아이디</th>
									<th>e-mail</th>
									<th>전화번호</th>
									<th>포인트</th>
									<th>등급</th>
									<th><input type="checkbox" id="selectAllCheckbox" value="전체선택" onClick="javascript:allselect()"></th>
								</tr>
								<%
								Vector<UserBean> ulist = Umgr.getUserList(keyField, keytext, start, cnt);
								for(int i = 0; i < ulist.size(); i++){
									UserBean ubean = ulist.get(i);
									String u_id = ubean.getUser_id();
									String u_name = ubean.getUser_name();
									String u_email = ubean.getUser_email();
									String u_phone = ubean.getUser_phone();
									int u_point = ubean.getUser_point();
									int u_grade = ubean.getUser_grade();
								%>
								<tr>
									<th><%=u_name %></th>
									<th class="user-id"><%=u_id %></th>
									<th class="user-email"><input value="<%=u_email%>"></th>
									<th class="user-phone"><input value="<%=u_phone%>"></th>
									<th><%=u_point %></th>
									<th>
										<select>
											<option value="1" <%= (u_grade == 1) ? "selected" : "" %>>1</option>
						                    <option value="2" <%= (u_grade == 2) ? "selected" : "" %>>2</option>
						                    <option value="3" <%= (u_grade == 3) ? "selected" : "" %>>3</option>
						                    <option value="4" <%= (u_grade == 4) ? "selected" : "" %>>4</option>
						                    <option value="5" <%= (u_grade == 5) ? "selected" : "" %>>5</option>
						                    <option value="6" <%= (u_grade == 6) ? "selected" : "" %>>6</option>
						                    <option value="7" <%= (u_grade == 7) ? "selected" : "" %>>7</option>
						                    <option value="8" <%= (u_grade == 8) ? "selected" : "" %>>8</option>
						                    <option value="9" <%= (u_grade == 9) ? "selected" : "" %>>9</option>
						                    <option value="10" <%= (u_grade == 10) ? "selected" : "" %>>10</option>
										</select>
									</th>
									<th><input type="checkbox" name="checkbox" onClick="updateSelectAllCheckbox()"></th>
								</tr>
								<%} %>
							</table>
						</main>
					</main>
					<footer class="d-flex justify-content-center">
						<nav aria-label="Page navigation">
							<ul class="pagination">
								<%
								if (nowBlock > 1) {
								%>
								<li class="page-item"><a class="page-link"
									href="javascript:block('<%=nowBlock - 1%>')"
									aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
										<span class="sr-only">Previous</span>
								</a></li>
								<%
								}
								%>
								<%
								int pageStart = (nowBlock - 1) * pagePerBlock + 1;
								int pageEnd = (pageStart + pagePerBlock < totalPage ? pageStart + pagePerBlock : totalPage + 1);
								for (; pageStart < pageEnd; pageStart++) {
								%>
								<li
									class="page-item <%=nowPage == pageStart ? "active" : ""%>">
									<a class="page-link"
									href="javascript:pageing('<%=pageStart%>')"><%=pageStart%></a>
								</li>
								<%
								}
								%>
								<%
								if (nowBlock < totalBlock) {
								%>
								<li class="page-item"><a class="page-link"
									href="javascript:block('<%=nowBlock + 1%>')" aria-label="Next">
										<span aria-hidden="true">&raquo;</span> <span class="sr-only">Next</span>
								</a></li>
								<%
								}
								%>
							</ul>
						</nav>
					</footer>
					<form name="listFrm" method="post">
						<input type="hidden" name="reload" value="true"> 
						<input type="hidden" name="nowPage" value="1">
					</form>
					<form name="readFrm" id="readFrm">
						<input type="hidden" name="nowPage" value="<%=nowPage%>"> 
						<input type="hidden" name="numPerPage" value="<%=numPerPage%>">
						<input type="hidden" name="keytext" value="<%=keytext%>">
						<input type="hidden" name="keyField" value="<%=keyField%>">	
						<input type="hidden" name="okay" value="<%=okay %>">	
						<input type="hidden" name="num" value="">
					</form>
					<form name="amendFrm" id ="amendFrm" method="post" action="updateUserInfo">
					    <input type="hidden" name="user_id" id="user_id" value="">
					    <input type="hidden" name="user_email" id="user_email" value="">
					    <input type="hidden" name="user_phone" id="user_phone" value="">
					    <input type="hidden" name="user_grade" id="user_grade" value="">
					</form>
					<form name="delFrm" id="delFrm" method="post" action="deleteuserInfo">
						<input type="hidden" name="tuser_id" id="tuser_id" value="">
					</form>
					<!-- // 컨텐츠 입력 end -->
				</div>
			</div>
		</div>
	</div>
	<!-- // 사이드 메뉴 영역  -->
	<%@ include file="inc/footer.jsp"%>
</body>
</html>
					