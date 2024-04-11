<%-- 회원가입 --%>
<%-- 
	- 해야할 거
	1. 아이디 옆에 중복확인 버튼 만들어서 사용 가능한 아이디인지 구별
 --%>

<%@ page contentType="text/html; charset=UTF-8"%>
<%
	String idchkresult = request.getParameter("idDuplicateChkreturn");
	String idreturn = request.getParameter("idreturn");
	String namereturn = request.getParameter("namereturn");
	String pwdreturn = request.getParameter("pwdreturn");
	String pwdretypereturn = request.getParameter("pwdretypereturn");
	String emailreturn = request.getParameter("emailreturn");
	String phonereturn = request.getParameter("phonereturn");
	
	String id = "", name = "", pwd = "", pwdretype = "", email = "", phone = "";
	
	if ( idreturn != null ) {
		id = idreturn;
		name = namereturn;
		pwd = pwdreturn;
		pwdretype = pwdretypereturn;
		email = emailreturn;
		phone = phonereturn;
	}
	
	String text = "동의?";
	
%>
<html>
	<head>
		<style>
			
			.d1 {
				width: 1200px;
				height: 650px;
				position: absolute;
				left: 500px;
				top: 150px;
				display: flex;
			}
			
			.d2 {
				width: 70%;
				height: 100%;
				align-content: center;
			}
			
			.d3 {
				width: 30%;
				height: 100%;
			}
			
			.registerinput {
				display:flex;
			    width: 80%;
			    height: 6%;
			    margin: 40px;
			    border-radius: 10px;
			    border: solid 1px rgba(139, 139, 139, 0.8);
			    box-shadow: 0px 4px 7px rgba(0, 0, 0, 0.25);
			    padding-left: 15px;
    			font-size: 20px;
			}
			
			.mismatch, .space{
				position: absolute;
				left: 90px;
				color: red;
			}
			
			.space {
				top: 343px;
			}
			
			.mismatch {
				top: 421px;
			}
			
			.hide {
				display: none;
			}
			
			.regiid {
				width: 65%;
				margin-right: 165px;
			}
			
			.duplicatechk {
				position: absolute;
				left: 680px;
				top: 145px;
			}
			
			.registerbtn {
				display: block;
				position: absolute;
				float: left;
				width: 120px;
				padding: 0;
				margin: 10px 20px 10px 0;
				font-weight: 600;
				text-align: center;
				line-height: 50px;
				color: #fff;
				border-radius: 5px;
				transition: all 0.2s;
				background: #9d9d9d;
				left: 360px;
				bottom: -70px;
			}
			
			.registerbtn:hover {
				background: #2c2c2c;
			}
			
			.test3 > * {
    			display: block;
			}
			
			.test3_1 {
			    width: 90%;
			    height: 18%;
			    resize: none;
			}
			
			.test3_1_1 {
				border: none;
				pointer-events: none;
				margin-left: 15px;
				width: 280px;
			}
			
			.test3_1_ {
				display: flex;
				justify-content: space-between;
			}
			
		</style>
	</head>
	<body>
		<div class="test d1">
			<div class="test d2" align="center">
				<h2>회원가입</h2>
				<form action="" method="post" name="idfrm">
					<input class="registerinput regiid" placeholder="아이디" name="registerid" value="<%=id%>">
					<button class="duplicatechk" onclick="duplicateCheck()">중복확인</button>
					<input class="registerinput reginame" placeholder="이름" name="registername" value="<%=name%>">
					<input type="password" class="registerinput regipwd" placeholder="비밀번호" name="registerpwd" value="<%=pwd%>">
					<div class="space hide">공백이 존재합니다</div>
					<input type="password" class="registerinput regipwdretype" placeholder="비밀번호 확인" name="registerpwdretype" value="<%=pwdretype%>">
					<div class="mismatch hide">비밀번호가 일치하지 않습니다.</div>
					<input class="registerinput regiemail" placeholder="이메일" name="registeremail" value="<%=email%>">
					<input class="registerinput regiphone" placeholder="전화번호" name="registerphone" value="<%=phone%>">
					<input class="duplicateResult" type="hidden" value="<%=idchkresult%>">
					<input class="idreturn" type="hidden" value="<%=idreturn%>">
				</form>
				<button type="button" class="registerbtn" onclick="registerUser()">회원가입</button>
			</div>
			<div class="test d3" align="center">
				<div class="test3">
					<h3>이용약관 동의</h3>
					<textarea class="test3_1" readonly><%=text%></textarea>
					<div class="test3_1_">
						<input class="test3_1_1" value="약관에 동의합니다." readonly>
						<input type="checkbox" id="checkbox1" style="margin-right: 18px;">
					</div>
					
				</div>
				<div class="test3">
					<h3>서비스 약관동의</h3>
					<textarea class="test3_1" readonly><%=text%></textarea>
					<div class="test3_1_">
						<input class="test3_1_1" value="서비스 약관에 동의합니다." readonly>
						<input type="checkbox" id="checkbox2" style="margin-right: 18px;">
					</div>
				</div>
				<div class="test3">
					<h3>개인정보 수집 및 이용동의</h3>
					<textarea class="test3_1" readonly><%=text%></textarea>
					<div class="test3_1_">
						<input class="test3_1_1" value="개인정보 수집 및 이용에 동의합니다." readonly>
						<input type="checkbox" id="checkbox3" style="margin-right: 18px;">
					</div>
				</div>
			</div>
		</div>
		<script src="js/register.js"></script>
	</body>
</html>