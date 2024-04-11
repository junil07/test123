<%@page import="table.TableListBean"%>
<%@page import="java.util.Vector"%>
<%@page import="table.TableListMgr"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
    TableListMgr mgr = new TableListMgr();
    Vector<TableListBean> vlist = mgr.getTableList();
    String sess=(String) session.getAttribute("idKey");
    
    int num=0, user_op=0, pay_op=0, likey_op=0, uploadfile_op=0, comment_op=0, newnum=vlist.size();
    String table="", tablename="";
%>


<html>
    <head>
    <%@ include file="../inc/head.jsp" %>
    <script type="text/javascript">
    
    function submitvalue(event){
         document.updateOp.action="UpdateTableProc.jsp";
         document.updateOp.submit();
      }
    
    function createtable(event) {
        let tableName = document.getElementById("table").value.trim();
        let boardName = document.getElementById("tablename").value.trim();

        if (!tableName || !boardName) {
            alert("테이블 이름과 게시판 이름을 모두 입력해주세요.");
            event.preventDefault(); // 폼 전송을 막음
        } else {
        	if(!confirm("게시판을 생성하시겠습니까?")){
        	}else{
        	    alert("생성 되었습니다.");
        	    document.createOp.action = "CreateTableProc.jsp";
                document.createOp.submit();
        	}
        }
    }
    
    function updateTable(event, i) {
        let tableName = document.getElementById("table" + i).value.trim();
        let boardName = document.getElementById("tablename" + i).value.trim();

        if (!tableName || !boardName) {
            alert("이름과 게시판 이름을 모두 입력해주세요.");
            event.preventDefault(); // 폼 전송을 막음
        } else {
        	if(!confirm("게시판을 수정하시겠습니까?")){
        	}else{
        	    alert("수정 되었습니다.");
        	    document.updateOp.action = "UpdateTableProc.jsp";
                document.updateOp.submit();
        	}
        }
    }
    
    function deleteTable(event) {
    	if(!confirm("게시판을 삭제하시겠습니까?")){
    	}else{
    	    alert("삭제 되었습니다.");
    	    document.updateOp.action = "DeleteTableProc.jsp";
            document.updateOp.submit();
    	}
    }
    
    </script>
    <style>

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
    	<!-- Page Wrapper -->
    <div id="wrapper">
        <!-- // 사이드 메뉴 영역  -->
		<%@ include file="../inc/menu.jsp" %>
        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">
            <!-- Main Content -->
            <div id="content" class="bg-white">
                <!-- // 최상단 Top 영역 -->
				<%@include file="../inc/top.jsp"%>
				<!-- Begin Page Content -->
                <div class="container-fluid">
                	<!-- // 컨텐츠 입력 start  -->
                	 <main>
			                <div id="mainBoard">
			                    <h2>Board Create</h2>
			                      <div class="table-responsive small">
			                      <form method="post" name="createOp">
			                        <table class="table table-striped table-sm">
			                          <thead>
			                            <tr>
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
			                                <tr>
			                                  <td><input type="text" style="width: 200px; height: 28px;" class="form-control" name="table" id="table" placeholder="" 
			                                        value="" required></td>
			                                  <td><input type="text" style="width: 200px; height: 28px;" class="form-control" name="tablename" id="tablename" placeholder="" 
			                                        value="" required></td>
			                                  <td style="padding-left:32px">
			                                      <input class="form-check-input" type="checkbox" name="user_op" id="user_op" value="user_op">
			                                  </td>
			                                  <td style="padding-left:32px">
			                                      <input class="form-check-input" type="checkbox" name="pay_op" id="pay_op" value="pay_op">
			                                  </td>
			                                  <td style="padding-left:32px">
			                                      <input class="form-check-input" type="checkbox" name="likey_op" id="likey_op" value="likey_op">
			                                  </td>
			                                  <td style="padding-left:32px">
			                                      <input class="form-check-input" type="checkbox" name="uploadfile_op" id="uploadfile_op" value="fileupload_op">
			                                  </td>
			                                  <td style="padding-left:32px">
			                                      <input class="form-check-input" type="checkbox" name="comment_op" id="comment_op" value="comment_op">
			                                  </td>
			                                  <td>
			                                      <button type="submit" class="btn btn-primary btn-sm" id="btn" onclick="createtable(event)">추가</button>    
			                                  </td>
			                                </tr>
			                        </form>
			                        
			                        
			                       
			                        </tbody>
			                        </table>
			                        </form>
			                      </div>
			                   </div>
			            
			                <div id="mainBoard">
			                    <h2>Board List</h2>
			                      <div class="table-responsive small">
			                      <form method="post" name="updateOp">
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
			                                if((vlist.size()==i)){
			                                    user_op=0; pay_op=0; likey_op=0; uploadfile_op=0; comment_op=0;
			                                }else{
			                                    TableListBean bean = vlist.get(i);
			                                    num = bean.getTablelist_num();
			                                    table = bean.getTablelist_table();
			                                    tablename = bean.getTablelist_name();
			                                    user_op = bean.getTablelist_user_op();
			                                    pay_op = bean.getTablelist_pay_op();
			                                    likey_op = bean.getTablelist_likey_op();
			                                    uploadfile_op = bean.getTablelist_fileupload_op();
			                                    comment_op = bean.getTablelist_comment_op();
			                                }
			                                
			                          %>
			                            
			                                <tr>
			                                  <td><%=i+1%></td>
			                                  <td><input type="text" style="width: 200px; height: 28px;" class="form-control" name="table<%=num%>" id="table<%=num%>" placeholder="" 
			                                        value="<%=table%>" required="required"></td>
			                                  <td><input type="text" style="width: 200px; height: 28px;" class="form-control" name="tablename<%=num%>" id="tablename<%=num%>" placeholder="" 
			                                        value="<%=tablename%>" required="required"></td>
			                                  <td style="padding-left:32px">
			                                      <input class="form-check-input" type="checkbox" name="user_op<%=num%>" id="user_op<%=num%>" value="user_op" 
			                                      <%if(user_op==1)%>checked="checked">
			                                  </td>
			                                  <td style="padding-left:32px">
			                                      <input class="form-check-input" type="checkbox" name="pay_op<%=num%>" id="pay_op<%=num%>" value="pay_op" 
			                                      <%if(pay_op==1)%>checked="checked">
			                                  </td>
			                                  <td style="padding-left:32px">
			                                      <input class="form-check-input" type="checkbox" name="likey_op<%=num%>" id="likey_op<%=num%>" value="likey_op" 
			                                      <%if(likey_op==1)%>checked="checked">
			                                  </td>
			                                  <td style="padding-left:32px">
			                                      <input class="form-check-input" type="checkbox" name="uploadfile_op<%=num%>" id="uploadfile_op<%=num%>" value="fileupload_op" 
			                                      <%if(uploadfile_op==1)%>checked="checked">
			                                  </td>
			                                  <td style="padding-left:32px">
			                                      <input class="form-check-input" type="checkbox" name="comment_op<%=num%>" id="comment_op<%=num%>" value="comment_op" 
			                                      <%if(comment_op==1)%>checked="checked">
			                                  </td>
			                                  <td>
			                                        <button type="submit" name="line" value="<%=num%>" class="btn btn-primary btn-sm" onclick="updateTable(event, <%=num%>)">수정</button>
			                                        <button type="submit" name="line" value="<%=num%>" class="btn btn-secondary btn-sm" onclick="deleteTable(event)">삭제</button>
			                                  </td>
			                                </tr>
			                              <%}//--for %>
			                        </form>
			                        
			                       
			                       
			                        </tbody>
			                        </table>
			                        </form>
			                      </div>
			                   </div>
			                
			        </main>
   	 			 </div>
            </div>
        </div>
    </div>
 <!-- // 사이드 메뉴 영역  -->
	<%@ include file="../inc/footer.jsp" %>
    	
       
    </body>
</html>
