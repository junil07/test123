<%@page import="project.Board_commentBean"%>
<%@page import="project.BoardBean"%>
<%@page import="java.util.Vector"%>
<%@page import="project.PaypostCommentBean"%>
<%@page import="project.PaypostBean"%>
<%@page import="project.UtilMgr"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="Mgr" class="project.BoardMgr" />
<jsp:useBean id="Cmgr" class="project.Board_commentMgr" />
<jsp:useBean id="Mmgr" class="project.ManagerMgr" />

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
String keyField = request.getParameter("keyField");
int num = 0;
if (request.getParameter("num") != null) {
	num = UtilMgr.parseInt(request, "num");
}



//BoardBean 불러오기
BoardBean bean = Mgr.getlist(num);
int board_num = bean.getBoard_num();
String board_title = bean.getBoard_title();
String board_content = bean.getBoard_content();
String board_date = bean.getBoard_date();
int board_count = bean.getBoard_count();
String board_userid = bean.getBoard_user_id();



//유저등급 출력
int usergrade = Mgr.getGrade(board_userid);

//게시글 별 댓글 수
int countComment = Cmgr.getCountComment(board_num);

//댓글 호출 판단
String flag = request.getParameter("flag");
if (flag != null && flag.equals("insert")) {
	Board_commentBean CommentBean = new Board_commentBean();
	CommentBean.setComment_board_num(num);
	if (sess == null || sess.isEmpty()) {
		CommentBean.setBoard_comment_user_id(adminKey);
	} else if (adminKey == null || adminKey.isEmpty()) {
		CommentBean.setBoard_comment_user_id(sess);
	}

	String commentParameter = request.getParameter("comment");
	String underCommentParameter = request.getParameter("under_comment");

	if (commentParameter == null || commentParameter.isEmpty()) {
		CommentBean.setBoard_comment_content(underCommentParameter);
	} else if (underCommentParameter == null || underCommentParameter.isEmpty()) {
		CommentBean.setBoard_comment_content(commentParameter);
	}

	Cmgr.insertComment(CommentBean);
}

String name = Mgr.getUserName(board_userid);

//현재 로그인 유저 이름들고 오기
String this_name = Cmgr.getthisName(sess, adminKey);
%>
<!DOCTYPE html>
<html>
<head>
<!-- // 공통 Head  -->
<%@ include file="inc/head.jsp"%>
<link href="./css/admin_paypost_list.css" rel="stylesheet"
	type="text/css">
<script type="text/javascript">
var num = '<%=num%>';

var sess = '<%=sess%>';
var adminKey = '<%=adminKey%>';
var userId = 'null';

if(sess == 'null' || sess.isEmpty()){
	userId = adminKey;
}else if(adminKey == 'null' || adminKey.isEmpty()){
	userId = sess;
}else {
	userId = 'null';
}

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
function cInsert_under(comment_pos, comment_ref, comment_depth) {
    var inputTextId = "inputText_" + comment_pos + "_" + comment_ref + "_" + comment_depth;
    var inputValue = document.getElementById(inputTextId).value;
    if (inputValue.trim() == "") {
        alert("댓글을 입력하세요.");
        return;
    } else {
    	document.getElementById("under_comment").value = inputValue;
        document.getElementById("Cpos").value = comment_pos;
        document.getElementById("Cref").value = comment_ref;
        document.getElementById("Cdepth").value = comment_depth;
        document.getElementById("userId").value = userId;
        document.getElementById("num").value = num; // JavaScript 변수를 사용하여 userId 값 전달
        // 폼 제출
        document.getElementById("commentForm").submit();
    }
}

//댓글 삭제
function deleteunderComment(comment_pos, comment_ref, comment_depth){
	var reply = comment_pos + comment_ref + comment_depth;
	if(reply != null || !reply.isEmpty()){
		document.getElementById("Dpos").value = comment_pos;
        document.getElementById("Dref").value = comment_ref;
        document.getElementById("Ddepth").value = comment_depth;
        document.getElementById("Dnum").value = num;
		document.getElementById("deletFrom").submit();
	}
}


//대댓글 작성칸 숨기고 키기
function toggleHidden(comment_pos, comment_ref, comment_depth) {
	var element = document.getElementById(comment_pos, comment_ref, comment_depth);
	if (element.style.display === 'none') {
		element.style.display = 'block';
	} else {
		element.style.display = 'none';
	}
}

