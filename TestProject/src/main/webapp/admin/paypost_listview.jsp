<%@page import="java.util.Vector"%>
<%@page import="project.PaypostCommentBean"%>
<%@page import="project.PaypostBean"%>
<%@page import="project.UtilMgr"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="Mgr" class="project.PaypostMgr" />
<jsp:useBean id="Cmgr" class="project.PaypostCommentMgr"/>
<jsp:useBean id="Mmgr" class="project.ManagerMgr"/>
<!-- // session 정보 확인하는 내용 -->
<%@ include file="inc/session.jsp"%>
<%
String keyWord = "";
String url = "../test/Mainpage.jsp";
if (request.getParameter("keyWord") != null) {
	keyWord = request.getParameter("keyWord");
}

//리스트 페이지에서 주소값 불러오기
String nowPage = request.getParameter("nowPage");
String numPerPage = request.getParameter("numPerPage");
String keytext = request.getParameter("keytext");
int num = 0;
if(request.getParameter("num") != null){
	num = UtilMgr.parseInt(request, "num");
}

//paypostBean 불러오기
PaypostBean pbean = Mgr.getlist(num);
//paypost 내용 불러오기
int list_num = pbean.getPaypost_num();
String test_num = pbean.getPaypost_test_num();
String userId = pbean.getPaypost_user_id();
String title = pbean.getPaypost_title();
String content = pbean.getPaypost_content();
int pay = pbean.getPaypost_pay();
int agree = pbean.getPaypost_agree();
String date = pbean.getPaypost_date();
int good = pbean.getPaypost_good();
String reason = pbean.getPaypost_reason();

//유저등급 출력
int usergrade = Mgr.getUserGrade(userId);

//유료글 추천 출력
int paypost_good = Mgr.getpaypostlike(list_num);

//게시글 별 댓글 수
int countComment = Cmgr.getCountComment(list_num);

//댓글 호출 판단
String flag = request.getParameter("flag");
if (flag != null && flag.equals("insert")) {
	PaypostCommentBean CommentBean = new PaypostCommentBean();
	CommentBean.setComment_paypost_num(num);
	if(sess == null || sess.isEmpty()){
		CommentBean.setPaypost_comment_user_id(adminKey);
	}else if(adminKey == null || adminKey.isEmpty()){
		CommentBean.setPaypost_comment_user_id(sess);
	}
	

	String commentParameter = request.getParameter("comment");
	String underCommentParameter = request.getParameter("under_comment");

	if(commentParameter == null || commentParameter.isEmpty()){
		CommentBean.setPaypost_comment_content(underCommentParameter);
	}else if(underCommentParameter == null || underCommentParameter.isEmpty()){
		CommentBean.setPaypost_comment_content(commentParameter);
	}

	Cmgr.insertComment(CommentBean);
}

session.setAttribute("pbean", pbean);
String name = Mgr.getUserName(userId);
%>
<!DOCTYPE html>
<html>
<head>
<!-- // 공통 Head  -->
<%@ include file="inc/head.jsp"%>
<script type="text/javascript">
var num = '<%=num%>';
var userId = '<%=userId %>'; 
//댓글 작성
function cInsert() {
	if (document.cFrm.comment.value == "") {
		alert("댓글을 입력하세요.");
		document.cFrm.comment.focus();
		return;
	}
	document.cFrm.submit();
}

// 대댓글 작성
function cInsert_under(reply_pos, reply_ref, reply_depth) {
	var inputTextId = "inputText_" + reply_pos + "_" + reply_ref + "_" + reply_depth;
	var inputValue = document.getElementById(inputTextId).value;
    if (inputValue.trim() == "") {
        alert("댓글을 입력하세요.");
        return;
    } else {
    	 document.getElementById("under_comment").value = inputValue;
         document.getElementById("Cpos").value = reply_pos;
         document.getElementById("Cref").value = reply_ref;
         document.getElementById("Cdepth").value = reply_depth;
         document.getElementById("userId").value = userId; // JavaScript 변수를 사용하여 userId 값 전달
         document.getElementById("num").value = num; // JavaScript 변수를 사용하여 userId 값 전달
         // 폼 제출
         document.getElementById("commentForm").submit();
    }
}

