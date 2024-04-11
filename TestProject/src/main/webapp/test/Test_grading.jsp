<%@page import="project.ExplanationBean"%>
<%@page import="java.net.URL"%>
<%@page import="project.ChoiceBean"%>
<%@page import="project.QuestionBean"%>
<%@page import="java.util.Vector"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="questMgr" class="project.QuestionMgr"/>
<jsp:useBean id="choiceMgr" class="project.ChoiceMgr"/>
<jsp:useBean id="explanationMgr" class="project.ExplanationMgr"/>
<%@ include file="inc/session.jsp" %>
<%
	String url = "Test_grading.jsp";
	String title = request.getParameter("test_title");
	String year = request.getParameter("test_year");
	String test_sec[] = request.getParameterValues("test_sess[]");
    String testNum[] = request.getParameterValues("test_num[]");
    String subject[] = request.getParameterValues("test_subject[]");
    int testNumCount=testNum.length;
    String nulId = "비회원";
    int correctCount[]=new int[testNum.length];
    int oneSubQueCount[] = new int[testNum.length];
    Vector<QuestionBean> qlist = new Vector<QuestionBean>();
    Vector<ChoiceBean> clist = new Vector<ChoiceBean>();
    Vector<ExplanationBean> expllist = new Vector<ExplanationBean>();
    int choiceCount = choiceMgr.choiceCount(1);
    for (int i = 0; i < testNum.length; i++) {
        qlist.addAll(questMgr.testQuestion(testNum[i]));
        correctCount[i]=0;
        oneSubQueCount[i]=0;
    }
    int questionCount = qlist.size();
    //System.out.println(questionCount);
		int[] userCorrect = new int[questionCount];
		
		for (int i = 0; i < questionCount; i++) {
	        String userCor = request.getParameter("choice" + (i));
	        if (userCor != null && !userCor.isEmpty() && !"null".equals(userCor)) {
	            userCorrect[i] = Integer.parseInt(userCor);
	        } else {
	            userCorrect[i] = 0;
	        }
	    }
    int index = 0;
    System.out.print(sess);
%>
<!-- // session 정보 확인하는 내용 -->

