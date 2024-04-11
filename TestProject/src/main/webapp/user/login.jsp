<!-- login.jsp -->

<%--
	사용자 로그인이 된 상태로 관리자 로그인을 할 시, 관리자의 세션 날려버리기 반대 또한 동일(뒤로가기 해서 로그인 들어갔을 때 한정) 
	1. 사용자 세션이 존재할 때 관리자 로그인 시도하면 세션 날려버리기
	2. 혹은 뒤로가기 버튼으로 로그인 창 이동 시 리로드로 스크립트 활성화로 튕기게 하기
	고민중!!
--%>

<%@ page contentType="text/html; charset=UTF-8"%>

<%
	String beforeurl = request.getParameter("url");
	System.out.println("\n --- login.jsp --- \n" + beforeurl);
%>

<html>
<head>
	<link href="css/style.css" rel="stylesheet" type="text/css">
	<link href="css/login.css" rel="stylesheet">
    <script>

	<%
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
			location.href = "myInfo.jsp";
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

			document.frm.action = "../admin/managerLoginProc.jsp";
			document.frm.url.value = "<%=beforeurl%>";
			document.frm.action = "proc/managerLoginProc.jsp";

			document.frm.submit();
		} else {
			document.frm.url.value = "<%=beforeurl%>";
			document.frm.action = "proc/loginProc.jsp";
			document.frm.submit();
		}
		
	}
	
    </script>
    
    
    
</head>
	<body>
		<div class="center" >
		  <div class="a" >로그인</div>
		  <form action="" method="post" name="frm">

			  <div class="b">
			    <button id="loginbtn" class="c" type="submit" onclick="login()">로그인</button>  -->
			    <div class="d" ></div>
			  </div>
			  
			  <div class="e" >아이디 비밀번호를 입력하세요.</div>
			  
			  <div class="f" >
			  <!-- <div style="width: 67px; height: 0px; left: 108px; top: 248px; position: absolute; border: 1px black solid"></div> -->
			  로그인
			  </div>
			  
			  <input id="id" class="g" type="text" placeholder="아이디" name="id" value="">
			  <input class="h" type="password" placeholder="비밀번호" name="pwd" value="">
		
		  <button class="i" onclick="signIn()">회원가입</button>
		
		   
		  <div class="j" >
		    <div class="k" ></div>
		    <div class="l" ></div>
		  </div>
		  
		  <div class="m" ></div>
		  <div class="n" ></div>
		  <div class="o" >비밀번호 찾기</div>
		  <div class="p" >
			  <input id="saveIdCheckbox" class="q" type="checkbox" name="idSave" value="checked">아이디 저장
		  </div>
		  <div class="managerLogin">
		  <input class="managerCheck" type="checkbox" name="managerIdSave" id="managerIdChk" value="">관리자 로그인
		  </div>

		  
		  <input type="hidden" name="url" value="">
		  
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
	
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script>
		$(document).ready(function() { // 문서 전부 로드 되었을 때 시작하는 방법인듯
		    // 아이디 저장 체크박스 상태 초기화
		    var savedId = getCookie('savedId');
		    if (savedId) {
		        $('#id').val(savedId);
		        $('#saveIdCheckbox').prop('checked', true);
		    }
		
		    // 관리자 로그인 체크박스 상태 초기화
		    var isAdminLogin = getCookie('isAdminLogin');
			    if (isAdminLogin) {
			        $('#managerIdChk').prop('checked', true);
		    }
			
		    // 로그인 버튼 눌릴 때
		    $('#loginbtn').click(function() {
		    	
		    	if ( $('#saveIdCheckbox').is(':checked') ) {
		    		setCookie('savedId', $('#id').val(), 365); // 365일 동안 유효한 쿠키 설정
		    	} else if ( !$('#saveIdCheckbox').is(':checked') ) {
	    			deleteCookie('savedId');
		    	}
		    	
		    });
			
		    // 관리자 로그인 체크박스 이벤트 핸들러
		    $('#managerIdChk').change(function() {
		        if ($('#managerIdChk').is(':checked')) {
		            setCookie('isAdminLogin', 'true', 365); // 365일 동안 유효한 쿠키 설정
		        } else {
		            deleteCookie('isAdminLogin');
		        }
		    });
		});
		
		// 쿠키 설정 함수
		function setCookie(name, value, days) {
		    var expires = "";
		    if (days) {
		        var date = new Date();
		        date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
		        expires = "; expires=" + date.toUTCString();
		    }
		    document.cookie = name + "=" + (value || "") + expires + "; path=/";
		}
		
		// 쿠키 가져오기 함수
		function getCookie(name) {
		    var nameEQ = name + "=";
		    var ca = document.cookie.split(';');
		    for (var i = 0; i < ca.length; i++) {
		        var c = ca[i];
		        while (c.charAt(0) == ' ') c = c.substring(1, c.length);
		        if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length, c.length);
		    }
		    return null;
		}
		
		// 쿠키 삭제 함수
		function deleteCookie(name) {
		    document.cookie = name + "=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/;";
		}
	</script>
	<%
		System.out.println("\n -- login.jsp2 -- \n" + beforeurl + "\n -- login.jsp2 -- \n");
	%>
</html>