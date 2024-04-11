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
    <a class="sidebar-brand d-flex align-items-center justify-content-center" href="../admin/adminpage.jsp">
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
        기출문제 관리
    </div>

    <!-- Nav Item - Pages Collapse Menu -->
    <li class="nav-item">
        <a class="nav-link" href="javascript:void(0);">
            <i class="fas fa-fw fa-cog"></i>
            <span>기출문제 관리</span>
        </a>
    </li>

    <!-- Divider -->
    <hr class="sidebar-divider">

    <!-- Heading -->
    <div class="sidebar-heading">
       	회원관리
    </div>
    
    <li class="nav-item">
        <a class="nav-link" href="admin_userInfo.jsp">
         <!-- todo. i 태그 :: class를 통해서 아이콘 추가 -->
            <i class="fas fa-fw fa-user"></i>
            <span>회원 정보</span>
        </a>
    </li>
    <li class="nav-item">
        <a class="nav-link" href="admin_buylist.jsp">
            <i class="fas fa-fw fa-cog"></i>
            <span>회원 구매 내역</span>
        </a>
    </li>
    
    <!-- Divider -->
    <hr class="sidebar-divider">

    <!-- Heading -->
    <div class="sidebar-heading">
        마이페이지
    </div>
    
    <li class="nav-item">
        <a class="nav-link" href="admin_post_list.jsp">
         <!-- todo. i 태그 :: class를 통해서 아이콘 추가 -->
            <i class="fas fa-fw fa-user"></i>
            <span>자유게시판 관리</span>
        </a>
    </li>
    <li class="nav-item">
        <a class="nav-link" href="admin_paypost_list.jsp">
            <i class="fas fa-fw fa-cog"></i>
            <span>유료게시판 관리</span>
        </a>
    </li>
    <li class="nav-item">
        <a class="nav-link" href="paypost_agree_list.jsp">
            <i class="fas fa-fw fa-cog"></i>
            <span>유료게시글 승인 관리</span>
        </a>
    </li>
</ul>
<!-- End of Sidebar -->