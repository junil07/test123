<%-- QnA 안에 페이지 --%>

<%@page import="project.Qna_commentBean"%>
<%@page import="project.QnaBean"%>
<%@page import="java.util.Vector"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="qnaMgr" class="project.QnaMgr"/>
<jsp:useBean id="commentMgr" class="project.Qna_commentMgr"/>
<jsp:useBean id="userMgr" class="project.UserMgr"/>

<%
	String sess = (String) session.getAttribute("idKey");
	int num = Integer.parseInt( request.getParameter("num") );
	String title = "", user = "", content = "", date = "";
	Vector<QnaBean> vlist = qnaMgr.getQnA(num);
	
	String comment_userid = "", comment_username = "", comment_content = "", comment_date = "";
	
	for ( int i = 0; i < vlist.size(); i++ ) {
		QnaBean bean = vlist.get(i);
		title = bean.getQna_title();
		content = bean.getQna_content();
		date = bean.getQna_date();
		user = bean.getQna_user_id();
	}
	
	String username = userMgr.getName(user);
	int userGrade = userMgr.getGrade(user);
	
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
	
	int commentCount = commentMgr.getCount(num);
	int count = commentMgr.getOriginCount(num); 
	String username1 = userMgr.getName(sess);
%>

<html>
	
	<head>
		
		<%@ include file="../inc/head.jsp" %>
		<link href="css/qnaInPage.css" rel="stylesheet">
		
		<style>
			
			body {
				color: black;
			}
			
			img {
				vertical-align: baseline;
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
		
		<h1 style="position:absolute; left: 250px; top:100px;">QnA</h1>
		
		
		
		<div class="grandmadiv">
		
			<div class="parantdiv">
				
				<div class="titlediv">
					
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
						<h5 style="margin-top: 20px;">QnA</h5>
						<textarea class="titletext" spellcheck="false" readonly><%=title%></textarea>
						<div class="userinfo" style="display: flex; align-items: center;">
							
							<img src="<%=imgsrc%>" class="iconimage">
							<textarea class="userinfotext" spellcheck="false" style="margin-left: 10px;" readonly><%=username%>&#10;<%=date%></textarea>
							
						</div>
						
					</div>
					
				</div>
				
				<div class="contentdiv">
					
					<div class="contentchild">
						
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
										
										Vector<Qna_commentBean> vlist1 = commentMgr.getComment(num, i);
										// comment_userid = "", comment_username = "", comment_content = "", comment_date = "";
										for ( int j = 0; j < vlist1.size(); j++ ) {
											Qna_commentBean bean = vlist1.get(j);
											comment_userid = bean.getQna_comment_user_id();
											comment_content = bean.getQna_comment_content();
											comment_date = bean.getQna_comment_date();
											comment_username = userMgr.getName(comment_userid);
											int commentUserGrade = userMgr.getGrade(comment_userid);
											int pos = bean.getQna_comment_reply_pos();
											int ref = bean.getQna_comment_reply_ref();
											int depth = bean.getQna_comment_reply_depth();
											System.out.println(depth);
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
												if (sess == null ) {
													
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
			
			<div class="deletebtnhere">
				
				<%
					if ( sess == null ) {
						
					} else if ( sess.equals(user) ) {
				%>
					<button class="deleteThisShit" onclick="deleteThisBaby()">삭제</button>
				<%
					}
				%>
				
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
		
		<form name="deletefrm">
			
			<input type="hidden" name="num" value="">
			<input type="hidden" name="pos" value="">
			<input type="hidden" name="ref" value="">
			
		</form>
		
		<form name="urlfrm">
			
			
			
		</form>
		
		<form name="deleteqnafrm">
			
			<input type="hidden" name="num" value="<%=num%>">
			
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
					
					document.deleteqnafrm.action = "proc/deleteQnaProc.jsp";
					document.deleteqnafrm.submit();
					
				} else {
					alert("취소하였습니다");
				}
				
			}
			
			/*
			window.onscroll = function() {
			    var navbar = document.getElementById("wrapper");
			    if (document.body.scrollTop > 20 || document.documentElement.scrollTop > 20) {
			        navbar.style.top = "0"; 										// 스크롤이 아래로 이동했을 때 네비게이션 바를 화면 상단에 고정
			    }
			}
			*/
			
		</script>
		
	</body>
	
</html>