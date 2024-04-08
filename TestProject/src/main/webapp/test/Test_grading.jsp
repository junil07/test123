<%@page import="java.net.URL"%>
<%@page import="project.ChoiceBean"%>
<%@page import="project.QuestionBean"%>
<%@page import="java.util.Vector"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="questMgr" class="project.QuestionMgr"/>
<jsp:useBean id="choiceMgr" class="project.ChoiceMgr"/>
<%
	String url = request.getRequestURI();
	String getP= request.getQueryString();
	if(request.getQueryString()!=null){
		getP.replace("/", "&");
		url+="?"+getP;
	}
	System.out.print(url);
	String userId = request.getParameter("sess");
	String idkey = (String) session.getAttribute("idKey");
	String title = request.getParameter("test_title");
	String year = request.getParameter("test_year");
	String sess[] = request.getParameterValues("test_sess[]");
    String testNum[] = request.getParameterValues("test_num");
    String subject[] = request.getParameterValues("test_subject[]");
    String nulId = "비회원";
    int correctCount[]=new int[testNum.length];
    int oneSubQueCount[] = new int[testNum.length];
    Vector<QuestionBean> qlist = new Vector<QuestionBean>();
    Vector<ChoiceBean> clist = new Vector<ChoiceBean>();
    int choiceCount = choiceMgr.choiceCount(1);
    for (int i = 0; i < testNum.length; i++) {
        qlist.addAll(questMgr.testQuestion(testNum[i]));
        correctCount[i]=0;
        oneSubQueCount[i]=0;
    }
    int questionCount = qlist.size();
    int livequestCount = qlist.size();
    //System.out.println(questionCount);
    String[] struserParam = new String[questionCount];
    String[] strUserCor=new String[questionCount];
    int[] userCorrect = new int[questionCount];
    for(int i =0; i<strUserCor.length; i++){
    	struserParam[i] = "choice"+i;
    	if(request.getParameter(struserParam[i])!=null){
	    	strUserCor[i]=request.getParameter(struserParam[i]);
	    	userCorrect[i] = Integer.parseInt(strUserCor[i]);
    	}else{
    		userCorrect[i]=0;
    	}
   		System.out.print(strUserCor[i]);
    }
    System.out.print(subject[0]);
    int index = 0;
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
        
        window.onload = function() {
            <% for(int i = 0; i < questionCount; i++) { %>
                var userResponse<%= i %> = '<%= strUserCor[i] %>';
                if (userResponse<%= i %> !== '') {
                    var radioName<%= i %> = "choice" + <%= i %>;
                    var radioButton<%= i %> = document.getElementsByName(radioName<%= i %>);
                    for (var j = 0; j < radioButton<%= i %>.length; j++) {
                        if (radioButton<%= i %>[j].value === userResponse<%= i %>) {
                            radioButton<%= i %>[j].checked = true;
                        }
                    }
                }
            <% } %>
        }
        
        window.onload = function() {
            <% for(int i = 0; i < questionCount; i++) { %>
                var userResponse<%= i %> = '<%= strUserCor[i] %>';
                if (userResponse<%= i %> !== '') {
                    var radioName<%= i %> = "choice" + <%= i %>;
                    var radioButton<%= i %> = document.getElementsByName(radioName<%= i %>);
                    for (var j = 0; j < radioButton<%= i %>.length; j++) {
                        if (radioButton<%= i %>[j].value === userResponse<%= i %>) {
                            radioButton<%= i %>[j].checked = true;
                            synchronizeOMR(radioButton<%= i %>[j], <%= i %>); // OMR 라디오 버튼을 선택하도록 호출
                        }
                    }
                }
            <% } %>
        }
        
     
        document.addEventListener('DOMContentLoaded', function() {
            // 이미 추가된 인덱스를 저장할 배열
            var addedIndexes = [];

            // 체크박스 변경 이벤트 처리
            var checkboxes = document.querySelectorAll('input[type="checkbox"]');
            checkboxes.forEach(function(checkbox) {
                checkbox.addEventListener('change', function() {
                    var index = this.name.replace('wrongCartInsert', ''); // 체크박스의 인덱스 추출
                    var wrongCartDiv = document.querySelector('.wrongCart');
                    var label = document.createElement('p');
                    if (this.checked) {
                        // 이미 추가된 인덱스인지 확인하여 중복 추가 방지
                        if (!addedIndexes.includes(index)) {
                            label.textContent = (parseInt(index) + 1) + '번';
                            label.setAttribute('data-index', index); // 라벨에 인덱스 속성 추가
                            label.classList.add('addedLabel'); // 추가된 라벨에 클래스 추가

                            // 배열에 추가된 인덱스 중 현재 인덱스보다 큰 값들의 위치를 찾아 현재 인덱스 앞에 추가
                            var insertIndex = addedIndexes.findIndex(function(idx) {
                                return parseInt(idx) > parseInt(index);
                            });

                            // 배열에 추가된 인덱스 중 현재 인덱스보다 큰 값들이 없으면 맨 뒤에 추가
                            if (insertIndex === -1) {
                                insertIndex = addedIndexes.length;
                            }

                            // 라벨을 해당 위치에 추가
                            if (insertIndex === 0) {
                                wrongCartDiv.prepend(label); // 맨 앞에 추가
                            } else {
                                var previousLabel = document.querySelector('p[data-index="' + addedIndexes[insertIndex - 1] + '"]');
                                previousLabel.after(label); // 이전 라벨 다음에 추가
                            }

                            // 추가된 인덱스 배열에 현재 인덱스 추가
                            addedIndexes.splice(insertIndex, 0, index);
                        }
                    } else {
                        // 체크가 해제된 경우 해당 메시지 제거
                        var existingLabel = document.querySelector('p[data-index="' + index + '"]');
                        if (existingLabel) {
                            existingLabel.remove();
                            var indexToRemove = addedIndexes.indexOf(index);
                            if (indexToRemove !== -1) {
                                addedIndexes.splice(indexToRemove, 1); // 배열에서 해당 인덱스 제거
                            }
                        }
                    }
                });
            });
        })
      
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
            border-top: 3px solid black;
            margin-top:0px;
            margin-bottom:3px;
        }
        .wrongCart {
	        margin:0px;
    	}

    	.addedLabel {
	        background-color: #f0f0f0;
	        padding: 5px 10px;
	        border-radius: 5px;
	        display: inline-block; /* 인라인 블록 요소로 설정하여 가로로 배치 */
	        margin-right: 7px; /* 라벨 간 간격 조절 */
	        margin-bottom: 10px; /* 필요에 따라 아래 여백 추가 */
	        margin-left: 7px;
	        margin-top:5px;	
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
<div id="modal" class="modal" tabindex="-1" style="display:block; backdrop-filter: blur(5px);">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title">모의 시험 결과</h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	        <table>
	        	<tr>
	        		<td>과목번호</td>
	        		<td>과목명</td>
	        		<td>정답수</td>
	        		<td>점수</td>
	        		<td>판정</td>
	        	</tr>
	        	
	        		<%
	        		for(int j=0; j<testNum.length;j++){
	        			Vector<QuestionBean> qclist= questMgr.QuestionCorrect(testNum[j]);
	        			QuestionBean qbean = new QuestionBean();
	        			correctCount[j]=0;
	        			for(int i=0;i<qclist.size();i++) {
	        				qbean = qclist.get(i);
	        				if(userCorrect[i]==qbean.getQuestion_correct()){
	        					correctCount[j]++;
	        				}
	        				oneSubQueCount[j]++;
	        			}
	        		}%>
	        		<%for(int i=0;i<sess.length;i++){ %>
	        		<tr>
	        			<td><%=sess[i]%></td>
	        			<td><%=subject[i]%></td>
	        			<td><%=correctCount[i]+"/"+oneSubQueCount[i]%></td>
	        			<td><%=correctCount[i]*5%>점</td>
	        			<td>
	        			<%if(correctCount[i]*5>=60){ %>
	        				<%="통과"%>
	        			<%}else if(correctCount[i]*5<60&&correctCount[i]*5>=40){%>
	        				<%="불합격"%>
	        			<%}else{%>
	        				<%="과락"%>
	        			<%} %>
	        			</td>
	        		</tr>
	        		<%} %>
	        </table>
	        <h5>평균 점수 : <%int average=0;
	        			   int sum = 0;
	        			   String judgment="";
	        				for(int i=0;i<testNum.length;i++){
	        					sum+=(userCorrect[i]*5);
	        				}
	        				average=sum/5;
	        				if(average>=60){ %>
	        				<%judgment="통과";%>
		        			<%}else if(average<60&&average>=40){%>
		        				<%judgment="불합격";%>
		        			<%}else{%>
		        				<%judgment="과락";%>
		        			<%} %>
	        				<%=average%><%=judgment%>
	        </h5>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="custom-button" onclick="closeModal()">Close</button>
	        <script>
	            // 모달을 닫는 JavaScript 함수
	            function closeModal() {
	                var modal = document.querySelector('.modal');
	                modal.style.display = 'none'; // 모달을 숨깁니다.
	            }
	        </script>
	      </div>
	    </div>
	  </div>
	 </div>

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
			<!-- 깃 -->
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
                            <%if(idkey==null){ %>
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
</div>
<div class="container" style="border: 2px solid;left: 250px;height:800px; position: absolute; overflow:auto;">
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
        			<%if(idkey==null){ %>
        				<%=nulId%>
        			<%}else{%>
        				<%=idkey%>
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
    
        <div>
            <% 
                ChoiceBean cbean = new ChoiceBean();
                for (QuestionBean bean : qlist) { 
                    // Retrieve choices for each question
                    clist.addAll(choiceMgr.testChoice(bean.getQuestion_num()));
            %>
            		<%if(userCorrect[index]==bean.getQuestion_correct()){ %>
            			<img class="grading" src="./img/circle.gif" alt="grading" style="width: 100px; margin-bottom: -130px; margin-left: -30px; position: relative; pointer-events : none;">
            		<%}
            		else{
            		%>
            		<img alt="grading" src="./img/rain.gif" style="width: 70px; margin-bottom: -130px; margin-left: -30px; position: relative; margin-left: -30px; pointer-events : none;">
            		<%} %>
            		<div>
	            		<input type="checkbox" name="wrongCartInsert<%=index%>" value="<%=bean.getQuestion_num()%>">
	            		<label class="checkbox-label" for="wrongCart<%=index+1%>" value="<%=index+1%>"><%=index+1%></label> 번 오답노트에 추가
            		</div>
                    <div name ="question" style="padding-top: 10px; position: relative; z-index: 1;"><%=bean.getQuestion_number()%>. <%= bean.getQuestion_content() %></div>
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
            <div class="cbt_omr" align="center">
                <table border="1" style="overflow:auto;">
                <tr align="center">
                    <td>번호</td>
                    <td>정답 선택</td>
                </tr>
                <%for(int i=0; i<qlist.size();i++){ %>
                    <tr align="center">
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
        		<div align="center" style="margin-top:20px">오답노트 장바구니</div>
	        	<div class="wrongCart" style="border:1px solid black; border-radius:10px; height:150px; margin-top:0px; margin-bottom:0px;	overflow:auto">
	        		
	        	</div>	
        	<div align="center" style="margin-top:10px">
        		<input type="button" id="wrongInsert" value="오답노트 추가">
        	</div>
        </div>
    	<%for(int i=0; i<testNum.length;i++){%>
    	<input type="hidden" name="test_num" value="<%=testNum[i]%>">
    	<%}%>
    </form>
    <script type="text/javascript">
    	function submitvalue(){
    	document.testGrading.action="Test_grading.jsp";
    	document.testGrading.submit();
    	}
	</script>
	<form method="get" name="loginFrm">
		<input type="hidden" name="url" value="<%=url%>">
	</form>
</div>
</body>
</html>