<%-- 시험 일정 날짜 등 내용 수정하는 페이지 --%>

<%@page import="project.Schedule_columnBean"%>
<%@page import="java.util.Vector"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="columnMgr" class="project.Schedule_columnMgr"/>

<%
	int num = Integer.parseInt( request.getParameter("num") );
	int fknum = Integer.parseInt( request.getParameter("fknum") );
	int j = 0;
	String contentname[] = new String[]{"회차", "필기 원서점수", "필기 시험", "필기 합격발표", "실기 원서점수", "실기 시험", "면접 원서접수", "면접 시험", "합격자 발표"};
	String content[] = new String[9];
	String attempt = "", written_Registration = "", written_test = "", written_pass = "", practical_registration = "", practical_test = "", interview_registration = "", interview_test = "", pass = "";
	Vector<Schedule_columnBean> vlist = columnMgr.onerow(num, fknum);
	Schedule_columnBean bean;
	
	for ( int i = 0; i < vlist.size(); i++ ) {
		 bean = vlist.get(i);
		 attempt = bean.getSchedule_column_attempt();
		 content[0] = attempt;
		 written_Registration = bean.getSchedule_column_written_registration();
		 content[1] = written_Registration;
		 written_test = bean.getSchedule_column_written_test();
		 content[2] = written_test;
		 written_pass = bean.getSchedule_column_written_pass();
		 content[3] = written_pass;
		 practical_registration = bean.getSchedule_column_practical_registration();
		 content[4] = practical_registration;
		 practical_test = bean.getSchedule_column_practical_test();
		 content[5] = practical_test;
		 interview_registration = bean.getSchedule_column_interview_registration();
		 content[6] = interview_registration;
		 interview_test = bean.getSchedule_column_interview_test();
		 content[7] = interview_test;
		 pass = bean.getSchedule_column_pass();
		 content[8] = pass;
	}
	
	
	
%>
<html>

	<head>
		
		<style>
			
			button {
				cursor: pointer;
			}
			
			button:hover {
				background: #bebebe;
			}
			
			textarea {
				resize: none;
				width: 100%;
			}
			
			.grandmadiv {
				width: 100%;
				height: 100%;
				display:flex;
				align-items: center;
				flex-direction: column;
    			justify-content: center;
			}
			
			.parantdiv {
				display: flex;
				align-items: center;
				width: 100%;
			    margin-top: auto;
			}
			
			.row {
			    width: 11%;
    			margin-left: 3%;
			}
			
			.btndiv {
			    margin-top: auto;
			    width: 100%;
				height: 50px;
				display: flex;
			    align-items: center;
			    justify-content: center;
			}
			
			.btndiv > button {
				width: 10%;
				height: 100%;
				border: none;
				margin-top: 10px;
			}
			
			.contentname {
				
			}
			
			.edit {
				margin-right: 10px;
			}
			
		</style>
		
	</head>
	
	<body>
	<form name="frm">
		<div class="grandmadiv">
			<div class="parantdiv">
				
				<%
					for ( int i = 0; i < 7; i++) {
						
						if ( ( fknum == 1 || fknum == 2 ) && ( i == 6 ) ) j = j + 2;
						if ( ( fknum == 3 || fknum == 4 ) && ( i == 4 ) ) j = j + 2;
						System.out.println("\n -- j -- \n" + j + "\n -- j -- \n");
				%>
						<div class="row">
							<div class="contentname"><%=contentname[j]%> :</div>
							<textarea name="content<%=i+1%>"><%=content[j]%></textarea>
						</div>
				<%
						j++;
					}
				%>
				
			</div>
			
			<div class="btndiv">
				<button class="edit" onclick="contentEdit()">수정</button>
				<button class="close" onclick="self.close()">닫기</button>
			</div>
		</div>
		<input type="hidden" name="num" value="<%=num%>">
		<input type="hidden" name="fknum" value="<%=fknum%>">
	</form>
		<script>
		
			function contentEdit() {
				
				var result = confirm("수정 하시겠습니까?");
				
				if ( result ) {
				
					document.frm.action = "titlecontentEditProc.jsp";
					document.frm.submit();
					
				}
				
			}
		
		</script>
		
	</body>
	
</html>