<!DOCTYPE html>
<html>
<head>
	<!-- // 공통 Head  -->
	<%@ include file="../inc/head.jsp" %>
	
	<style>
		img.red-circle { width: 100px; margin-bottom: -75px; margin-left: -30px; position: relative; pointer-events : none; z-index: 10; }
		img.red-rain { width: 70px; margin-bottom: -75px; margin-left: -10px; position: relative; margin-left: -30px; pointer-events : none; z-index: 10; }
	</style>
	
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
				<%@ include file="inc/top.jsp" %>
				<!-- Begin Page Content -->
                <div class="container-fluid">
                	<!-- // 컨텐츠 입력 start  -->
                	
                	
                	
                	<div class="modal" tabindex="-1" style="display:block; backdrop-filter: blur(5px);">
					  <div class="modal-dialog modal-lg">
					    <div class="modal-content">
					      <div class="modal-header">
					        <h5 class="modal-title">모의 시험 결과</h5>
					        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					      </div>
					      <div class="modal-body">
					        <table class='table table-bordered text-center'>
					        	<thead class="table-dark">
					        		<tr>
					        			<th>과목번호</th>
					        			<th>과목명</th>
					        			<th>정답수</th>
					        			<th>점수</th>
					        			<th>판정</th>
					        		</tr>
					        	</thead>
					        	<tbody>
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
					        		<%for(int i=0;i<test_sec.length;i++){ %>
						        		<tr>
						        			<td><%=test_sec[i]%></td>
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
					        		
					        	</tbody>
					        	<tfoot>
					        		<tr>
					        			<td colspan="3" class="table-warning fw-bolder">평균점수</td>
					        			<td> <%int average=0;
								        			   int sum = 0;
								        			   String judgment="";
								        				for(int i=0;i<testNum.length;i++){
								        					sum+=(userCorrect[i]*5);
								        				}
								        				average=sum/5;%><%=average%> 점</td>
					        			<td> <%if(average>=60){
										        			judgment="통과";%>
							        			<% }else if(average<60&&average>=40){%>
							        				<%judgment="불합격";%>
							        			<%}else{%>
							        				<%judgment="과락";%>
							        			<%} %>
						        				<%=judgment%> </td>
					        		</tr>
					        	</tfoot>
					        </table>
					      </div>
					      <div class="modal-footer">
					        <button type="button" class="btn-modal-close btn btn-secondary" data-bs-dismiss="modal">Close</button>
					      </div>
					    </div>
					  </div>
					</div>
                	
                	
                	<div class="row">
                		<div class="col-8 p-4" >
                			<div class="border p-5" style="height: 750px; overflow: hidden; overflow-y: auto;">
                				<h2> 자격증 기출문제 </h2>
	                			<hr/>
	                			<table class="table table-bordered text-center">
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
	                						<td><%
	                							if ( sess == null ) out.print(nulId);
	                							else out.print(sess);
	                							%></td>
	                						<td><%=title%></td>
        									<td><%=year%></td>
	                						<td><%
	                							for ( int i = 0 ; i < test_sec.length; i++ ) {
	                								if ( i == test_sec.length - 1 ) out.print(test_sec[test_sec.length-1]);
	                								else if ( i < test_sec.length - 1 ) out.print(test_sec[i]+", ");
	                							}
	                							%></td>
	                					</tr>
	                				</tbody>
	                			</table>
	                			
	                			<script>
	                				$(document).ready(function() {
	                					// 답안 선택시, 답안지 데이터 변경 
	                					$("#testList li.list-group-item").on("click", function() {
	                						// 선택한 항목 활성화 
	                						$(this).closest("ul").find("li.list-group-item").removeClass("active");
	                						$(this).addClass("active");
	                						// 문제번호 
	                						var _question_num = $(this).closest("ul").data("question-num");
	                						// 선택 답안 번호 
	                						var _select_num = $(this).index()+1;
	                						// 답안지 데이터 변경 
	                						$("#answer"+_question_num).val(_select_num);
	                					});
	                					
	                					// 오답노트 추가 
	                					
	                					$(".add-wrongNote").on("click", function() {
	        
	                							var idKey = "<%=sess%>";
	                							if(idKey==="null"){
	                								alert("로그인이 필요합니다.");
	                							}
	                							else{
										        var _html = "";
										        $(".add-wrongNote").each(function() {
										            if ($(this).is(":checked")) {
										                _html += "<span class='btn btn-secondary me-2'> " + $(this).val() + "번	 </span>";
										                // todo. name 설정
										                _html += "<input type='hidden' name='wrongnotes' value='" + $(this).val() + "'>";
										            }
										        });
										        $("#wrongNotePlate").html('').append(_html);
	                							}
										});
	                					// 모달창 닫기 이벤트 
	                					$(".btn-close, .btn-modal-close").on("click", function() {
	                						$(".modal").hide();
	                					});
	                				});
	                			</script>
	                			
	                			<div class="p-1" id="testList">
	                				<% 
						                ChoiceBean cbean = new ChoiceBean();
	                					ExplanationBean exBean = new ExplanationBean();
						                for (QuestionBean bean : qlist) { 
						                    // Retrieve choices for each question
						                    clist.addAll(choiceMgr.testChoice(bean.getQuestion_num()));
						                    expllist.addAll(explanationMgr.explanationlist(bean.getQuestion_num())); 
						             
						            %>
         							<% if(userCorrect[index]==bean.getQuestion_correct()){ %>
				           			<img class="red-circle" src="./img/circle.gif" alt="grading">
				            		<% } else { %>
				            		<img class="red-rain" src="./img/rain.gif" alt="grading">
				            		<%} %>
	                				<div class="card mb-3" >
										  <div class="card-header bg-dark text-white">
										    <%=bean.getQuestion_number()%>. <%= bean.getQuestion_content() %>
										    <small style="float: right;"> 정답률 : <%=bean.getQuestion_percent() %>% </small>
										  </div>
										  <!-- // 문제 번호를 태그 속성에 포함  -->
										  <ul class="list-group list-group-flush" data-question-num="<%=bean.getQuestion_num()%>">
										 	 <% for (ChoiceBean choice : clist) { %>
									    <li class="list-group-item <%= userCorrect[index] == choice.getChoice_number() ? "active" : "" %>">
									        <%= choice.getChoice_number() %>. <%= choice.getChoice_content()[0] %>
									    </li>
									<% } %>
										  </ul>
								    </div>
								    
									  <div class="accordion" id="accordionExample">
									    <div class="accordion-item">
									        <h2 class="accordion-header">
									            <!-- // id 번호 주의 -->
									            <button class="accordion-button collapsed fw-bolder" type="button" data-bs-toggle="collapse" data-bs-target="#collapse<%=bean.getQuestion_number()%>" aria-expanded="true" aria-controls="collapse<%=bean.getQuestion_number()%>">
									                <%=bean.getQuestion_number()%>번 해설 및 정답 보기
									            </button>
									        </h2>
									        <div id="collapse<%=bean.getQuestion_number()%>" class="accordion-collapse collapse">
									            <div class="accordion-body">
									            	<div>
												    <strong>정답 : <%=bean.getQuestion_correct()%> </strong>
												    </div>
												    <% 
												    // 동적으로 해당 문제에 대한 해설 가져오기
												    if (!expllist.isEmpty()) {
												        exBean = expllist.get(0); // 벡터가 비어있지 않을 때만 가져오도록 수정
												    }
												    %>
												    <!-- // 해당 문제에 대한 해설 출력 -->
												    <div>
												    <strong>해설 : <%=exBean != null ? exBean.getExplanation_content() : "" %></strong>
												    </div>
												</div>
	
									        </div>
									    </div>
									</div>
									<div class="ps-3 pe-3 pt-2 pb-2">
									            		<div class="form-check">
														  <input class="form-check-input add-wrongNote" type="checkbox" value="<%=index+1%>" id="flexCheckChecked2">
														  <label class="form-check-label" for="flexCheckChecked2"> 오답노트에 추가 </label>
														</div>
													  </div>
									<%
									// index 증가
									index++;
									// 클리어해줘야 다음 문제의 해설을 올바르게 가져올 수 있습니다.
									expllist.clear();
									clist.clear();
									} 
									%>
                					
                				</div>
                			</div>
                		</div>
                		<div class="col-4 p-4">
                			<div class="border p-5" style="height: 750px; overflow: hidden; overflow-y: auto;">
                				<h2> OMR 답안지 </h2>
                				<hr/>
                				<div class="p-2" style="overflow-y: auto;">
                					<form id="" name="" method="POST">
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
	                								<td><%=i+1%></td>
	                								<td>
	                									<input type="text" id="answer<%=i+1%>" name="" class="form-control form-control-sm border-0 bg-white text-center"
	                									 readonly value="<%= userCorrect[i] %>">
	                								</td>
	                							</tr>
	                							<%}%>
	                						</tbody>
	                					</table>
                					</form>
                					<button type="button" id="btn-correct-modal" class="btn btn-primary w-100"> 채점하기 </button>
                				</div>
                				<hr/>
                				<div class="p-1">
                					<h3> 오답노트 장바구니 </h3>
                					<form id="wrong_insert" name="wrong_insert" method="POST">
                						<input type="hidden" name="test_title" value="<%=title%>">
                						<input type="hidden" name="test_year" value="<%=year%>">
                						<% for (int i = 0; i < test_sec.length; i++) { %>
									        <input type="hidden" name="test_sess[]" value="<%= test_sec[i] %>">
									    <% } %>
	                					<div class="card mb-3">
										   <div class="card-body" id="wrongNotePlate"></div>
										</div>
										<button type="button" class="btn btn-primary w-100" id="wrong_button">저장하기</button>
									</form>
                				</div>
                				<script>
	                				$(document).ready(function() {
	                					// 로그인 버튼 이벤트
	                					$("#wrong_button").on("click", function() {
	      
	                							$("#wrong_insert").attr("action", "WrongInsert.jsp");
	                							$("#wrong_insert").submit();
	              
	                					});
	                				});
                				</script>
                			</div>
                	
                	
                	
                	<!-- // 컨텐츠 입력 end -->
                	<form id="test_grading" method="post">
					    <input type="hidden" name="sess" value="<%= sess %>">
					    <input type="hidden" name="test_title" value="<%= title %>">
					    <input type="hidden" name="test_year" value="<%= year %>">
					    <input type="hidden" name="url" value="<%=url%>">
					    <input type="hidden" name="questionCount" value="<%=questionCount%>">					    
					    <% for (int i = 0; i < test_sec.length; i++) { %>
					        <input type="hidden" name="test_sess[]" value="<%= test_sec[i] %>">
					    <% } %>
					    <% for (int i = 0; i < testNum.length; i++) { %>
					        <input type="hidden" name="test_num[]" value="<%= testNum[i] %>">
					    <% } %>
					    <% for (int i = 0; i < subject.length; i++) { %>
					        <input type="hidden" name="test_subject[]" value="<%= subject[i] %>">
					    <% } %>
					    <% for (int i = 0; i < questionCount; i++) { %>
					        <input type="hidden" id="choice_<%= i %>" name="choice<%= i %>" value="<%=userCorrect[i]%>">
					    <% } %>
					</form>
					<script>
					    $(document).ready(function() {
					        $("#testList li.list-group-item").on("click", function() {
					            // 선택한 항목 활성화
					            $(this).closest("ul").find("li.list-group-item").removeClass("active");
					            $(this).addClass("active");
					            // 문제 번호
					            var questionNum = $(this).closest("ul").data("question-num");
					            // 선택 답안 번호
					            var selectedNum = $(this).index() + 1;
					            // 해당 문제의 hidden input에 선택된 답안 번호 설정
					            $("#choice_" + (questionNum-1)).val(selectedNum);
					        });
					    });
					</script>
                </div>
            </div>
        </div>
    </div>
    <%for(int i=0; i<testNum.length;i++){
    		System.out.print(testNum.length+"/");
    	}%>
    <!-- // 사이드 메뉴 영역  -->
	<%@ include file="../inc/footer.jsp" %>
</body>
</html>