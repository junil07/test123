
<%@page import="project.WrongBean"%>
<%@page import="java.util.Vector"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../inc/session.jsp" %>
<jsp:useBean id="wrongMgr" class="project.WrongMgr"/>
<%
	String url = "../wrong/WrongList.jsp";
	int totalRecord = 0;
	int numPerPage = 10;
	int pagePerBlock = 10;
	int totalPage = 0;
	int totalBlock = 0;
	int nowPage = 1;
	int nowBlock = 1;
	

	String keyField = "", keyWord = "";
	if ( request.getParameter("keyWord") != null ) {
		keyField = request.getParameter("keyField");
		keyWord = request.getParameter("keyWord");
	}
	
	if ( request.getParameter("reload") != null && request.getParameter("reload").equals("true") ) {
		keyField = "";
		keyWord = "";
	}
	
	totalRecord = wrongMgr.getTotalCount(keyField, keyWord);
	
	if ( request.getParameter("nowPage") != null ) {
		nowPage = Integer.parseInt(request.getParameter("nowPage"));
	}
	
	int start = ( nowPage * numPerPage ) - numPerPage;
	int cnt = numPerPage;
	
	
	totalPage = (int) Math.ceil( (double) totalRecord / numPerPage );
	totalBlock = (int) Math.ceil( (double) totalPage / pagePerBlock );
	nowBlock = (int) Math.ceil( (double) nowPage / pagePerBlock );



%>
<!-- // session 정보 확인하는 내용 -->

<!DOCTYPE html>
<html>
<head>
	<!-- // 공통 Head  -->
	<%@ include file="../inc/head.jsp" %>
	<link href="qna.css" rel="stylesheet">
	<style>
		
	</style>
	<script>
			
			// 이전에 캐싱되어있던적이 있다면 새로고침
			window.onpageshow = function(event) {
			    if (event.persisted) {
			        window.location.reload(); 
			    }
			};
		
			function check() {
				if ( document.searchfrm.keyWord.value == "" ) {
					alert("검색어를 입력하세요");
					document.searchfrm.keyWord.focus();
					return;
				}
				document.searchfrm.action = "WrongList.jsp";
				document.searchfrm.submit();
			}
		
			function read(num) {
				document.readfrm.num.value = num;
				document.readfrm.action = "qnaInPage.jsp";
				document.readfrm.submit();
			}
			
			function reload() {
				document.listfrm.action = "WrongList.jsp";
				document.listfrm.submit();
			}
			
			function pageing(page) {
				document.readfrm.nowPage.value = page;
				document.readfrm.action = "WrongList.jsp";
				document.readfrm.submit();
			}
			
			function blockprev(block) {
				if ( <%=nowBlock%> === 1 ) {
					alert("하하 처음이지롱");
					return;
				}
				document.readfrm.nowPage.value = <%=pagePerBlock%> * ( block - 1 ) + 1;
				document.readfrm.action = "WrongList.jsp";
				document.readfrm.submit();
			}
			
			function blocknext(block) {
				if ( <%=nowBlock%> === <%=totalBlock%> ) {
					alert("하하 끝이지롱");
					return;
				}
				document.readfrm.nowPage.value = <%=pagePerBlock%> * ( block - 1 ) + 1;
				document.readfrm.action = "WrongList.jsp";
				document.readfrm.submit();
			}
			
			function upload() {
				
				<%
					if ( sess == null ) {
				%>
						alert("로그인이 필요합니다.");
						location.href = "login.jsp";
				<%
					} else {
				%>
						location.href = "qnaUpload.jsp";
				<%
					}
				%>
				
			}
			
			function moveWrong(){
				document.move_wrong_listFrm.action="WrongQuestionList.jsp";
				document.move_wrong_listFrm.submit();
			}
		</script>
	
