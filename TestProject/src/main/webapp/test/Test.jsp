<%@page import="project.ChoiceBean"%>
<%@page import="project.QuestionBean"%>
<%@page import="java.util.Vector"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="questMgr" class="project.QuestionMgr"/>
<jsp:useBean id="choiceMgr" class="project.ChoiceMgr"/>
<%
    String testNum[] = request.getParameterValues("test_num[]");
    Vector<QuestionBean> qlist = new Vector<QuestionBean>();
    Vector<ChoiceBean> clist = new Vector<ChoiceBean>();
    int choiceCount = choiceMgr.choiceCount(1);
    for (int i = 0; i < testNum.length; i++) {
        qlist.addAll(questMgr.testQuestion(testNum[i]));
    }
    int questionCount = qlist.size();
    int livequestCount = qlist.size();
    //System.out.println(questionCount);
%>
<!DOCTYPE html>
<html>
<head>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
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
    </script>
    <style>
        .container{
            position: absolute;
            top:5%;
            left:25%;
            width:1000px;
        }
        .line{
            border : 0px;
            border-top: 5px solid black;
        }
        
        
    </style>
</head>
<body>

<div class="container" style="border: 2px solid;left: 250px;position: absolute;">
    <h1 class="test_title">자격증 기출문제</h1>
    <hr class="line"/>
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
                 <span>남은 문항 : <em id="livequestCount"><%=livequestCount%></em> 문항</span>
                 <span>남은 문항 : <em><%=livequestCount%></em> 문항</span>
            </div>
            <div class="cbt_omr">
                <table border="1" align="center">
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
    	<%}%>
    </form>
    <script type="text/javascript">
    	function submitvalue(){
    	document.testGrading.action="Test_grading.jsp";
    	document.testGrading.submit();
    	}
	</script>
</div>
</body>
</html>