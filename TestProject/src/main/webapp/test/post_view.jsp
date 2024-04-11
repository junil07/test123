
<%@page import="project.UtilMgr"%>
<%@page import="project.BoardBean"%>
<%@page import="project.Board_commentBean"%>
<%@page import="java.util.Vector"%>
<%@page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="Bmgr" class="project.BoardMgr"/>
<jsp:useBean id="Bcmgr" class="project.Board_commentMgr"/>

<%@include file="../inc/session.jsp"%>
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
BoardBean Bbean = Bmgr.getlist(num);
int board_num = Bbean.getBoard_num();
String board_title = Bbean.getBoard_title();
String board_content = Bbean.getBoard_content();
String board_date = Bbean.getBoard_date();
int board_count = Bbean.getBoard_count();
String board_userid = Bbean.getBoard_user_id();

//유저등급 출력
int usergrade = Bmgr.getGrade(board_userid);

//게시글 별 댓글 수
int countComment = Bcmgr.getCountComment(board_num);

//댓글 호출 판단
String flag = request.getParameter("flag");
if (flag != null && flag.equals("insert")) {
	Board_commentBean Bcbean = new Board_commentBean();
	Bcbean.setComment_board_num(num);
	if (sess == null || sess.isEmpty()) {
		Bcbean.setBoard_comment_user_id(adminKey);
	} else if (adminKey == null || adminKey.isEmpty()) {
		Bcbean.setBoard_comment_user_id(sess);
	}

	String commentParameter = request.getParameter("comment");
	String underCommentParameter = request.getParameter("under_comment");

	if (commentParameter == null || commentParameter.isEmpty()) {
		Bcbean.setBoard_comment_content(underCommentParameter);
	} else if (underCommentParameter == null || underCommentParameter.isEmpty()) {
		Bcbean.setBoard_comment_content(commentParameter);
	}

	Bcmgr.insertComment(Bcbean);
}
//등급별 이미지 출력
String imgsrc = "";

String imgsrc1 = "https://i.namu.wiki/i/3t4jrWPmNFqyrDs3xUJnCNE6-wbc069FEO33_OFcenoatrkXStgCN0_fSwB1be_aWoaLe_QDQXn3vIx_OAbvhP_u6Jgs01Rx0gd536bG7H8xeEJTbV1lNdtfZOpwYwimASvgbM17fyQSyztcfhwTBw.webp";
	
String imgsrc2 = "https://i.namu.wiki/i/8nDVP1V6uDTtF_DSqd8k3VgdmmW3alDTj0i6jTQ" +
			 "1iJXBoS3bfjR5ov63R-ch2vhAy1XRM21dWRIOUL1WwkNKOfNF3zNZq3h" +
			 "VeVkD6WnlIJLPxSdbkVnl_SNnzk9Wkta0T0HXmTz2mrcXfZPxMxet3w.webp";
	
String imgsrc3 = "https://i.namu.wiki/i/c49u7Vr0uQfxNPOS9YwS9u5u_yaz7QlBrbMqz6" +
			 "Vv3sz6HyVNS5Af769-y_06L_rX8IN9vtKOI91_nu3GxI9a6VTOMoLnZ2A" +
			 "oFJRnDRe53mUrtwfjjA4blJ9Bza3jhCAVPawUibCIA1sB9YT32dvkXA.webp";

String name = Bmgr.getUserName(board_userid);

//현재 로그인 유저 이름들고 오기
String this_name = Bcmgr.getthisName(sess, adminKey);

