<%--
	- 아이디를 업데이트 하는 팝업창 ㅇㅋ
	- 중복확인, 수정, 닫기 버튼 필요 ㅇㅋ
	- 본래의 아이디와 똑같은 걸로 중복확인을 누를 시 같은 아이디로는 수정할 수 없다는 메세지 출력
	- 중복확인 버튼은 누르면 적은 아이디가 중복이 되는지 확인
	- 중복확인을 하지 않았을 때 수정버튼을 누르면 중복확인을 해달라는 메세지 출력
	- 공백 혹은 특수문자 넣을 시 안된다는 빨간 글씨 출력
 --%>

<%@page import="project.UserBean"%>
<%@page import="java.util.Vector"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="userMgr" class="project.UserMgr"/>
<%
	String updateid = (String) session.getAttribute("updateid");
	String input1 = "";
	if ( updateid != null ) {
		input1 = updateid;
	}
	
	String sess = (String) session.getAttribute("idKey");
	Vector<UserBean> vlist = userMgr.showUserInfo(sess);
	String infoId = "";
	
	for ( int i = 0; i < vlist.size(); i++ ) {
		UserBean bean = vlist.get(i);
		infoId = bean.getUser_id();
	}
	
%>
<html>
	<head>
		<script>
			
			function updateId() {
				
				self.close();
			}
			
			
		</script>
		<style>
			.wrap {
				justify-content: space-between; 
				align-items: center; 
				flex-direction: column;
				display: inline-flex; 
				margin-top:50px; 
				width:500px; 
				height:150px; 
				border:solid black;
				border-width: 1px;
				padding: 10px;
			}
			
			.button1 {
				text-align: center;
				margin-top:50px;
				width: 500px;
			}
			
			.input1 {
				margin-left: 10px;
				width: 300px;
			}
			
			.update button{
				margin-right: 10px;
			}
			
			.update {
				margin: auto;
			}
			
			.hide {
				display: none;
			}
			
			.success1{
				font-color: red;
			}
			
		</style>
	</head>
	<body>
		
		<h2 style="position: relative; top: 10px">아이디 변경</h2>
		<form action="idUpdateProc.jsp" method="post" name="frm" onsubmit="return checkDuplicate()">
			<div class="wrap">
				<div class="update">
					<input name="username" class="input1" value="<%=input1%>">
					<button type="submit" onclick="checkDuplicate()">중복확인</button>
				</div>
				<div>
					<div class="success1 hide">사용할 수 있는 아이디입니다.</div>
					<div class="error1 hide">공백 없이 영어 또는 숫자만 가능합니다.</div>
				</div>
			</div>
			<div class="button1" align="center">
				<button type="submit" onclick="updateId()">수정</button>
				<button type="submit" onclick="self.close()">닫기</button>
			</div>
		</form>
		<%
			session.removeAttribute("updateid");
			System.out.println("\n 세션제거줄 \n");
			System.out.println("\n" + session.getAttribute("updateid") + "\n");
		%>
		<script>
			
			let elSuccessMessage = document.querySelector('.success1');
	        let elFailureMessage = document.querySelector('.error1');
			
	        function onlyNumberAndEnglish(str) { 							// 영어 대소문자 혹은 숫자만
	        	  return /^[A-Za-z0-9][A-Za-z0-9]*$/.test(str);				// 그 외에는 false 리턴
	        	}
	        
		function checkDuplicate() { 										// 중복확인 클릭시
				var inputValue = document.querySelector(".input1").value;	// 값을 가져옵니다
				if ( onlyNumberAndEnglish(inputValue) === false ) {			// 대소문자 혹은 숫자 이외라면
					elFailureMessage.classList.remove('hide');				// 공백 없이 영어 또는 숫자만 가능합니다 출력
					return false;											// 만약 틀렸다면 여기서 빠져나갑니다
				}
				return true;
			}
			
		</script>
	</body>
</html>

