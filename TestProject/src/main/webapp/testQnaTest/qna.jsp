<%-- QnA 게시판 --%>

<%@page import="project.Qna_commentMgr"%>
<%@page import="project.QnaBean"%>
<%@page import="java.util.Vector"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="qnaMgr" class="project.QnaMgr"/>
<jsp:useBean id="commentMgr" class="project.Qna_commentMgr"/>

<%
	String sess = (String) session.getAttribute("idKey");
	String url = request.getRequestURI();
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
	
	totalRecord = qnaMgr.getTotalCount(keyField, keyWord);
	
	if ( request.getParameter("nowPage") != null ) {
		nowPage = Integer.parseInt(request.getParameter("nowPage"));
	}
	
	int start = ( nowPage * numPerPage ) - numPerPage;
	int cnt = numPerPage;
	
	
	totalPage = (int) Math.ceil( (double) totalRecord / numPerPage );
	totalBlock = (int) Math.ceil( (double) totalPage / pagePerBlock );
	nowBlock = (int) Math.ceil( (double) nowPage / pagePerBlock );
	
	
%>

<html>

	<head>
	
		<%@ include file="../inc/head.jsp" %>
		<title>QnA</title>
		<link href="css/qna.css" rel="stylesheet">
		
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
				document.searchfrm.action = "qna.jsp";
				document.searchfrm.submit();
			}
		
			function read(num) {
				document.readfrm.num.value = num;
				document.readfrm.action = "qnaInPage.jsp";
				document.readfrm.submit();
			}
			
			function reload() {
				document.listfrm.action = "qna.jsp";
				document.listfrm.submit();
			}
			
			function pageing(page) {
				document.readfrm.nowPage.value = page;
				document.readfrm.action = "qna.jsp";
				document.readfrm.submit();
			}
			
			function blockprev(block) {
				if ( <%=nowBlock%> === 1 ) {
					alert("하하 처음이지롱");
					return;
				}
				document.readfrm.nowPage.value = <%=pagePerBlock%> * ( block - 1 ) + 1;
				document.readfrm.action = "qna.jsp";
				document.readfrm.submit();
			}
			
			function blocknext(block) {
				if ( <%=nowBlock%> === <%=totalBlock%> ) {
					alert("하하 끝이지롱");
					return;
				}
				document.readfrm.nowPage.value = <%=pagePerBlock%> * ( block - 1 ) + 1;
				document.readfrm.action = "qna.jsp";
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
			
		</script>
		
	</head>
	
	<body>
		
		<div id="grandpadiv" style="position:fixed; width: 100%;">
		
			<div id="wrapper">
				
				<%@ include file="../inc/menu.jsp" %>
					
				<div id="content-wrapper" class="d-flex flex-column">
		            <!-- Main Content -->
		            <div id="content" class="bg-white">
		                <!-- // 최상단 Top 영역 -->
						<%@ include file="../inc/top.jsp" %>
						<!-- Begin Page Content -->
		                <div class="container-fluid">
		                	<!-- // 컨텐츠 입력 start  -->
		   	  			</div>
		   	  
		            </div>
		            
		        </div>
				
			</div>
		
		</div>
		
		<%@ include file="../inc/footer.jsp" %>
		
		<h1 style="position:absolute; left: 250px; top:100px;">QnA 게시판</h1>
		
		<!-- 시작 -->
		<div class="parantdiv">
			
			<table>
				
				<tr>
					
					<td align="center">
						
						<table style="border-collapse: collapse">
							
							<tr class="subjecttitle" align="center">
								
								<td width="100">번 호</td>
								<td width="600">제 목</td>
								<td width="100">작 성 자</td>
								<td width="150">등 록 일</td>
								
							</tr>
							
							<%
								Vector<QnaBean> vlist = qnaMgr.getQnaList(keyField, keyWord, start, cnt);
								int listSize = vlist.size();
								
								if ( vlist.isEmpty() ) {
									
								} else {
							
								
								for ( int i = 0; i < numPerPage; i++ ) {
									if ( i == listSize ) break;
									QnaBean bean = vlist.get(i);
									int num = bean.getQna_num();
									String title = bean.getQna_title();
									String date = bean.getQna_date();
									String userId = bean.getQna_user_id();
									int commentCount = commentMgr.getCount(num);
							%>
								
								<tr class="subjecttitle" align="center">
									
									<td><%=totalRecord - start - i%></td>
									<%
										if ( commentCount == 0 ) {
									%>
									<td><a href="javascript:read('<%=num%>')"><%=title%></a></td>
									<%
										} else {
									%>									
									<td><a href="javascript:read('<%=num%>')"><%=title%> <font color="red">(<%=commentCount%>)</font></a></td>
									<%
										}
									%>
									<td><%=userId%></td>
									<td><%=date%></td>
									
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
						
					</td>
					
				</tr>
				
			</table>
			
			<form name="searchfrm">
			
				<div class="bottomcpn">
				
					<select name="keyField">
						<option value="QNA_TITLE">제목</option>
						<option value="QNA_USER_ID">작성자</option>
					</select>
					
					<input name="keyWord" style="width: 30%;">
					<button class="searchbtn" type="button" onclick="check()">검색</button>
					<button class="reloadbtn" type="button" onclick="reload()">새로고침</button>
					<button class="newpostbtn" type="button" onclick="upload()">글 쓰기</button>
					
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
		
		<div style="position: fixed; width: 1500px; height: 70px; background: white; left: 230px;"></div>
		
		<script>
			
			window.onscroll = function() {
			    var navbar = document.getElementById("grandpadiv");
			    if (document.body.scrollTop > 20 || document.documentElement.scrollTop > 20) {
			        navbar.style.top = "0";
			    }
			}
			
		</script>
		
	</body>
	
</html>