function deleteunderComment(reply_pos, reply_ref, reply_depth){
	var reply = reply_pos + reply_ref + reply_depth;
	if(reply != null || !reply.isEmpty()){
		document.getElementById("Dpos").value = reply_pos;
        document.getElementById("Dref").value = reply_ref;
        document.getElementById("Ddepth").value = reply_depth;
        document.getElementById("Dnum").value = num;
		document.getElementById("deletFrom").submit();
	}
}


//대댓글 작성칸 숨기고 키기
function toggleHidden(reply_pos, reply_ref, reply_depth) {
	var element = document.getElementById(reply_pos, reply_ref, reply_depth);
	if (element.style.display === 'none') {
		element.style.display = 'block';
	} else {
		element.style.display = 'none';
	}
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
				<div class="container-xxl">
					<!-- // 컨텐츠 입력 start  -->
					<!-- 메인내용 -->
					<section>	
					<!-- 작성자 정보 -->
						<header class="border-bottom border-info">
							<div class="d-flex justify-content-between">
							    <h2 class="text-primary fw-bold"><%= title %></h2>
							    <input type="button" class="justify-content-end me-2 btn btn-dark" value="삭제" onClick="javascript:deleteboard(num)" >
						    </div>
						    <div class="d-flex align-items-center justify-content-between">
						        <h4 class="fa-solid fa-user font text-black"><%= name %></h4>
						        <div>
						            <div class="d-flex justify-content-end align-items-center">
						                <div class="border-end border-black me-2">
						                    <span class="me-1 text-black">추천</span>
						                    <span class="me-1 text-black bg-secondary-subtle"><%= usergrade %></span>
						                </div>
						                <div class="border-end border-black me-2">
						                    <span class="me-1 text-black">댓글</span>
						                    <span class="me-1 text-black bg-secondary-subtle"><%= countComment %></span>
						                </div>
						                <div class="border-end border-black me-2">
						                    <span class="me-1 text-black">조회수</span>
						                    <span class="me-1 text-black bg-secondary-subtle"><%= countComment %></span>
						                </div>
						                <div class="border-end border-black me-2">
						                    <span class="me-1 text-black">등급</span>
						                    <span class="me-1 text-black bg-secondary-subtle"><%= usergrade %></span>
						                </div>
						                <div class="border-end border-black me-2">
						                    <span class="me-1 text-black">작성일</span>
						                    <span class="me-1 text-black bg-secondary-subtle"><%= date %></span>
						                </div>
						            </div>
						        </div>
						    </div>
						</header>
						<main class ="border-bottom border-info mt-3 pb-3" >
							<div class = "text-black fs-5 fw-semibold" >
								<%=content %><br>
								<!-- 임시 사진임 -->
								<img src="./img/test.png">
							</div>
						</main>
						<footer class="pb-2 mb-2">
							<form method="post" name = "cFrm">
								<table class="container-xxl">
									<tr class="border-bottom border-info">
										<td class="text-black fs-5 fw-semibold">댓글</td>
									</tr>
									<tr >
									    <td class="pb-2 mb-2">
									        <%
									        Vector<PaypostCommentBean> cvlist = Cmgr.getCommentList(list_num);
											if(!cvlist.isEmpty()){
									        %>
									            <table class="container-fluid">
									            <%
									            for(int i=0; i<cvlist.size(); i++){
													PaypostCommentBean cbean = cvlist.get(i);
													String Ccontent = cbean.getPaypost_comment_content();
													String comment_id = cbean.getPaypost_comment_user_id();
													String Cdate = cbean.getPaypost_comment_date();
													int reply_pos = cbean.getPaypost_comment_reply_pos();
													int reply_ref = cbean.getPaypost_comment_reply_ref();
													int reply_depth = cbean.getPaypost_comment_reply_depth();
													int Cgrade = Cmgr.getCuserGrade(comment_id);
													//사용자와 관리자의 이름 출력
													String user_name = Mgr.getUserName(comment_id);
													String admin_name = Mmgr.getAdminName(comment_id); 
									            %>
									            <tr>
									                <td>
									                    <div class="border border-info mt-3">
									                        <div class="d-flex justify-content-between border-bottom border-info bg-secondary-subtle">
															    <%
														        for (int j = 0; j < reply_depth; j++) {
														            out.println("&nbsp;&nbsp;");// 들여쓰기
														        }
														        %>
															    <div class="mt-2 mb-2">
															        <span class="text-black"><%=user_name %></span>
															        <span class="fa-solid fa-user font"></span>
															    </div>
															    <div class="ml-auto mr-2 mt-2 mb-2"> <!-- ml-auto 클래스를 사용하여 오른쪽으로 정렬 -->
															        <span class="text-black border-end border-black me-2 pr-3">등급 : <%=Cgrade %></span>
															        <span class="text-black border-end border-black me-2 pr-3">작성일 : <%= Cdate %></span>
															       	<a class="text-black me-2 pl-2" href="javascript:void(0)" onClick="deleteunderComment('<%=reply_pos%>', '<%=reply_ref%>', '<%=reply_depth%>')">삭제</a>
															    </div>
															</div>	
															<!-- 댓글출력 -->								                        
									                        <div class="h-50 pt-3 pb-3 mt-2 mb-2">
									                            <%
									                            for (int j = 0; j < reply_depth; j++) {
									                                out.println("&nbsp;&nbsp;");
									                            }
									                            // 여기서는 reply_depth에 따라 "&nbsp;&nbsp;"를 여러 번 출력한 후에 "<i class="fa-solid fa-arrow-right"></i>"를 한 번만 출력하도록 하였습니다.
									                            if (reply_depth > 0) {
									                                out.println("<i class=\"fa-solid fa-arrow-right\"></i>");
									                            }
									                            %>
									                            <span class="text-black fs-6 ml-2"><%=Ccontent %></span>
									                        </div>
									                     </div>
									                </td>
									            </tr>
									            <%} %>
									            </table>
									        <%} %> 
									    </td>
									</tr>
								</table> 
								<input type="hidden" name="flag" value="insert">
								<input type="hidden" name="num" value="<%=num %>">
								<input type="hidden" name="cnum">
								<input type="hidden" name="nowPage" value="<%=nowPage %>">
								<input type="hidden" name="numPerPage" value="<%=numPerPage %>">
								<%
								if(!(keytext == null || keytext.equals(""))){	
								%>
								<input type="hidden" name="keytext" value="<%=keytext %>">
								<%} %>
							</form>
							<form id="commentForm" action="UnderCommentServlet" method="POST">
								<input type="hidden" id="Cpos" name="Cpos" value="">
								<input type="hidden" id="Cref" name="Cref" value="">
								<input type="hidden" id="Cdepth" name="Cdepth" value="">
								<input type="hidden" id="inputValue" name="inputValue" value="">
								<input type="hidden" id="under_comment" name="under_comment" value="">
								<input type="hidden" id="userId" name="userId" value="">
								<input type="hidden" id="num" name="num" value="">
							</form> 
							<form id="deletFrom" action="deleteUComment" method="POST">
								<input type="hidden" id="Dpos" name="Dpos" value="">
								<input type="hidden" id="Dref" name="Dref" value="">
								<input type="hidden" id="Ddepth" name="Ddepth" value="">
								<input type="hidden" id="Dnum" name="Dnum" value="">
								<!--  
								<input type="hidden" id="userId" name="userId" value="">
								-->
							</form>								
						</footer>
					</section>	
					<!-- // 컨텐츠 입력 end -->
				</div>
			</div>
		</div>
	</div>
	<!-- // 사이드 메뉴 영역  -->
	<%@ include file="inc/footer.jsp"%>
</body>
</html>
						