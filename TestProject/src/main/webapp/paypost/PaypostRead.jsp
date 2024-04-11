<%-- QnA 안에 페이지 --%>

<%@page import="project.UtilMgr"%>
<%@page import="project.PaypostCommentBean"%>
<%@page import="project.PaypostBean"%>
<%@page import="java.util.Vector"%>
<%@page import="project.UtilMgr"%>
<%@page import="project.Paypost_fileuploadBean"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="PaypostMgr" class="project.PaypostMgr"/>
<jsp:useBean id="commentMgr" class="project.PaypostCommentMgr"/>
<jsp:useBean id="userMgr" class="project.UserMgr"/>
<jsp:useBean id="buyMgr" class="project.BuyListMgr"/>

<%
   String sess = (String) session.getAttribute("idKey");
   String sessManager = (String) session.getAttribute("adminKey");
   int num = Integer.parseInt( request.getParameter("num") );
   String title = "", user = "", content = "", date = "";
   int good = 0, pay = 0;
   Vector<PaypostBean> vlist = PaypostMgr.getPayposts(num);
   
   String nowPage = request.getParameter("nowPage");
   String numPerPage = request.getParameter("numPerPage");
   String keyField = request.getParameter("keyField");
   String keyWord = request.getParameter("keyWord");

   
   String comment_userid = "", comment_username = "", comment_content = "", comment_date = "";
   
   for ( int i = 0; i < vlist.size(); i++ ) {
		PaypostBean bean = vlist.get(i);
		title = bean.getPaypost_title();
		content = bean.getPaypost_content();
		date = bean.getPaypost_date();
		good = bean.getPaypost_good();   
		user = bean.getPaypost_user_id();
		pay = bean.getPaypost_pay();
	}
   
   String username = userMgr.getName(user);
   int userGrade = userMgr.getGrade(user);
   
   PaypostBean pbean = PaypostMgr.getlist(num);
   Paypost_fileuploadBean fbean = PaypostMgr.getFile(num);

   
   String imgsrc = "";
   
   String imgsrc1 = "https://i.namu.wiki/i/3t4jrWPmNFqyrDs3xUJnCNE6-wbc069FEO33" +
             "_OFcenoatrkXStgCN0_fSwB1be_aWoaLe_QDQXn3vIx_OAbvhP_u6Jg" +
             "s01Rx0gd536bG7H8xeEJTbV1lNdtfZOpwYwimASvgbM17fyQSyztcfhwTBw.webp";
      
   String imgsrc2 = "https://i.namu.wiki/i/8nDVP1V6uDTtF_DSqd8k3VgdmmW3alDTj0i6jTQ" +
             "1iJXBoS3bfjR5ov63R-ch2vhAy1XRM21dWRIOUL1WwkNKOfNF3zNZq3h" +
             "VeVkD6WnlIJLPxSdbkVnl_SNnzk9Wkta0T0HXmTz2mrcXfZPxMxet3w.webp";
      
   String imgsrc3 = "https://i.namu.wiki/i/c49u7Vr0uQfxNPOS9YwS9u5u_yaz7QlBrbMqz6" +
             "Vv3sz6HyVNS5Af769-y_06L_rX8IN9vtKOI91_nu3GxI9a6VTOMoLnZ2A" +
             "oFJRnDRe53mUrtwfjjA4blJ9Bza3jhCAVPawUibCIA1sB9YT32dvkXA.webp";
   
   int commentCount = commentMgr.getCountComment(num);
   int count = commentMgr.getOriginCount(num);
   String username1 = userMgr.getName(sess);
   
   String filename = fbean.getPaypost_fileupload_name();
   if(filename!=null&&!filename.equals(""))
       filename += "." + fbean.getPaypost_fileupload_extension();
    int filesize = fbean.getPaypost_fileupload_size();
    //읽어온 게시물을 수정, 삭제를 위해서 세션에 저장
    session.setAttribute("pbean", pbean);

%>

