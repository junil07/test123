<%@page import="table.TableListBean"%>
<%@page import="java.util.Vector"%>
<%@page import="table.TableListMgr"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	TableListMgr varmgr = new TableListMgr();
	Vector<TableListBean> varvlist = varmgr.getTableList();
%>

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
        Board
    </div>

    <!-- Nav Item - Pages Collapse Menu -->
    <%for(int i=0; i<varvlist.size(); i++) {
    	TableListBean varbean = varvlist.get(i);%>
    <li class="nav-item">
        <a class="nav-link" href="Notice.jsp;">
            <i class="fas fa-fw fa-cog"></i>
            <span><%= varbean.getTablelist_name()%></span>
        </a>
    </li>
    <%} %>
    

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