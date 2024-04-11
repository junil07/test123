<%@ page contentType="text/html; charset=UTF-8"%>
<%
String btn_log_id = "btn-login";
String btn_log_name = "로그인";
if ( sess != null ) {
	btn_log_id = "btn-logout";
	btn_log_name = "로그아웃";
}

%>
<form method="post" id="testDataFrm" >
   			<input type="hidden" name="url" value="<%=url%>"> 
</form>
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
			<button type="button" class="btn btn-primary" id="<%=btn_log_id%>"><%=btn_log_name%></button>
        </li>
    </ul>
</nav>
<script>
	$(document).ready(function() {
		// 로그인 버튼 이벤트
		$("#btn-login").on("click", function() {
			//location.href = "../user/login.jsp?url=" + location.href;
				$("#testDataFrm").attr("action", "../user/login.jsp");
				$("#testDataFrm").submit();
			
		});
		// 로그아웃 버튼 이벤트 
		$("#btn-logout").on("click", function() {
			$("#testDataFrm").attr("action", "../user/logout.jsp");
			$("#testDataFrm").submit();
		});
	});
</script>
<!-- End of Topbar -->
