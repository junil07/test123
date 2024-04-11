<%@page import="java.text.DecimalFormat"%>
<%@page import="project.ExplanationBean"%>
<%@page import="project.TestBean"%>
<%@page import="project.ChoiceBean"%>
<%@page import="project.QuestionBean"%>
<%@page import="project.WrongBean"%>
<%@page import="java.util.Vector"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="wrongMgr" class="project.WrongMgr"/>
<jsp:useBean id="testMgr" class="project.TestMgr"/>
<jsp:useBean id="questMgr" class="project.QuestionMgr"/>
<jsp:useBean id="choiceMgr" class="project.ChoiceMgr"/>
<jsp:useBean id="explanationMgr" class="project.ExplanationMgr"/>

<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../inc/session.jsp" %>
<%
	String url = "WrongQuestionList.jsp";
	String strIndex = request.getParameter("testIndex");
	int index = Integer.parseInt(strIndex);
	String title = request.getParameter("title"+index);
	String testYear = request.getParameter("test_year"+index);
	String test_cat = request.getParameter("test_cat"+index);
	String[] strArray1 = test_cat.split(","); // 쉼표로 문자열을 분할하여 문자열 배열 생성
	int[] testCat = new int[strArray1.length]; // int 배열 생성
	String test_num[] = new String[strArray1.length];
	// 문자열 배열을 순회하면서 각 요소를 int로 변환하여 int 배열에 담기
	for (int i = 0; i < strArray1.length; i++) {
		testCat[i] = Integer.parseInt(strArray1[i]);
		test_num[i] = testMgr.testNum(title, testYear, testCat[i]);
	}
	
	String question_num = wrongMgr.updateQuestionNum(sess, title, testYear, test_cat);
	String[] strArray = question_num.split(","); // 쉼표로 문자열을 분할하여 문자열 배열 생성
	int[] questionNum = new int[strArray.length]; // int 배열 생성

	// 문자열 배열을 순회하면서 각 요소를 int로 변환하여 int 배열에 담기
	for (int i = 0; i < strArray.length; i++) {
		questionNum[i] = Integer.parseInt(strArray[i].trim());
	}
	
	Vector<QuestionBean> qlist = new Vector<QuestionBean>();
    Vector<ChoiceBean> clist = new Vector<ChoiceBean>();
    Vector<TestBean> tlist = new Vector<TestBean>();
    Vector<ExplanationBean> expllist = new Vector<ExplanationBean>();
	
    for (int i = 0; i < test_num.length; i++) {
    	tlist.addAll(testMgr.getTestlist(test_num[i]));
    	for(int j=0;j<questionNum.length;j++){
        	qlist.addAll(questMgr.wrongQuestion(test_num[i],questionNum[j]));
    	}
    }
%>

<!DOCTYPE html>
<html>
<head>
	<!-- // 공통 Head  -->
	<%@ include file="../inc/head.jsp" %>
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
                	<div class="p-1" id="testList">
	                				<% 
						                ChoiceBean cbean = new ChoiceBean();
	                					ExplanationBean exBean = new ExplanationBean();
	                					int index1 = 0;
	                					int x=0;
						                for (QuestionBean bean : qlist) { 
						                    // Retrieve choices for each question
						                    clist.addAll(choiceMgr.testChoice(bean.getQuestion_num()));
						                    expllist.addAll(explanationMgr.explanationlist(bean.getQuestion_num())); 
						            %>
	                				<div class="card mb-3" >
										  <div class="card-header bg-dark text-white">
										    <%=bean.getQuestion_number()%>. <%=bean.getQuestion_content()%>
										    <small style="float: right;"> 정답률 : <%=bean.getQuestion_percent() %>% </small>
										  </div>
										  <!-- // 문제 번호를 태그 속성에 포함  -->
										  <ul class="list-group list-group-flush" data-question-num="<%=bean.getQuestion_number()%>">
										 	 <% for (ChoiceBean choice : clist) { %>
											    <li class="list-group-item">
											        <%= choice.getChoice_number() %>. <%= choice.getChoice_content()[0] %>
											    </li>
											<% } %>
										  </ul>
								    </div>
								    <%
								    	index1++; // 인덱스 변수 증가
								        // Clear choices for next question
								        clist.clear();
									%>
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
												        exBean = expllist.get(x); // 벡터가 비어있지 않을 때만 가져오도록 수정
												    }
												    %>
												    <!-- // 해당 문제에 대한 해설 출력 -->
												    <div>
												    <strong>해설 : <%=exBean != null ? exBean.getExplanation_content() : "" %></strong>
												    <%x++; %>
												    </div>
										        
										      </div>
										    </div>
								    	</div>
								      </div>
								      <div class="ps-3 pe-3 pt-2 pb-2">
					            	
									  </div>
									<%} %>
                					
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
</body>      
</html>