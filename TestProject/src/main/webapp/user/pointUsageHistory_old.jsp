<%-- 포인트 이용 내역 --%>

<%-- 오늘의 교훈 2024-04-03 좀 보인다고 해서 예제를 무시하지 말자 --%>

<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="project.BuyListBean"%>
<%@page import="project.UserBean"%>
<%@page import="java.util.Vector"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="userMgr" class="project.UserMgr"/>
<jsp:useBean id="buyListMgr" class="project.BuyListMgr"/>
<jsp:useBean id="paypostMgr" class="project.PaypostMgr"/>
<%
	String sess = (String) session.getAttribute("idKey");
	String sessManager = (String) session.getAttribute("adminKey");
	int totalpoints = 0;
	int refundpoints = 0;
	String totalpoints_str = "";
	String refundpoints_str = "";
	String pay = "";
	String date = "";
	String title = "";
	String username = "", userphone = "", useremail = ""; 
	
	int num = 0;
	int numPerPage = 10;									// 한번에 표시할 페이지 수
	int nowPage = 1;										// 현재 페이지
	int nowBlock = 1;
	int pagePerBlock = 10;
	int firstgguck = 0;
	
	int pageBlockEnd = pagePerBlock + 10;
	int totalPage;
	int totalBlock = 0;
	int cnt = numPerPage;
	int blockPage = 1;
	int blockPage1 = 1;
	
	Vector<UserBean> uservlist = userMgr.showUserInfo(sess);
	for ( int i = 0; i < uservlist.size(); i++) {
		UserBean bean = uservlist.get(i);
		username = bean.getUser_name();
		userphone = bean.getUser_phone();
		useremail = bean.getUser_email();
	}
	
	Date today = new Date();
	Calendar cal = Calendar.getInstance();
	cal.setTime(today);
	cal.add(Calendar.MONTH, -1);
	Date oneMonthAgo = cal.getTime();
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	String todaydate = sdf.format(today);
	String oneMonthAgodate = sdf.format(oneMonthAgo);

	
	String sd = request.getParameter("dateStart");
	String ed = request.getParameter("dateEnd");

	if ( sd != null && ed != null ) {
		oneMonthAgodate = sd;
		todaydate = ed;
	}
	
	if ( request.getParameter("blockPage") != null ) {
		blockPage = Integer.parseInt(request.getParameter("blockPage"));
		blockPage1 = Integer.parseInt(request.getParameter("blockPage"));
	}
	
	
	
	System.out.println("\n -- blockPage -- \n" + blockPage + "\n -- blockPage -- \n");
	
	if ( request.getParameter("nowBlock") != null ) {
		nowBlock = Integer.parseInt(request.getParameter("nowBlock"));
	}
	System.out.println("\n -- nowPage -- \n" + nowPage + "\n -- nowPage -- \n");
	if ( request.getParameter("nowPage") != null ) {
		nowPage = Integer.parseInt(request.getParameter("nowPage"));
	}
	System.out.println("\n -- nowPage -- \n" + nowPage + "\n -- nowPage -- \n");
	int start = ( nowPage * numPerPage ) - numPerPage;		// LIMIT용
	
	int totalCount = buyListMgr.getTotalCount(sess, oneMonthAgodate, todaydate);	// 총 결과 갯수
	System.out.println("\n -- totalCount -- \n" + totalCount + "\n -- totalCount -- \n");
	int pageEnd = totalCount;
	totalCount = totalCount - ((nowPage * numPerPage) - numPerPage);	// 몇 개 보기에 따른 페이지에 보이는 결과 갯수
	
	totalPage = (int)Math.ceil((double)pageEnd / numPerPage);		// 전체 페이지 갯수
	System.out.println("\n -- totalPage -- \n" + totalPage + "\n -- totalPage -- \n");
	
	int lastblock = totalPage % 10;
	if ( lastblock == 0 ) {
		lastblock = 10;
	}
	System.out.println("\n -- lastblock -- \n" + lastblock + "\n -- lastblock -- \n");
	
	totalBlock = (int)Math.ceil((double)totalPage / numPerPage);  // 전체 블럭 갯수
	
	
