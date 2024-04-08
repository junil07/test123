
<%@page import="table.TableListBean"%>
<%@page import="java.util.Vector"%>
<%@page import="table.TableListMgr"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	TableListMgr mgr = new TableListMgr();
	Vector<TableListBean> vlist = mgr.getTableList();
%>


<html>
	<head>
	<script type="text/javascript">
		function submitvalue(event){
	    	document.createOp.action="TableList.jsp";
	    	document.createOp.submit();
	    	}
	
	</script>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
	
	<style>
		#mainBoard {
			width: 1000px;
			margin-top: 30px;
			margin-left: 260px;
		}
		td{
			align:center;
			text-align:center;
		}
		th{
			text-align:center;
		}
	</style>
</head>
	<body>
		<main>
			<form method="post" name="createOp">
				<div id="mainBoard">
					<h2>Board</h2>
				      <div class="table-responsive small">
				        <table class="table table-striped table-sm">
				          <thead>
				            <tr>
				              <th>No</th>
				              <th style="width: 200px;">테이블 이름</th>
				              <th style="width: 200px;">게시판 이름</th>
				              <th>회원 접근</th>
				              <th>유료</th>
				              <th>추천</th>
				              <th>첨부파일</th>
				              <th>댓글</th>
				              <th>관리</th>
				              
				            </tr>
				          </thead>
				          <tbody>
				          <%for(int i = 0; i<vlist.size() ; i++) {
				          	TableListBean bean = vlist.get(i);
				          	int num = bean.getTablelist_num();
				          	String table = bean.getTablelist_table();
				          	String tablename = bean.getTablelist_name();
				          	int user_op = bean.getTablelist_user_op();
				          	int pay_op = bean.getTablelist_pay_op();
				          	int likey_op = bean.getTablelist_likey_op();
				          	int uploadfile_op = bean.getTablelist_uploadfile_op();
				          	int comment_op = bean.getTablelist_comment_op();
				          %>
				          	
					            <tr>
					              <td><%=i+1%><input type="hidden" name="num<%=i%>" id="num" value="<%=num%>"></td>
					              <td><input type="text" style="width: 200px; height: 28px;" class="form-control" name="table<%=i%>" id="tableName" placeholder="" value="<%=table%>" required></td>
					              <td><input type="text" style="width: 200px; height: 28px;" class="form-control" name="tablename<%=i%>" id="tableName" placeholder="" value="<%=tablename%>" required></td>
					              <td style="padding-left:32px">
					              	<input class="form-check-input" type="checkbox" name="user_op<%=i%>" id="user_op" value="user_op" 
					              	<%if(user_op==1)%>checked="checked">
					              </td>
					              <td style="padding-left:32px">
					              	<input class="form-check-input" type="checkbox" name="pay_op<%=i%>" id="pay_op" value="pay_op" 
					              	<%if(pay_op==1)%>checked="checked">
					              </td>
					              <td style="padding-left:32px">
					              	<input class="form-check-input" type="checkbox" name="likey_op<%=i%>" id="likey_op" value="likey_op" 
					              	<%if(likey_op==1)%>checked="checked">
					              </td>
					              <td style="padding-left:32px">
					              	<input class="form-check-input" type="checkbox" name="uploadfile_op<%=i%>" id="uploadfile_op" value="uploadfile_op" 
					              	<%if(uploadfile_op==1)%>checked="checked">
					              </td>
					              <td style="padding-left:32px">
					              	<input class="form-check-input" type="checkbox" name="comment_op<%=i%>" id="comment_op" value="comment_op" 
					              	<%if(comment_op==1)%>checked="checked">
					              </td>
					              <td>
					                <button type="submit" name="line" value="<%=i%>" class="btn btn-primary btn-sm" onclick="submitvalue(event)">수정</button>
					                <button type="button" class="btn btn-secondary btn-sm">복사</button>
					              </td>
					            </tr>
							  <%}//--for %>
				           
				          </tbody>
				        </table>
				      </div>
				   </div>
				</form>
		</main>
	</body>
</html>