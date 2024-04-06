<!-- 마이페이지.jsp -->
<%@page import="project.ManagerBean"%>
<%@page import="project.UserBean"%>
<%@page import="java.util.Vector"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="userMgr" class="project.UserMgr"/>
<jsp:useBean id="managerMgr" class="project.ManagerMgr"/>

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
		<%--bootstrap css --%>
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
		<nav>		
			<ul class="menu">
				<%--로고 --%>
				<li><a href="">
					<img class="z" src="https://ih1.redbubble.net/image.538022342.9685/flat,750x,075,f-pad,750x1000,f8f8f8.u2.jpg" />
				</a></li>
				<div id="board_title">Discover</div>
				<li><a href="">게시판 관리</a></li>
				<li><a href="">유저 관리</a></li>
				<li><a href="">어쩌구</a></li>
				<li><a href="">저쩌구</a></li>
			</ul>
		</nav>
		<style>
			#board_title {
				width: 80%;
				margin:15px;
				background-color:white;
				font-weight:bold;
			}
			
			nav {
				width:230px;
				background-color:white;
				border-right:1px solid #ddd;
				position:fixed;
				height:100%;
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
				imgsrc = "https://i.namu.wiki/i/4dyrzwxAnmVHd7JjndrohJlGESXVjYP-Ct8fXOG67" +
						 "W_dM5dDC_YM_76o04rD2_VQOkMmrHNEp_obMY2j4DZG9ktPZmC-Cb5h" +
						 "y1abdfHOP4qZwxc6iTJsZQXpPflg6Kf1FpJH0O-2SUVp4WDSNT0mLw.webp";
			} else if ( infoGrade.equals("2") ) {
				imgsrc = "https://i.namu.wiki/i/aWztAVxIf8Jetr_bi-jh2BOP8MfiIZBViuKsuDDD" +
						 "SWl7_FOE2fsXcH5HOZfDg1sUJXO8eOljgrz2jBslZZ4rc1qEGT1Rlr8TZ" +
						 "QNaPfTpwrxhkoQ433_XLe_7bqknBGWr1c1C9AZgY4vg0ruZnsvnzw.webp";
			} else if ( infoGrade.equals("3") ) {
				imgsrc = "https://i.namu.wiki/i/jl758B--4mqIF2qLyWzA_oAn4dzrpFuusGl2b-" +
						 "J0vqbPsLq6KJ4-jYuOKJtrgeWnX5p1gre4It-O1JLhnlwB69HQq2lG3ft" +
						 "SLHQov33dgyiGhS4ev9QlPf59f3Hao9ACm9pI7pPlwnXq6KX_uoYtmg.webp";
			}
		}
	} else if ( sess == null && sessManager != null ) {
		for ( int i = 0; i < vlistManager.size(); i++ ) {
			ManagerBean bean = vlistManager.get(i);
			infoId = bean.getManage_id();
			infoPwd = bean.getManage_pwd();
			infoName = bean.getManage_name();
			infoPhone = bean.getManage_phone();
			imgsrc = "https://i.namu.wiki/i/R-IwABz1mehw3BFlMQWqP1rWWyvE6QLrMddzA" +
					 "1ZvPFEULGStbcFLI2HgVgJ18nHnLnsm3DWpfMicwxDS3NM716_1BMkY" +
					 "iBj_3sU0M3vOhwLzWxNJXvLBxtIHskSpIL0su1zt0h2qYGItQNTcMEPErw.webp";
		}
	} 
%>
		</script>
	</body>      
</html>