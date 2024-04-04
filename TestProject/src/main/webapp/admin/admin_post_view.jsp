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

		//Cmgr.insertComment(CommentBean);
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
	<section id="maincontent" class="maincontent">
		<header class = "main_head">
			<a class = "head_text">유료 게시판</a>
		</header>
		<main class = "main_content">
			<div class = "content">
				<div class = "content_head">
					<a href = "admin_post_list.jsp" class = "link">유로 게시판</a><br>
					<a class = "title"><%=board_title %></a><br>
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
									/////////
									Vector<Board_commentBean> cvlist = Cmgr.getCommentList(board_num);
									if(!cvlist.isEmpty()){
									%>
										<table>
										<%
											for(int i=0; i<cvlist.size(); i++){
												Board_commentBean cbean = cvlist.get(i);
												String Ccontent = cbean.getPaypost_comment_content();
												String Cuser_id = cbean.getPaypost_comment_user_id();
												String Cdate = cbean.getPaypost_comment_date();
												int reply_pos = cbean.getPaypost_comment_reply_pos();
												int reply_ref = cbean.getPaypost_comment_reply_ref();
												int reply_depth = cbean.getPaypost_comment_reply_depth();
												String Cname = Cmgr.getCuserName(Cuser_id);
												int Cgrade = Cmgr.getCuserGrade(Cuser_id);
										%>
										<tr>
											<div style="border: 1px solid black; margin-top: 10px;">
											    <div style="border-bottom: 1px solid black;">
											        <%
											        for (int j = 0; j < reply_depth; j++) {
											            out.println("&nbsp;&nbsp;");// 들여쓰기
											        }
											        %>
											        <%=Cname %><a class="fa-solid fa-user font"></a>
											        <a>등급 :<%=Cgrade %></a>
											        <a style="text-align: right;">작성일 :<%= Cdate %></a>
											        <%
											        if(reply_ref == 0 && reply_depth == 0){
											        %>	
											        	<input type="button" value="답변" onClick="toggleHidden('comment_<%=reply_pos%>_<%=reply_ref%>_<%=reply_depth%>')">
											       	<%
											        }
											        %>
											        <input type="button" value="삭제" onClick="deleteunderComment('<%=reply_pos%>', '<%=reply_ref%>', '<%=reply_depth%>')">
											    </div>
											    <div>
											        <%
											        for (int j = 0; j < reply_depth; j++) {
											            out.println("&nbsp;&nbsp;");
											        }
											        // 여기서는 reply_depth에 따라 "&nbsp;&nbsp;"를 여러 번 출력한 후에 "<i class="fa-solid fa-arrow-right"></i>"를 한 번만 출력하도록 하였습니다.
											        if (reply_depth > 0) {
											            out.println("<i class=\"fa-solid fa-arrow-right\"></i>");
											        }
											        %>
											        <a><%=Ccontent %></a><br>  
											        <%=reply_pos %> <%=reply_ref %> <%=reply_depth %>
											    </div>
											</div>
											<div id="comment_<%=reply_pos%>_<%=reply_ref%>_<%=reply_depth%>" style="display: none;">
												<input name="under_comment" placeholder="댓글을 입력해주세요" size="100" id = "inputText_<%=reply_pos%>_<%=reply_ref%>_<%=reply_depth%>">
												<input type="button" value="작성" onclick="cInsert_under('<%=reply_pos%>', '<%=reply_ref%>', '<%=reply_depth%>')">
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
				</div>
			</div>
		</main>
	</section>
	</body>
</html>