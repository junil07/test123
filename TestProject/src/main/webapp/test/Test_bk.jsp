<%@page import="java.util.Arrays"%>
<%@page import="project.TestBean"%>
<%@page import="project.ChoiceBean"%>
<%@page import="project.QuestionBean"%>
<%@page import="java.util.Vector"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="questMgr" class="project.QuestionMgr"/>
<jsp:useBean id="choiceMgr" class="project.ChoiceMgr"/>
<jsp:useBean id="testMgr" class="project.TestMgr"/>
<%
	String url="../test/Test.jsp?";
	String userId = request.getParameter("sess");
	String title = request.getParameter("test_title");
	String year = request.getParameter("test_year");
	String sess[] = request.getParameterValues("test_sess[]");
	String test_subject[]=request.getParameterValues("test_subject[]");
    String testNum[] = request.getParameterValues("test_num[]");
    for(int i =0; i<sess.length;i++){
    	url+="test_num"+Arrays.toString(testNum)+"="+testNum[i];
    	url+="&test_sess"+Arrays.toString(sess)+"="+sess[i]+"&";
    }
    url+="test_title="+title+"&";
    url+="sess"+userId+"&";
    url+="test_year="+year;
    String nulId = "비회원";
    Vector<QuestionBean> qlist = new Vector<QuestionBean>();
    Vector<ChoiceBean> clist = new Vector<ChoiceBean>();
    Vector<TestBean> tlist = new Vector<TestBean>();
    int choiceCount = choiceMgr.choiceCount(1);
    for (int i = 0; i < testNum.length; i++) {
        qlist.addAll(questMgr.testQuestion(testNum[i]));
        tlist.addAll(testMgr.getTestlist(testNum[i]));
    }
    int questionCount = qlist.size();
    int livequestCount = qlist.size();
    //System.out.println(questionCount);
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
		
		<!-- Custom fonts for this template-->
	    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet" type="text/css">
	    <link
	        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	        rel="stylesheet">
			
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
		
		<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
		
		<link href="assets/css/sb-admin-2.min.css" rel="stylesheet">
		<!--<link href="assets/css/sb-admin-2.css" rel="stylesheet">-->
    <script type="text/javascript">
	    function synchronizeOMR(selection, index) {
	        // 선택한 라디오 버튼의 이름을 가져옴
	        var questName = "choice" + index;
	
	        // 선택한 라디오 버튼의 값 가져오기
	        var selectedValue = selection.value;
	
	        // 해당하는 omr 라디오 버튼의 이름 가져오기
	        var omrName = "omr" + (index+1);
	
	        // 선택한 라디오 버튼과 같은 값을 가진 omr 라디오 버튼을 찾아 체크
	        var omrRadios = document.getElementsByName(omrName);
	        for (var i = 0; i < omrRadios.length; i++) {
	            if (omrRadios[i].value === selectedValue) {
	                // 선택한 라디오 버튼과 같은 값을 가진 omr 라디오 버튼이면 체크
	                omrRadios[i].checked = true;
	            }
	        }
	    }
        
        function synchronizeQuest(selection, index) {
            // 선택한 라디오 버튼의 이름을 가져옴
            var omrName = "omr" + index;

            // 선택한 라디오 버튼의 값 가져오기
            var selectedValue = selection.value;

            // 해당하는 choice 라디오 버튼의 이름 가져오기
            var choiceName = "choice" + (index-1);

            // 선택한 라디오 버튼과 같은 이름을 가진 모든 choice 라디오 버튼을 가져옴
            var choiceRadios = document.getElementsByName(choiceName);

            // 선택한 라디오 버튼과 같은 값을 가진 choice 라디오 버튼을 찾아 체크
            for (var i = 0; i < choiceRadios.length; i++) {
                if (choiceRadios[i].value === selectedValue) {
                    // 선택한 라디오 버튼과 같은 값을 가진 choice 라디오 버튼이면 체크
                    choiceRadios[i].checked = true;
                }
            }
        }
      
        function uncheckRadio(radio) {
            if (radio.checked) {
                radio.checked = false;
            }
        }
        
        function submitForm() {
        	document.correctFrm.action="Test_grading.jsp";
        	document.correctFrm.
            document.getElementById('correctFrm').submit();
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
    <style>
        .container{
            position: absolute;
            top:10%;
            left:25%;
            width:1000px;
        }
        .line{
            border : 0px;
            border-top: 5px solid black;
        }
        body{
        	color:black;
        }
        tr{
        	border:1px black solid;
        	text-align:center;
        }
        td{
        	border:1px black solid;
        	text-align:center;
        }
    </style>
</head>
<body>
<!-- Page Wrapper -->
    <div id="wrapper">

        <!-- Sidebar -->
        <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

            <!-- Sidebar - Brand -->
            <a class="sidebar-brand d-flex align-items-center justify-content-center" href="index.html">
                <div class="sidebar-brand-icon rotate-n-15">
                    <i class="fas fa-laugh-wink"></i>
                </div>
                <div class="sidebar-brand-text mx-3"> Perfect </div>
            </a>

            <!-- Divider -->
            <hr class="sidebar-divider my-0">

            <!-- Nav Item - Dashboard -->
            <li class="nav-item active">
                <a class="nav-link" href="index.html">
                    <i class="fas fa-fw fa-tachometer-alt"></i>
                    <span>Dashboard</span>
                </a>
            </li>

            <!-- Divider -->
            <hr class="sidebar-divider">

            <!-- Heading -->
            <div class="sidebar-heading">
                Discover
            </div>

            <!-- Nav Item - Pages Collapse Menu -->
            <li class="nav-item">
                <a class="nav-link" href="javascript:void(0);">
                    <i class="fas fa-fw fa-cog"></i>
                    <span>기출문제풀기</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="javascript:void(0);">
                    <i class="fas fa-fw fa-cog"></i>
                    <span>공지사항</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="javascript:void(0);">
                    <i class="fas fa-fw fa-cog"></i>
                    <span>QnA</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="javascript:void(0);">
                    <i class="fas fa-fw fa-cog"></i>
                    <span>스토어</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="javascript:void(0);">
                    <i class="fas fa-fw fa-cog"></i>
                    <span>자유게시판</span>
                </a>
            </li>

            <!-- Divider -->
            <hr class="sidebar-divider">

            <!-- Heading -->
            <div class="sidebar-heading">
                마이페이지
            </div>
            
            <li class="nav-item">
                <a class="nav-link" href="javascript:void(0);">
	                <!-- todo. i 태그 :: class를 통해서 아이콘 추가 -->
                    <i class="fas fa-fw fa-user"></i>
                    <span>내정보</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="javascript:void(0);">
                    <i class="fas fa-fw fa-cog"></i>
                    <span>오답노트</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="javascript:void(0);">
                    <i class="fas fa-fw fa-cog"></i>
                    <span>구매내역</span>
                </a>
            </li>
        </ul>
        <!-- End of Sidebar -->

        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">

            <!-- Main Content -->
            <div id="content">

                <!-- Topbar -->
                <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

                    <!-- Sidebar Toggle (Topbar) -->
                    <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
                        <i class="fa fa-bars"></i>
                    </button>

                    <!-- Topbar Navbar -->
                    <ul class="navbar-nav ml-auto">

                        <!-- Nav Item - User Information -->
                        <li class="nav-item dropdown no-arrow">
                        	<!-- 
                            <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button"
                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <span class="mr-2 d-none d-lg-inline text-gray-600 small">관리자</span>
                                <img class="img-profile rounded-circle" src="img/undraw_profile.svg">
                            </a>
                            -->
                            <!-- Dropdown - User Information -->
                            <%if(sess==null){ %>
                            	<button type="button" class="btn btn-primary" onclick="javascript:login('<%=url%>')">로그인</button>
                            <%}else{%>
                            	<button type="button" class="btn btn-primary" onclick="javascript:logout('<%=url%>')">로그아웃</button>
                            <%} %>
                            <!--
                            <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="userDropdown">
                                <a class="dropdown-item" href="#">
                                    <i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>
                                    Profile
                                </a>
                                <a class="dropdown-item" href="#">
                                    <i class="fas fa-cogs fa-sm fa-fw mr-2 text-gray-400"></i>
                                    Settings
                                </a>
                                <a class="dropdown-item" href="#">
                                    <i class="fas fa-list fa-sm fa-fw mr-2 text-gray-400"></i>
                                    Activity Log
                                </a>
                                <div class="dropdown-divider"></div>
                                <a class="dropdown-item" href="#" data-toggle="modal" data-target="#logoutModal">
                                    <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
                                    Logout
                                </a>
                            </div>
                             -->
                        </li>

                    </ul>

                </nav>
                <!-- End of Topbar -->


        </div>
        <!-- End of Content Wrapper -->

    </div>
    <!-- End of Page Wrapper -->

    <!-- Scroll to Top Button-->
    <a class="scroll-to-top rounded" href="#page-top">
        <i class="fas fa-angle-up"></i>
    </a>

    <!-- Logout Modal-->
    <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">Select "Logout" below if you are ready to end your current session.</div>
                <div class="modal-footer">
                    <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
                    <a class="btn btn-primary" href="login.html">Logout</a>
                </div>
            </div>
        </div>
    </div>

    
    <!-- Core plugin JavaScript-->
    <script src="assets/js/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="assets/js/sb-admin-2.min.js"></script>


<div class="container" style="border: 2px solid;left: 250px; height:800px; wigth:1200px;position: absolute; overflow:auto;">
    <h1 class="test_title">자격증 기출문제</h1>
    <hr class="line"/>
    <div align="center">
        	<table style="border:1px black solid;">
        		<tr>
        			<td>응시자</td>
        			<td>자격증명</td>
        			<td>년도 및 회차</td>
        			<td>응시 과목</td>
        		<tr>
        		<tr>
        			<td>
        			<%if(userId.equals("null")){ %>
        				<%=nulId%>
        			<%}else{%>
        				<%=userId%>
        			<%} %>
        			</td>
        			<td><%=title%></td>
        			<td><%=year%></td>
        			<td>
        			<%for(int i =0; i<sess.length;i++){ %>
        			<%if(i==sess.length-1){%>
        				<%=sess[sess.length-1]%>
        			<%}else if(i<sess.length-1){%>
        				<%=sess[i]+","%>
        			<%}
        			} %>
        			</td>
        		</tr>
        	</table>
    </div>
    <div align="right"></div>
    <form method="post" name="testGrading">
        <div>
            <% 
                ChoiceBean cbean = new ChoiceBean();
           		int index = 0;
                for (QuestionBean bean : qlist) { 
                    // Retrieve choices for each question
                    clist.addAll(choiceMgr.testChoice(bean.getQuestion_num()));
            %>
				    <div style="padding-top:10px"><%=bean.getQuestion_number()%>. <%= bean.getQuestion_content() %></div>
				    <div>정답률 : <%=bean.getQuestion_percent() %>%</div>
				    <!-- Loop through choices -->
				    <% for (ChoiceBean choice : clist) { %>
				        <div class="form-check">
				            <input class="form-check-input" type="radio" name="choice<%=index%>" 
				                id="quest<%=bean.getQuestion_num()%>_<%=choice.getChoice_number()%>"
				                value="<%=choice.getChoice_number()%>"
				                onchange="synchronizeOMR(this, <%=index%>);"> <!-- onChange 이벤트 추가 -->
				            <label class="form-check-label" for="quest<%=choice.getChoice_question_num()%>_<%=choice.getChoice_number()%>">
				                <%=choice.getChoice_number()%>. <%=choice.getChoice_content()[0]%>
				            </label>
				        </div>
				    <%} %>
				    <%
				        index++; // 인덱스 변수 증가
				        // Clear choices for next question
				        clist.clear();
				%>
            	<div class="accordion" id="accordionExample">
            		<div class="accordion-item">
	        			<h2 class="accordion-header">
		        			<button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapse<%=bean.getQuestion_number()%>" aria-expanded="true" aria-controls="collapse<%=bean.getQuestion_number()%>">
		        			<%=bean.getQuestion_number()%>번 해설 및 정답 보기
		        			</button>
	        			</h2>
		        		<div id="collapse<%=bean.getQuestion_number()%>" class="accordion-collapse collapse">
					      <div class="accordion-body">
					        <strong>정답 : <%=bean.getQuestion_correct()%></strong> 
					      </div>
					    </div>
			    	</div>
			    </div>
            <%
                } 
            %>
        </div>
        <div class = "container-omr" style="top: 140px;width: 300px;position: fixed;left: 1260px;">
            <div class="cbt_omr_title" align="center">
                 <span>OMR 답안지</span>
            </div>
            <div class="cbt_omr">
                <table border="1px" align="center">
                <tr>
                    <td>번호</td>
                    <td>정답 선택</td>
                </tr>
                <%for(int i=0; i<qlist.size();i++){ %>
                    <tr>
                        <td><strong><%=i+1%></strong></td>
                        <td style="display:flex;">
                            <%for(int j=0;j<choiceCount;j++){ %>
                                <div class="form-omr">
									    <input class="form-omr-input" type="radio" name="omr<%=i+1%>" id="omr<%=i+1%>_<%=j%>" value="<%=j+1%>" onchange="synchronizeQuest(this, <%=i+1%>)">
									    <label class="form-omr-label" for="omr<%=i+1%>_<%=j+1%>"><span class="omr_inner_label"><%=j+1%></span></label>
                                </div>
                            <%}%>
                        </td>
                    </tr>
                <%}%>
                </table>
            </div>
         	<div align="center" style="padding-top:10px">
            	<input type="button" id="grading" value="채점하기" onclick="submitvalue()">
        	</div>
        </div>
        
    	<%for(int i=0; i<testNum.length;i++){%>
    	<input type="hidden" name="test_num" value="<%=testNum[i]%>">
    	<input type="hidden" name="test_sess[]" value="<%=sess[i]%>">
    	<input type="hidden" name="test_subject[]" value="<%=test_subject[i]%>">    	
    	<%}%>
    	<input type="hidden" name="sess" value="<%=userId%>">
		<input type="hidden" name="test_title" value="<%=title%>">
		<input type="hidden" name="test_year" value="<%=year%>">
    </form>
    <script type="text/javascript">
    	function submitvalue(){
    	document.testGrading.action="Test_grading.jsp";
    	document.testGrading.submit();
    	}
	</script>
	<form name = "loginFrm">
  		<input type="hidden" name="url" value="<%=url%>">
  	</form>
</div>
</body>
</html>