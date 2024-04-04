<!-- Mainpage.jsp -->
<%@page import="project.TestBean"%>
<%@page import="java.util.Vector"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="userMgr" class="project.UserMgr"/>
<jsp:useBean id="testMgr" class="project.TestMgr"/>

<%
   String keyWord="";
   
	if ( request.getParameter("keyWord") != null ) {
		keyWord = request.getParameter("keyWord");
	}
	
	// 검색 후에 다시 초기화 요청
	if ( request.getParameter("reload") != null &&
			request.getParameter("reload").equals("true") ) {
		keyWord = "";
	}
%>
<!DOCTYPE html>
<html>
<head>
   <script type="text/javascript">
   function check() {
		if(document.searchFrm.keyWord.value==""){
			alert("검색어를 입력하세요.");
			document.searchFrm.keyWord.focus();
			return;
		}
		document.searchFrm.submit();
	}
   function read(title) {
		document.readFrm.title.value=title;
		document.readFrm.action = "Test_correct.jsp";
		document.readFrm.submit();
	}
   </script>
   <style>
        /* 여기에 CSS 스타일을 정의합니다 */
        a {
            color: inherit; /* 링크 기본 색상 사용 */
            text-decoration: none; /* 밑줄 제거 */
        }
        .container{
        	position: absolute;
   			top:5%;
   			left:25%;
   			width:1000px;
        }
        .test_button{
        	display: inline-block;
            padding: 10px 20px;
            font-size: 16px;
            cursor: pointer;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            transition: background-color 0.3s;
            margin-top: 10px;
        }
        .test_title{
        	FONT-FAMILY:	
        }
        .line{
        	border : 0px;
  			border-top: 5px solid black;
        }
    </style>
