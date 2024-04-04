<%@ page contentType="text/html; charset=UTF-8"%>
<%
	
%>
<html>
	<head>
		<script>
			
			function validateEmail(email) {
			    return /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/i.test(email);
			}
			
			function updateEmail() {
				
				let elEmail = document.querySelector('.email');
				let elValidateMessage = document.querySelector('.validate');
				
				if ( elEmail.value.length === 0 ) {
					alert("이메일을 입력해주세요");
					return;
				} else if ( validateEmail(elEmail.value) === false ) {
					alert("유효하지 않은 이메일 형식입니다.");
					return;
				}
				
				var result = confirm("정말 바꾸시겠습니까?");
				
				if ( result === true ) {
					document.frm.action = "emailUpdateProc.jsp";
					document.frm.submit();
				} else {
					
				}
				
			}
			
		</script>
		<style>
			.wrap {
				flex-direction: column;
				display: inline-flex; 
				margin-top:10px; 
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
				
			}
			
			.hide {
				display: none;
			}
			
			.validate {
				color: red;
			}
			
			.email {
				width: 300px;
			}
		</style>
	</head>
	<body>
		<h2 style="position: relative; top: 10px">이메일 변경</h2>
		<form action="" method="post" name="frm">
			<div class="wrap">
				<div class="update">
					<h3>새 이메일</h3>
					<input name="useremail" class="email" value="">
				</div>
				<div>
					<div class="validate hide">유효하지 않은 이메일 형식입니다.</div>
				</div>
			</div>
			<div class="button1" align="center">
				<button type="submit" onclick="updateEmail()">수정</button>
				<button type="submit" onclick="self.close()">닫기</button>
			</div>
		</form>
		<script>
			
			let elEmail = document.querySelector('.email');
			let elValidateMessage = document.querySelector('.validate');
			
			function validateEmail(email) {
			    return /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/i.test(email);
			}
			
			elEmail.onkeyup = function() {
				if ( elEmail.value.length !== 0 ) {
					if ( validateEmail(elEmail.value) === false ) {
						elValidateMessage.classList.remove('hide');
					} else {
						elValidateMessage.classList.add('hide');
					}
				} else {
					elValidateMessage.classList.add('hide');
				}
			}
			
		</script>
	</body>
</html>