%>
<!DOCTYPE html>
<html>
<head>
<!-- // 공통 Head  -->
<%@ include file="../inc/head.jsp"%>
<link href="../user/css/qnaInPage.css" rel="stylesheet">
<script type="text/javascript">
</script>
</head>
<body>
	<!-- Page Wrapper -->
	<div id="wrapper">
		<!-- // 사이드 메뉴 영역  -->
		<%@ include file="../inc/menu.jsp"%>
		<!-- Content Wrapper -->
		<div id="content-wrapper" class="d-flex flex-column">
			<!-- Main Content -->
			<div id="content" class="bg-white">
				<!-- // 최상단 Top 영역 -->
				<%@ include file="../inc/top.jsp"%>
				<!-- Begin Page Content -->
				<div class="container-xxl">
					<!-- // 컨텐츠 입력 start  -->
					<section>
						<h2 class="container-xl text-primary fw-bold">자유게시판</h2>
						<section class="container-xl">
							<header class="mt-2 border border-info">
								<div class="fs-6 fw-light text-secondary ml-2">자유게시판</div>
								<div class="fs-4 fw-bold text-dark ml-2"><%=board_title %></div>
								<div class="d-flex ml-2 mb-3">
									<div style="width: 50px; height: 50px">
										<img src="<%=imgsrc1%>" style="width: 50px; height: 50px">							
									</div>
									<div class="ml-3 pt-2">
										<div class="text-dark fw-bold"><%=name%></div>
										<div class="text-dark fw-bold"><%=board_date %></div>
									</div>
								</div>
							</header >
							<main class="border border-top-0 border-info">
								<div class="p-2">
									<div class="ml-2">
									이미지 출력칸
									</div>
									<div class="ml-2 mt-2 text-dark fs-5 fw-medium" style="min-height: 100px;">
									<%=board_content %>
									</div>
								</div>
								<div class="p-2 d-flex">
									<div style="width: 50px; height: 50px">
									<%
									/*if ( userGrade == 1 ) {
										imgsrc = imgsrc1;
									} else if ( userGrade == 2 ) {
										imgsrc = imgsrc2;
									} else if ( userGrade == 3 ) {
										imgsrc = imgsrc3;
									}*/
									%>
										<img src="<%=imgsrc1%>" style="width: 50px; height: 50px">							
									</div>
									<div class="ml-3 pt-2">
										<div class="text-dark fw-bold"><%=name %></div>
										<div class="text-dark fw-bold">등급:<%=usergrade %></div>
									</div>
								</div>
								<footer>
									<form class="container-fluid">
										<table class="container-fluid">	
											<tr>
												<td class="text-black bg-secondary-subtle">댓글:<%=countComment %></td>
											</tr>
											<tr>
												<td>
													<%
													Vector<Board_commentBean> cvlist = Bcmgr.getCommentList(board_num);
											        if(!cvlist.isEmpty()){
													%>
													<table class="container-fluid">
													<%
									                for(int i=0; i<cvlist.size(); i++){
									                    Board_commentBean Bcbean = cvlist.get(i);
									                    int comment_num = Bcbean.getBoard_comment_num();
									                    int comment_board_num = Bcbean.getComment_board_num();
									                    String comment_content = Bcbean.getBoard_comment_content();
									                    int comment_pos = Bcbean.getBoard_comment_reply_pos();
									                    int comment_ref = Bcbean.getBoard_comment_reply_ref();
									                    int comment_depth = Bcbean.getBoard_comment_reply_depth();
									                    String comment_id = Bcbean.getBoard_comment_user_id();
									                    String comment_date = Bcbean.getBoard_comment_date();
									                    int comment_grade = Bmgr.getGrade(comment_id);
									                    //사용자와 관리자의 이름 출력
									                    String user_name = Bmgr.getUserName(comment_id); 
										            %>
											            <tr>
											            	<td>
											            		<div class="border border-info">
											            			<div>
											            				
																        <div class="mb-2 d-flex justify-content-between border-bottom border-info">
																	        <div class="d-flex justify-content-start">
																	        	<div style="width: 50px; height: 50px">
																				<img src="<%=imgsrc1%>" style="width: 50px; height: 50px">							
																			</div>
																	        <span class="text-black align-self-center mt-2"><%=user_name %></span>
																	        </div>
																	        <div class="ml-auto mr-2 mt-2 mb-2 align-self-center justify-content-end"> <!-- ml-auto 클래스를 사용하여 오른쪽으로 정렬 -->
																		        <span class="text-black border-end border-black me-2 pr-3"><%= comment_date %></span>
																		       	<%if(comment_ref == 0 && comment_depth == 0){%>
																					<a class="text-black border-end border-black pr-3" href="javascript:void(0)" onClick="toggleHidden('comment_<%=comment_pos%>_<%=comment_ref%>_<%=comment_depth%>')">답글</a>
																        		<%}%>
																        		<a class="text-black me-2 pl-2" href="javascript:void(0)" onClick="deleteunderComment('<%=comment_pos%>', '<%=comment_ref%>', '<%=comment_depth%>')">삭제</a>
																		    </div>
																	    </div>
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
											                            <span class="text-black fs-6 ml-2"><%=comment_content %></span>
											            			</div>
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
																<span class="text-black">이름을 출력</span>
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
									</form>
								</footer>
							</main>
							
						</section>
					</section>
					<!-- // 컨텐츠 입력 end -->
				</div>
			</div>
		</div>
	</div>
<!-- // 사이드 메뉴 영역  -->
<%@ include file="../inc/footer.jsp"%>
</body>
</html>