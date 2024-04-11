<%@ page contentType="text/html; charset=UTF-8"%>
<%
int test = 3;
System.out.println(test);
%>

<!DOCTYPE HTML>
<html lang="ko">
	<head>
		<meta charset="utf-8">
		
		<!-- Custom fonts for this template-->
	    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet" type="text/css">
	    <link
	        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	        rel="stylesheet">
			
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
		
		<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
		
		<link href="assets/css/sb-admin-2.min.css" rel="stylesheet">
		<!--<link href="assets/css/sb-admin-2.css" rel="stylesheet">-->
		
		<title> 포인트 </title>
	</head>
	<body id="page-top">

    <!-- Page Wrapper -->
    <div id="wrapper">

        <!-- Sidebar -->
        <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

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
                <a class="nav-link" href="javascript:void(0);">
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
                <a class="nav-link" href="javascript:void(0);">
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

        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">

            <!-- Main Content -->
            <div id="content">

                <!-- Topbar -->
                <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

                    <!-- Sidebar Toggle (Topbar) -->
                    <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
                        <i class="fa fa-bars"></i>
                    </button>

                    <!-- Topbar Navbar -->
                    <ul class="navbar-nav ml-auto">

                        <!-- Nav Item - User Information -->
                        <li class="nav-item dropdown no-arrow">
                        	
                            <!-- Dropdown - User Information -->
                            <button type="button" class="btn btn-primary">로그아웃</button>
                            
                        </li>

                    </ul>

                </nav>
                <!-- End of Topbar -->

                <!-- Begin Page Content -->
                <div class="container-fluid">

                    <!-- Page Heading -->
                    <div class="d-sm-flex align-items-center justify-content-between mb-4">
                        <h1 class="h3 mb-0 text-gray-800">포인트</h1>
                    </div>
					
					<div class="">
						<!-- // main contents -->
						
					
					</div>
                    
                </div>
                <!-- /.container-fluid -->

            </div>
            <!-- End of Main Content -->

        </div>
        <!-- End of Content Wrapper -->

    </div>
    <!-- End of Page Wrapper -->

    <!-- Scroll to Top Button-->
    <a class="scroll-to-top rounded" href="#page-top">
        <i class="fas fa-angle-up"></i>
    </a>

    <!-- Logout Modal-->
    <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">Select "Logout" below if you are ready to end your current session.</div>
                <div class="modal-footer">
                    <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
                    <a class="btn btn-primary" href="login.html">Logout</a>
                </div>
            </div>
        </div>
    </div>

    
    <!-- Core plugin JavaScript-->
    <script src="assets/js/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="assets/js/sb-admin-2.min.js"></script>

</body>
</html>