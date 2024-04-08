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
		String url=request.getParameter("url");
		System.out.print(url);
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
		  </form> 
		  
		  <div class="r" ></div>
		  <img class="s" src="img/bottom.png" />
		  <img class="t" src="img/logo.png" />
		  <div class="u">
		    <div class="v"></div>
		    <div class="w"></div>
		  </div>
		</div>
	</body>
</html>