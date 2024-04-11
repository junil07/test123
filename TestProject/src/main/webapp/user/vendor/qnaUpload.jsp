<%-- qna 글 작성하는 페이지 --%>

<%-- 글자 수 제한 spellcheck 비 활성화 --%>

<%@ page contentType="text/html; charset=UTF-8"%>

<%
	
%>


<html>
	
	<head>
		
		<style>
			
			textarea {
				resize: none;
				overflow: hidden;
			}
			
			textarea:focus {
			    outline: none;
			}
			
			.parantdiv {
				width: 1100px;
				height: 1000px;
				border-top: solid;
				border-width: 2px;
				position: absolute;
				left: 500px;
				top: 150px;
				display: flex;
			    flex-direction: column;
			    align-items: center;
			}
			
			.marginbaby {
				margin-top: 20px;
			}
			
			.titleinputlan {
				width: 100%;
				height: 200px;
				border: solid;
				border-color: #bebebe;
				border-radius: 20px;
				display: flex;
				flex-direction: column;
			}
			
			.boardname {
				width: 30%;
			    height: 30px;
			    font-size: 20px;
			    border: none;
			    border-bottom: solid;
			    border-color: #bebebe;
			    border-width: 1px;
			    padding-left: 15px;
			    margin-top: 30px;
    			margin-left: 40px;
    			font-weight: 600;
			}
			
			.titlename {
				width: 80%;
			    font-size: 20px;
			    height: 60px;
			    padding: 18px;
			    margin-top: 30px;
				margin-left: 40px;
				border-radius: 15px;
			    background: #D8D8D8;
			    border: none;
			}
			
			.textinputlan {
				width: 100%;
				height: 600px;
				border: solid;
				border-color: #bebebe;
				display: flex;
			    align-items: center;
			    justify-content: center;
			}
			
			.contentinputtext {
				width: 90%;
    			height: 85%;
    			border: none;
    			font-size: 15px;
			}
			
			.uploadbtn {
			    width: 200px;
			    height: 50px;
			    border: none;
			    background: black;
			    color: white;
			    font-size: 20px;
			    font-weight: 300;
			}
			
			.uploadbtn:hover {
				cursor: pointer;
				background: gray;
			}
			
		</style>
		
	</head>
	
	<body>
		
		<form name="frm">
			
			<div class="parantdiv">
				
					<div class="titleinputlan marginbaby">
						
						<textarea class="boardname" spellcheck="false" readonly>QnA 게시판</textarea>
						<textarea id="noEnter" name="titlename" class="titlename" placeholder="제목을 입력하세요" maxlength="30"></textarea>
						
					</div>
					
					<div class="textinputlan marginbaby">
						
						<textarea id="contentid" name="content" class="contentinputtext" maxlength="1000" oninput="checkLimit()"></textarea>
						
					</div>
				
				<button type="button" class="uploadbtn marginbaby" onclick="qnaUpload()">등록</button>
				
			</div>
		
		</form>
		
		<script>
			
			document.getElementById("noEnter").addEventListener("keydown", function(event) {
			   
			    if (event.keyCode === 13) {
			        event.preventDefault();
			    }
			    
			});
			
			function checkLimit() {
				const textarea = document.getElementById("contentid");
				const maxlength = parseInt(textarea.getAttribute("maxlength"));
				const currentlength = textarea.value.length;
				
				if ( currentlength > maxlength ) {
					textarea.value = textarea.value.substring(0, maxlength);
					alert("글자 수는 1000자를 넘길 수 없습니다.");
				}
			}
			
			function qnaUpload() {
				
				var titlename = document.querySelector('.titlename');
				var content = document.querySelector('.contentinputtext');
				
				if ( titlename.value === "" ) {
					
					alert("제목을 입력하세요");
					return;
					
				} else if ( content.value === "" ) {
					
					alert("내용을 입력하세요");
					return;
					
				}
				
				var result = confirm("등록 하시겠습니까?");
				
				if ( result === true ) {
					
					document.frm.action = "proc/qnaUploadProc.jsp";
					document.frm.submit();
					
				} else {
					
					return;
					
				}
				
			}
			
		</script>
		
	</body>
	
</html>