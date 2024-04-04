<%@ page import="java.util.Vector" %>
<%@ page import="project.QuestionBean" %>
<%@ page import="project.QuestionMgr" %>
<%@ page import="project.ChoiceBean" %>
<%@ page import="project.ChoiceMgr" %>

<%@ page contentType="text/html; charset=UTF-8" %>
<jsp:useBean id="mgr" class="project.QuestionMgr"/>
<jsp:useBean id="cmgr" class="project.ChoiceMgr"/>

<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
    <title>문제 수정</title>
    
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js" integrity="sha384-BBtl+eGJRgqQAUMxJ7pMwbEyER4l1g+O15P+16Ep7Q9Q+zqX6gSbd85u4mG4QzX+" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
</head>
<body>

	<div class="container p-3">
		<h1 class="mt-3 mb-3">문제 수정하기</h1>
		<div class="row"> 
			<div class="col-8">
				<form id="updateForm" name="updateForm" method="post" action="ChoiceUpdate.jsp">
					<%
					// 문제 목록
					Vector<QuestionBean> qlist = mgr.questionBeans();
					Vector<ChoiceBean> alist = cmgr.choiceBeans();
					for ( int i = 0 ; i < qlist.size() ; i++ ) {
						QuestionBean bean = qlist.get(i);
					%>
					<div class="card mb-3">
						<div class="card-header">
							<div class="row">
								<input type="hidden" name="question_number_<%=i%>" value="<%=bean.getQuestion_number()%>">
							    <span class="col-auto p-2"><%=bean.getQuestion_number()%>.</span> 
							    <input type="text" class="form-control col-auto" value="<%= bean.getQuestion_content() %>" style="width: 90%;" >
							</div>
						</div>
						<ul class="list-group list-group-flush">
							<% 
							for ( int j = 0 ; j < alist.size() ; j++ ) {
								ChoiceBean cbean = alist.get(j);
								if(bean.getQuestion_number() == cbean.getChoice_question_num()) {
									String[] choiceContents = cbean.getChoice_content();
									StringBuilder combinedContent = new StringBuilder();
									if (choiceContents != null) {
									    for (String content : choiceContents) {
									        combinedContent.append(content).append(" "); // 각 요소를 공백으로 구분하여 추가
									    }
									}
							%>
						   	<li class="list-group-item">
						   		<div class="row">
						   			<input type="hidden" name="" value="<%= cbean.getChoice_number() %>"> 
							   		<span class="col-auto p-2"><%= cbean.getChoice_number() %>.</span> 
								    <input type="text" class="form-control col-auto" value="<%= combinedContent.toString().trim() %>" style="width: 90%;">
						   		</div>
						   	</li>
						   	<% } } %>
						</ul>
						<div class="card-footer">
						    <!-- // 정답, 정답률  -->
						    <div class="row text-end">
						    	<div class="col-3 p-2">정답</div>
						    	<div class="col-3">
						    		<input type="text" class="form-control" name="" value="<%= bean.getQuestion_correct() %>">
						    	</div>
						    	<div class="col-3 p-2">정답률(%)</div>
						    	<div class="col-3">
						    		<input type="text" class="form-control" name="" value="<%= bean.getQuestion_percent() %>">
						    	</div>
						    </div>
						    <!-- // 첨부파일  -->
						    <% //if ( bean.getQuestion_file() != null ) { %>
						    <hr/>
						    <div class="">
						    	<div class="row mb-2"> 
						    		<label class="col-auto"> 첨부파일 </label>
						    		<div class="col-auto border-bottom"> 
						    			<%= bean.getQuestion_file() %>
						    			<small> ( 파일크기 : <%= bean.getQuestion_filesize() %> bytes ) </small> 
					    			</div>
						    	</div>
						    </div>
						    <% //} %>
						</div>
					</div>
					<%} %>
					<input type="submit" value="문제 수정">
				</form>
				
			</div>
			<div class="col-4">
				<div class="border" style="min-height: 300px;" >



					&nbsp;
				</div>
			</div>
		</div>
		
	</div>




<form action="ChoiceUpdate.jsp" method="post">


<%
Vector<QuestionBean> vlist = mgr.questionBeans();
Vector<ChoiceBean> clist = cmgr.choiceBeans();

for(int i = 0; i < vlist.size(); i++) {
    QuestionBean bean = vlist.get(i);
%>
    <div>
    
        <input type="text" id="question_number" id="choice_question_number" name="question_number" value="<%= bean.getQuestion_number() %>" required size="2"> 번 :
        <input type="text" name="question_content" value="<%= bean.getQuestion_content() %>" required size="50"><br>

        
<%
    // 해당 문제 번호에 해당하는 보기들을 불러옴
    for(int j = 0; j < clist.size(); j++) {
        ChoiceBean cbean = clist.get(j);
        // 보기의 문제 번호가 현재 문제 번호와 같을 때만 보기를 출력
        if(bean.getQuestion_number() == cbean.getChoice_question_num()) {
%>
        <div>
           <!-- 보기 번호 --> <input type="text" name="choice_number" value="<%= cbean.getChoice_number() %>" size="2">
           <!-- 보기 내용 (배열을 사용) -->
        <%String[] choiceContents = cbean.getChoice_content();
				StringBuilder combinedContent = new StringBuilder();
				if (choiceContents != null) {
				    for (String content : choiceContents) {
				        combinedContent.append(content).append(" "); // 각 요소를 공백으로 구분하여 추가
				    }
				}
%>
<input type="text" name="choice_content" value="<%= combinedContent.toString().trim() %>" size="50">

           

        </div>
<%
        }
    }
%>
       <div>
           정답 : <input type="text" name="choice_number" value="<%= bean.getQuestion_correct() %>" size="2">
           정답률 : <input type="text" name="choice_content" value=" <%= bean.getQuestion_percent() %>" size= "2">
        </div>
       
        
        <p>문제 첨부파일: <%= bean.getQuestion_file() %></p>
        <p>문제 첨부파일 사이즈: <%= bean.getQuestion_filesize() %></p>
        
    </div>
<%
}
%>



</form>

</body>
</html>
