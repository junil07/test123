
<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="mailsend" class="mail.GmailSend"/>
<jsp:useBean id="userMgr" class="project.UserMgr"/>

<%
	
%>

<html>
	
	<head>
		
		<%@ include file="navi/head.jsp" %>
				
		<style>
			
			input {
				border: none;
				background: #f1f1f1;
			}
			
			input:focus {
				outline:3px solid #4e73df;
				transition: outline 0.05s ease;
			}
			
			.parantdiv {
				position: absolute;
			    left: 750px;
			    top: 180px;
			}
			
			.childdiv {
		        margin: auto;
			    border: solid;
			    border-color: #bccdff;
			    border-width: 1px;
			    width: 650px;
			    height: 650px;
			    display: flex;
			    justify-content: center;
			    align-items: center;
			}
			
			.hide {
				display: none;
			}
			
			.idhelp {
				resize: none;
				overflow: hidden;
				border: none;
				text-align: center;
				width: 100%;
				background: white;
			}
			
			.idhelp1 {
			    font-size: 30;
    			color: black;
			}
			
			.idhelp2 {
				color: gray;
			}
			
			.idinput, .pwdinput {
				margin-top: 30px;
			}
			
			.id_name, .id_email {
				float: right;
			    width: 350;
    			margin-right: 30;
			}
			
			.findbtn {
			    margin-top: 70px;
			    height: 50px;
			    border: none;
			    width: 90%;
			    margin-left: 10px;
			}
			
			.findbtn:hover {
				cursor: pointer;
				background: gray;
			}
			
			.selectbtn {
			    position: absolute;
			    left: 960px;
			    top: 770px;
			}
			
			.btn1, .btn2 {
				border: none;
				background: white;
				color: #bebebe;
			}
			
			.plus {
				border-bottom: 1px solid black;
				color: black;
			}
			
		</style>
		
	</head>
	
	<body>
		
		<div id="grandpadiv" style="position:fixed; width: 100%;">
		
			<div id="wrapper">
				
				<%@ include file="navi/menu.jsp" %>
					
				<div id="content-wrapper" class="d-flex flex-column">
		            <!-- Main Content -->
		            <div id="content" class="bg-white">
		                <!-- // 최상단 Top 영역 -->
						<%@ include file="navi/top.jsp" %>
						<!-- Begin Page Content -->
		                <div class="container-fluid">
		                	<!-- // 컨텐츠 입력 start  -->
		   	  			</div>
		   	  
		            </div>
		            
		        </div>
				
			</div>
		
		</div>
		
		<%@ include file="navi/footer.jsp" %>
		
		<div class="parantdiv">
			
			<div class="childdiv">
				
				<div class="idfinddiv" style="margin-bottom: 40px;">
					
					<textarea class="idhelp idhelp1" disabled>아이디 찾기</textarea>
					<textarea class="idhelp idhelp2" disabled>이름과 이메일을 입력해주세요</textarea>
					
					<div class="idinput">
						
						<label>이름</label>
						<input class="id_name" spellcheck="false">
						
					</div>
					
					<div class="pwdinput">
						
						<label>이메일</label>
						<input class="id_email" spellcheck="false">
						
					</div>
					
					<button class="findbtn" onclick="idfind()">찾기</button>
					
				</div>
				
				<div class="pwdfinddiv">
					
					<textarea class="idhelp idhelp1" disabled>비밀번호 재발급</textarea>
					<textarea class="idhelp idhelp2" disabled>아이디와 이메일을 입력해주세요</textarea>
					
					<div class="idinput">
						
						<label>아이디</label>
						<input class="id_name" spellcheck="false">
						
					</div>
					
					<div class="pwdinput">
						
						<label>이메일</label>
						<input class="id_email" spellcheck="false">
						
					</div>
					
					<button class="findbtn" onclick="pwdfind()">재발급</button>
					
				</div>
				
				
			</div>
				
		</div>
		
		<div class="selectbtn">
					
			<button class="btn1">아이디 찾기</button>
			<button class="btn2">비밀번호 찾기</button>
			
		</div>
		
		<form name="idfrm" method="post">
			
			<input type="hidden" name="name" value="">
			<input type="hidden" name="email" value="">
			
		</form>
		
		<form name="pwdfrm" method="post">
			
			<input type="hidden" name="id" value="">
			<input type="hidden" name="email" value="">
			
		</form>
		
    	<script>
    		
    		var idfindbtn = document.querySelector('.btn1');
    		var pwdfindbtn = document.querySelector('.btn2');
    		var idfinddiv = document.querySelector('.idfinddiv');
    		var pwdfinddiv = document.querySelector('.pwdfinddiv');
    		
    		idfindbtn.classList.add('plus');
    		pwdfindbtn.classList.remove('plus');
    		idfinddiv.classList.remove('hide');
    		pwdfinddiv.classList.add('hide');
    		
    		idfindbtn.onclick = function() {
    			
    			idfindbtn.classList.add('plus');
        		pwdfindbtn.classList.remove('plus');
        		idfinddiv.classList.remove('hide');
        		pwdfinddiv.classList.add('hide');
    			
    		}
    		
    		pwdfindbtn.onclick = function() {
    			
    			idfindbtn.classList.remove('plus');
        		pwdfindbtn.classList.add('plus');
        		idfinddiv.classList.add('hide');
        		pwdfinddiv.classList.remove('hide');
    			
    		}
    		
    		function idfind() {
    			
    			window.open("", "idfind", "width=650, height=290, left=650, top=400");
    			document.idfrm.target = "idfind";
    			document.idfrm.action = "";
    			document.idfrm.submit();
    			
    		}
    		
    		function pwdfind() {
    			
    			window.open("", "pwdfind", "width=650, height=290, left=650, top=400");
    			document.pwdfrm.target = "pwdfind";
    			document.pwdfrm.action = "";
    			document.pwdfrm.submit();
    			
    		}
    		
    	</script>
		
	</body>
	
</html>