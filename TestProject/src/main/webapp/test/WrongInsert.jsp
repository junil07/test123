<%@page import="java.util.HashSet"%>
<%@page import="java.util.Set"%>
<%@page import="project.WrongMgr"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="WrongUtil.WrongUtilMgr"%>
<jsp:useBean id="wrongMgr" class="project.WrongMgr"/>
<%
	String userId = (String)session.getAttribute("idKey");
	String title = request.getParameter("test_title");
	String test_year = request.getParameter("test_year");
	String test_sec[] = request.getParameterValues("test_sess[]");
	String question_num[] = request.getParameterValues("wrongnotes");
	String insQuestion_num="";
	
	for(int i=0;i<question_num.length; i++){
		if(i<question_num.length-1)
	insQuestion_num +=question_num[i]+",";
		else
	insQuestion_num +=question_num[i];
	}
	
	System.out.print(insQuestion_num);
	String instest_sec="";
	for(int i=0;i<test_sec.length;i++){
		if(i<test_sec.length-1)
	instest_sec += test_sec[i]+",";
		else
	instest_sec += test_sec[i];
	}
	
	
	boolean flag = wrongMgr.wrongDupli(userId, title, test_year, instest_sec, insQuestion_num);
	
	String updateQuestion_num="";
	if(flag==true){
	// 데이터베이스에 저장된 문제번호를 파싱하여 숫자 집합으로 변환
    Set<Integer> set1 = WrongUtilMgr.parseStringToSet(wrongMgr.updateQuestionNum(userId, title, test_year, instest_sec));

    // 새로 들어온 번호를 파싱하여 숫자 집합으로 변환
    Set<Integer> set2 = WrongUtilMgr.parseStringToSet(insQuestion_num);

    // 중복을 제거하고 합집합 생성
    Set<Integer> union = new HashSet<>(set1);
    union.addAll(set2);
    
    updateQuestion_num = String.join(",",union.toString());
    
    updateQuestion_num = updateQuestion_num.replace("[", "").replace("]", "");
    System.out.println(updateQuestion_num);
	}
	if(flag==false){
		wrongMgr.wrongInsert(userId, title, test_year, instest_sec, insQuestion_num);
	}else if(flag==true){
		wrongMgr.updateQuestion(updateQuestion_num, userId, title, test_year, instest_sec);
	}
%>
<script>
	alert("오답노트에 추가되었습니다.");
	history.back();
</script>