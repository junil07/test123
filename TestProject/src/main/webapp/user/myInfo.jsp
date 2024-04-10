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
    <link href="myInfo.css" rel="stylesheet">
    <link href="sidebar.css" rel="stylesheet">
</head>
<body>
<div class="a">
    <div class="b">
      <div class="c">
        <div class="d">Discover</div>
      </div>
      <div class="e">
        <img class="f" src="" />
        <div class="g">
        	<a href="https://www.naver.com/">기출 문제 풀기</a>
        </div>
      </div>
      <div class="h">
        <img class="i" src="" />
        <div class="j">
        	<a href="https://www.naver.com/">공지사항</a>
        </div>
      </div>
      <div class="k">
        <img class="l" src="https://cdn.pixabay.com/photo/2017/02/13/01/26/the-question-mark-2061539_1280.png" />
        <div class="m">
        	<a href="https://www.naver.com/">QnA</a>
        </div>
      </div>
    </div>
    <div class="n">
      <div class="o">
        <div class="p">
        마이페이지
        </div>
      </div>
      <div class="q">
        <img class="r" src="https://search.pstatic.net/sunny/?src=https%3A%2F%2Fpng.pngtree.com%2Fpng-vector%2F20230303%2Fourmid%2Fpngtree-information-line-icon-vector-png-image_6630884.png&type=sc960_832" />
        <div class="s">
        	<a href="">내 정보</a>
        </div>
      </div>
      <div class="t">
        <img class="u" src="" />
        <div class="v">
        	<a href="https://www.naver.com/">오답노트</a>
        </div>
      </div>
      <div class="w">
        <img class="x" src="https://via.placeholder.com/24x24" />
        <div class="y">
        	<a href="https://www.naver.com/">구매내역</a>
        </div>
        <button type="button" onclick="location.href = 'logout.jsp'">로그아웃</button>
      </div>
    </div>
    <a href="https://www.youtube.com/">
    	<img class="z" src="https://ih1.redbubble.net/image.538022342.9685/flat,750x,075,f-pad,750x1000,f8f8f8.u2.jpg" />
    </a>
    <div class="a1">
      <img class="a2" src="https://previews.123rf.com/images/vectorchef/vectorchef1506/vectorchef150617704/41619187-%EC%83%81%EC%A0%90-%EC%83%81%EC%A0%90-%EC%95%84%EC%9D%B4%EC%BD%98.jpg" />
      <div class="a3">
      	<a href="../paypost/Paypost.jsp">스토어</a>
      </div>
    </div>
    <div class="a4">
      <img class="a5" src="https://search.pstatic.net/sunny/?src=https%3A%2F%2Fcdn-icons-png.flaticon.com%2F512%2F1051%2F1051048.png&type=sc960_832" />
      <div class="a6">
      	<a href="https://www.naver.com/">자유게시판</a>
      </div>
    </div>
  </div>
  
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
				<button class="update_button btn-1" onclick="javascript:showPopup()">수정</button>
			</div>
		</div>
	          <div class="head_title">
			<h3 class="subindex_title">이름</h3>
		</div>
		<div class="subindex_graybox">
			<div class="into_title">
				<input class="title_text" value="<%=infoName%>">
				<button class="update_button btn-1" onclick="javascript:namePopup()">수정</button>
			</div>
		</div>
	          <div class="head_title">
			<h3 class="subindex_title">전화번호</h3>
		</div>
		<div class="subindex_graybox">
			<div class="into_title">
				<input class="title_text" value="<%=infoPhone%>">
				<button class="update_button btn-1" onclick="javascript:phonePopup()">수정</button>
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
			</div>
		</div>
	<%}%>
	</div>
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
  		<script src="myInfo.js"></script>
</body>      
</html>