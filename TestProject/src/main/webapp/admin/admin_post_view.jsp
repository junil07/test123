<%@page import="project.Board_commentBean"%>
<%@page import="project.BoardBean"%>
<%@page import="java.util.Vector"%>
<%@page import="project.PaypostCommentBean"%>
<%@page import="project.PaypostBean"%>
<%@page import="project.UtilMgr"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="Mgr" class="project.BoardMgr" />
<jsp:useBean id="Cmgr" class="project.Board_commentMgr"/>
<%
	//리스트 페이지에서 주소값 불러오기
	String nowPage = request.getParameter("nowPage");
	String numPerPage = request.getParameter("numPerPage");
	String keyWord = request.getParameter("keyWord");
	String keyField = request.getParameter("keyField");
	int num = 0;
	if(request.getParameter("num") != null){
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
	int usergrade = Mgr.getUserGrade(board_userid);
	
	//게시글 별 댓글 수
	int countComment = Cmgr.getCountComment(board_num);
	
	//댓글 호출 판단
	String flag = request.getParameter("flag");
	if (flag != null && flag.equals("insert")) {
		Board_commentBean CommentBean = new Board_commentBean();
		CommentBean.setComment_board_num(num);
		CommentBean.setBoard_comment_user_id(board_userid);

		String commentParameter = request.getParameter("comment");
		String underCommentParameter = request.getParameter("under_comment");

		if(commentParameter == null || commentParameter.isEmpty()){
			CommentBean.setBoard_comment_content(underCommentParameter);
		}else if(underCommentParameter == null || underCommentParameter.isEmpty()){
			CommentBean.setBoard_comment_content(commentParameter);
		}

		Cmgr.insertComment(CommentBean);
	}

	session.setAttribute("bean", bean);
	String name = Mgr.getUserName(board_userid);
%>
<!DOCTYPE html>
<html>
 <head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <link href="./css/paypost_listview.css" rel="stylesheet" type="text/css">
  <script src="https://kit.fontawesome.com/cd8a19c45f.js" crossorigin="anonymous"></script>
  <title><%=board_title %></title>
<script type="text/javascript">
	var num = '<%=num%>';
	var userId = '<%=board_userid %>'; 
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
            document.getElementById("userId").value = userId; // JavaScript 변수를 사용하여 userId 값 전달
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
				<a class="fa-solid fa-house">QnA</a><br> 
				<a class="fa-solid fa-house">FAQ</a><br> 
				<a class="fa-solid fa-house" href="admin_post_list.jsp">자유게시판</a><br> 
				<a class="fa-solid fa-house" href="admin_paypost_list.jsp">유로글 게시판</a><br> 
				<a class="fa-solid fa-house" href="paypost_agree_list.jsp">유로 게시글 검토 승인</a>
			</div>
		</main>
	</section>
	<section id="maincontent" class="maincontent">
		<header class = "main_head">
			<a class = "head_text">자유게시판</a>
		</header>
		<main class = "main_content">
			<div class = "content">
				<div class = "content_head">
					<a href = "admin_post_list.jsp" class = "link">자유게시판</a><br>
					<a class = "title"><%=board_title %></a>
					<input type = "button" name="fixed" value="삭제" onClick="javascript:deleteboard('<%=num %>')" class="herf"><br>
					<div class = "user_profil">
						<a class="fa-solid fa-user font"><%=name %></a>
						<a>등급 :<%=usergrade %></a><br>
						<a class = "date">작성일: <%=board_date %></a>
						<!-- 조회 DB없음 -->
						<a class = "reply">조회:</a>
					</div>
				</div>
				<div class = "content_main">
					<div class= "div_content">
						<%=board_content %><br>
						<!-- 임시 사진임 -->
						<img src="./img/test.png">
					</div>
					<div class = "div_icon">
						<i class="fa-regular fa-comment icon">댓글 : <%=countComment %></i>
					</div>
				</div>
				<div class = "content_comment">
					<form method="post" name = "cFrm">
						<table>
							<tr>
								<td style="border-bottom : 2px solid black">댓글</td>
							</tr>
							<tr>
								<td>
									<%
									Vector<Board_commentBean> cvlist = Cmgr.getCommentList(board_num);
									if(!cvlist.isEmpty()){
									%>
										<table>
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
												String comment_name = Mgr.getUserName(board_userid);
												int comment_grade = Mgr.getUserGrade(board_userid);
												
										%>
										<tr>
											<div style="border: 1px solid black; margin-top: 10px;">
											    <div style="border-bottom: 1px solid black;">
											        <%
											        for (int j = 0; j < comment_depth; j++) {
											            out.println("&nbsp;&nbsp;");// 들여쓰기
											        }
											        %>
											        <%=comment_name %><a class="fa-solid fa-user font"></a>
											        <a>등급 :<%=comment_grade %></a>
											        <a style="text-align: right;">작성일 :<%= comment_date %></a>
											        <%
											        if(comment_ref == 0 && comment_depth == 0){
											        %>	
											        	<input type="button" value="답변" onClick="toggleHidden('comment_<%=comment_pos%>_<%=comment_ref%>_<%=comment_depth%>')">
											       	<%
											        }
											        %>
											        <input type="button" value="삭제" onClick="deleteunderComment('<%=comment_pos%>', '<%=comment_ref%>', '<%=comment_depth%>')">
											    </div>
											    <div>
											        <%
											        for (int j = 0; j < comment_depth; j++) {
											            out.println("&nbsp;&nbsp;");
											        }
											        // 여기서는 reply_depth에 따라 "&nbsp;&nbsp;"를 여러 번 출력한 후에 "<i class="fa-solid fa-arrow-right"></i>"를 한 번만 출력하도록 하였습니다.
											        if (comment_depth > 0) {
											            out.println("<i class=\"fa-solid fa-arrow-right\"></i>");
											        }
											        %>
											        <a><%=comment_content %></a><br>  
											        <%=comment_pos %> <%=comment_ref %> <%=comment_depth %>
											    </div>
											</div>
											<div id="comment_<%=comment_pos%>_<%=comment_ref%>_<%=comment_depth%>" style="display: none;">
												<input name="under_comment" placeholder="댓글을 입력해주세요" size="100" id = "inputText_<%=comment_pos%>_<%=comment_ref%>_<%=comment_depth%>">
												<input type="button" value="작성" onclick="cInsert_under('<%=comment_pos%>', '<%=comment_ref%>', '<%=comment_depth%>')">
											</div>
										</tr>
										<%} %>
										</table>
									<%} %>	
								</td>
							</tr>
							<tr>
								<td>
								<input name = "comment" size="100" placeholder="댓글을 입력해주세요">
								<input type = "button" value = "등록" onclick="cInsert()">
								</td>
							</tr>
						</table> 
						<input type="hidden" name="flag" value="insert">
						<input type="hidden" name="num" value="<%=num %>">
						<input type="hidden" name="cnum">
						<input type="hidden" name="nowPage" value="<%=nowPage %>">
						<input type="hidden" name="numPerPage" value="<%=numPerPage %>">
						<%
						if(!(keyWord == null || keyWord.equals(""))){	
						%>
						<input type="hidden" name="keyWord" value="<%=keyWord %>">
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
						<input type="hidden" name="keyWord" value="<%=keyWord%>">
						<input type="hidden" name="keyField" value="<%=keyField%>">		
						<input type="hidden" name="num" value="">
					</form>
					<form method="POST" name="delFrm" id="delFrm" action="delboard"> 
						<input type="hidden" name="num" value="">
					</form>
				</div>
			</div>
		</main>
	</section>
	</body>
</html>