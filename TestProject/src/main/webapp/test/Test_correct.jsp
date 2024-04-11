<%@page import="java.util.Vector"%>
<%@page import="project.TestBean"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="testMgr" class="project.TestMgr"/>
<%
	String title = request.getParameter("title");
	String sess = (String) session.getAttribute("idKey");
	String url = "../test/Test_correct.jsp?title="+title;
	System.out.print(sess);
	Vector<TestBean> ylist = testMgr.testyear(title);
	Vector<TestBean> slist = testMgr.testSessTitle(title);
	String testYear = "",testTitle="";
	if(request.getParameter("year")!=null){
		testTitle = request.getParameter("title");
		testYear = request.getParameter("year");
	}
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
		
		<%@ include file="../inc/head.jsp" %>

	<script type="text/javascript">
	function read(title,year,checkbox[]) {
		document.regFrm.title.value=title;
		document.regFrm.year.value=year;
		document.regFrm.checkbox[].value=checkbox[];
		document.regFrm.action = "TestStartProc.jsp";
		document.regFrm.submit();
	}
	function login(url){
		   document.loginFrm.url.value=url;
		   document.loginFrm.action="../user/login.jsp";
		   document.loginFrm.submit();
	}
	function logout(url){
		   document.loginFrm.url.value=url;
		   document.loginFrm.action="../user/logout.jsp"
		   document.loginFrm.submit();
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
                	<form name="regFrm" method="post" action="TestStartProc.jsp">
					  	  <input type="hidden" name="sess" value="<%=sess%>">
						  <div class = "container">
						  	<h1 class="test_title">자격증 기출문제</h1>
						  	<hr class="line"/>
						  	<h3>응시과목 : <%=title%></h3>
						  	<div align="left">
						  		<table class="yearSelect">
						  			<tr>
						  			<td><label id="yearlabel">년도/회차 : </label></td>
						  			<td>
						  				<input type="hidden" name="title" value="<%=title%>">
										<select id="year" name="year">
						    				<option selected>년도 선택</option>
						    				<%for(int i=0;i<ylist.size();i++){
						    					TestBean testBean = ylist.get(i);
						    					String year = testBean.getTest_year();
						    				%>
						    				<option value="<%=year%>"><%=year%></option>
						    				<%}%>
						   				</select>
						   			</td>
						   			</tr>
						   		</table>
						   	</div>
						   	<div align="center" style="padding-top: 16px">
						   		<table class="table table-striped table-hover" border="1" align="center">
						   			<tr align="center">
						   				<td width="100">과목번호</td>
						   				<td width="300">과목명</td>
						   				<td width="150">문항수</td>
						   				<td width="150">과목선택</td>
						   			</tr>
						   			<%
						   				String subnum[] = new String[slist.size()];
						   				for(int i=0;i<slist.size();i++){
						   					TestBean bean = slist.get(i);
						   					String subTitle = bean.getTest_subject();
						   					int questionCount = 20;
						   			%>
						   			
						   			<tr align="center">
						   				<td><%=i+1%></td>
						   				<td><%=subTitle%></td>
						   				<td><%=questionCount%>문항</td>
						   				<td><input type="checkbox" id="checkbox<%=i+1%>" name="checkbox[]" value="<%=i+1%>" checked> <!-- 체크박스 -->
										<label for="checkbox<%=i+1%>" id="label<%=i+1%>">응시</label>
										<script>
											var checkbox = document.getElementById("checkbox<%=i+1%>");
											var label = document.getElementById("label<%=i+1%>");
							
											// 페이지 로드 시 실행되어 처음에 선택된 체크박스 상태에 따라 텍스트 변경
											window.onload = function() {
											  if (checkbox.checked) {
											    label.textContent = "응시"; // 체크됐을 때 텍스트 변경
											  } else {
											    label.textContent = "미응시"; // 체크 해제됐을 때 원래 텍스트로 변경
											  }
											};
											
											 checkbox<%= i + 1 %>.addEventListener("change", function(event) {
												    var currentCheckbox = event.target;
												    var currentLabel = document.querySelector("label[for='" + currentCheckbox.id + "']");
												    if (currentCheckbox.checked) {
												      currentLabel.textContent = "응시";
												    } else {
												      currentLabel.textContent = "미응시";
												    }
											});
						   				</script>
										</td>
						   			</tr>
						   			<%
						   				}
						   			%>
						   		</table>
						   	</div>
						   	<div class="goTestbutton" align="center" style="padding-top: 16px">
						   		<input type="submit" value="문제풀기">
						  	</div>
					  	</div>
					  </form>
   	 			 </div>
            </div>
        </div>
    </div>
 <!-- // 사이드 메뉴 영역  -->
	<%@ include file="../inc/footer.jsp" %>
  
</body>
</html>