%>
<html>
	<head>
	
		<%@ include file="navi/head.jsp" %>
		<script>
		
			history.scrollRestoration = "auto";
			
			<%
				if ( sessManager != null ) {
			%>
					alert("튕김");
					location.href = "myInfo.jsp";
			<%
				}
			%>
			
			<%
				if ( sess == null ) {
			%>
					alert("로그인이 필요합니다.");
					location.href = "login.jsp";
			<%
				} else {
					Vector<UserBean> vlist = userMgr.showUserInfo(sess);
					UserBean bean = vlist.get(0);
					totalpoints = bean.getUser_point();
					
					int points = totalpoints / 5000;
					refundpoints = points * 5000;
					
					refundpoints_str = userMgr.addComma(refundpoints);
					totalpoints_str = userMgr.addComma(totalpoints);
					
					
				}
			%>
			
		 	
			function pageing(page) {
				document.pagefrm.nowPage.value = page;
				document.pagefrm.submit();
			}
			
		</script>
		
		<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
		
		<style>
			A:link {text-decoration:none;color:#696969}
			A:hover{text-decoration:yes;color:#66CCFF}
			A:visited {text-decoration:none;color:#330066}
		</style>
		
		<meta charset="utf-8">
		<link href="css/pointUsageHistory.css" rel="stylesheet">
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
		<link rel="preconnect" href="https://fonts.googleapis.com">
		<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
		<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
		
		<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
		<title> 포인트 히스토리 </title>
	</head>
	<body>
		
		
		<div id="grandpadiv" style="position:fixed; width: 100%;">
		
			<div id="wrapper">
				
				<%@ include file="navi/menu.jsp" %>
					
				<div id="content-wrapper" class="d-flex flex-column">
		            <!-- Main Content -->
		            <div id="content" class="bg-white">
		                <!-- // 최상단 Top 영역 -->
						<%@ include file="navi/top.jsp" %>
						<!-- Begin Page Content -->
		                <div class="container-fluid">
		                	<!-- // 컨텐츠 입력 start  -->
		                	
		   	  			</div>
		   	  
		            </div>
		            
		        </div>
				
			</div>
		
		</div>
		
		<%@ include file="navi/footer.jsp" %>
		
		<h1 style="position:absolute; left: 250px; top:100px;">포인트 히스토리</h1>
		
		<div class="pointbutton">
			<div class="point">
				<div class="wrap">
					<input class="topbartext1" type="text" value="총 포인트" disabled/>
					<input class="topbartext1 totalpoints" type="text" value="<%=totalpoints_str%>P" disabled/>
				</div>
				<button class="chargebtn" data-bs-toggle="modal" data-bs-target="#pointcharge">충전하기</button>
			</div>
			<div class="exchange">
				<div class="wrap">
					<input class="topbartext1" type="text" value="환불 가능 포인트" disabled/>
					<input class="topbartext1 totalpoints" type="text" value="<%=refundpoints_str%>P" disabled/>
				</div>
				<button class="exchangebtn" data-bs-toggle="modal" data-bs-target="#pointrefund">환불하기</button>
			</div>
		</div>
		
		<div class="usagehistory" align="center">
			<table>
				<tr style="height: 50px;">
					<td width="800">
						
					</td>
					<td align="right">
						<form name="npFrm" method="post">
							
							<!-- Button trigger modal -->
							<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#staticBackdrop">
							  날짜 선택
							</button>
							
						</form>
					</td>
				</tr>
			</table>
			<table>
				<tr>
					<td align="center">
						<table style="border-collapse: collapse">
							<tr class="subjecttitle" align="center">
								<td width="100">번 호</td>
								<td width="550">이 용  내 역</td>
								<td width="100">포 인 트</td>
								<td width="100">분 류</td>
								<td width="100">날 짜</td>
							</tr>
							<%
								Vector<BuyListBean> buyListvlist = buyListMgr.showBuyList(sess, oneMonthAgodate, todaydate, start, cnt);
								// System.out.println("\n--start--\n" + start + "\n--start--\n");
								// System.out.println("\n--cnt--\n" + cnt + "\n--cnt--\n");
								int listSize = buyListvlist.size();	
								
								for ( int i = 0; i < buyListvlist.size(); i++) {
									BuyListBean bean = buyListvlist.get(i);
									pay = Integer.toString(bean.getBuylist_pay());
									date = bean.getBuylist_date();
									num = bean.getBuylist_paypost_num();
									title = paypostMgr.showPaypostTitle(num);
									
								if ( buyListvlist.isEmpty() ) {
									out.print("등록된 게시물이 없습니다");
								} else {
									// System.out.println(title);
									// System.out.println(num);
									if ( i == listSize ) break;
									// System.out.println(listSize);
									// System.out.println("\n---totalCount---\n" + totalCount + "\n---totalCount---\n");
							%>
							<tr class="subjecttitle" align="center">
								<td><%=totalCount%></td>
								<td><%=title%></td>
								<td class="celdetail"><%=pay%></td>
								<td>차감</td>
								<td class="celdetail"><%=date%></td>
							</tr>
							<%
							totalCount--;
									} // --else
								} // -- for
							%>
							<tr align="center">
							<%
							if ( listSize == 0 ) {
								%>
									<td colspan="5">정보가 없습니다.</td>
								<%
									} else {
							%>
								<td colspan="5" style="height: 70px;">
									<%
									
									System.out.println("\n nowBlock \n" + nowBlock + "\n nowBlock \n");
									System.out.println("\n pagePerBlock \n" + pagePerBlock + "\n pagePerBlock \n");
									System.out.println("\n blockPage \n" + blockPage + "\n blockPage \n");
									System.out.println("\n blockPage1 \n" + blockPage1 + "\n blockPage1 \n");
									blockPage = ( nowBlock - 1 ) * pagePerBlock + 1;
									firstgguck = blockPage;
									blockPage1 = blockPage + 10;
									if ( nowBlock == totalBlock ) blockPage1 = blockPage + lastblock;
									System.out.println("\n nowBlock \n" + nowBlock + "\n nowBlock \n");
									System.out.println("\n pagePerBlock \n" + pagePerBlock + "\n pagePerBlock \n");
									System.out.println("\n blockPage \n" + blockPage + "\n blockPage \n");
									System.out.println("\n blockPage1 \n" + blockPage1 + "\n blockPage1 \n");
									for ( int i = blockPage; i < blockPage1; i++) {
										if ( i == firstgguck ) {
									%>
										<a href="javascript:blockprev('<%=nowBlock - 1%>')">&#60;</a>
									<%
										}
									%>
										<a href="javascript:pageing('<%=blockPage%>')">
									<%
									
										if ( nowPage == i ) {
									%>
											<font color="blue">
									<%
										}
									%>
									<%=blockPage%>
									<%
										// System.out.println("\n -- blockPage -- \n" + blockPage + "\n -- blockPage -- \n");
										if ( nowPage == i + 1 ) {
									%>
											</font>
									<%
										}
									%>
										</a>
								 	<%
								 	if ( i == blockPage1 - 1 ) {
							 		%>
							 			<a href="javascript:blocknext('<%=nowBlock + 1%>')">&#62;</a>
							 		<%
								 	}
								 	blockPage++;
									}
									}
									%>
										
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</div>
		
		<!-- Modal -->
		<form name="modalfrm">
			<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
			  <div class="modal-dialog modal-dialog-centered">
			    <div class="modal-content">
			      <div class="modal-header">
			        <h1 class="modal-title fs-5" id="staticBackdropLabel">날짜 선택</h1>
			        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			      </div>
			      <div class="modal-body" align="center">
			        <input type="date" name="dateStart" id="dateInputStart" value="<%=oneMonthAgodate%>">
			        <input type="date" name="dateEnd" id="dateInputEnd">
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-primary" onclick="test()">적용</button>
			        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
			      </div>
			    </div>
			  </div>
			</div>
		</form>
		
		<!-- 포인트 충전 모달 -->
		<form name="chargefrm">
		<div class="modal fade" id="pointcharge" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
			  <div class="modal-dialog modal-dialog-centered">
			    <div class="modal-content">
			      <div class="modal-header">
			        <h1 class="modal-title fs-5" id="staticBackdropLabel" style="margin-left: auto;">포인트 충전</h1>
			        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			      </div>
			      <div class="modal-body" align="center" style="background-color: #bbbbbb; height: 500px; display: flex; justify-content: center; align-items: center;">
			        <div style="width:80%; height:80%; align-items: center; justify-content: center; display: flex; flex-direction: column;">
			        	<h6>결제 금액</h6>
				        <select style="width: 70%; height: 10%; margin: 20px;" name="totalprice">
				        	<option value="30">3,000</option>
				        	<option value="50">5,000</option>
				        	<option value="10">10,000</option>
				        	<option value="30">30,000</option>
				        	<option value="50">50,000</option>
				        	<option value="10">100,000</option>
				        </select>
				        <h6>입금자명</h6>
				        <input style="width: 70%; height: 10%; margin: 20px;" name="username" value="<%=username%>" readonly>
				        <h6>전화번호</h6>
				        <input style="width: 70%; height: 10%; margin: 20px;" name="userphone" value="<%=userphone%>" readonly>
				        <h6>이메일</h6>
				        <input style="width: 70%; height: 10%; margin: 20px;" name="useremail" value="<%=useremail%>" readonly>
			        </div>
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-outline-success" style="justify-content: center;" onclick="pointcharge()">충전</button>
			        <button type="button" class="btn btn-outline-dark" data-bs-dismiss="modal">닫기</button>
			      </div>
			    </div>
			  </div>
			</div>
		</form>
		
		
		<!-- 포인트 환전 모달 -->
		<form name="refundfrm">
		<div class="modal fade" id="pointrefund" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
			  <div class="modal-dialog modal-dialog-centered">
			    <div class="modal-content">
			      <div class="modal-header">
			        <h1 class="modal-title fs-5" id="staticBackdropLabel" style="margin-left: auto;">포인트 환불</h1>
			        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			      </div>
			      <div class="modal-body" align="center" style="background-color: #bbbbbb; height: 500px; display: flex; justify-content: center; align-items: center;">
			        <div style="width:80%; height:80%; align-items: center; justify-content: center; display: flex; flex-direction: column;">
			        	<h6>환불 금액</h6>
				        <select style="width: 70%; height: 10%; margin: 20px;" name="totalprice" id="refundpoints">
				        	<option value="5000">5,000</option>
				        	<option value="10000">10,000</option>
				        	<option value="15000">15,000</option>
				        	<option value="30000">30,000</option>
				        	<option value="50000">50,000</option>
				        	<option value="100000">100,000</option>
				        </select>
				        <h6>전화번호</h6>
				        <input style="width: 70%; height: 10%; margin: 20px;" name="userphone" value="<%=userphone%>" readonly>
				        <h6>이메일</h6>
				        <input style="width: 70%; height: 10%; margin: 20px;" name="useremail" value="<%=useremail%>" readonly>
			        </div>
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-outline-success" style="justify-content: center;" onclick="pointrefund()">환불</button>
			        <button type="button" class="btn btn-outline-dark" data-bs-dismiss="modal">닫기</button>
			      </div>
			    </div>
			  </div>
			</div>
		</form>
		
		<div style="position: fixed; width: 1500px; height: 70px; background: white; left: 230px;"></div>
		
		<script>
			
			var today = new Date();
	
			var year = today.getFullYear();
			var month = ('0' + (today.getMonth() + 1)).slice(-2);
			var day = ('0' + today.getDate()).slice(-2);
	
			var dateString = year + '-' + month  + '-' + day;
			
		    document.getElementById("dateInputEnd").value = "<%=todaydate%>";
		    document.getElementById("dateInputStart").value = "<%=oneMonthAgodate%>";
		    document.getElementById("dateInputStart").setAttribute("max", dateString);
		    document.getElementById("dateInputEnd").setAttribute("max", dateString);
		    
		    function test() {
		    	document.modalfrm.action = "pointUsageHistory_old.jsp";
		    	document.modalfrm.submit();
		    }
		    
		    function pointcharge() {
		    	document.chargefrm.action = "proc/payProc.jsp";
		    	document.chargefrm.submit();
		    }
		    
		    function pointrefund() {
		    	if ( document.getElementById("refundpoints").value > <%=refundpoints%> ) {
		    		alert("환불 가능한 액수를 초과하였습니다");
		    		return;
		    	}
		    	var result = confirm("환불 하시겠습니까?");
		    	
		    	if ( result === true ) {
		    		document.refundfrm.action = "proc/refundProc.jsp";
		    		document.refundfrm.submit();
		    	} else {
		    		alert("환불 취소");
		    	}
		    }
		    
		    function blocknext(block) {
				if ( <%=nowBlock%> === <%=totalBlock%> ) return;
				document.blockfrm.nowPage.value = <%=blockPage1%>;
				document.blockfrm.pagePerBlock.value = (10 * block) - 10;
				document.blockfrm.submit();
			}
			
			function blockprev(block) {
				if ( <%=nowBlock%> === 1 ) return;
				document.blockfrm1.nowPage.value = <%=firstgguck - 1%>;
				document.blockfrm1.pagePerBlock.value = (10 * block) - 10;
				document.blockfrm1.submit();
			}
			
		    
		</script>
		
		<form name="pagefrm">
			<input type="hidden" name="nowPage" value="<%=nowPage%>">
			<input type="hidden" name="dateStart" value="<%=oneMonthAgodate%>">
			<input type="hidden" name="dateEnd" value="<%=todaydate%>">
			<input type="hidden" name="nowBlock" value="<%=nowBlock%>">
			<input type="hidden" name="pagePerBlock" value="<%=pagePerBlock%>">
		</form>
		
		<form name="blockfrm">
			<input type="hidden" name="nowBlock" value="<%=nowBlock + 1%>">
			<input type="hidden" name="nowPage" value="<%=nowPage%>">
			<input type="hidden" name="blockPage" value="<%=blockPage%>">
			<input type="hidden" name="pagePerBlock" value="">
			<input type="hidden" name="dateStart" value="<%=oneMonthAgodate%>">
			<input type="hidden" name="dateEnd" value="<%=todaydate%>">
		</form>
		
		<form name="blockfrm1">
			<input type="hidden" name="nowBlock" value="<%=nowBlock - 1%>">
			<input type="hidden" name="nowPage" value="<%=firstgguck - 1%>">
			<input type="hidden" name="blockPage" value="<%=blockPage%>">
			<input type="hidden" name="pagePerBlock" value="">
			<input type="hidden" name="dateStart" value="<%=oneMonthAgodate%>">
			<input type="hidden" name="dateEnd" value="<%=todaydate%>">
		</form>
		
		<script>
			
			window.onscroll = function() {
			    var navbar = document.getElementById("test");
			    if (document.body.scrollTop > 20 || document.documentElement.scrollTop > 20) {
			        navbar.style.top = "0"; 										// 스크롤이 아래로 이동했을 때 네비게이션 바를 화면 상단에 고정
			    }
			}
			
		</script>
		
	</body>
</html>








