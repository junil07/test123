<!-- 마이페이지.jsp -->
<%@page import="project.ManagerBean"%>
<%@page import="project.UserBean"%>
<%@page import="java.util.Vector"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="userMgr" class="project.UserMgr"/>
<jsp:useBean id="managerMgr" class="project.ManagerMgr"/>

<%-- 세션으로 아이디 값 받아와서 로그인 된 상태면 이쪽으로 로그인 되지 않았다면 login.jsp로 튕기도록 만들기 --%>
<%
	String id = request.getParameter("id");
	String pwd = request.getParameter("pwd");
	String sess = (String) session.getAttribute("idKey");
	String sessManager = (String) session.getAttribute("adminKey");
	Vector<UserBean> vlist = userMgr.showUserInfo(sess);
	Vector<ManagerBean> vlistManager = managerMgr.showManagerInfo(sessManager);
	String infoId = "정보가 없습니다", infoPwd = "정보가 없습니다", infoName = "정보가 없습니다", infoPhone = "정보가 없습니다", infoEmail = "정보가 없습니다";
	String infoGrade = "", infoPoint = "";
	String imgsrc = "";
	String test = "";
%>
<html>
<head>
	
	<%@ include file="navi/head.jsp" %>
	
	<script>
		
<%
	// System.out.println("!!" + sess);						// 내 정보는 로그인을 해야 볼 수 있음. 세션에 idKey값 없을 시 login.jsp로 이동
	if ( sess == null && sessManager == null ) {
%>
		alert("로그인이 필요합니다.");
		location.href = "login.jsp";
<%
	} else if ( sess != null && sessManager != null ) {
		session.invalidate();
%>
		alert("세션이 중복되었습니다 다시 로그인을 해주세요");
		location.href = "login.jsp";
<%
	} else if ( sess != null && sessManager == null ) {
		for ( int i = 0; i < vlist.size(); i++ ) {
			UserBean bean = vlist.get(i);
			infoId = bean.getUser_id();
			infoPwd = bean.getUser_pw();
			infoName = bean.getUser_name();
			infoPhone = bean.getUser_phone();
			infoEmail = bean.getUser_email();
			infoPoint = Integer.toString(bean.getUser_point());
			infoGrade = Integer.toString(bean.getUser_grade());
			if ( infoGrade.equals("1") ) {
				imgsrc = "https://i.namu.wiki/i/3t4jrWPmNFqyrDs3xUJnCNE6-wbc069FEO33" +
						 "_OFcenoatrkXStgCN0_fSwB1be_aWoaLe_QDQXn3vIx_OAbvhP_u6Jg" +
						 "s01Rx0gd536bG7H8xeEJTbV1lNdtfZOpwYwimASvgbM17fyQSyztcfhwTBw.webp";
			} else if ( infoGrade.equals("2") ) {
				imgsrc = "https://i.namu.wiki/i/8nDVP1V6uDTtF_DSqd8k3VgdmmW3alDTj0i6jTQ" +
						 "1iJXBoS3bfjR5ov63R-ch2vhAy1XRM21dWRIOUL1WwkNKOfNF3zNZq3h" +
						 "VeVkD6WnlIJLPxSdbkVnl_SNnzk9Wkta0T0HXmTz2mrcXfZPxMxet3w.webp";
			} else if ( infoGrade.equals("3") ) {
				imgsrc = "https://i.namu.wiki/i/c49u7Vr0uQfxNPOS9YwS9u5u_yaz7QlBrbMqz6" +
						 "Vv3sz6HyVNS5Af769-y_06L_rX8IN9vtKOI91_nu3GxI9a6VTOMoLnZ2A" +
						 "oFJRnDRe53mUrtwfjjA4blJ9Bza3jhCAVPawUibCIA1sB9YT32dvkXA.webp";
			}
		}
	} else if ( sess == null && sessManager != null ) {
		for ( int i = 0; i < vlistManager.size(); i++ ) {
			ManagerBean bean = vlistManager.get(i);
			infoId = bean.getManage_id();
			infoPwd = bean.getManage_pwd();
			infoName = bean.getManage_name();
			infoPhone = bean.getManage_phone();
			imgsrc = "https://i.namu.wiki/i/JL4AMb2vGpikuwZHzUOm4I6Ad8nMnHVWfPlfoJr" +
					 "BNPH0ak0l2ZbN_e_0hlkKusNXzTY0Z1oLxmE0UmJlQ6c11cNCGZJgd9" +
					 "OUyyqEm_l2YAmKPXaXwufM1jy6nsHLxil7pta9gTTDLrFIElCdetBQhA.webp";
		}
	} 
