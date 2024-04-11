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
	<style>
		.container{
        	position: absolute;
   			top:15%;
   			left:25%;
   			width:1000px;
        }
        .line{
        	border : 0px;
  			border-top: 5px solid black;
        }
        .yearSelect{
        	rigth:10%;
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
                            <form name="loginFrm">
								  <input type="hidden" name="url" value="<%=url%>">
							</form>
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

                <!-- Begin Page Content -->
                <div class="container-fluid">

                    <!-- Page Heading -->
                    <div class="d-sm-flex align-items-center justify-content-between mb-4">
                        
                    </div>
					
					<div class="">
						<!-- // main contents -->
						
					
					</div>
                    
                </div>
                <!-- /.container-fluid -->

            </div>
            <!-- End of Main Content -->

            <!-- Footer -->
            <footer class="sticky-footer bg-white">
                <div class="container my-auto">
                    <div class="copyright text-center my-auto">
                    </div>
                </div>
            </footer>
            <!-- End of Footer -->

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
	   		<table border="1" align="center">
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
</body>
</html>