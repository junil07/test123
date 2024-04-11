<!-- Mainpage.jsp -->
<%@page import="project.TestBean"%>
<%@page import="java.util.Vector"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="userMgr" class="project.UserMgr"/>
<jsp:useBean id="testMgr" class="project.TestMgr"/>

<!-- // session 정보 확인하는 내용 -->
<%@ include file="../inc/session.jsp" %>
<%

   String keyWord="";
   String url="../test/Mainpage.jsp";
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
   <!-- // 공통 Head  -->
   <%@ include file="../inc/head.jsp" %>

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
            <%@ include file="../inc/top.jsp" %>
                <!-- Begin Page Content -->
                <div class="container-fluid">
                   <!-- // 컨텐츠 입력 start  -->



                    <!-- 자격증 기출문제 타이틀 -->
                    <div class="p-3">
                       <h1 class="text-dark"> 자격증 기출문제 </h1>
                       <div class="d-flex justify-content-end">
                          <form id="searchFrm" name="searchFrm" class="row g-3" method="GET">
                             <div class="col-auto">
                          <input type="text" class="form-control" id="search_keyword" name="keyWord" placeholder="검색어를 입력해주세요.">
                        </div>
                        <div class="col-auto">
                          <button type="submit" id="btn-search" class="btn btn-primary mb-3"> 찾기 </button>
                        </div>
                          </form>
                       </div>
                       <hr/>

                       <div class="row row-cols-4">
                          <!-- 자격증 종류 리스트 -->
                     <%Vector<TestBean> vlist = testMgr.testList(keyWord);%>
                     <%for(int i = 0; i<vlist.size();i++){
                          TestBean testBean = vlist.get(i);
                          String title = testBean.getTest_title();
                       %>
                      <div class="col">
                         <div class="card">
                          <div class="card-header fw-bolder bg-dark text-white">
                            <%=title%>
                          </div>
                          <div class="card-body">
                             <!--
                            <h5 class="card-title">Special title treatment</h5>
                            <p class="card-text">With supporting text below as a natural lead-in to additional content.</p>
                             -->
                            <a href="Test_correct.jsp?title=<%=title%>" class="btn btn-success w-100">이동</a>
                          </div>
                        </div>
                      </div>
                      <%}%>
                    </div>
                    </div>

               <script>
                  $(document).ready(function() {
                     // 검색 기능
                     $("#btn-search").on("click", function() {
                        var _search_txt = $("#search_keyword").val().trim();
                        if ( _search_txt.length <= 0 ) {
                           alert("검색어를 입력해주세요.");
                           $("#search_keyword").val('').focus();
                           return false;
                        }
                     });
                     // 검색시, Enter Key 이벤트 등록
                     $("#search_keyword").on("keyup", function(e) {
                        if ( e.keyCode == 13 ) {
                           $("#btn-search").trigger("click");
                        }
                     });
                  });
               </script>



                    <!-- // 컨텐츠 입력 end -->
                </div>
            </div>
        </div>
    </div>
    <!-- // 사이드 메뉴 영역  -->
   <%@ include file="../inc/footer.jsp" %>
</body>      
</html>