<html>
   
   <head>
      
      <%@ include file="../inc/head.jsp" %>
      <link href="css/paypostInPage.css" rel="stylesheet">
      
      <style>
         
         body {
            color: black;
         }
         
         img {
            vertical-align: baseline;
         }
         
         .price-info {
			    margin-top: 20px;
			    font-size: 18px;
			}
			
			.price-label {
			    font-weight: bold;
			    margin-right: 10px;
			}
			
			.price {
			    color: #007bff; /* 가격 색상을 원하는 색으로 설정하세요 */
			}
      </style>
      
      <script>
         
         // 이전에 캐싱되어있던적이 있다면 새로고침
         window.onpageshow = function(event) {
             if (event.persisted) {
                 window.location.reload(); 
             }
         };
         
      </script>
      
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
      
      <h1 style="position:absolute; left: 255px; top:100px;">유료글 게시판</h1>
      
      
      
      <div class="grandmadiv">
      
         <div class="parantdiv">
            
            <div class="titlediv" style="height: 180px;">
               
               <div class="titlechild">
                  <%
                     if ( userGrade == 1 ) {
                        imgsrc = imgsrc1;
                     } else if ( userGrade == 2 ) {
                        imgsrc = imgsrc2;
                     } else if ( userGrade == 3 ) {
                        imgsrc = imgsrc3;
                     }

                  %>
                  <h5 style="margin-top: 20px; width: 850px; float: left;">유료글</h5>
                  <td colspan="4" align="right">
					    <div style="display: flex; justify-content: flex-end; align-items: right; width: 200px;">
					        <span style="margin-top: 20px; margin-right: 10px;">총 추천수 <%=good%></span>
					        <% if (PaypostMgr.goodCheck(sess, num)) { %>
					            <span style="color: red; margin-top: 20px;"><i class="fas fa-heart"></i> 추천</span>
					        <% } else { %>
					            <button type="button" class="btn btn-link" style="margin-top: 12px; "onclick="goodUp()"><i class="far fa-heart"></i> 추천</button>
					        <% } %>
					    </div>
					</td>
                  <textarea class="titletext" spellcheck="false" readonly><%=title%></textarea>
                  <div class="userinfo" style="display: flex;">
                     
                     <img src="<%=imgsrc%>" class="iconimage">
                     <textarea class="userinfotext" spellcheck="false" style="margin-left: 10px;" readonly><%=username%>&#10;<%=date%></textarea>
                     <div class="price-info" style="margin-top: 20px;">
					    <span class="price-label">가격:</span>
					    <span class="price"><%=pay%> 원</span>
					</div>
					 
					 <% if(sess.equals(user)) { %>
				    <div class="d-flex" style="height: 40px; margin-top:12px; margin-left: 570px;">
				        <a href="PaypostUpdate.jsp?nowPage=<%=nowPage%>&num=<%=num%>&numPerPage=<%=numPerPage%>" class="btn btn-primary mr-2">수정</a>
				        <button type="button" class="btn btn-danger" onclick="delFn()">삭제</button>
				    </div>
<% } %>

					
         
                     
                  </div>
                  
               </div>
               
            </div>
            
            <div class="contentdiv">
               
               <div class="contentchild">
               	  <td align="center" bgcolor="#DDDDDD"></td>
					<table style="width: 100%;">
					    <tr>
					        <td align="center" bgcolor="#f8f9fa" style="padding: 10px;">첨부파일</td>
					        <td bgcolor="#f8f9fa" colspan="3" style="padding: 10px; text-align: left;">
					            <%
					            if(filename!=null&&!filename.equals("")){
					                if(buyMgr.buyCheck(sess, num)||(sess.equals(user))) {%>
					                    <a href="javascript:down('<%=num%>')">
					                        <button type="button" class="btn btn-primary">
					                        	<%=filename%>
					                            <span style="text-decoration: underline;"></span>
					                            (<%=UtilMgr.intFormat(filesize)%>bytes)
					                        </button>
					                <%   }else {
					                    %>
					                    
					                        <span style="font-size: 14px; color: #dc3545;">파일을 다운받기 위해서는 구매가 필요합니다.</span>
					                        <button type="button" class="btn btn-primary" style="margin-left: 10px;" onclick="fileBuy()">구매</button>
					                    </div>
					                <%}
					                }else{%>
					                	<div style="display: flex; align-items: center;">
					                		<span style="font-size: 14px; color: #dc3545;">첨부된 파일이 없습니다.</span>
					                	</div>
					                <%}%>
					        </td>
					    </tr>
					</table>

               	  
                  
                  <textarea id="contexttext" class="contenttext" spellcheck="false" readonly><%=content%></textarea>
                  <div class="userinfo1" style="display: flex; align-items: center;">
                     
                     <img src="<%=imgsrc%>" class="iconimage">
                     <textarea class="userinfotext" spellcheck="false" style="margin-left: 10px;" readonly><%=username%>&#10;등급: <%=userGrade%></textarea>
                     
                  </div>
                  
               </div>
                              
            </div>
     
            <div class="commentdiv">
               
               <div class="commentchild">
                  
                  <h4 style="margin-top: 10px; margin-bottom: 30px;">댓글 <%=commentCount%></h4>
                  
                  <div class="commentblock">
                     
                        
                        <%
                           for ( int i = 0; i < count; i++) {
                              
                              Vector<PaypostCommentBean> vlist1 = commentMgr.getComment(num, i);
                              // comment_userid = "", comment_username = "", comment_content = "", comment_date = "";
                              for ( int j = 0; j < vlist1.size(); j++ ) {
                                 PaypostCommentBean bean = vlist1.get(j);
                                 comment_userid = bean.getPaypost_comment_user_id();
                                 comment_content = bean.getPaypost_comment_content();
                                 comment_date = bean.getPaypost_comment_date();
                                 comment_username = userMgr.getName(comment_userid);
                                 int commentUserGrade = userMgr.getGrade(comment_userid);
                                 int pos = bean.getPaypost_comment_reply_pos();
                                 int ref = bean.getPaypost_comment_reply_ref();
                                 int depth = bean.getPaypost_comment_reply_depth();
                                 String margin = "";
                                 if ( j > 0 ) margin = "margin-left: 50px;";
                        %>
                           <div class="comment" style="<%=margin%>">
                              
                              <%
                                 if ( depth == 1 ) {
                                    if ( commentUserGrade == 1 ) {
                                       imgsrc = imgsrc1;
                                    } else if ( commentUserGrade == 2 ) {
                                       imgsrc = imgsrc2;
                                    } else if ( commentUserGrade == 3 ) {
                                       imgsrc = imgsrc3;
                                    }
                              %>
                              
                              <img src="<%=imgsrc%>" class="iconimage">
                              <div class="commentlan">
                              
                                 <textarea class="userinfotext userinfotext1" spellcheck="false" readonly><%=comment_username%></textarea>
                                 <textarea class="replytext" readonly><%=comment_content%></textarea>
                                 <div class="replylan">
                                 <%
                                    if (sess == null && sessManager == null) {
                                       
                                    } else if ( sess != null && !sess.equals(comment_userid) ) {
                                 %>
                                    <textarea class="replydate" spellcheck="false" readonly><%=comment_date%></textarea>
                                    <button type="button" class="replybtn" onclick="addBox(<%=i%>,<%=j%>)">답글쓰기</button>
                                 <%
                                    } else if ( sess.equals(comment_userid) ) {
                                 %>
                                    <textarea class="replydate" spellcheck="false" readonly><%=comment_date%></textarea>
                                    <button type="button" class="replybtn" onclick="addBox(<%=i%>,<%=j%>)">답글쓰기</button>
                                    <button type="button" class="replybtn" onclick="deletereply(<%=num%>, <%=i%>, <%=j%>)">삭제</button>
                                 <%
                                    }
                                 %>
                                    
                                 </div>
                              
                              </div>
                              
                              <%
                                 } else if ( depth == 0 ) {
                              %>
                                 <div class="commentlan">
                                    
                                    <textarea class="userinfotext userinfotext1" spellcheck="false" readonly></textarea>
                                    <textarea class="replytext" readonly>댓글이 삭제되었습니다</textarea>
                                    
                                 </div>
                              <%
                                 }
                              %>
                              
                           </div>
                           <div class="commentinsertblock existingbox box<%=i%><%=j%> hide" style="<%=margin%>">
                              
                              <div><%=username1%></div>
                              <textarea id="textBox" class="commenttext textarea<%=i%><%=j%>" maxlength="255" placeholder="댓글을 남겨보세요." oninput="checkLimit()"></textarea>
                              <div class="yesnobtn" style="display: flex;">
                                 <button type="button" class="insertbtn" style="height: 25px;" onclick="commentAction(1, '', '<%=sess%>', <%=i%>, <%=j%>)">등록</button>
                                 <button type="button" class="insertbtn" style="height: 25px; margin-left: 1%;" onclick="removebox(<%=i%>,<%=j%>)">취소</button>
                              </div>
                              
                           </div>
                        <%
                                 
                              }
                              
                           }
                        %>
                     
                  </div>
                  
                  <div class="commentinsertblock">
                     
                     <%
                        if ( sess != null ) {
                           
                     %>
                     <div><%=username1%></div>
                     <textarea id="textBox" class="commenttext testarea" maxlength="255" placeholder="댓글을 남겨보세요." oninput="checkLimit()"></textarea>
                     <button type="button" class="insertbtn" onclick="commentAction(0, '', '<%=sess%>', -1, -1)">등록</button>
                     
                     <%
                        } else {
                     %>
                     
                     <button type="button" class="logintry" onclick="tologin()">로그인 후 이용해주세요 &#62;</button>
                     
                     <%
                        }
                     %>
                     
                  </div>
                  
               </div>
               
            </div>
            
         </div>
         
         
      </div>
      
      <div style="position: fixed; width: 1500px; height: 70px; background: white; left: 230px;"></div>
      
      <form name="comment">
         
         <input type="hidden" name="num" value="<%=num%>">
         <input type="hidden" name="check" value="">
         <input type="hidden" name="content" value="">
         <input type="hidden" name="userid" value="">
         <input type="hidden" name="pos" value="">
         <input type="hidden" name="url" value="">
         
      </form>
      
      <form name="delFrm" action="noticeDelete" method="post">
	   <input type="hidden" name="nowPage" value="<%=nowPage%>">
	   <input type="hidden" name="numPerPage" value="<%=numPerPage%>">
	   <%if(!(keyWord==null||keyWord.equals(""))){%>
	   <input type="hidden" name="keyField" value="<%=keyField%>">
	   <input type="hidden" name="keyWord" value="<%=keyWord%>">
	   <%}%>
	   <input type="hidden" name="pass">
	</form>
	
	<form name="goodFrm" action="GoodUpProc.jsp" method="post">
	   <input type="hidden" name="num" value="<%=num%>">
	   <input type="hidden" name="infoId" value="<%=sess%>">
	   <input type="hidden" name="nowPage" value="<%=nowPage%>">
	   <input type="hidden" name="numPerPage" value="<%=numPerPage%>"> 
	</form>
	
	<form name="buyFrm" action="FileBuyProc.jsp" method="post">
	   <input type="hidden" name="seller" value="<%=user%>"> 
	   <input type="hidden" name="buyer" value="<%=sess%>"> 
	   <input type="hidden" name="num" value="<%=num%>">
	   <input type="hidden" name="pay" value="<%=pay%>">
	   <input type="hidden" name="nowPage" value="<%=nowPage%>">
	   <input type="hidden" name="numPerPage" value="<%=numPerPage%>"> 
	</form>

      
      <script>
         
         document.addEventListener("DOMContentLoaded", function() {
            autoResize();
            autoResizeAll();
         });
         
         function autoResize() {
            
            const textarea = document.getElementById("contexttext");
            textarea.style.height = "auto";
            textarea.style.height = (textarea.scrollHeight) + "px";
            
         }
         
         function autoResizeAll() {
            
            const replyTextElements = document.querySelectorAll(".replytext");
              
            replyTextElements.forEach(function(textarea) {
                textarea.style.height = "auto";
                textarea.style.height = (textarea.scrollHeight) + "px";
            });
           
         }
         
         function checkLimit() {
            const textarea = document.getElementById("textBox");
            const maxlength = parseInt(textarea.getAttribute("maxlength"));
            const currentlength = textarea.value.length;
            
            if ( currentlength > maxlength ) {
               textarea.value = textarea.value.substring(0, maxlength);
               alert("글자 수는 255를 넘길 수 없습니다.");
            }
         }
         
         function commentAction(check, content, userid, pos, j) {
            
            var currentURL = location.href;
            var sess = "<%=sess%>";
            console.log(sess);
            
            if ( sess === 'null' ) {
               alert("로그인후 이용해주세요");
               location.href = "login.jsp";
               return;
            }
            
            var test = '.textarea' + pos + j;
            var wheretext = document.querySelector(test);
            var wheretext1 = document.querySelector('.testarea');
            
            document.comment.check.value = check;
            
            if ( check === 0 )
               document.comment.content.value = wheretext1.value;
            else if ( check === 1 ) 
               document.comment.content.value = wheretext.value;
            document.comment.userid.value = userid;
            document.comment.pos.value = pos;
            document.comment.url.value = currentURL;
            document.comment.action = "proc/commentAction.jsp";
            document.comment.submit();
            
         }
         
         function tologin() {
            
            document.urlfrm.action = "login.jsp";
            document.urlfrm.submit();
            
         }
         
         function addBox(i, j) {
            
            var boxnum = '.box' + i + j;
            var addremove = document.querySelector(boxnum);
            var exist = document.querySelectorAll('.existingbox');
            
            exist.forEach(function(element) {
               element.classList.add('hide');
            });
            
            addremove.classList.remove('hide');
            
         }
         
         function removebox(i, j) {
            
            var test = '.box' + i + j;
            var remove = document.querySelector(test);
            
            console.log(test);
            console.log(remove);
            
            remove.classList.add('hide');
            
         }
         
         function deletereply(num, pos, ref) {
            
            var result = confirm("정말 삭제하시겠습니까?");
            
            if ( result ) {
               
               document.deletefrm.num.value = num;
               document.deletefrm.pos.value = pos;
               document.deletefrm.ref.value = ref;
               document.deletefrm.action = "proc/deleteReplyProc.jsp";
               document.deletefrm.submit();
               
            } else {
               
               return;
               
            }
            
         }
         
         function deleteThisBaby() {
            
            var result = confirm("게시글을 삭제하시겠습니까?");
            
            if ( result ) {
               
               document.deletepaypostfrm.submit();
               
            } else {
               alert("취소하였습니다");
            }
            
         }
         
         function fileBuy() {
             if(!confirm("해당 게시물을 구매하시겠습니까?")){
              }else{
                  document.buyFrm.submit();
              }
          }
         
         function goodUp() {
             if(!confirm("해당 게시물을 추천하시겠습니까?")){
              }else{
                  document.goodFrm.submit();
              }
          }


         
         /*
         window.onscroll = function() {
             var navbar = document.getElementById("wrapper");
             if (document.body.scrollTop > 20 || document.documentElement.scrollTop > 20) {
                 navbar.style.top = "0";                               // 스크롤이 아래로 이동했을 때 네비게이션 바를 화면 상단에 고정
             }
         }
         */
         
      </script>
      
   </body>
   
</html>