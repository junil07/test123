<%@ page contentType="text/html; charset=UTF-8"%>

<%

%>
<html>
	<head>
		<%--bootstrap css --%>
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
		
		<main>
			<div id="var">
					
					<ul class="menu">
						<%--로고 --%>
						<li><a href="">
							<img class="z" src="https://ih1.redbubble.net/image.538022342.9685/flat,750x,075,f-pad,750x1000,f8f8f8.u2.jpg" />
						</a></li>
						<div id="var_title">Discover</div>
						<li><a href="">게시판 관리</a></li>
						<li><a href="">유저 관리</a></li>
						<li><a href="">어쩌구</a></li>
						<li><a href="">저쩌구</a></li>
					</ul>
				
			</div>
			<div id="board">
				<div class="text-center">
	      			<h1 style="font-weight: bold">게시판 관리</h1>
	      		</div>
	      		
	      		<hr class="my-4" style="clear: left;">
	      		
	      		<div id="create_board_input">
		      		<%--테이블 이름 입력--%>
		    		<div style="float: left; margin-right:20px;">
		              <label for="tableName" class="form-label">테이블 이름</label>
		              <input type="text" style="width:350px;" class="form-control" id="tableName" placeholder="" value="" required>
		              <div class="invalid-feedback">
		                Valid first name is required.
		              </div>
		            </div>
		            <%--게시판 이름 입력--%>
		            <div style="float: left;">
		              <label for="tableName" class="form-label">게시판 이름</label>
		              <input type="text" style="width:350px;" class="form-control" id="tableName" placeholder="" value="" required>
		              <div class="invalid-feedback">
		                Valid first name is required.
		              </div>
		            </div>
		        </div>
		        
		        <div id="create_board_op">
		        	<h3 style="font-weight: bold">[Option]</h3>
			         
			          <div class="my-3" id="checkOp_block">
			          	<h6 style="font-weight: bold">사용자 글쓰기 권한</h6>
			            <div class="form-check" id="checkOp">
			              <input type="checkbox" class="form-check-input" id="same-address1">
            			  <label class="form-check-label" for="same-address">미사용</label>
			            </div>
			            <div class="form-check">
			              <input type="checkbox" class="form-check-input" id="same-address">
            			  <label class="form-check-label" for="same-address">사용</label>
			            </div>
			          </div>
			          
			          <div class="my-3" id="checkOp_block">
			          	<h6 style="font-weight: bold">유료글 기능</h6>
			            <div class="form-check" id="checkOp">
			              <input type="checkbox" class="form-check-input" id="same-address1">
            			  <label class="form-check-label" for="same-address">미사용</label>
			            </div>
			            <div class="form-check">
			              <input type="checkbox" class="form-check-input" id="same-address">
            			  <label class="form-check-label" for="same-address">사용</label>
			            </div>
			          </div>
			          
			          <div class="my-3" id="checkOp_block">
			          	<h6 style="font-weight: bold">추천</h6>
			            <div class="form-check" id="checkOp">
			              <input type="checkbox" class="form-check-input" id="same-address1">
            			  <label class="form-check-label" for="same-address">미사용</label>
			            </div>
			            <div class="form-check">
			              <input type="checkbox" class="form-check-input" id="same-address1">
            			  <label class="form-check-label" for="same-address">사용</label>
			            </div>
			          </div>
			          
			          <div class="my-3" id="checkOp_block">
			          	<h6 style="font-weight: bold">첨부파일</h6>
			            <div class="form-check" id="checkOp">
			              <input type="checkbox" class="form-check-input" id="same-address1">
            			  <label class="form-check-label" for="same-address">미사용</label>
			            </div>
			            <div class="form-check">
			              <input type="checkbox" class="form-check-input" id="same-address">
            			  <label class="form-check-label" for="same-address">사용</label>
			            </div>
			            <div class="form-check">
			              <input type="checkbox" class="form-check-input" id="same-address">
            			  <label class="form-check-label" for="same-address">사용</label>
			            </div>
			          </div>
			          
			          <div class="my-3" id="checkOp_block">
			          	<h6 style="font-weight: bold">댓글</h6>
			            <div class="form-check" id="checkOp">
			              <input type="checkbox" class="form-check-input" id="same-address">
            			  <label class="form-check-label" for="same-address">미사용</label>
			            </div>
			            <div class="form-check">
			              <input type="checkbox" class="form-check-input" id="same-address">
            			  <label class="form-check-label" for="same-address">사용</label>
			            </div>
			          </div>
		        </div>
    		</div>
    		
    		
            
            
            
            

	        
            
		</main>
		<style>
			#var {
				width:240px;
				background-color:white;
				border-right:1px solid #ddd;
				position:fixed;
				height:100%;
				clear:both;
			}
			#var_title {
				width: 80%;
				margin:15px;
				background-color:white;
				font-weight:bold;
			}
			#board {
				margin-left: 250px;
				margin-right: 20px;
				margin-top: 50px;
			}
			#create_board_input {
				margin-top: 50px;
				margin-right: 85px;
				margin-left: 85px;
				margin-bottom: 30px;
			}
			#checkOp_block {
				margin-top: 20px;
				margin-bottom: 20px;
				clear: left;
			}
			#create_board_op {
				margin-top: 170px;
				margin-right: 85px;
				margin-left: 85px;
			}
			
			#checkOp {
				width: 200px;
				float: left;
			}
			
			board1 {
				left:20px;
				background-color:#CF0;
			}
			ul { list-style: none;
    			 padding-left: 0px;
 			}
			.menu {}
			.menu li {
				
			}
			
			.menu li a {
			height:30px;
			line-height:30px;
			disploay:block;
			padding:0 20px;
			font-size:12px;
			color:#555;
			}
			
			.z {
				width: 191px; 
				height: 170px; 
				left: 30px; 
				top: 10px; 
			}
		</style>
		<script>
		
		</script>
	</body>      
</html>