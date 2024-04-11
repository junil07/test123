<!-- login.jsp -->

<%--
	사용자 로그인이 된 상태로 관리자 로그인을 할 시, 관리자의 세션 날려버리기 반대 또한 동일(뒤로가기 해서 로그인 들어갔을 때 한정) 
	1. 사용자 세션이 존재할 때 관리자 로그인 시도하면 세션 날려버리기
	2. 혹은 뒤로가기 버튼으로 로그인 창 이동 시 리로드로 스크립트 활성화로 튕기게 하기
	고민중!!
--%>

<%@ page contentType="text/html; charset=UTF-8"%>

<html>
<head>
	<link href="style.css" rel="stylesheet" type="text/css">
	<link href="login.css" rel="stylesheet">
    <script src="script.js"></script>
    <script>

	<%
		String idkey = (String) session.getAttribute("idKey");
		String title = request.getParameter("test_title");
		String year = request.getParameter("test_year");
		String test_sec[] = request.getParameterValues("test_sess[]");
	    String testNum[] = request.getParameterValues("test_num[]");
	    String subject[] = request.getParameterValues("test_subject[]");
	    int testNumCount=testNum.length;
	    System.out.print(request.getParameter("questionCount"));
	
	    String strquestionCount = request.getParameter("questionCount");
	    int questionCount = Integer.parseInt(strquestionCount);
	    System.out.print(questionCount);
	    //System.out.println(questionCount);
			int[] userCorrect = new int[questionCount];
			
			for (int i = 0; i < questionCount; i++) {
		        String userCor = request.getParameter("choice" + (i));
		        if (userCor != null && !userCor.isEmpty() && !"null".equals(userCor)) {
		            userCorrect[i] = Integer.parseInt(userCor);
		            System.out.print(userCorrect[i]);
		        } else {
		            userCorrect[i] = 0;
		        }
		    }
	    
		String url=request.getParameter("url");
    	String sess = (String) session.getAttribute("idKey");
		String managerSess = (String) session.getAttribute("adminKey");	
		
	    
    	if ( sess != null ) {
	%>
    		alert("이미 로그인이 되었습니다");
    		location.href = "myInfo.jsp";
	<%
    	} else if ( managerSess != null ) {
	%>
			alert("이미 관리자 로그인이 되었습니다");
			location.href = "test2.jsp";
	<%
    	}
	%>
	
	function signIn() {
		document.frm.action = "register.jsp";
	}
	
	function login() {
		
		var managerChk = document.getElementById("managerIdChk");
		
		var value1 = managerChk.checked ? '1' : '0';
		
		if ( value1 === '1' ) {
			document.frm.action = "managerLoginProc.jsp";
			document.frm.submit();
		} else {
			document.frm.action = "loginProc.jsp";
			document.test_grading.submit();
			document.frm.submit();
		}
		
	}
	
    </script>
</head>
	<body>
		<div class="center" >
		  <div class="a" >로그인</div>
		  <form action="" method="post" name="frm">
		  	  <input type="hidden" name="url" value="<%=url%>">
			  <div class="b">
			    <button class="c" type="submit" onclick="login()">로그인</button>  -->
			    <div class="d" ></div>
			  </div>
			  
			  <div class="e" >아이디 비밀번호를 입력하세요.</div>
			  
			  <div class="f" >
			  <!-- <div style="width: 67px; height: 0px; left: 108px; top: 248px; position: absolute; border: 1px black solid"></div> -->
			  로그인
			  </div>
			  
			  <input class="g" type="text" placeholder="아이디" name="id" value="">
			  <input class="h" type="password" placeholder="비밀번호" name="pwd" value="">
		
		  <button class="i" onclick="signIn()">회원가입</button>
		
		   
		  <div class="j" >
		    <div class="k" ></div>
		    <div class="l" ></div>
		  </div>
		  
		  <div class="m" ></div>
		  <div class="n" ></div>
		  <div class="o" >아이디/비밀번호 찾기</div>
		  <div class="p" >
			  <input class="q" type="checkbox" name="idSave" value="checked">아이디 저장
		  </div>
		  <div class="managerLogin">
		  <input class="managerCheck" type="checkbox" name="managerIdSave" id="managerIdChk" value="">관리자 로그인
		  </div>
		 
		  
		  <div class="r" ></div>
		  <img class="s" src="img/bottom.png" />
		  <img class="t" src="img/logo.png" />
		  <div class="u">
		    <div class="v"></div>
		    <div class="w"></div>
		  </div>
		</div>
		<form id="test_grading" name="test_grading" method="post">
					    <input type="hidden" name="sess" value="<%= idkey %>">
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
	</body>
</html>