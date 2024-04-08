<%-- 시험 일정의 제목을 수정하는 팝업 페이지 --%>

<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="scheduleMgr" class="project.ScheduleMgr"/>

<%
	String titlenum = request.getParameter("titlenum");
%>
<html>
	<head>
		
		<style>
			
			button {
				cursor: pointer;
			}
			
			button:hover {
				background: #bebebe;
			}
			
			.parantdiv {
				width: 100%;
				height: 100%;
				display: flex;
			    align-items: center;
			    justify-content: center;
			    flex-direction: column;
			}
			
			.btndiv {
				width: 100%;
				height: 50px;
				display: flex;
			    align-items: center;
			    justify-content: center;
			}
			
			.btndiv > button {
				width: 20%;
				height: 100%;
				border: none;
				margin-top: 10px;
			}
			
			.titleedit {
				border: none;
				background-color: #bebebe;
				width: 100%;
				height: 50%;
				margin-top: 25px;
			}
			
			.edit {
			    margin-right: 10;
			}
			
		</style>
		
	</head>
	<body>
		
		<form name="titlefrm">
			<div class="parantdiv">
				<h3 style="margin-top: 10px;">텍스트 편집</h3>
				<input class="titleedit" id="titletext" name="titletext" autocomplete="off">
				<div class="btndiv">
					<button class="edit" onclick="edit()">수정</button>
					<button class="close" onclick="self.close()">닫기</button>
				</div>
			</div>
			<input type="hidden" name="titlenum" value="<%=titlenum%>">
		</form>
		
		<script>
			
			window.onload = function() {
				document.getElementById("titletext").focus();
			}
			
			function edit() {
				
				var result = confirm("수정 하시겠습니까?");
				
				if ( result === true ) {
					
					document.titlefrm.action = "titlenameEditProc.jsp";
					document.titlefrm.submit();
					
				} else {
					
				}
				
			}
		
		</script>
		
	</body>
</html>