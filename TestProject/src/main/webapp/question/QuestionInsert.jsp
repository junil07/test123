<%@page import="java.util.Vector"%>
<%@page contentType="text/html;charset=UTF-8"%>
<% request.setCharacterEncoding("UTF-8");%>
<%@ page import="project.ChoiceBean" %>
<%@ page import="project.QuestionBean" %>
<jsp:useBean id="Questionmgr" class="project.QuestionMgr"/>
<jsp:useBean id="Questionbean" class="project.QuestionBean"/>
<jsp:useBean id="Choicemgr" class="project.ChoiceMgr"/>
<jsp:useBean id="Choicebean" class="project.ChoiceBean"/>
<jsp:setProperty name="Questionbean" property="*" />
<jsp:setProperty name="Choicebean" property="*" />
<%boolean flag = Questionmgr.insertQuestion(Questionbean);%>

<% 
		int num = Questionmgr.maxPk();
	
		Choicebean.setChoice_question_num(num);
		Choicebean.setChoice_number(1);
        boolean flagg = Choicemgr.insertChoice(Choicebean);
    
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> 문제 입력하기</title>
</head>
<body>
<h2>정보처리 기사</h2>
<form action="QuestionInsert.jsp" method="post">
    <!-- 문제 테스트 번호 -->
     <label for="question_test_num">문제 고유 번호 :</label>
    <input type="text" id="question_test_num" name="question_test_num" required><br>
   
   <!-- 문제 번호 -->
    <label for="question_number">문제번호 :</label>
    <input type="text" id="question_number" id="choice_question_number" name="question_number" required><br>

    <!-- 문제 내용 -->
    <label for="question_content">문제 내용 :</label><br>
    <textarea id="question_content" name="question_content" rows="4" cols="50" ></textarea><br>

	<!-- (1) 보기 내용  -->
	<label for="choice_content" id=choice_num>(1) 보기 내용 :</label><br>
	<textarea id="choice_content" name="choice_content" rows="4" cols="50" required></textarea><br>
	
	<!-- (2)보기 내용  -->
	<label for="choice_content">(2) 보기 내용 :</label><br>
	<textarea id="choice_content" name="choice_content" rows="4" cols="50" required></textarea><br>
	
	<!-- (3) 보기 내용  -->
	<label for="choice_content">(3) 보기 내용 :</label><br>
	<textarea id="choice_content" name="choice_content" rows="4" cols="50" required></textarea><br>
	
	<!-- (4) 보기 내용  -->
	<label for="choice_content">(4) 보기 내용 :</label><br>
	<textarea id="choice_content" name="choice_content" rows="4" cols="50" required></textarea><br>

    <!-- 문제 정답 -->
    <label for="question_correct">문제 정답 :</label>
    <input type="text" id="question_correct" name="question_correct"><br>

    <!-- 문제 파일 -->
    <label for="question_file">문제 첨부파일 :</label>
    <input type="text" id="question_file" name="question_file"><br>

    <!-- 문제 파일 크기 -->
    <label for="question_filesize"> 파일 사이즈 :</label>
    <input type="text" id="question_filesize" name="question_filesize"><br>

    <!-- 문제 백분율 -->  
    <label for="question_percent">문제 정답률 :</label>
    <input type="text" id="question_percent" name="question_percent"><br>

    <!-- 완료  버튼 -->
    
    <input type="submit" value="완료" >
</form>
</body>
</html>
