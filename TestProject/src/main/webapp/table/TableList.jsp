<%@page import="table.TableListMgr"%>
<%@page import="project.UtilMgr"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8"%>

<%
	TableListMgr mgr = new TableListMgr();
	int line = UtilMgr.parseInt(request, "line");
	List<String> opList = new ArrayList<>();
	int num = UtilMgr.parseInt(request, "num"+line);
	System.out.print(num);
	opList.add(request.getParameter("table"+line));
	opList.add(request.getParameter("tablename"+line));
	opList.add(request.getParameter("user_op"+line));
	opList.add(request.getParameter("pay_op"+line));
	opList.add(request.getParameter("likey_op"+line));
	opList.add(request.getParameter("uploadfile_op"+line));
	opList.add(request.getParameter("comment_op"+line));
	
	mgr.updateTable(opList, num);
	
%>
<html>
	<head>
		<script type="text/javascript">
		function submitvalue(){
	    	document.createOp.action="CreateTableProc.jsp";
	    	document.createOp.submit();
	    	}
	
		</script>
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
		        	<form method="post" name="createOp">
			        	<h3 style="font-weight: bold">[Option]</h3>
				         
				          <div class="my-3" id="checkOp_block">
				          	<h6 style="font-weight: bold">사용자 글쓰기 권한</h6>
				            <div class="form-check" id="checkOp">
				              <input class="form-check-input" type="radio" name="user_op" id="user_op" value="user_x" onchange="synchronizeOp(this, user_x)" checked="checked">
	            			  <label class="form-check-label" for="same-address">미사용</label>
				            </div>
				            <div class="form-check">
				              <input class="form-check-input" type="radio" name="user_op" id="user_op" value="user_o" onchange="synchronizeOp(this, user_o)">
	            			  <label class="form-check-label" for="same-address">사용</label>
				            </div>
				          </div>
				          
				          <div class="my-3" id="checkOp_block">
				          	<h6 style="font-weight: bold">유료글 기능</h6>
				            <div class="form-check" id="checkOp">
				              <input class="form-check-input" type="radio" name="pay_op" id="pay_op" value="pay_x" onchange="synchronizeOp(this, pay_x)" checked="checked">
	            			  <label class="form-check-label" for="same-address">미사용</label>
				            </div>
				            <div class="form-check">
				              <input class="form-check-input" type="radio" name="pay_op" id="pay_op" value="pay_o" onchange="synchronizeOp(this, pay_o)">
	            			  <label class="form-check-label" for="same-address">사용</label>
				            </div>
				          </div>
				          
				          <div class="my-3" id="checkOp_block">
				          	<h6 style="font-weight: bold">추천</h6>
				            <div class="form-check" id="checkOp">
				              <input class="form-check-input" type="radio" name="likey_op" id="likey_op" value="likey_x" onchange="synchronizeOp(this, likey_x)" checked="checked">
	            			  <label class="form-check-label" for="same-address">미사용</label>
				            </div>
				            <div class="form-check">
				              <input class="form-check-input" type="radio" name="likey_op" id="likey_op" value="likey_o" onchange="synchronizeOp(this, likey_o)">
	            			  <label class="form-check-label" for="same-address">사용</label>
				            </div>
				          </div>
				          
				          <div class="my-3" id="checkOp_block">
				          	<h6 style="font-weight: bold">첨부파일</h6>
				            <div class="form-check" id="checkOp">
				              <input class="form-check-input" type="radio" name="uploadfile_op" id="uploadfile_op" value="uploadfile_x" onchange="synchronizeOp(this, uploadfile_x)" checked="checked">
	            			  <label class="form-check-label" for="same-address">미사용</label>
				            </div>
				            <div class="form-check">
				              <input class="form-check-input" type="radio" name="uploadfile_op" id="uploadfile_op" value="uploadfile_o" onchange="synchronizeOp(this, uploadfile_o)">
	            			  <label class="form-check-label" for="same-address">사용</label>
				            </div>
				          </div>
				          
				          <div class="my-3" id="checkOp_block">
				          	<h6 style="font-weight: bold">댓글</h6>
				            <div class="form-check" id="checkOp">
				              <input class="form-check-input" type="radio" name="comment_op" id="comment_op" value="comment_x" onchange="synchronizeOp(this, comment_x)" checked="checked">
	            			  <label class="form-check-label" for="same-address">미사용</label>
				            </div>
				            <div class="form-check">
				              <input class="form-check-input" type="radio" name="comment_op" id="comment_op" value="comment_o" onchange="synchronizeOp(this, comment_o)">
	            			  <label class="form-check-label" for="same-address">사용</label>
				            </div>      
				          </div>
				          
				       	  <%for(int i = 0; i<opList.size(); i++) {%>
				       	  	op : <%=opList.get(i)%> <br>
				       	  <%} %>
				     	  
				     	  <input type="button" id="create" value="만들기" style="clear: left; margin-top: 60px; margin-left: 270px;"onclick="submitvalue()">
				     	  
				     	  <input type="hidden" name="user_op">
				     	  <input type="hidden" name="pay_op">
				     	  <input type="hidden" name="likey_op">
				     	  <input type="hidden" name="uploadfile_op">
				     	  <input type="hidden" name="comment_op">
				     </form>
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
				width: 900px;
			}
			#create_board_input {
				margin-top: 50px;
				margin-right: 85px;
				margin-left: 85px;
				margin-bottom: 30px;
				width: 750px;
			}
			#checkOp_block {
				margin-top: 20px;
				margin-bottom: 20px;
				margin-right: 20px;
				width: 350px;
				float: left;

			}
			#create_board_op {
				margin-top: 170px;
				margin-right: 85px;
				margin-left: 85px;
				margin-bottom: 50px;
				width: 750px;
			}
			
			#checkOp {
				width: 200px;

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