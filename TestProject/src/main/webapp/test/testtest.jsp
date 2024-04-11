<%@page import="java.net.URL"%>
<%@page import="project.ChoiceBean"%>
<%@page import="project.QuestionBean"%>
<%@page import="java.util.Vector"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="questMgr" class="project.QuestionMgr"/>
<jsp:useBean id="choiceMgr" class="project.ChoiceMgr"/>

<!-- // session 정보 확인하는 내용 -->
<%@ include file="../inc/session.jsp" %>

<!DOCTYPE html>
<html>
<head>
	<!-- // 공통 Head  -->
	<%@ include file="../inc/head.jsp" %>
	
	<style>
		img.red-circle { width: 100px; margin-bottom: -75px; margin-left: -30px; position: relative; pointer-events : none; z-index: 10; }
		img.red-rain { width: 70px; margin-bottom: -75px; margin-left: -30px; position: relative; margin-left: -30px; pointer-events : none; z-index: 10; }
	</style>
	
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
                	
                	
                	
                	<div class="modal" tabindex="-1" style="display:block; backdrop-filter: blur(5px);">
					  <div class="modal-dialog">
					    <div class="modal-content">
					      <div class="modal-header">
					        <h5 class="modal-title">모의 시험 결과</h5>
					        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					      </div>
					      <div class="modal-body">
					        <table class='table table-bordered text-center'>
					        	<thead class="table-dark">
					        		<tr>
					        			<th>과목번호</th>
					        			<th>과목명</th>
					        			<th>정답수</th>
					        			<th>점수</th>
					        			<th>판정</th>
					        		</tr>
					        	</thead>
					        	<tbody>
					        		<tr>
					        			<td>1</td>
					        			<td>소프트웨어 설계</td>
					        			<td>3/10</td>
					        			<td>15점</td>
					        			<td>과락</td>
					        		</tr>
					        		<tr>
					        			<td>2</td>
					        			<td>소프트웨어 설계</td>
					        			<td>3/10</td>
					        			<td>15점</td>
					        			<td>과락</td>
					        		</tr>
					        		<tr>
					        			<td>3</td>
					        			<td>소프트웨어 설계</td>
					        			<td>3/10</td>
					        			<td>15점</td>
					        			<td>과락</td>
					        		</tr>
					        	</tbody>
					        	<tfoot>
					        		<tr>
					        			<td colspan="3" class="table-warning fw-bolder">평균점수</td>
					        			<td> 15점 </td>
					        			<td> 탈락 </td>
					        		</tr>
					        	</tfoot>
					        </table>
					      </div>
					      <div class="modal-footer">
					        <button type="button" class="btn-modal-close btn btn-secondary" data-bs-dismiss="modal">Close</button>
					      </div>
					    </div>
					  </div>
					</div>
                	
                	
                	<div class="row">
                		<div class="col-8 p-4" >
                			<div class="border p-5" style="height: 750px; overflow: hidden; overflow-y: auto;">
                				<h2> 자격증 기출문제 </h2>
	                			<hr/>
	                			<table class="table table-bordered text-center">
	                				<thead class="table-secondary">
	                					<tr>
	                						<th>응시자</th>
	                						<th>자격증명</th>
	                						<th>년도 및 회차</th>
	                						<th>응시 과목</th>
	                					</tr>
	                				</thead>
	                				<tbody>
	                					<tr>
	                						<td>비회원</td>
	                						<td>정보처리기사</td>
        									<td>2022년 1차 시험</td>
	                						<td>1, 2, 3, 4, 5</td>
	                					</tr>
	                				</tbody>
	                			</table>
	                			
	                			<script>
	                				$(document).ready(function() {
	                					// 답안 선택시, 답안지 데이터 변경 
	                					$("#testList li.list-group-item").on("click", function() {
	                						// 선택한 항목 활성화 
	                						$("#testList li.list-group-item").removeClass("active");
	                						$(this).addClass("active");
	                						// 문제번호 
	                						var _question_num = $(this).closest("ul").data("question-num");
	                						// 선택 답안 번호 
	                						var _select_num = $(this).index() + 1;
	                						// 답안지 데이터 변경 
	                						$("#answer"+_question_num).val(_select_num);
	                					});
	                					// 오답노트 추가 
	                					$(".add-wrongNote").on("click", function() {
	                						var _html = "";
	                						$(".add-wrongNote").each(function() {
	                							if ( $(this).is(":checked") ) {
	                								_html += "<span class='btn btn-secondary me-2'> " + $(this).val() + "번	 </span>";
	                								// todo. name 설정
	                								_html += "<input type='hidden' name='wrongnotes' value='" + $(this).val() + "'>";
	                							}
	                						});
	                						$("#wrongNotePlate").html('').append(_html);
	                					});
	                					// 모달창 닫기 이벤트 
	                					$(".btn-close, .btn-modal-close").on("click", function() {
	                						$(".modal").hide();
	                					});
	                				});
	                			</script>
	                			
	                			<div class="p-1" id="testList">
	                			
	                			
	                			
	                				<img class="red-circle" src="./img/circle.gif" alt="grading">
	                				<div class="card mb-3" >
									  <div class="card-header bg-dark text-white">
									    1. UML 다이어그램 중 순차 다이어그램에 대한 설명으로 틀린 것은?
									    <small style="float: right;"> 정답률 : 89.24% </small>
									  </div>
									  <!-- // 문제 번호를 태그 속성에 포함  -->
									  <ul class="list-group list-group-flush mb-3" data-question-num='1'>
									  	<li class="list-group-item" >1. 객체 간의 동적 상호작용을 시간 개념을 중심으로 모델링 하는 것이다.</li>
									  	<!-- // 사용자가 선택한 답안지에 'active' 활성화 -->
									  	<li class="list-group-item active" >2. 객체 간의 동적 상호작용을 시간 개념을 중심으로 모델링 하는 것이다.</li>
									  	<li class="list-group-item" >3. 객체 간의 동적 상호작용을 시간 개념을 중심으로 모델링 하는 것이다.</li>
									  	<li class="list-group-item" >4. 객체 간의 동적 상호작용을 시간 개념을 중심으로 모델링 하는 것이다.</li>
									  </ul>
									  <div class="accordion" id="accordionExample">
					            		<div class="accordion-item">
						        			<h2 class="accordion-header">
							        			<!-- // id 번호 주의 -->
							        			<button class="accordion-button collapsed fw-bolder" type="button" data-bs-toggle="collapse" data-bs-target="#collapse1" aria-expanded="true" aria-controls="collapse1">
							        				해설 및 정답 보기
							        			</button>
						        			</h2>
							        		<div id="collapse1" class="accordion-collapse collapse">
										      <div class="accordion-body">
										        <strong>정답 : 2 </strong> 
										      </div>
										    </div>
								    	</div>
								      </div>
								      <div class="ps-3 pe-3 pt-2 pb-2">
					            		<div class="form-check">
						            	  <!-- // id 주의, value는 문제번호 -->
										  <input class="form-check-input add-wrongNote" type="checkbox" value="1" id="flexCheckChecked1" >
										  <label class="form-check-label" for="flexCheckChecked1"> 오답노트에 추가 </label>
										</div>
									  </div>
									</div>
									
									
									
									<img class="red-rain" src="./img/rain.gif" alt="grading">
									<div class="card mb-3" >
									  <div class="card-header bg-dark text-white">
									    2. UML 다이어그램 중 순차 다이어그램에 대한 설명으로 틀린 것은?
									    <small style="float: right;"> 정답률 : 89.24% </small>
									  </div>
									  <ul class="list-group list-group-flush mb-3" data-question-num='2'>
									  	<li class="list-group-item" >1. 객체 간의 동적 상호작용을 시간 개념을 중심으로 모델링 하는 것이다.</li>
									  	<li class="list-group-item" >2. 객체 간의 동적 상호작용을 시간 개념을 중심으로 모델링 하는 것이다.</li>
									  	<li class="list-group-item active" >3. 객체 간의 동적 상호작용을 시간 개념을 중심으로 모델링 하는 것이다.</li>
									  	<li class="list-group-item" >4. 객체 간의 동적 상호작용을 시간 개념을 중심으로 모델링 하는 것이다.</li>
									  </ul>
									  <div class="accordion" id="accordionExample">
					            		<div class="accordion-item">
						        			<h2 class="accordion-header">
							        			<button class="accordion-button collapsed fw-bolder" type="button" data-bs-toggle="collapse" data-bs-target="#collapse2" aria-expanded="true" aria-controls="collapse2">
							        				해설 및 정답 보기
							        			</button>
						        			</h2>
							        		<div id="collapse2" class="accordion-collapse collapse">
										      <div class="accordion-body">
										        <strong>정답 : 3 </strong> 
										      </div>
										    </div>
								    	</div>
								      </div>
								      <div class="ps-3 pe-3 pt-2 pb-2">
					            		<div class="form-check">
										  <input class="form-check-input add-wrongNote" type="checkbox" value="2" id="flexCheckChecked2" >
										  <label class="form-check-label" for="flexCheckChecked2"> 오답노트에 추가 </label>
										</div>
									  </div>
									</div>
									
									
	                				
	                			</div>
                			</div>
                		</div>
                		<div class="col-4 p-4">
                			<div class="border p-5" style="height: 750px; overflow: hidden; overflow-y: auto;">
                				<h2> OMR 답안지 </h2>
                				<hr/>
                				<div class="p-2">
                					<form id="" name="" method="POST">
	                					<table class="table table-sm table-bordered text-center">
	                						<colgroup>
	                							<col style="width: 40%;">
	                							<col style="width: *;">
	                						</colgroup>
	                						<thead class="table-dark">
	                							<tr>
	                								<th> 문제번호 </th>
	                								<th> 제출답안 </th>
	                							</tr>
	                						</thead>
	                						<tbody>
	                							<tr>
	                								<td>1</td>
	                								<td>
	                									<input type="text" id="answer1" name="" class="form-control form-control-sm border-0 bg-white text-center" readonly value="2">
	                								</td>
	                							</tr>
	                							<tr>
	                								<td>2</td>
	                								<td>
	                									<input type="text" id="answer2" name=""  class="form-control form-control-sm border-0 bg-white text-center" readonly value="3">
	                								</td>
	                							</tr>
	                						</tbody>
	                					</table>
                					</form>
                					<button type="button" id="btn-correct-modal" class="btn btn-primary w-100"> 채점하기 </button>
                				</div>
                				<hr/>
                				<div class="p-1">
                					<h3> 오답노트 장바구니 </h3>
                					<form id="" name="" method="POST">
	                					<div class="card mb-3">
										   <div class="card-body" id="wrongNotePlate"></div>
										</div>
										<button type="button" class="btn btn-primary w-100">저장하기</button>
									</form>
                				</div>
                				
                			</div>
                		</div>
                	</div>
                	
                	
                	<!-- // 컨텐츠 입력 end -->
                </div>
            </div>
        </div>
    </div>
    <!-- // 사이드 메뉴 영역  -->
	<%@ include file="../inc/footer.jsp" %>
</body>
</html>