//삭제
function deleteboard(num) {
	document.delFrm.num.value = <%=num%>;
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
				<div class="container-xxl">
					<!-- // 컨텐츠 입력 start  -->
					<!-- 메인내용 -->
					<section>	
						<!-- 작성자 정보 -->
						<header class="border-bottom border-info">
						    <h2 class="text-primary fw-bold"><%= board_title %></h2>
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
						                    <span class="me-1 text-black bg-secondary-subtle"><%= board_date %></span>
						                </div>
						            </div>
						        </div>
						    </div>
						</header>
						<main class ="border-bottom border-info mt-3 pb-3" >
							<div class = "text-black fs-5 fw-semibold" >
								<%=board_content %><br>
								<!-- 임시 사진임 -->
								<img src="./img/test.png">
							</div>
						</main>
						<footer>
							<form method="post" name = "cFrm">
								<table class="container-xxl">
									<tr class="border-bottom border-info">
										<td class="text-black fs-5 fw-semibold">댓글</td>
									</tr>
									<tr>
									    <td>
									        <%
									        Vector<Board_commentBean> cvlist = Cmgr.getCommentList(board_num);
									        if(!cvlist.isEmpty()){
									        %>
									            <table class="container-fluid">
									            <%
									                for(int i=0; i<cvlist.size(); i++){
									                    Board_commentBean cbean = cvlist.get(i);
									                    int comment_num = cbean.getBoard_comment_num();
									                    int comment_board_num = cbean.getComment_board_num();
									                    String comment_content = cbean.getBoard_comment_content();
									                    int comment_pos = cbean.getBoard_comment_reply_pos();
									                    int comment_ref = cbean.getBoard_comment_reply_ref();
									                    int comment_depth = cbean.getBoard_comment_reply_depth();
									                    String comment_id = cbean.getBoard_comment_user_id();
									                    String comment_date = cbean.getBoard_comment_date();
									                    int comment_grade = Mgr.getGrade(comment_id);
									                    //사용자와 관리자의 이름 출력
									                    String user_name = Mgr.getUserName(comment_id);
									                    String admin_name = Mmgr.getAdminName(comment_id); 
									            %>
									            <tr>
									                <td>
									                    <div class="border border-info mt-3">
									                        <div class="d-flex justify-content-between border-bottom border-info bg-secondary-subtle">
															    <%
														        for (int j = 0; j < comment_depth; j++) {
														            out.println("&nbsp;&nbsp;");// 들여쓰기
														        }
														        %>
															    <div class="mt-2 mb-2">
															        <span class="text-black"><%=user_name %></span>
															        <span class="fa-solid fa-user font"></span>
															    </div>
															    <div class="ml-auto mr-2 mt-2 mb-2"> <!-- ml-auto 클래스를 사용하여 오른쪽으로 정렬 -->
															        <span class="text-black border-end border-black me-2 pr-3">등급 : <%=comment_grade %></span>
															        <span class="text-black border-end border-black me-2 pr-3">작성일 : <%= comment_date %></span>
															        <%
															        if(comment_ref == 0 && comment_depth == 0){
															        %>
															        	<a class="text-black border-end border-black pr-3" href="javascript:void(0)" onClick="toggleHidden('comment_<%=comment_pos%>_<%=comment_ref%>_<%=comment_depth%>')">답글</a>
															        <%
															        }
															        %>
															        <%
															        if(adminKey == null || adminKey.isEmpty()){
															        	if(sess == comment_id || sess.equals(comment_id)){
															        %>
																		<a class="text-black me-2 pl-2" href="javascript:void(0)" onClick="deleteunderComment('<%=comment_pos%>', '<%=comment_ref%>', '<%=comment_depth%>')">삭제</a>
																		<%} %>
																	<%
																	}else if(sess == null || sess.isEmpty()){
																		if(adminKey == comment_id || adminKey.equals(comment_id)){
																	%>
																		<a class="text-black me-2 pl-2" href="javascript:void(0)" onClick="deleteunderComment('<%=comment_pos%>', '<%=comment_ref%>', '<%=comment_depth%>')">삭제</a>
																		<%} %>
																	<%}else{%>
																	<%}%>
															    </div>
															</div>	
															<!-- 댓글출력 -->								                        
									                        <div class="h-50 pt-3 pb-3 mt-2 mb-2">
									                            <%
									                            for (int j = 0; j < comment_depth; j++) {
									                                out.println("&nbsp;&nbsp;");
									                            }
									                            // 여기서는 reply_depth에 따라 "&nbsp;&nbsp;"를 여러 번 출력한 후에 "<i class="fa-solid fa-arrow-right"></i>"를 한 번만 출력하도록 하였습니다.
									                            if (comment_depth > 0) {
									                                out.println("<i class=\"fa-solid fa-arrow-right\"></i>");
									                            }
									                            %>
									                            <span class="text-black fs-6 ml-2"><%=comment_content %></span>
									                        </div>
									                     </div>
									                   	 <div class="border border-info rounded border-info bg-secondary-subtle mt-5 mb-5" id="comment_<%=comment_pos%>_<%=comment_ref%>_<%=comment_depth%>" style="display: none;">
									                   	 	<div class="border-bottom mt-2 mb-2 justify-content-between d-flex">
									                   	 		<div class="justify-content-start">
																	<span class="text-black">댓글 작성</span>
																	<span class="fa-solid fa-user font"></span>
																	<span class="text-black"><%=this_name %></span>
																</div>
																<div class="justify-content-end mr-2">
																	<a href="javascript:void(0)" class="text-black border-start border-black pl-2" onclick="cInsert_under('<%=comment_pos%>', '<%=comment_ref%>', '<%=comment_depth%>')">작성</a>
																</div>	
									                   	 	</div>
									                   	 	<textarea class="form-control border-0 form-control-lg h-25" rows="2" name="under_comment" placeholder="댓글을 입력해주세요" id = "inputText_<%=comment_pos%>_<%=comment_ref%>_<%=comment_depth%>"></textarea>
									                   	 </div>
									                </td>
									            </tr>
									            <%} %>
									            </table>
									        <%} %> 
									    </td>
									</tr>
									<tr>
										<td>
											<div class="border border-info rounded border-info bg-secondary-subtle mt-5 mb-5 ">
												<div class="border-bottom mt-2 mb-2 justify-content-between d-flex">
													<div class="justify-content-start">
														<span class="text-black">댓글 작성</span>
														<span class="fa-solid fa-user font"></span>
														<span class="text-black"><%=this_name %></span>
													</div>	
													<div class="justify-content-end mr-2">
														<a href="javascript:void(0)" class="text-black border-start border-black pl-2" onclick="cInsert()">작성</a>
													</div>	
												</div>
												<textarea class="form-control border-0 form-control-lg h-25" rows="5" name = "comment"  placeholder="댓글을 입력해주세요"></textarea>
											</div>
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
							<form id="commentForm" action="insertcomment" method="POST">
								<input type="hidden" id="Cpos" name="Cpos" value="">
								<input type="hidden" id="Cref" name="Cref" value="">
								<input type="hidden" id="Cdepth" name="Cdepth" value="">
								<input type="hidden" id="inputValue" name="inputValue" value="">
								<input type="hidden" id="under_comment" name="under_comment" value="">
								<input type="hidden" id="userId" name="userId" value="">
								<input type="hidden" id="num" name="num" value="">
							</form> 
							<form id="deletFrom" action="deletecomment" method="POST">
								<input type="hidden" id="Dpos" name="Dpos" value="">
								<input type="hidden" id="Dref" name="Dref" value="">
								<input type="hidden" id="Ddepth" name="Ddepth" value="">
								<input type="hidden" id="Dnum" name="Dnum" value="">
								<!--  
								<input type="hidden" id="userId" name="userId" value="">
								-->
							</form>	
							<form name="readFrm" id="readFrm">
								<input type="hidden" name="nowPage" value="<%=nowPage%>"> 
								<input type="hidden" name="numPerPage" value="<%=numPerPage%>">
								<input type="hidden" name="keytext" value="<%=keytext%>">
								<input type="hidden" name="keyField" value="<%=keyField%>">		
								<input type="hidden" name="num" value="">
							</form>
							<form method="POST" name="delFrm" id="delFrm" action="delboard"> 
								<input type="hidden" name="num" value="">
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
