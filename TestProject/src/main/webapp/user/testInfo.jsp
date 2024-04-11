<%-- 시험 일정 / 응시 자격 페이지 --%>

<%@page import="project.Schedule_columnBean"%>
<%@page import="project.ScheduleBean"%>
<%@page import="java.util.Vector"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="scheduleMgr" class="project.ScheduleMgr"/>
<jsp:useBean id="columnMgr" class="project.Schedule_columnMgr"/>
<%
	Vector<ScheduleBean> vlist = scheduleMgr.getTitleName();
	String titleColor[] = new String[]{"#FC8E8E", "#8793FF", "#FF6363", "#F981FC"};
	String width[] = new String[]{"102", "170.5", "138.5", "170.5", "170.5", "139", "154.5"};
%>

<html>
	<head>
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
		<link href="testInfo.css" rel="stylesheet">
		
	</head>
	<body>
		
		<div class="parentdiv">
			<div class="buttondiv">
				<button class="schedulebtn">시험 일정</button>
				<button class="qualificationbtn">응시 자격</button>			
			</div>
			
			<div class="schedulediv">
			
				<%
					int count = 1;
					for ( int i = 0; i < vlist.size(); i++ ) {
						ScheduleBean bean = vlist.get(i);
				%>
					<div class="titlewrap">
						<h5 style="color: <%=titleColor[i]%>;"><%=bean.getSchedule_name()%></h5>
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
							<div class="itemarea">
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
							</div>
							<%
								}
							%>
						</div> 
					</div>
				<%
					count++;
					}
				%>
				
				<div class="titlewrap">
					<h5 style="color: #3D9C1B;">상시시험 종목</h5>
					<div class="title" style="background-color: #3D9C1B;">
						<div class="title_name1" style="margin-left: 34px;">회차</div>
						<div class="title_name1">종목명</div>
						<div class="title_name1" style="margin-right: 55px;">비고</div>
					</div>
					<div>
						<div class="itemarea">
							
						</div>
					</div>
				</div>
			</div>
			
			<div class="qualificationdiv">
				<div class="accordion" id="accordionPanelsStayOpenExample">
				  <div class="accordion-item accordionone">
				    <h2 class="accordion-header">
				      <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseOne" aria-expanded="true" aria-controls="panelsStayOpen-collapseOne">
				        기능사 응시자격
				      </button>
				    </h2>
				    <div id="panelsStayOpen-collapseOne" class="accordion-collapse collapse">
				      <div class="accordion-body">
				        제한 없음
				      </div>
				    </div>
				  </div>
				  <div class="accordion-item accordiontwo">
				    <h2 class="accordion-header">
				      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseTwo" aria-expanded="false" aria-controls="panelsStayOpen-collapseTwo">
				        산업 기사 응시자격
				      </button>
				    </h2>
				    <div id="panelsStayOpen-collapseTwo" class="accordion-collapse collapse">
				      <div class="accordion-body">
				        1. 기능사 등급 이상의 자격을 취득한 후 응시하려는 종목이 속하는 동일 및 유사 직무분야에 1년 이상 실무에 종사한 사람<br><br>
						2. 응시하려는 종목이 속하는 동일 및 유사 직무분야의 다른 종목의 산업기사 등급 이상의 자격을 취득한 사람<br><br>
						3. 관련학과의 2년제 또는 3년제 전문대학졸업자 등 또는 그 졸업예정자<br><br>
						4. 관련학과의 대학졸업자 등 또는 그 졸업예정자<br><br>
						5. 동일 및 유사 직무분야의 산업기사 수준 기술훈련과정 이수자 또는 그 이수예정자<br><br>
						6. 응시하려는 종목이 속하는 동일 및 유사 직무분야에서 2년 이상 실무에 종사한 사람<br><br>
						7. 고용노동부령으로 정하는 기능경기대회 입상자<br><br>
						8. 외국에서 동일한 종목에 해당하는 자격을 취득한 사람
				      </div>
				    </div>
				  </div>
				  <div class="accordion-item accordionthree">
				    <h2 class="accordion-header">
				      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseThree" aria-expanded="false" aria-controls="panelsStayOpen-collapseThree">
				        기사 응시자격
				      </button>
				    </h2>
				    <div id="panelsStayOpen-collapseThree" class="accordion-collapse collapse">
				      <div class="accordion-body">
				        1. 산업기사 등급 이상의 자격을 취득한 후 응시하려는 종목이 속하는 동일 및 유사 직무분야에서 1년 이상 실무에 종사한 사람<br><br>
						2. 기능사 자격을 취득한 후 응시하려는 종목이 속하는 동일 및 유사 직무분야에서 3년 이상 실무에 종사한 사람<br><br>
						3. 응시하려는 종목이 속하는 동일 및 유사 직무분야의 다른 종목의 기사 등급 이상의 자격을 취득한 사람<br><br>
						4. 관련학과의 대학졸업자등 또는 그 졸업예정자<br><br>
						5. 3년제 전문대학 관련학과 졸업자등으로서 졸업 후 응시하려는 종목이 속하는 동일 및 유사 직무분야에서 1년 이상 실무에 종사한 사람<br><br>
						6. 2년제 전문대학 관련학과 졸업자등으로서 졸업 후 응시하려는 종목이 속하는 동일 유사 직무분야에서 2년 이상 실무에 종사한 사람<br><br>
						7. 동일 및 유사 직무분야의 기사 수준 기술훈련과정 이수자 또는 그 이수예정자<br><br>
						8. 동일 및 유사 직무분야의 산업기사 수준 기술훈련과정 이수자로서 이수 후 응시하려는 종목이 속하는 동일 및 유사 직무분야에서 2년 이상 실무에 종사한 사람<br><br>
						9. 응시하려는 종목이 속하는 동일 및 유사 직무분야에서 4년 이상 실무에 종사한 사람<br><br>
						10. 외국에서 동일한 종목에 해당하는 자격을 취득한 사람
				      </div>
				    </div>
				  </div>
				  <div class="accordion-item accordionfour">
				    <h2 class="accordion-header">
				      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseFour" aria-expanded="false" aria-controls="panelsStayOpen-collapseThree">
				        기능장 응시자격
				      </button>
				    </h2>
				    <div id="panelsStayOpen-collapseFour" class="accordion-collapse collapse">
				      <div class="accordion-body">
				        1. 응시하려는 종목이 속하는 동일 및 유사 직무분야의 산업기사 또는 기능사 자격을 취득한 후 「근로자직업능력 개발법」에 따라 설립된 기능대학의 기능장과정을 마친 이수자 또는 그 이수예정자<br><br>
						2. 산업기사 등급 이상의 자격을 취득한 후 응시하려는 종목이 속하는 동일 및 유사 직무분야에서 5년 이상 실무에 종사한 사람<br><br>
						3. 기능사 자격을 취득한 후 응시하려는 종목이 속하는 동일 및 유사 직무분야에서 7년 이상 실무에 종사한 사람<br><br>
						4. 응시하려는 종목이 속하는 동일 및 유사 직무분야에서 9년 이상 실무에 종사한 사람<br><br>
						5. 응시하려는 종목이 속하는 동일 및 유사직무분야의 다른 종목의 기능장 등급의 자격을 취득한 사람<br><br>
						6. 외국에서 동일한 종목에 해당하는 자격을 취득한 사람
				      </div>
				    </div>
				  </div>
				  <div class="accordion-item accordionfive">
				    <h2 class="accordion-header">
				      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseFive" aria-expanded="false" aria-controls="panelsStayOpen-collapseThree">
				        기술사 응시자격
				      </button>
				    </h2>
				    <div id="panelsStayOpen-collapseFive" class="accordion-collapse collapse">
				      <div class="accordion-body">
				        1. 기사 자격을 취득한 후 응시하려는 종목이 속하는 직무분야(고용노동부령으로 정하는 유사 직무분야를 포함한다. 이하 “동일 및 유사 직무분야”라 한다)에서 4년 이상 실무에 종사한 사람<br><br>
						2. 산업기사 자격을 취득한 후 응시하려는 종목이 속하는 동일 및 유사 직무분야에서 5년 이상 실무에 종사한 사람<br><br>
						3. 기능사 자격을 취득한 후 응시하려는 종목이 속하는 동일 및 유사 직무분야에서 7년 이상 실무에 종사한 사람<br><br>
						4. 응시하려는 종목과 관련된 학과로서 고용노동부장관이 정하는 학과(이하 “관련학과”라 한다)의 대학졸업자등으로서 졸업 후 응시하려는 종목이 속하는 동일 및 유사 직무분야에서 6년 이상 실무에 종사한 사람<br><br>
						5. 응시하려는 종목이 속하는 동일 및 유사직무분야의 다른 종목의 기술사 등급의 자격을 취득한 사람<br><br>
						6. 3년제 전문대학 관련학과 졸업자등으로서 졸업 후 응시하려는 종목이 속하는 동일 및 유사 직무분야에서 7년 이상 실무에 종사한 사람<br><br>
						7. 2년제 전문대학 관련학과 졸업자등으로서 졸업 후 응시하려는 종목이 속하는 동일 및 유사 직무분야에서 8년 이상 실무에 종사한 사람<br><br>
						8. 국가기술자격의 종목별로 기사의 수준에 해당하는 교육훈련을 실시하는 기관 중 고용노동부령으로 정하는 교육훈련기관의 기술훈련과정(이하 “기사 수준 기술훈련과정”이라 한다) 이수자로서 이수 후 응시하려는 종목이 속하는 동일 및 유사 직무분야에서 6년 이상 실무에 종사한 사람<br><br>
						9. 국가기술자격의 종목별로 산업기사의 수준에 해당하는 교육훈련을 실시하는 기관 중 고용노동부령으로 정하는 교육훈련기관의 기술훈련과정(이하 “산업기사 수준 기술훈련과정”이라 한다) 이수자로서 이수 후 동일 및 유사 직무분야에서 8년 이상 실무에 종사한 사람<br><br>
						10. 응시하려는 종목이 속하는 동일 및 유사 직무분야에서 9년 이상 실무에 종사한 사람<br><br>
						11. 외국에서 동일한 종목에 해당하는 자격을 취득한 사람
				      </div>
				    </div>
				  </div>
				</div>
			</div>
		
		
		</div>
		
		
		<script>
			var schedulebtn = document.querySelector('.schedulebtn');
			var qualificationbtn = document.querySelector('.qualificationbtn');
			var schedulediv = document.querySelector('.schedulediv');
			var qualificationdiv = document.querySelector('.qualificationdiv');
			
			schedulediv.classList.remove('hide');
			qualificationdiv.classList.add('hide');
			schedulebtn.classList.add('changingcolor');
			qualificationbtn.classList.remove('changingcolor');
			
			schedulebtn.onclick = function() {
				schedulediv.classList.remove('hide');
				qualificationdiv.classList.add('hide');
				schedulebtn.classList.add('changingcolor');
				qualificationbtn.classList.remove('changingcolor');
			}
			qualificationbtn.onclick = function() {
				qualificationdiv.classList.remove('hide');
				schedulediv.classList.add('hide');
				qualificationbtn.classList.add('changingcolor');
				schedulebtn.classList.remove('changingcolor');
			}
		</script>
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
	</body>
</html>