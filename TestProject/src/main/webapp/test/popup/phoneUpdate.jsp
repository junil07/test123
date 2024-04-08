<%-- 번호 업데이트 --%>

<%@ page contentType="text/html; charset=UTF-8"%>
<%
	
%>
<html>
	<head>
		<script>
			
			function noSpace(str) {
			    return /^[^\s]*$/.test(str);
			}
			
			function onlyNumbers(str) {
			    return /^[0-9]*$/.test(str);
			}
			
			function updatePhone() {
				
				let elPhone = document.querySelector('.phone');
				let elSpaceMessage = document.querySelector('.space');
				let elOnlyNumberMessage = document.querySelector('.onlynumber');
				
				if ( elPhone.value.length === 0 ) {
					alert("번호를 입력해주세요");
					return;
				} else if ( noSpace(elPhone.value) === false ) {
					alert("공백이 존재합니다");
					return;
				} else if ( onlyNumbers(elPhone.value) === false ) {
					alert("숫자만 입력해주세요");
					return;
				}
				
				var result = confirm("정말 바꾸시겠습니까?");
				
				if ( result === true ) {
					document.frm.action = "phoneUpdateProc.jsp";
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
			
			.space, .onlynumber{
				color: red;
			}
			
		</style>
	</head>
	<body>
		<h2 style="position: relative; top: 10px">번호 변경</h2>
		<form action="" method="post" name="frm">
			<div class="wrap">
				<div class="update">
					<h3>새 번호</h3>
					<input name="userphone" class="phone" value="">
				</div>
				<div>
					<div>- 없이 입력해주세요.</div>
					<div class="space hide">공백이 존재합니다.</div>
					<div class="onlynumber hide">숫자만 입력해주세요.</div>
				</div>
			</div>
			<div class="button1" align="center">
				<button type="submit" onclick="updatePhone()">수정</button>
				<button type="submit" onclick="self.close()">닫기</button>
			</div>
		</form>
		<script>
			
			let elPhone = document.querySelector('.phone');
			let elSpaceMessage = document.querySelector('.space');
			let elOnlyNumberMessage = document.querySelector('.onlynumber');
			
			function noSpace(str) {
			    return /^[^\s]*$/.test(str);
			}
			
			function onlyNumbers(str) {
			    return /^[0-9]*$/.test(str);
			}
			
			elPhone.onkeyup = function() {
				if ( elPhone.value.length !== 0 ) {
					if ( noSpace(elPhone.value) === false ) {
						elSpaceMessage.classList.remove('hide');
					} else if ( onlyNumbers(elPhone.value) === false ) {
						elOnlyNumberMessage.classList.remove('hide');
					} else {
						elSpaceMessage.classList.add('hide');
						elOnlyNumberMessage.classList.add('hide');
					}
				} else {
					elSpaceMessage.classList.add('hide');
					elOnlyNumberMessage.classList.add('hide');
				}
			}
			
		</script>
	</body>
</html>