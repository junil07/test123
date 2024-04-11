<%-- 이름 업데이트 --%>

<%@ page contentType="text/html; charset=UTF-8"%>
<%
	
%>
<html>
	<head>
		<script>
			
			function noSpace(str) {
			    return /^[^\s]*$/.test(str);
			}
			
			function updateName() {
				let elName = document.querySelector('.name')
				let elSpaceMessage = document.querySelector('.space');
				
				if ( elName.value.length === 0 ) {
					alert("이름을 입력해주세요");
					return;
				} else if ( noSpace(elName.value) === false ) {
					alert("공백이 존재합니다");
					return;
				}
				
				var result = confirm("정말 바꾸시겠습니까?");
				
				if ( result === true ) {
					document.frm.action = "nameUpdateProc.jsp";
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
			
			.space{
				color: red;
			}
			
		</style>
	</head>
	<body>
		<h2 style="position: relative; top: 10px">이름 변경</h2>
		<form action="" method="post" name="frm">
			<div class="wrap">
				<div class="update">
					<h3>새 이름</h3>
					<input name="username" class="name" value="">
				</div>
				<div>
					<div class="space hide">공백이 존재합니다.</div>
				</div>
			</div>
			<div class="button1" align="center">
				<button type="submit" onclick="updateName()">수정</button>
				<button type="submit" onclick="self.close()">닫기</button>
			</div>
		</form>
		<script>
			
			let elName = document.querySelector('.name');
			let elSpaceMessage = document.querySelector('.space');
			
			function noSpace(str) {
			    return /^[^\s]*$/.test(str);
			}
			
			elName.onkeyup = function() {
				if ( elName.value.length !== 0 ) {
					if ( noSpace(elName.value) === false ) {
						elSpaceMessage.classList.remove('hide');
					} else {
						elSpaceMessage.classList.add('hide');
					}
				} else {
					elSpaceMessage.classList.add('hide');
				}
			}
			
		</script>
	</body>
</html>