</head>
<body>
<!-- 왼쪽 nav 바 -->
<div style="width: 256px; height: 983px; left: 0px; top: 0px; position: absolute; background: white; border-right: 1px #E0E0E0 solid">
    <div style="width: 240px; height: 164px; left: 8px; top: 159px; position: absolute; flex-direction: column; justify-content: flex-start; align-items: flex-start; gap: 4px; display: inline-flex">
      <div style="align-self: stretch; height: 40px; padding-left: 16px; padding-right: 16px; border-radius: 8px; justify-content: flex-start; align-items: center; gap: 16px; display: inline-flex">
        <div style="width: 208px; height: 24px; color: black; font-size: 16px; font-family: Inter; font-weight: 600; line-height: 24px; word-wrap: break-word">Discover</div>
      </div>
      <div style="align-self: stretch; height: 40px; padding-left: 16px; padding-right: 16px; background: white; border-radius: 8px; justify-content: flex-start; align-items: center; gap: 16px; display: inline-flex">
        <img style="width: 26.32px; height: 24px" src="data:image/jpeg;base64,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" />
        <div style="flex: 1 1 0; color: black; font-size: 16px; font-family: Inter; font-weight: 500; line-height: 24px; word-wrap: break-word">
           <a href="https://www.naver.com/">기출 문제 풀기</a>
        </div>
      </div>
      <div style="align-self: stretch; height: 40px; padding-left: 16px; padding-right: 16px; background: white; border-radius: 8px; justify-content: flex-start; align-items: center; gap: 16px; display: inline-flex">
        <img style="width: 26.32px; height: 24px" src="https://media.istockphoto.com/id/1325039445/ko/%EB%B2%A1%ED%84%B0/%EB%A9%94%EA%B0%80%ED%8F%B0-%EA%B3%B5%EC%A7%80-%EC%82%AC%ED%95%AD-%ED%94%84%EB%A1%9C%EB%AA%A8%EC%85%98-%EB%B0%8F-%EB%89%B4%EC%8A%A4%EC%97%90-%EB%8C%80%ED%95%9C-%EA%B0%84%EB%8B%A8%ED%95%9C-%EB%B2%A1%ED%84%B0-%EC%95%84%EC%9D%B4%EC%BD%98%EC%9E%85%EB%8B%88%EB%8B%A4.jpg?s=612x612&w=0&k=20&c=xe0__vNe6dhjyYcnGNLdojjZI1n-qlak1P96BIeqEZc=" />
        <div style="flex: 1 1 0; color: black; font-size: 16px; font-family: Inter; font-weight: 500; line-height: 24px; word-wrap: break-word">
           <a href="https://www.naver.com/">공지사항</a>
        </div>
      </div>
      <div style="align-self: stretch; height: 40px; padding-left: 16px; padding-right: 16px; background: white; border-radius: 8px; justify-content: flex-start; align-items: center; gap: 16px; display: inline-flex">
        <img style="width: 26.32px; height: 24px" src="https://cdn.pixabay.com/photo/2017/02/13/01/26/the-question-mark-2061539_1280.png" />
        <div style="flex: 1 1 0; color: black; font-size: 16px; font-family: Inter; font-weight: 500; line-height: 24px; word-wrap: break-word">
           <a href="https://www.naver.com/">QnA</a>
        </div>
      </div>
    </div>
    <!-- <img style="width: 26.32px; height: 24px" src="" /> -->
    <div style="height: 168px; left: 8px; top: 491px; position: absolute; flex-direction: column; justify-content: flex-start; align-items: flex-start; gap: 8px; display: inline-flex">
      <div style="align-self: stretch; padding-left: 16px; padding-right: 16px; justify-content: flex-start; align-items: center; gap: 8px; display: inline-flex">
        <div style="flex: 1 1 0; color: black; font-size: 16px; font-family: Inter; font-weight: 600; line-height: 24px; word-wrap: break-word">
        마이페이지
        </div>
      </div>
      <div style="align-self: stretch; height: 40px; padding-left: 16px; padding-right: 16px; background: white; border-radius: 8px; justify-content: flex-start; align-items: center; gap: 16px; display: inline-flex">
        <img style="width: 26.32px; height: 24px" src="https://search.pstatic.net/sunny/?src=https%3A%2F%2Fpng.pngtree.com%2Fpng-vector%2F20230303%2Fourmid%2Fpngtree-information-line-icon-vector-png-image_6630884.png&type=sc960_832" />
        <div style="flex: 1 1 0; color: black; font-size: 16px; font-family: Inter; font-weight: 500; line-height: 24px; word-wrap: break-word">
           <a href="https://www.naver.com/">내 정보</a>
        </div>
      </div>
      <div style="align-self: stretch; height: 40px; padding-left: 16px; padding-right: 16px; background: white; border-radius: 8px; justify-content: flex-start; align-items: center; gap: 16px; display: inline-flex">
        <img style="width: 26.32px; height: 24px" src="" />
        <div style="flex: 1 1 0; color: black; font-size: 16px; font-family: Inter; font-weight: 500; line-height: 24px; word-wrap: break-word">
           <a href="https://www.naver.com/">오답노트</a>
        </div>
      </div>
      <div style="align-self: stretch; height: 40px; padding-left: 16px; padding-right: 16px; background: white; border-radius: 8px; justify-content: flex-start; align-items: center; gap: 16px; display: inline-flex">
        <img style="width: 24px; height: 24px" src="https://via.placeholder.com/24x24" />
        <div style="flex: 1 1 0; color: black; font-size: 16px; font-family: Inter; font-weight: 500; line-height: 24px; word-wrap: break-word">
           <a href="https://www.naver.com/">구매내역</a>
        </div>
        <button type="button" onclick="location.href = 'logout.jsp'">로그아웃</button>
      </div>
    </div>
    <a href="https://www.youtube.com/">
       <img style="width: 191px; height: 140px; left: 30px; top: 10px; position: absolute" src="https://ih1.redbubble.net/image.538022342.9685/flat,750x,075,f-pad,750x1000,f8f8f8.u2.jpg" />
    </a>
    <div style="width: 200px; height: 40px; padding-left: 16px; padding-right: 16px; left: 8px; top: 375px; position: absolute; background: white; border-radius: 8px; justify-content: flex-start; align-items: center; gap: 16px; display: inline-flex">
      <img style="width: 26.32px; height: 24px" src="https://previews.123rf.com/images/vectorchef/vectorchef1506/vectorchef150617704/41619187-%EC%83%81%EC%A0%90-%EC%83%81%EC%A0%90-%EC%95%84%EC%9D%B4%EC%BD%98.jpg" />
      <div style="flex: 1 1 0; color: black; font-size: 16px; font-family: Inter; font-weight: 500; line-height: 24px; word-wrap: break-word">
         <a href="https://www.naver.com/">스토어</a>
      </div>
    </div>
    <div style="width: 200px; height: 40px; padding-left: 16px; padding-right: 16px; left: 8px; top: 415px; position: absolute; background: white; border-radius: 8px; justify-content: flex-start; align-items: center; gap: 16px; display: inline-flex">
      <img style="width: 26.32px; height: 24px" src="https://search.pstatic.net/sunny/?src=https%3A%2F%2Fcdn-icons-png.flaticon.com%2F512%2F1051%2F1051048.png&type=sc960_832" />
      <div style="flex: 1 1 0; color: black; font-size: 16px; font-family: Inter; font-weight: 500; line-height: 24px; word-wrap: break-word">
         <a href="https://www.naver.com/">자유게시판</a>
      </div>
    </div>
  </div>
 <!-- 자격증 기출문제 타이틀 -->
<div class = "container">
	<h1 class="test_title">자격증 기출문제</h1>
	<div align="right">
	<form  name="searchFrm">
	<table  width="600" cellpadding="4" cellspacing="0">
 		<tr>
  			<td align="center" valign="bottom">
   				<input size="16" name="keyWord">
   				<input type="button"  value="찾기" onClick="javascript:check()">
  			</td>
 		</tr>
	</table>
</form>
   	</div>
	<hr class="line"/>
	<!-- 자격증 종류 리스트 -->
	<%Vector<TestBean> vlist = testMgr.testList(keyWord);%>
  		<%for(int i = 0; i<vlist.size();i++){
  			TestBean testBean = vlist.get(i);
  			String title = testBean.getTest_title();
  		%>
  			<button type="button" class="test_button" onclick="javascript:read('<%=title%>')"><%=title%></button>
  		<%}%>
  	<form name = "readFrm">
  		<input type="hidden" name="title">
  	</form>
</div>
</body>      
</html>
