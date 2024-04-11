<%-- 관리자가 시험 일정을 수정하는 페이지 --%>

<%-- 
	버튼을 두 개 만들어서 QnA 수정 화면과 시험일정 수정 화면을 각각 보이게 하기 (like 시험일정 & 응시자격)
	시험일정 수정은 textarea를 사용할 것 (줄바꿈을 자바 문자열로 받았을 때 \n을 받기 위함)
	버튼으로 뒤덮어서 누르면 팝업창이 뜨게 할까? 어카지
	그래 버튼을 누르면 팝업창이 나오고 한 줄 한 줄 수정할 수 있도록 해보자!
--%>

<%@page import="project.Schedule_columnBean"%>
<%@page import="project.ScheduleBean"%>
<%@page import="java.util.Vector"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="scheduleMgr" class="project.ScheduleMgr"/>
<jsp:useBean id="columnMgr" class="project.Schedule_columnMgr"/>
<%
	String sessManager = (String) session.getAttribute("adminKey");
	Vector<ScheduleBean> vlist = scheduleMgr.getTitleName();
	String titleColor[] = new String[]{"#FC8E8E", "#8793FF", "#FF6363", "#F981FC"};
	String width[] = new String[]{"102", "170.5", "138.5", "170.5", "170.5", "139", "154.5"};
%>
<html>
	<head>
	
		<%@ include file="navi/head.jsp" %>
		<link href="css/scheduleEdit.css" rel="stylesheet">
		
		<script>
			
			<%
				if ( sessManager == null ) {
			%>
					alert("관리자 로그인이 필요합니다");
					location.href = "login.jsp";
			<%
				}
			%>
			
		</script>
		
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
		
		<div class="parantdiv">
				
			<h1>시험 일정 수정</h1>
			
			<div class="scheduleeditdiv">
				
				<%
					int count = 1;
					for ( int i = 0; i < vlist.size(); i++ ) {
						ScheduleBean bean = vlist.get(i);
				%>
					<div class="titlewrap">
						<button class="titlename" style="color: <%=titleColor[i]%>; border: none;" onclick="titlenameEdit('<%=i+1%>')"><%=bean.getSchedule_name()%></button>
						<div class="title" style="background-color: <%=titleColor[i]%>;">
							<div class="title_name">회차</div>
							<div class="title_name">필기 원서점수</div>
							<div class="title_name">필기 시험</div>
							<div class="title_name">필기 합격발표</div>
						<%
							if ( count == 1 || count == 2 ) {
						%>
								<div class="title_name">실기 원서점수</div>
								<div class="title_name">실기 시험</div>
						<%
							} else {
						%>
								<div class="title_name">면접 원서점수</div>
								<div class="title_name">면접 시험</div>
						<%
							}
						%>
							<div class="title_name">합격자 발표</div>
						</div>
						<div>
							<%
								Vector<Schedule_columnBean> vlist1 = columnMgr.getExamSchedule(count);
								for ( int j = 0; j < vlist1.size(); j++ ) {
									Schedule_columnBean bean1 = vlist1.get(j);
							%>		
							<button class="itemarea" onclick="editContent('<%=bean1.getSchedule_column_num()%>', '<%=count%>')">
								<div style="width: <%=width[0]%>"><%=bean1.getSchedule_column_attempt()%></div>
								<div style="width: <%=width[1]%>"><%=bean1.getSchedule_column_written_registration()%></div>
								<div style="width: <%=width[2]%>"><%=bean1.getSchedule_column_written_test()%></div>
								<div style="width: <%=width[3]%>"><%=bean1.getSchedule_column_written_pass()%></div>
								<%
									if ( count == 1 || count == 2) {
								%>
									<div style="width: <%=width[4]%>"><%=bean1.getSchedule_column_practical_registration()%></div>
									<div style="width: <%=width[5]%>"><%=bean1.getSchedule_column_practical_test()%></div>
								<%
									} else if ( count == 3 || count == 4 ) {
										String brplus = bean1.getSchedule_column_interview_registration().replace("\n", "<br>");
										String brplus1 = bean1.getSchedule_column_interview_test().replace("\n", "<br>");
								%>
									<div style="width: <%=width[4]%>"><%=brplus%></div>
									<div style="width: <%=width[5]%>"><%=brplus1%></div>
								<%
									}
								%>
								<div style="width: <%=width[6]%>"><%=bean1.getSchedule_column_pass()%></div>
							</button>
							<%
								}
							%>
						</div> 
					</div>
				<%
					count++;
					}
				%>
				
			</div>
			
			<form method="post" name="titlefrm">
				<input type="hidden" name="titlenum" value="">
			</form>
			
			<form method="post" name="contentfrm">
				<input type="hidden" name="num" value="">
				<input type="hidden" name="fknum" value="">				
			</form>
			
		</div>
		
		<div style="position: fixed; width: 1500px; height: 70px; background: white; left: 230px;"></div>
		
		<script src="js/scheduleEdit.js"></script>
	</body>
</html>