<%@page import="project.ChoiceBean"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="project.TestBean"%>
<%@page import="project.QuestionBean"%>
<%@page import="project.ExplanationBean"%>
<%@page import="java.util.Vector"%>
<%@page import="project.PaypostCommentBean"%>
<%@page import="project.PaypostBean"%>
<%@page import="project.UtilMgr"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="Mgr" class="project.PaypostMgr" />
<jsp:useBean id="Cmgr" class="project.PaypostCommentMgr"/>
<jsp:useBean id="Tmgr" class="project.TestMgr"/>
<jsp:useBean id="Qmgr" class="project.QuestionMgr"/>
<jsp:useBean id="hmgr" class="project.ChoiceMgr"/>
<jsp:useBean id="Emgr" class="project.ExplanationMgr"/>
<%
//리스트 페이지에서 주소값 불러오기
	String nowPage = request.getParameter("nowPage");
	String numPerPage = request.getParameter("numPerPage");
	String keyWord = request.getParameter("keyWord");
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
	
	
	//testBean 불러오기
	TestBean tbean = Tmgr.getTestInfo(test_num);
	//testBean 내용
	String tnum = tbean.getTest_num();
	String ttitle = tbean.getTest_title();
	String tyear = tbean.getTest_year();
	String tsubject = tbean.getTest_subject();
	int tsubnumber = tbean.getTest_subnumber();
	
	
	//exExplanationBean 불러오기
	//ExplanationBean ebean = Emgr.getExInfo(tnum);
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
		CommentBean.setPaypost_comment_user_id(userId);

		String commentParameter = request.getParameter("comment");
		String underCommentParameter = request.getParameter("under_comment");

		if(commentParameter == null || commentParameter.isEmpty()){
			CommentBean.setPaypost_comment_content(underCommentParameter);
		}else if(underCommentParameter == null || underCommentParameter.isEmpty()){
			CommentBean.setPaypost_comment_content(commentParameter);
		}

		Cmgr.insertComment(CommentBean);
	}

	String refuse = Mgr.getpaypostReason(num);
	String name = Mgr.getUserName(userId);
	
%>
<!DOCTYPE html>
<html>
 <head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <link href="./css/paypost_agreeview.css" rel="stylesheet" type="text/css">
  <script src="https://kit.fontawesome.com/cd8a19c45f.js" crossorigin="anonymous"></script>
  <title>승인관리: <%=title %></title>
