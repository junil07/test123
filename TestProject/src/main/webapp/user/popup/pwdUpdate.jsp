<%@ page contentType="text/html; charset=UTF-8"%>
<%
	
%>
<html>
	<head>
		<script>
			
			function noSpace(str) {
			    return /^[^\s]*$/.test(str);
			}
		
			function updatePwd() {
				let elPassWord = document.querySelector('.password');					// 패스워드 입력칸
				let elPassWordRetype = document.querySelector('.password-retype');		// 패스워드 확인 입력칸
				
				// 비밀번호가 입력되지 않았거나 공백이 존재하거나 일치하지 않을 시에 수정되지 않음
				if ( elPassWord.value.length === 0 || elPassWordRetype.value.length === 0 ) {
					alert("비밀번호를 입력해주세요");
					return;
				} else if ( noSpace(elPassWord.value) === false || noSpace(elPassWordRetype.value) === false ) {
					alert("공백이 존재합니다");
					return;
				} else if ( elPassWord.value !== elPassWordRetype.value ) {
					alert("비밀번호가 일치하지 않습니다");
					return;
				}
				
				// 재차 확인
				var result = confirm("정말 바꾸시겠습니까?");
				
				// 확인 누를 시 db수정하러 떠납니다
				if ( result === true ) {
					document.frm.action = "pwdUpdateProc.jsp";
					document.frm.submit();
				} else {				// 이거는 취소 시
					
				}
			}
			
			
		</script>
		<style>
			.wrap {
				flex-direction: column;
				display: inline-flex; 
				margin-top:10px; 
				width:500px; 
				height:250px; 
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
				
			}
			
			.hide {
				display: none;
			}
			
			.space, .space1, .Mismatch{
				color: red;
			}
			
		</style>
	</head>
	<body>
		
		<h2 style="position: relative; top: 10px">새 비밀번호 설정</h2>
		<form action="" method="post" name="frm">
			<div class="wrap">
				<div class="update">
					<h3>새 비밀번호</h3>
					<input type="password" name="userpwd" class="password" value="">
				</div>
				<div>
					<div class="space hide">공백이 존재합니다.</div>
				</div>
				<div class="update">
					<h3>새 비밀번호 확인</h3>
					<input type="password" name="userpwd1" class="password-retype" value="">
				</div>
				<div>
					<div class="Mismatch hide">비밀번호가 다릅니다.</div>
					<div class="space1 hide">공백이 존재합니다.</div>
				</div>
			</div>
			<div class="button1" align="center">
				<button type="submit" onclick="updatePwd()">수정</button>
				<button type="submit" onclick="self.close()">닫기</button>
			</div>
		</form>
		
		<script>
			// input태그들 정보 불러오기 
			let elPassWord = document.querySelector('.password');
			let elPassWordRetype = document.querySelector('.password-retype');
			
			// 각종 숨겨둔 div태그들 정보 불러오기(에러메세지)
			let elMismatchMessage = document.querySelector('.Mismatch');
			let elSpaceMessage = document.querySelector('.space');
			let elSpaceMessage1 = document.querySelector('.space1');
			
			// 비밀번호에 스페이스 들어갈 시 false 반환
			function noSpace(str) {
			    return /^[^\s]*$/.test(str);
			}
			
			// 비밀번호 입력칸과 비밀번호 확인 입력칸이 같은가?
			function isMatch(password1, password2) {
				return password1 === password2;
			}
			
			// 입력칸에 값이 입력될 때
			elPassWord.onkeyup = function() {							// 첫 번째 비밀번호 칸이 바뀔 때
				if ( elPassWord.value.length !== 0 ) {					// 비밀번호 칸이 뭐라도 적혀 있다면
					if ( noSpace(elPassWord.value) === false ) {		// 공백 있다면
						elSpaceMessage.classList.remove('hide');		// 공백 있다는 메세지 출력
					} else {											// 공백 없으면
						elSpaceMessage.classList.add('hide');			// 공백 있다는 메세지 숨김
					}
				} else {
					elSpaceMessage.classList.add('hide');
				}
			}
			
			// 비밀번호 확인 칸에 값이 입력될 때
			elPassWordRetype.onkeyup = function() {
				if ( elPassWord.value.length !== 0 ) {							// 뭐라도 적혀있으면
					if ( isMatch(elPassWord.value, elPassWordRetype.value) ) {	// 입력된 두 비밀번호가 같다면
						elMismatchMessage.classList.add('hide');				// 에러메세지 숨김
					} else {													// 다르면
						elMismatchMessage.classList.remove('hide');				// 에러메세지 나옴
					}
				} else {														// 아무 것도 안 적혀있으면
					elMismatchMessage.classList.add('hide');					// 에러메세지 숨김
				}
			}
			
		</script>
		
	</body>
</html>
