<%@page import="project.NoticeBean"%>
<%@page import="project.NoticeFileuploadBean"%>
<%@page import="project.ChoiceBean"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="project.TestBean"%>
<%@page import="project.QuestionBean"%>
<%@page import="java.util.Vector"%>
<%@page import="project.PaypostCommentBean"%>
<%@page import="project.PaypostBean"%>
<%@page import="project.UtilMgr"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="Mgr" class="project.PaypostMgr" />
<jsp:useBean id="Cmgr" class="project.PaypostCommentMgr" />
<jsp:useBean id="Tmgr" class="project.TestMgr" />
<jsp:useBean id="Qmgr" class="project.QuestionMgr" />
<jsp:useBean id="hmgr" class="project.ChoiceMgr" />
<!-- 나중에 데이터에 값 생기면 변경 -->
<jsp:useBean id="Nmgr" class="project.NoticeMgr" />
<%@ include file="inc/session.jsp"%>
<%
String keyWord = "";
String url = "../test/Mainpage.jsp";
if (request.getParameter("keyWord") != null) {
	keyWord = request.getParameter("keyWord");
}
String nowPage = request.getParameter("nowPage");
String numPerPage = request.getParameter("numPerPage");
String keytext = request.getParameter("keytext");
int num = 0;
if (request.getParameter("num") != null) {
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

//첨부파일 불러오기(임시로 공지사항 불러옴)
NoticeBean nbean = Nmgr.getNotice(num);
NoticeFileuploadBean fbean = Nmgr.getFile(num);
String Ntitle = nbean.getNotice_title();
String Ncontent = nbean.getNotice_content();
String Ndate = nbean.getNotice_date();
int Ncount = nbean.getNotice_count();
String Nfilename = fbean.getNotice_fileupload_name();
if (Nfilename != null && !Nfilename.equals(""))
	Nfilename += "." + fbean.getNotice_fileupload_extension();
int Nfilesize = fbean.getNotice_fileupload_size();

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

	if (commentParameter == null || commentParameter.isEmpty()) {
		CommentBean.setPaypost_comment_content(underCommentParameter);
	} else if (underCommentParameter == null || underCommentParameter.isEmpty()) {
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
<!-- // 공통 Head  -->
<%@ include file="inc/head.jsp"%>
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

function down(num) {
	document.downFrm.num.value=num;
	document.downFrm.submit();
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
						                    <span class="me-2 text-black">등급</span>
						                    <span class="me-2 text-black bg-secondary-subtle"><%= usergrade %></span>
						                </div>
						                <div class="border-end border-black me-2">
						                    <span class="me-2 text-black">작성일</span>
						                    <span class="me-2 text-black bg-secondary-subtle"><%= date %></span>
						                </div>
						            </div>
						        </div>
						    </div>
						</header>
						<main class="border-bottom border-info mt-3 pb-3" >
							<div class="border-bottom border-top border-info bg-secondary-subtle">
							    <div class="row justify-content-end">
							        <div class="col-auto">
							            <% if(Nfilename!=null&&!Nfilename.equals("")){ %>
							                <a href="javascript:down('<%=num%>')">
							                    <%=Nfilename%>
							                </a>
							                <font color="gray">
							                    (<%=UtilMgr.intFormat(Nfilesize)%>bytes)
							                </font>
							            <% } else { 
							                out.print("첨부된 파일이 없습니다"); 
							            } %>
							        </div>
							    </div>
							</div>
							<div class = "text-black fs-5 fw-semibold mt-3" >
								<%=content %>
							</div>
						</main>
						<footer>
							<div class="border border-info mt-3">
								<div class="d-flex justify-content-between border-bottom border-info bg-secondary-subtle">
									<div class="mt-2 mb-2 justify-content-start">
										<div class="mt-2 mb-2 text-black">승인 확인</div>
									</div>
									<div class="mt-2 mb-2 justify-content-end pr-3">
										<input class="btn btn-dark" type="button" name="agree_content" value="승인" onClick="javascript:agree_content()"> 
										<input class="btn btn-dark" type="button" name="refuse_content" value="거절" onClick="javascript:refuse_content()">
									</div>
								</div>
								<div class = "border-bottom border-info text-black">
								<%if(agree == 0) {%>
				                    승인 대기중인 게시글 입니다.
				                <%}else if(agree == 1){%>    
				                    거절사유 : <%= refuse %>
				                <%}else if(agree == 2){ %>    
				                    승인된 게시글 입니다.	
				                <%}%> 
								</div>
								<div class="ml-auto mr-2 mt-2 mb-2">
									<textarea class="form-control border-0 form-control-lg h-25" rows="2" name="under_comment" placeholder="" id = "refuse_reason"></textarea>
								</div>
							</div>
						</footer>
					</section>
					<!-- // 컨텐츠 입력 end -->
					<form id="update_refuse_form" action="refuseReason" method="post">
					    <input type="hidden" id="reason_refuse" name="reason" value="">
					    <input type="hidden" id="num_refuse" name="num" value="">
					</form>
					<form id="update_agree_form" action="agreeReason" method="post">
					    <input type="hidden" id="reason_agree" name="reason" value="">
					    <input type="hidden" id="num_agree" name="num" value="">
					</form>
					<form method="post" name="downFrm" action="NoticeDownload.jsp">
						<input type="hidden" name="num">
					</form>
				</div>
			</div>
		</div>
	</div>
	<!-- // 사이드 메뉴 영역  -->
	<%@ include file="inc/footer.jsp"%>
</body>
</html>