<%@ page contentType="text/html; charset=UTF-8"%>
<%


%>
<Script>
   $(document).ready(function() {
      // 페이지 로딩시, 자동실행
      $(window).trigger("resize");
   });
   $(window).on("resize", function() {
      // 자동 여백 계산 
      // 좌측 메뉴 스크롤과 상관없이 항상 고정 
      var _nav_width = $("ul#accordionSidebar").outerWidth();
      $("div#content-wrapper").css("padding-left", _nav_width+"px");
   });   
</Script>

<!-- Sidebar -->
<ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar" style="position:fixed; z-index:10;">


    <!-- Sidebar - Brand -->
    <a class="sidebar-brand d-flex align-items-center justify-content-center" href="index.html">
        <div class="sidebar-brand-icon rotate-n-15">
            <i class="fas fa-laugh-wink"></i>
        </div>
        <div class="sidebar-brand-text mx-3"> Perfect </div>
    </a>

    <!-- Divider -->
    <hr class="sidebar-divider my-0">

    <!-- Nav Item - Dashboard -->
    <li class="nav-item active">
        <a class="nav-link" href="index.html">
            <i class="fas fa-fw fa-tachometer-alt"></i>
            <span>Dashboard</span>
        </a>
    </li>

    <!-- Divider -->
    <hr class="sidebar-divider">

    <!-- Heading -->
    <div class="sidebar-heading">

        Discover
    </div>

    <!-- Nav Item - Pages Collapse Menu -->
    <li class="nav-item">
        <a class="nav-link" href="../test/Mainpage.jsp">
            <i class="fas fa-fw fa-cog"></i>
            <span>기출문제풀기</span>
        </a>
    </li>
    <li class="nav-item">
        <a class="nav-link" href="javascript:void(0);">
            <i class="fas fa-fw fa-cog"></i>
            <span>공지사항</span>
        </a>
    </li>
    <li class="nav-item">
        <a class="nav-link" href="javascript:void(0);">
            <i class="fas fa-fw fa-cog"></i>
            <span>QnA</span>
        </a>
    </li>
    <li class="nav-item">
        <a class="nav-link" href="javascript:void(0);">
            <i class="fas fa-fw fa-cog"></i>
            <span>스토어</span>
        </a>
    </li>
    <li class="nav-item">
        <a class="nav-link" href="javascript:void(0);">
            <i class="fas fa-fw fa-cog"></i>
            <span>자유게시판</span>
        </a>
    </li>


    <!-- Divider -->
    <hr class="sidebar-divider">

    <!-- Heading -->
    <div class="sidebar-heading">
        마이페이지
    </div>
    
    <li class="nav-item">
        <a class="nav-link" href="javascript:void(0);">
         <!-- todo. i 태그 :: class를 통해서 아이콘 추가 -->
            <i class="fas fa-fw fa-user"></i>
            <span>내정보</span>
        </a>
    </li>
    <li class="nav-item">
        <a class="nav-link" href="../wrong/WrongList.jsp">
            <i class="fas fa-fw fa-cog"></i>
            <span>오답노트</span>
        </a>
    </li>
    <li class="nav-item">
        <a class="nav-link" href="javascript:void(0);">
            <i class="fas fa-fw fa-cog"></i>
            <span>구매내역</span>
        </a>
    </li>
</ul>
<!-- End of Sidebar -->