</head>
<body>
	<!-- Page Wrapper -->
    <div id="wrapper">
        <!-- // 사이드 메뉴 영역  -->
		<%@ include file="../inc/menu.jsp" %>
        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">
            <!-- Main Content -->
            <div id="content" class="bg-white">
                <!-- // 최상단 Top 영역 -->
				<%@ include file="../inc/top.jsp" %>
				<!-- Begin Page Content -->
                <div class="container-fluid">
                	<!-- // 컨텐츠 입력 start  -->
                		
		
						<!-- 시작 -->
						<h1 style="position:absolute; left: 250px; top:100px;">오답노트 리스트</h1>
						
						<div class="parantdiv">
								
										
										<table>
											
											<tr class="subjecttitle" align="center">
												
												<td width="100">번 호</td>
												<td width="400">시험 제목</td>
												<td width="500">년도 및 회차</td>
												<td width="300">시험 과목</td>
												<td width="300">추가 날짜</td>
												<td width="400">오답노트 이동</td>
												
											</tr>
											
											<%
												Vector<WrongBean> vlist = wrongMgr.getWrongList(keyField, keyWord, start, cnt ,sess);
												int listSize = vlist.size();
												
												if ( vlist.isEmpty() ) {
													
												} else {
											
												
												for ( int i = 0; i < numPerPage; i++ ) {
													if ( i == listSize ) break;
													WrongBean bean = vlist.get(i);
													int num = bean.getWrong_num();
													String title = bean.getWrong_test_title();
													String date = bean.getWrong_ins_time();
													String test_year = bean.getWrong_test_year();
													String test_sec = bean.getWrong_test_sec();
											%>
												<tr class="subjecttitle" align="center">
													
													<td><%=totalRecord - start - i%></td>
													<td><%=title%></td>
													<td><%=test_year%></td>
													<td><%=test_sec%></td>
													<td><%=date%></td>
													<td><button type="button" class="btn btn-primary" id="move_wrong_question" name="move_wrong_question" onclick="moveWrong()">오답노트 보기</button></td>
													
												</tr>
												
												
												
											<%
												} // -- for
												
												} // -- else
											%>
											
												<tr align="center">
													
											<%
												if ( listSize == 0 ) {
											%>
												
													<td colspan="4">정보가 없습니다.</td>
												
											<%
												} else {
											%>
													
													<td colspan="4" style="height: 70px;">
														
														<a href="javascript:blockprev('<%=nowBlock - 1%>')">&#60;</a>
														
														<%
															int pageStart = ( nowBlock - 1 ) * pagePerBlock + 1;
															int pageEnd = ( pageStart + pagePerBlock ) <= totalPage ?
																	pageStart + pagePerBlock : totalPage + 1;
															for ( ; pageStart < pageEnd; pageStart++ ) {
														%>
															
															<a href="javascript:pageing('<%=pageStart%>')">
															
														<%
															if ( nowPage == pageStart ) {
														%>
															<font color="blue">
														<%
															}
														%>
														
														<%=pageStart%>
														
														<%
															if ( nowPage == pageStart ) {
														%>
															</font>
														<%
															}
														%>
															
															</a>
															
														<%
															}
														%>
														
														<a href="javascript:blocknext('<%=nowBlock + 1%>')">&#62;</a>
														
													</td>
													
											<%
												}
											%>
													
												</tr>
										
										</table>
							<form name="searchfrm">
							
								<div class="bottomcpn">
								
									<select name="keyField">
										<option value="QNA_TITLE">시험 제목</option>
									</select>
									
									<input name="keyWord" style="width: 30%;">
									<button class="searchbtn" type="button" onclick="check()">검색</button>
								</div>
								
							</form>
							
							<div style="width: 100%; height: 100px;"></div>
							
						</div>
						
						
						
						<form name="readfrm">
							
							<input type="hidden" name="nowPage" value="">
							<input type="hidden" name="num" value="">
							<input type="hidden" name="keyField" value="<%=keyField%>">
							<input type="hidden" name="keyWord" value="<%=keyWord%>">
							
						</form>
						
						<form name="listfrm" method="post">
							
							<input type="hidden" name="reload" value="true">
							<input type="hidden" name="nowPage" value="1">
							
						</form>
						<script>
							
							window.onscroll = function() {
							    var navbar = document.getElementById("grandpadiv");
							    if (document.body.scrollTop > 20 || document.documentElement.scrollTop > 20) {
							        navbar.style.top = "0";
							    }
							}
							
						</script>
				                	<div><!-- 리스트 -->
				                		
				                	</div>
				                	
				                <!-- // 컨텐츠 입력 end -->
				                	
				                </div>
				            </div>
				        </div>
				    </div>
				    <form method="post" name="move_wrong_listFrm">
				    	<% for(int i = 0; i < vlist.size(); i++) { 
   							 WrongBean bean = vlist.get(i);
				    	%>
				    		<input type="hidden" name ="title<%=i%>" value="<%=bean.getWrong_test_title()%>">
				    		<input type="hidden" name ="test_year<%=i%>" value="<%=bean.getWrong_test_year()%>">
				    		<input type="hidden" name ="test_cat<%=i%>" value="<%=bean.getWrong_test_sec()%>">
				    		<input type="hidden" name ="testIndex" value="<%=i%>">
				    	<%} %>
				    	<input type="hidden" name ="url" value="<%=url%>">
				    </form>
				    <form id="testDataFrm">
				    	<input type="hidden" name="url" value="<%=url%>">
				    </form>
    <%@ include file="../inc/footer.jsp" %>
</body>
</html>