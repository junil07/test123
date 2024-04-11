<%-- qna 글 작성하는 페이지 --%>

<%-- 글자 수 제한 spellcheck 비 활성화 --%>

<%@ page contentType="text/html; charset=UTF-8"%>

<%
	String sess = (String) session.getAttribute("idKey");
%>


<html>
	
	<head>
		
		<%@ include file="../inc/head.jsp" %>
		<%@ include file="../inc/head.jsp" %>
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
				border-width: 2px;
				position: absolute;
				left: 500px;
				top: 200px;
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
		
		<div id="grandpadiv" style="position:fixed; width: 100%;">
		
			<div id="wrapper">
				
				<%@ include file="../inc/menu.jsp" %>
					
				<div id="content-wrapper" class="d-flex flex-column">
		            <!-- Main Content -->
		            <div id="content" class="bg-white">
		                <!-- // 최상단 Top 영역 -->
						<%@ include file="../inc/top.jsp" %>
						<!-- Begin Page Content -->
		                <div class="container-fluid">
		                	<!-- // 컨텐츠 입력 start  -->
		                	
		   	  			</div>
		   	  
		            </div>
		            
		        </div>
				
			</div>
		
		</div>
		
		<%@ include file="../inc/footer.jsp" %>
		
		<h1 style="position:absolute; left: 250px; top:100px;">유료 게시물 등록</h1>
		
		<form name="frm" method="post" action="paypostPost" enctype="multipart/form-data">
			
			<div class="parantdiv">
			    <div class="titleinputlan marginbaby">
			        <div class="container" style="margin-top:25px;">
			                <div class="form-group row">
			                    <label for="title" class="col-sm-2 col-form-label">제목</label>
			                    <div class="col-sm-10">
			                        <input type="text" class="form-control" id="title" name="title" maxlength="30" value="">
			                    </div>
			                </div>
			                <div class="form-group row">
							    <label for="pay" class="col-sm-2 col-form-label">금액</label>
							    <div class="col-sm-10">
							        <input type="number" class="form-control" id="pay" name="pay" maxlength="15" value="">
							    </div>
							</div>
			                <div class="form-group row">
			                    <label for="filename" class="col-sm-2 col-form-label">파일찾기</label>
			                    <div class="col-sm-10">
			                        <div class="custom-file">
			                            <input type="file" class="custom-file-input" id="filename" name="filename" onchange="displayFileName()">
			                            <label class="custom-file-label" for="filename" id="filenameLabel">파일 선택</label>
			                        </div>
			                    </div>
			                </div>

			        </div>
			    </div>
					
					<div class="textinputlan marginbaby">
						
						<textarea id="contentid" name="content" class="contentinputtext" maxlength="1000" oninput="checkLimit()"></textarea>
						
					</div>
				
				<button type="button" class="uploadbtn marginbaby" onclick="paypostUpload()">등록</button>
				
			</div>
			<input type="hidden" name="ip" value="<%=request.getRemoteAddr()%>">
			<input type="hidden" name="user" value="<%=sess%>">
			
		
		</form>
		
		<div style="position: fixed; width: 1500px; height: 70px; background: white; left: 230px;"></div>
		
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
			
			function paypostUpload() {
			    var titlename = document.querySelector('#title');
			    var content = document.querySelector('#contentid');
			    var pay = document.querySelector('#pay');
			    var filename = document.querySelector('#filename');
			    
			    if (titlename.value.trim() === "") {
			        alert("제목을 입력하세요");
			        return;
			    }
			    
			    if (pay.value.trim() === "") {
			        alert("가격을 입력하세요");
			        return;
			    }
			    
			    if (filename.value.trim() === "") {
			        alert("파일을 첨부하세요");
			        return;
			    }
			    
			    if (content.value.trim() === "") {
			        alert("내용을 입력하세요");
			        return;
			    }

			    var result = confirm("등록 하시겠습니까?");
			    
			    if (result) {
			        document.frm.submit();
			    }
			}
			
			function isNumberKey(evt) {
			    var charCode = (evt.which) ? evt.which : event.keyCode;
			    if (charCode < 48 || charCode > 57) {
			        evt.preventDefault();
			        return false;
			    }
			    return true;
			}
			
		    function displayFileName() {
		        const input = document.getElementById('filename');
		        const label = document.getElementById('filenameLabel');
		        const fileName = input.files[0].name;
		        label.innerHTML = fileName;
		    }
			
		</script>
		
	</body>
	
</html>