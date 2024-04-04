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
    <title>Question 리스트</title>
</head>
<body>
<h1>정보처리 기사 </h1>
	<form action= "QuestionInsert.jsp">
	<tr>
		<td align="center">
		<input type="submit" value="문제 입력하기">
		</td>
	</tr>
</form>
<form action= "ChoiceUpdate.jsp">
	<tr>
		<td align="center">
		<input type="submit" value="문제 수정하기">
		</td>
	</tr>
</form>
<%
Vector<QuestionBean> vlist = mgr.questionBeans();
Vector<ChoiceBean> clist = cmgr.choiceBeans();

for(int i = 0; i < vlist.size(); i++) {
    QuestionBean bean = vlist.get(i);
%>
    <div>
        <p>---------------<%= bean.getQuestion_number() %>번 :<%= bean.getQuestion_content() %>-----------------------</p>
<%
    // 해당 문제 번호에 해당하는 보기들을 불러옴
    for(int j = 0; j < clist.size(); j++) {
        ChoiceBean cbean = clist.get(j);
        // 보기의 문제 번호가 현재 문제 번호와 같을 때만 보기를 출력
        if(bean.getQuestion_num() == cbean.getChoice_question_num()) {
%>
            <p>보기 번호: <%= cbean.getChoice_number() %></p>
            <p>보기 내용: <%= cbean.getChoice_content() %></p>
<%
        }
    }
%>
        <p>정답: <%= bean.getQuestion_correct() %></p>
        <p>문제 첨부파일: <%= bean.getQuestion_file() %></p>
        <p>문제 첨부파일 사이즈: <%= bean.getQuestion_filesize() %></p>
        <p>정답률: <%= bean.getQuestion_percent() %></p>
    </div>
<%
}
%>

</body>
</html>
