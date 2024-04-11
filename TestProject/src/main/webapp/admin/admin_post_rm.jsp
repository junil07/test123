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
	String keyField = request.getParameter("keyField");
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
	String user_pw = Bmgr.getUserPw(board_userid);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<link href="./css/admin_post_rm.css" rel="stylesheet" type="text/css">
<script src="https://kit.fontawesome.com/cd8a19c45f.js"
	crossorigin="anonymous"></script>
<title>게시글 수정</title>
<script type="text/javascript"> 
	function goback(num) {
		document.readFrm.num.value = num;
	    document.readFrm.action = "admin_post_view.jsp";
	    document.readFrm.submit();
	}
	function check(){
		var input_pw = document.mFrm.password.value;
		var input_title = document.mFrm.inputTitle.value;
		//alert(input_title);	
		var input_content = document.mFrm.inputContent.value;
		var user_pw = '<%=user_pw%>';
		if(!input_pw){
			alert("비밀번호를 입력해주세요.")
		}else if(user_pw != input_pw){
			alert("잘못된 비밀번호입니다.")
		}else if(input_pw == user_pw){
			document.amendFrm.inputTitle.value = input_title;
			document.amendFrm.inputContent.value = input_content;
			document.amendFrm.num.value = <%=num%>;
			document.getElementById("amendFrm").submit();
		}
	}
	
	function confirmDelete() {
		var delete_text = "삭제된 글입니다.";
		document.delFrm.num.value = <%=num%>;
		document.delFrm.inputTitle.value = delete_text;
		document.delFrm.inputContent.value = delete_text;
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
	<section id="maincontent">
		<header class="main_head">
			<div class="main_head_left">
				<a>내용 관리</a>
			</div>
			<div class="main_head_right">
				<input type="button" name="list" value="뒤로"
					onClick="javascript:goback('<%=num %>')"> <input
					type="button" name="fixed" value="확인" onClick="javascript:check()">
			</div>
		</header>
		<main class="main_content">
			<form method="post" name="mFrm">
				<div class="showId">
					<a><%=board_name %></a> <span><%=board_userid %></span>
					<!-- 수정된 부분: 출력칸으로 변경 -->
					<a>비밀번호 입력칸</a> <input type="password" name="password"
						id="password" placeholder="비밀번호를 입력해주세요." value="">
					<!-- 수정된 부분: 입력칸으로 변경 -->
				</div>
				<div class="showTitle">
					<a>제목</a> <input name="inputTitle" id="inputTitle" placeholder=""
						value="<%=board_title%>">
					<!-- 수정된 부분: 입력칸으로 변경 -->
				</div>
				<div class="showContent">
					<a>내용</a>
					<textarea name="inputContent" id="inputContent"><%=board_content %></textarea>
					<!-- 수정된 부분: 텍스트 영역으로 변경 -->
				</div>
				<div class="showFile">
					<a>첨부파일</a> <input type="file" name="inputFile">
				</div>
			</form>
			<div class="deletebtn">
			    <input type="button" name="deleteboard" value="삭제" onClick="javascript:confirmDelete()">    
			</div>
		</main>
	</section>
	<form method="POST" name="readFrm" id="readFrm">
		<input type="hidden" name="nowPage" value="<%=nowPage%>"> 
		<input type="hidden" name="numPerPage" value="<%=numPerPage%>"> 
		<input type="hidden" name="keyWord" value="<%=keyWord%>">  
		<input type="hidden" name="keyField" value="<%=keyField%>"> 
		<input type="hidden" name="num" value="">
	</form>
	<form method="POST" name="amendFrm" id="amendFrm" action="adminamend">
		<input type="hidden" name="inputTitle" id="inputTitle"> 
		<input type="hidden" name="inputContent" id="inputContent"> 
		<input type="hidden" name="num" value="">
	</form>
	<form method="POST" name="delFrm" id="delFrm" action="delboard"> 
		<input type="hidden" name="num" value="">
	</form>
</body>
</html>