%>
	
	function topoint() {
		
		document.frm1.action = "pointUsageHistory_old.jsp";
		document.frm1.submit();
		
	}
	
	</script>
    <link href="css/myInfo.css" rel="stylesheet">
    <link href="css/sidebar.css" rel="stylesheet">
    
    <style>
    	
    	.subindex_item > * {
		    margin-top: 20;
		}
		
		.gradepoint > * {
		    margin-top: 20px;
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
		
		<h1 style="position:absolute; left: 250px; top:100px;">내 정보</h1>
	
  <div style="left: 500px; top: 200px; margin-bottom: 100px;" class="subindex_item">
		<div class="head_title">
			<h3 class="subindex_title">아이디</h3>
		</div>
		<div class="subindex_graybox">
			<div class="into_title">
				<input class="title_text" value="<%=infoId%>">
			</div>
		</div>
	          <div class="head_title">
			<h3 class="subindex_title">비밀번호</h3>
		</div>
		<div class="subindex_graybox">
			<div class="into_title">
				<input type="password" class="title_text" value="<%=infoPwd%>">
				<%
					if ( sess != null && sessManager == null ) {
				%>
				<button class="update_button btn-1" onclick="javascript:showPopup()">수정</button>
				<%
					}
				%>
			</div>
		</div>
	          <div class="head_title">
			<h3 class="subindex_title">이름</h3>
		</div>
		<div class="subindex_graybox">
			<div class="into_title">
				<input class="title_text" value="<%=infoName%>">
				<%
					if ( sess != null && sessManager == null ) {
				%>
				<button class="update_button btn-1" onclick="javascript:namePopup()">수정</button>
				<%
					}
				%>
			</div>
		</div>
	          <div class="head_title">
			<h3 class="subindex_title">전화번호</h3>
		</div>
		<div class="subindex_graybox">
			<div class="into_title">
				<input class="title_text" value="<%=infoPhone%>">
				<%
					if ( sess != null && sessManager == null ) {
				%>
				<button class="update_button btn-1" onclick="javascript:phonePopup()">수정</button>
				<%
					}
				%>
			</div>
		</div>
	          <div class="head_title head_title1 hide">
			<h3 class="subindex_title">이메일</h3>
		</div>
		<div class="subindex_graybox emailbox hide">
			<div class="into_title">
				<input class="title_text" value="<%=infoEmail%>">
				<button class="update_button btn-1" onclick="javascript:emailPopup()">수정</button>
			</div>
		</div>
	</div>
	<div class="gradepoint">
		<div class="head_title">
			<h3 class="subindex_title">회원등급</h3>
		</div>
		<div class="subindex_graybox forgrade">
			<div class="into_title gradetitle">
				<img class="gradeimg" src="<%=imgsrc%>">
				<%if ( sess != null && sessManager == null ) {%>
					<input class="title_text right_text right_text1 hide" value="<%=infoName%>님의 등급은 <%=infoGrade%>등급 입니다.">
				<%} else if ( sess == null && sessManager != null ) {%>
					<input class="title_text right_text right_text2 hide" value="관리자 <%=infoName%>님 반갑습니다.">
				<%}%>
			</div>
		</div>
	<%if ( sess != null && sessManager == null ) {%>
		<div class="head_title">
			<h3 class="subindex_title">보유 포인트</h3>
		</div>
		<div class="subindex_graybox forpoint">
			<div class="into_title pointtitle">
				<input class="title_text pointtext" value="<%=infoPoint%> P">
				<button class="topointbtn" onclick="topoint()">포인트 내역</button>
			</div>
		</div>
	<%}%>
	</div>
	
	<form name="frm1">
		
		
		
	</form>
	
		<script>
		
			// html 코드에서 값을 받아올려면 밑에 스크립트에서 작성을 해야 html이 로드되고 값을 받아올 수 있음
			let elEmail = document.querySelector('.emailbox');
			let elEmail1 = document.querySelector('.head_title1');
			
		<%
			if ( sess != null ) {
		%>
			elEmail.classList.remove('hide');
			elEmail1.classList.remove('hide');
		<%
			}
		%>
		</script>
  		<script src="js/myInfo.js"></script>
</body>      
</html>