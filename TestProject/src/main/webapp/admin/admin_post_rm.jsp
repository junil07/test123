<!--관리자 게시글 수정 -->
<%@page import="project.UtilMgr"%>
<%@page import="project.BoardBean"%>
<%@page import="java.util.Vector"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="Bmgr" class="project.BoardMgr" />
<%
	String nowPage = request.getParameter("nowPage");
	String numPerPage = request.getParameter("numPerPage");
	String keyWord = request.getParameter("keyWord");
	int num = 0;
	if(request.getParameter("num") != null){
		num = UtilMgr.parseInt(request, "num");
	}
	BoardBean bean = Bmgr.getlist(num);
	int board_num = bean.getBoard_num();
	String board_title = bean.getBoard_title();
	String board_content = bean.getBoard_content();
	String board_date = bean.getBoard_date();
	int board_count = bean.getBoard_count();
	String board_userid = bean.getBoard_user_id();
	
	String board_name = Bmgr.getUserName(board_userid);
%>
<!DOCTYPE html>
<html>
 <head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <link href="./css/admin_post_rm.css" rel="stylesheet" type="text/css">
  <script src="https://kit.fontawesome.com/cd8a19c45f.js" crossorigin="anonymous"></script>
  <title>게시글 수정</title>
<script type="text/javascript"> 
	function golist() {
		document.listFrm.action = "admin_post_list.jsp";
		document.listFrm.submit();
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
					class="fa-solid fa-house">유료 게시글 검토 승인</a>
			</div>
		</main>
	</section>
	<section id="maincontent">
		<header class = "main_head">
			<div class="main_head_left">
				<a>내용 관리</a>
			</div>
			<div class="main_head_right">
				<input type="button" name="list" value="목록" onClick="javascript:golist()"> 
				<input type="button" name="fixed" value="확인">
			</div>
		</header>
		<main class="main_content">
	      <div class="showId">
	        <a><%=board_name %></a>
	        <span><%=board_userid %></span> <!-- 수정된 부분: 출력칸으로 변경 -->
	        <a>아이디 입력칸</a>
	        <input name="inputId" placeholder="아이디를 입력해주세요."> <!-- 수정된 부분: 입력칸으로 변경 -->
	      </div>
	      <div class="showTitle">
	        <a>제목</a>
	        <span><%=board_title %></span> <!-- 수정된 부분: 출력칸으로 변경 -->
	        <a>제목 입력칸</a>
	        <input name="inputTitle" placeholder="아이디를 입력해주세요."> <!-- 수정된 부분: 입력칸으로 변경 -->
	      </div>
	      <div class="showContent">
	        <a>내용</a>
	        <textarea name="inputComment"><%=board_content %></textarea> <!-- 수정된 부분: 텍스트 영역으로 변경 -->
	      </div>
	      <div class="showFile">
	        <a>첨부파일</a>
	        <input type="file" name="inputFile">
	      </div>
	      <div class="deletebtn">
	        <input type="button" name="deletePost" value="삭제">
	      </div>
	    </main>
	</section>
	<form name="listFrm" method="post">
		<input type="hidden" name="reload" value="true"> 
		<input type="hidden" name="nowPage" value="1">
	</form>
</body>
</html>