<script type="text/javascript">
	var num = '<%=num%>';
	var userId = '<%=userId %>'; 
	
	// 승인 버튼 클릭 시 실행되는 함수
    function agree_content() {
        var text = "승인된 게시글 입니다.";
        document.getElementById("reason_agree").value = text;
        document.getElementById("num_agree").value = num;
        // 폼 제출
        document.getElementById("update_agree_form").submit();
    }

    // 거절 버튼 클릭 시 실행되는 함수
    function refuse_content() {
        var reason = document.getElementById("refuse_reason").value;
        if (reason.trim() === "") {
            alert("거절사유를 작성해 주세요.");
        } else{
        	document.getElementById("reason_refuse").value = reason;
            document.getElementById("num_refuse").value = num;
            // 폼 제출
            document.getElementById("update_refuse_form").submit();
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
			<a class = "head_text">유료글 승인 관리</a>
		</header>
		<main class = "main_content">
			<div class = "content">
				<div class = "content_head">
					<a href = "paypost_agree_list.jsp" class = "link">유료글 승인 관리</a><br>
					<a class = "title"><%=title %></a><br>
					<div class = "user_profil">
						<a class="fa-solid fa-user font"><%=name %></a>
						<a>등급 :<%=usergrade %></a><br>
						<a class = "date">작성일: <%=date %></a>
						<!-- 조회 DB없음 -->
						<a class = "reply">조회:</a>
						<a class = "pay">가격: <%=pay %></a>
					</div>
				</div>
				<div class = "content_main">
					<div class="div_content" style="border-bottom: 2px solid black;">
						<%=content %>
					</div>
					<div class="content_wrong">
						<div>
							<header class = "wrong_header">
								<span class = "wrong_side">제목</span><span class = "wrong_main"><%=title %></span><br>
								<span class = "wrong_side">시험과목</span><span class = "wrong_main"><%=ttitle %></span>
								<span class = "wrong_side">시험년도</span><span class = "wrong_main"><%=tyear %></span> <br>
								<span class = "wrong_side">시험 회차</span><span class = "wrong_main"><%=tyear %></span> 
								<span class = "wrong_side">가격</span><span class = "wrong_main"><%=pay %></span><br>
								<span class = "wrong_side">과목</span><span class = "wrong_main"><%=tsubnumber %></span> 
								<span class = "wrong_side side_right">첨부파일</span><span class = "wrong_main"><input type="file" name="download" value="파일첨부"></span><br>
							</header>
							<%
							Vector<QuestionBean> qlist = Qmgr.allQlist(tnum); 
							for(int i =0; i<qlist.size(); i++){
								QuestionBean qbean = qlist.get(i);
								int question_num = qbean.getQuestion_num();//기본키
								int question_number = qbean.getQuestion_number();//문제번호
								String question_content = qbean.getQuestion_content();//문제 질문
								int question_correct = qbean.getQuestion_correct();//정답번호
								String question_file = qbean.getQuestion_file();
								double question_percent = qbean.getQuestion_percent();//정답률
								DecimalFormat df = new DecimalFormat("#.#");
								String formattedPercent = df.format(question_percent);
							%>
							<section class = "test_view">
								<div class = "view">
									<div>문제</div>
									<!-- EXPLANATION_PAYPOST_NUM를 통해서 값들고오기
									 EXPLANATION_QUESTION_NUM + "." + EXPLANATION_CONTENT-->
									<div><%=question_number %>.<%=question_content %></div>
									<div>정답률: <%=formattedPercent%>%</div>
									<%if(question_file != null){%>
										<div><%=question_file %></div>
									<%}else if(question_file == null || question_file.isEmpty()){%>
										<div></div>
									<%} %>
									<%
									Vector<ChoiceBean> clist = hmgr.allChoice(question_number);
									for(int j = 0; j < clist.size(); j++){
										ChoiceBean cbean = clist.get(j);
										int choice_number = cbean.getChoice_number();
										String choice_content = cbean.getCcontent();
									%>	
									<div><%=choice_number %>. <%=choice_content %></div>
									<%}%>
								</div>
								<div class = "view">
									<div>해설</div>
									<!-- EXPLANATION_PAYPOST_NUM를 통해서 값들고오기
									 EXPLANATION_QUESTION_NUM + "." + EXPLANATION_CONTENT-->
									<div><%=question_number %>.<%=question_content %></div>
									<div>정답: <%=question_correct %> 정답률: <%=formattedPercent%>%</div>
									<%if(question_file != null){%>
										<div><%=question_file %></div>
									<%}else if(question_file == null || question_file.isEmpty()){%>
										<div></div>
									<%} %>	
									<%
									Vector<ExplanationBean> exlist = Emgr.allexinfo(question_number, num); 
									for(int k = 0; k<exlist.size(); k++){
										ExplanationBean exbean = exlist.get(k);
										String ex_content = exbean.getExplanation_content();
									%>
									<div class="ex_content"><%=ex_content %></div>
									<%} %>
								</div>
							</section>
							<%} %>
						</div>
					</div>
				</div>
				<div id="agree_reason">
					<div>
						<table>
							<tr>
								<td style="border-bottom: 2px solid black">승인 확인 
								<input type="button" name="agree_content" value="승인" onClick="javascript:agree_content()"> 
								<input type="button" name="refuse_content" value="거절" onClick="javascript:refuse_content()">
							</tr>
							<tr>
								<td>
									<%if(agree == 0) {%>
					                    승인 대기중인 게시글 입니다.
					                <%}else if(agree == 1){%>    
					                    <%= refuse %>
					                <%}else if(agree == 2){ %>    
					                    승인된 게시글 입니다.	
					                <%}%>    
								</td>
							</tr>
							<tr>
								<td><input name="refuse_reason" id="refuse_reason" size="100"></td>
							</tr>
						</table>
					</div>
				</div>
			</div>
		</main>
	</section>
	<form id="update_refuse_form" action="refuseReason" method="post">
	    <input type="hidden" id="reason_refuse" name="reason" value="">
	    <input type="hidden" id="num_refuse" name="num" value="">
	</form>
	<form id="update_agree_form" action="agreeReason" method="post">
	    <input type="hidden" id="reason_agree" name="reason" value="">
	    <input type="hidden" id="num_agree" name="num" value="">
	</form>
	</body>
</html>