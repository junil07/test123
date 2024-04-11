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
	<!-- // 공통 Head  -->
	<%@ include file="../inc/head.jsp" %>
	
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
                	
                	<div class="row">
                		<div class="col-8 p-4" >
                			<div class="border p-5" style="height: 750px; overflow: hidden; overflow-y: auto;">
                				<h2> 자격증 기출문제 </h2>
	                			<hr/>
	                			<table class="table table-bordered">
	                				<thead class="table-secondary">
	                					<tr>
	                						<th>응시자</th>
	                						<th>자격증명</th>
	                						<th>년도 및 회차</th>
	                						<th>응시 과목</th>
	                					</tr>
	                				</thead>
	                				<tbody>
	                					<tr>
	                						<td>
	                							<%
	                							if ( idkey == null ) out.print(nulId);
	                							else out.print(idkey);
	                							%>
	                						</td>
	                						<td><%=title%></td>
        									<td><%=year%></td>
	                						<td>
	                							<%
	                							for ( int i = 0 ; i < sess.length; i++ ) {
	                								if ( i == sess.length - 1 ) out.print(sess[sess.length-1]);
	                								else if ( i < sess.length - 1 ) out.print(sess[i]+", ");
	                							}
	                							%>
	                						</td>
	                					</tr>
	                				</tbody>
	                			</table>
	                			<div class="">
	                			
	                				<% 
						                ChoiceBean cbean = new ChoiceBean();
						                for (QuestionBean bean : qlist) { 
						                    // Retrieve choices for each question
						                    clist.addAll(choiceMgr.testChoice(bean.getQuestion_num()));
						            %>
						            		<% if(userCorrect[index]==bean.getQuestion_correct()){ %>
						           			<img class="grading" src="./img/circle.gif" alt="grading" style="width: 100px; margin-bottom: -130px; margin-left: -30px; position: relative; pointer-events : none; z-index: 100;">
						            		<% } else { %>
						            		<img alt="grading" src="./img/rain.gif" style="width: 70px; margin-bottom: -130px; margin-left: -30px; position: relative; margin-left: -30px; pointer-events : none; z-index: 100;">
						            		<%} %>
						            		
						            		<%-- <div>
							            		<input type="checkbox" name="wrongCartInsert<%=index%>" value="">
							            		<label class="checkbox-label" for="wrongCart<%=index+1%>" value="<%=index+1%>"><%=index+1%></label> 번 오답노트에 추가
						            		</div> --%>
						                    
										    <div class="card mb-3" >
											  <div class="card-header bg-dark text-white">
											    <%=bean.getQuestion_number()%>. <%= bean.getQuestion_content() %>
											    <small style="float: right;"> 정답률 : <%=bean.getQuestion_percent() %>% </small>
											  </div>
											  <ul class="list-group list-group-flush">
											  	<% for (ChoiceBean choice : clist) { %>
											  	<li class="list-group-item" ><%=choice.getChoice_number()%>. <%=choice.getChoice_content()[0]%></li>
											  	
											  	<%--
										        <div class="form-check">
										            <input class="form-check-input" type="radio" name="choice<%=index%>" 
										                id="quest<%=bean.getQuestion_num()%>_<%=choice.getChoice_number()%>"
										                value="<%=choice.getChoice_number()%>"
										                onchange="synchronizeOMR(this, <%=index%>);"> <!-- onChange 이벤트 추가 -->
										            <label class="form-check-label" for="quest<%=choice.getChoice_question_num()%>_<%=choice.getChoice_number()%>">
										            </label>
										        </div>
										         --%>
										    	<% } %>
											  </ul>
											</div>
										    <%
										        index++; // 인덱스 변수 증가
										        // Clear choices for next question
										        clist.clear();
										%>
						            	<div class="accordion" id="accordionExample">
						            		<div class="accordion-item">
							        			<h2 class="accordion-header">
								        			<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapse<%=bean.getQuestion_number()%>" aria-expanded="true" aria-controls="collapse<%=bean.getQuestion_number()%>">
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
						            <% } %>
	                			</div>
                			</div>
                		</div>
                		<div class="col-4 p-4">
                			<div class="border p-5" style="height: 750px; overflow: hidden; overflow-y: auto;">
                				<h2> OMR 답안지 </h2>
                				<hr/>
                				<div class="p-2">
                					<table class="table table-sm table-bordered text-center">
                						<colgroup>
                							<col style="width: 40%;">
                							<col style="width: *;">
                						</colgroup>
                						<thead class="table-dark">
                							<tr>
                								<th> 문제번호 </th>
                								<th> 제출답안 </th>
                							</tr>
                						</thead>
                						<tbody>
                							<% for ( int i = 0 ; i < qlist.size() ; i++ ) { %>
                							<tr>
                								<th> <span style="line-height: 35px; vertical-align: middle;"> <%=i+1%> </span> </th>
                								<td id="">
                									<input type="text" class="form-control border-0 bg-white"  readonly value=""> 
                								</td>
                							</tr>
                							<%}%>
                						</tbody>
                					</table>
                					<button type="button" class="btn btn-primary w-100"> 채점하기 </button>
                				</div>
                				<hr/>
                				<div class="">
                					<h3> 오답노트 장바구니 </h3>
                					<div class="card">
									  <div class="card-body">
									    
									  </div>
									</div>
                				</div>
                			</div>
                		</div>
                	</div>
                	
                	
                	<!-- // 컨텐츠 입력 end -->
                </div>
            </div>
        </div>
    </div>
    <!-- // 사이드 메뉴 영역  -->
	<%@ include file="../inc/footer.jsp" %>
				

<div class="container" style="display: block; border: 2px solid;">
    
        <div class = "container-omr" style="top: 140px;width: 300px;position: fixed;left: 1260px;">
            <div class="cbt_omr" align="center">
                <table border="1" style="overflow:auto;">
                    <%-- <tr align="center">
                        <td><strong><%=i+1%></strong></td>
                        <td style="display:flex;">
                            <%for(int j=0;j<choiceCount;j++){ %>
                                <div class="form-omr">
									    <input class="form-omr-input" type="radio" name="omr<%=i+1%>" id="omr<%=i+1%>_<%=j%>" value="<%=j+1%>" onchange="synchronizeQuest(this, <%=i+1%>)">
									    <label class="form-omr-label" for="omr<%=i+1%>_<%=j+1%>"><span class="omr_inner_label"><%=j+1%></span></label>
                                </div>
                            <%}%>
                        </td>
                    </tr> --%>
                
                </table>
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
    
	
</div>


</body>
</html>