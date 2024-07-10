<%@ page import="db.dto.MemberInfoDTO"%>
<%@ page import="db.dao.MemberInfoDAO"%>

<%@ page import="db.dto.MsgDTO"%>
<%@ page import="db.dao.MsgDAO"%>

<%@ page import="db.dto.BookDTO"%>
<%@ page import="db.dto.Book2DTO"%>
<%@ page import="db.dto.Book3DTO"%>
<%@ page import="db.dao.BookDAO"%>

<%@ page import="db.dto.EmployeeDTO"%>
<%@ page import="db.dao.EmployeeDAO"%>

<%@ page import="db.dto.RentalDTO"%>
<%@ page import="db.dao.RentalDAO"%>

<%@ page import="db.dto.ReturnDTO"%>
<%@ page import="db.dao.ReturnDAO"%>

<%@ page import="db.dto.RentalStatusDTO"%>
<%@ page import="db.dao.RentalStatusDAO"%>

<%@ page import="db.dao.ReserveStatusDAO"%>
<%@ page import="db.dto.ReserveStatusDTO"%>

<%@ page import="db.dao.BookInfoDAO"%>
<%@ page import="db.dto.BookInfoDTO"%>

<%@ page import="db.dao.ReserveAbleDAO"%>
<%@ page import="db.dto.ReserveAbleDTO"%>

<%@ page import="db.dao.BookQuantityRentalStatusDAO"%>
<%@ page import="db.dto.BookQuantityRentalStatusDTO"%>

<%@ page import="java.util.*"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Book Rental System</title>
<link href="css/style.css" rel="stylesheet">

</head>
<body>
<%
	//로그인 입력한 값을 기준으로 누구인지 확인
	request.setCharacterEncoding("UTF-8");
   	String ename = (String) session.getAttribute("ename");
   	String empno =  (String) session.getAttribute("empno");/* 로그인액션에서 정보를 받아 이름 확인 */  	
   	
   	//로그인이 정상적으로 완료되었다면
   	if (ename != null && empno != null) {
   		
   	request.setCharacterEncoding("UTF-8"); // 문자 인코딩 설정 한글 깨짐 방지

   	MemberInfoDAO memberDAO = new MemberInfoDAO();
   	List<MemberInfoDTO> memberList = null;

   	RentalDAO rentalDAO = new RentalDAO();
   	List<RentalDTO> rentalList = null;

   	BookDAO bookDAO = new BookDAO();
   	List<Book2DTO> getBookList = null;

   	RentalStatusDAO rentalStatusDAO = new RentalStatusDAO();
   	List<RentalStatusDTO> rentalStatusList = null;

   	boolean isEmptyStr = false;
   	List<String> db_params = new ArrayList<>();
   	String targetStr = null;
   	int targetNo = 0;
   	int targetAllSelect = 0;

   	// 회원 정보 조회
   	String m_membno = request.getParameter("m_membno");
   	String m_mname = request.getParameter("m_mname");
   	String m_mphone = request.getParameter("m_mphone");
   	String m_mstatus = request.getParameter("m_mstatus");

   	// 회원 대여 내역 조회
   	String mr_memberno = request.getParameter("mr_memberno");
   	String mr_membername = request.getParameter("mr_membername");
   	String mr_memberphone = request.getParameter("mr_memberphone");

   	// 대여 현황 조회
   	String rs_rentnoStr = request.getParameter("rs_rentno");
   	String rs_mname = request.getParameter("rs_mname");
   	String rs_bname = request.getParameter("rs_bname");
   	String rs_startDate = request.getParameter("rs_startDate");
   	String rs_endDate = request.getParameter("rs_endDate");
   	String rs_rstatus = request.getParameter("rs_rstatus");

   	// 도서 검색
   	String b_bookno = request.getParameter("b_bookno");
   	String b_bname = request.getParameter("b_bname");
   	String b_bauthor = request.getParameter("b_bauthor");
   	String b_bpublish = request.getParameter("b_bpublish");
   	String b_gname = request.getParameter("b_gname");
   	String b_bcount = request.getParameter("b_bcount");
	
   	//input창의 결과를 String 배열로 생성
   	String[] params = new String[] {
   	    m_membno, m_mname, m_mphone, m_mstatus,
   	    mr_memberno, mr_membername, mr_memberphone,
   	    rs_rentnoStr, rs_mname, rs_bname, rs_startDate, 
   	    rs_endDate, rs_rstatus, b_bookno, b_bname, 
   	    b_bauthor, b_bpublish, b_gname, b_bcount
   	};
   	
	//배열 값이 null이 아니면(""이거나 실제 값이 들어있는 경우)
   	for (int i = 0; i < params.length; i++) {
   	    if (params[i] != null) {
   	        db_params.add(params[i]);
   	        targetAllSelect = i;
   	    }
   	}
	
   	//db_params 에 값이 ""인 경우
	if (db_params.size() != params.length) {
	    for (String param : db_params) {
	        if (param.equals("")) {
	            isEmptyStr = true;
	            break;
	        }
	    }
	}
   	
	//실제로 값이 들어있는 경우 (targetStr에 값, targetNo에는 인덱스를 긁어옴)
	if (!isEmptyStr) {
	    for (int i = 0; i < params.length; i++) {
	        if (params[i] != null) {
	            targetStr = params[i];
	            targetNo = i;
	            break;
	        }
	    }
	    
		//긁어온 값이 null이 아니면
	    if (targetStr != null) {
	        // List<String> targetList = Arrays.asList(params);
	        switch (targetNo) {
	            // 회원 정보 조회
	            case 0:
	                int membnoInt = Integer.parseInt(request.getParameter("m_membno"));
	                memberList = memberDAO.selectMemberInfo(membnoInt);
	                break;
	            case 1:
	                memberList = memberDAO.selectMnameInfo(m_mname);
	                break;
	            case 2:
	                memberList = memberDAO.selectMphoneInfo(m_mphone);
	                break;
	            case 3:
	                memberList = memberDAO.selectMstatusInfo(m_mstatus);
	                break;
	            // 회원 대여 내역 조회
	            case 4:
	                int mr_membernoInt = Integer.parseInt(mr_memberno);
	                rentalList = rentalDAO.selectRentalMemberByNo(mr_membernoInt); // 회원번호로 대여내역 조회
	                break;
	            case 5:
	                rentalList = rentalDAO.selectRentalMemberByName(mr_membername); // 회원이름으로 대여내역 조회
	                break;
	            case 6:
	                rentalList = rentalDAO.selectRentalMemberByPhone(mr_memberphone); // 회원휴대폰번호로 대여내역 조회
	                break;
	            // 대여 현황 조회
	            case 7:
	                int rentno = Integer.parseInt(rs_rentnoStr);
	                rentalStatusList = rentalStatusDAO.selectRentalByRentno(rentno);
	                break;
	            case 8:
	                rentalStatusList = rentalStatusDAO.selectRentalByMname(rs_mname);
	                break;
	            case 9:
	                rentalStatusList = rentalStatusDAO.selectRentalByBname(rs_bname);
	                break;
	            case 10:
	            case 11:
	                rentalStatusList = rentalStatusDAO.selectRentalByStartDateEndDate(rs_startDate, rs_endDate);	            	
	                break;
	            case 12:
	                switch (rs_rstatus) {
	                    case "대여중":
	                        rs_rstatus = "rt";
	                        break;
	                    case "연체중":
	                        rs_rstatus = "od";
	                        break;
	                    case "반납완료":
	                        rs_rstatus = "cp";
	                        break;
	                    case "예약":
	                        rs_rstatus = "rs";
	                        break;
	                    case "예약취소":
	                        rs_rstatus = "cc";
	                        break;
	                }
	                rentalStatusList = rentalStatusDAO.selectRentalByRstatus(rs_rstatus);
	                break;
	            // 도서 정보
	            case 13:
	                if (b_bookno.isBlank()) { 
	%>					
	                    <script>alert("공백 안됨 다시 입력 Go!");</script>  					       						
	<%				
	                } else {
	                    int bookno = Integer.parseInt(b_bookno);
	                    getBookList = bookDAO.getBookNoList(bookno);
	                }     
	                break;
	            case 14:
	                getBookList = bookDAO.getBookNameList(b_bname);
	                break;
	            case 15:
	                getBookList = bookDAO.getBookAuthorList(b_bauthor);
	                break;
	            case 16:
	                getBookList = bookDAO.getBookPublishList(b_bpublish);
	                break;
	            case 17:
	                getBookList = bookDAO.getBookGnameList(b_gname);
	                break;
	            case 18:
	                if (b_bcount.isBlank()) {
	%>				
	                    <script>alert("공백 안됨 다시 입력 Go!");</script>  					
	<%			
	                } else {
	                    int bcount = Integer.parseInt(b_bcount);
	                    getBookList = bookDAO.getBookCountList(bcount);
	                }
	                break;
	        }           			
	    }
	}

	if (isEmptyStr) {
	    // 회원 정보
	    if (targetAllSelect >= 0 && targetAllSelect <= 3) {
	        memberList = memberDAO.selectMemberInfoAll();
	    } else if (targetAllSelect >= 4 && targetAllSelect <= 6) { // 회원 대여 내역 조회
	        // 회원 대여내역 조회는 전체 조회 기능이 X
	    } else if (targetAllSelect >= 7 && targetAllSelect <= 12) { // 대여 현황 조회
	        if (rs_startDate == null && rs_endDate == null) { 
	            rentalStatusList = rentalStatusDAO.selectAllRental();
	        } else {
	            if (rs_startDate.equals("") && !rs_endDate.equals("")) { 
	%>
	                <script>
	                    alert("대여날짜를 입력해주세요!");
	                </script>
	<% 
	            } else if (rs_endDate.equals("") && !rs_startDate.equals("")) { 
	%>
	                <script>
	                    alert("종료범위를 지정해주세요!");
	                </script>
	<% 
	            } else {
	                rentalStatusList = rentalStatusDAO.selectAllRental(); 
	            }
	        }
	    } else if (targetAllSelect >= 13 && targetAllSelect <= 18) { // 도서 정보 조회
	    	getBookList = bookDAO.getBookList();
	    }
	}
	//검색 기능 끝 
	%>
    <div class="header"><h1>도서 대여 시스템</h1></div>
 	<div class="section-title">"<%=ename%>"님 환영합니다.
		<button type="button" class="btn right" onclick="employeeClick()">관리자 공지사항</button>
		<button type="button" class="btn2 right" onclick="logOut()">로그아웃</button></div>
		    <script>
			function logOut(){	
				location.href="logout_action.jsp";
			}
			</script>
	<div class="modal-container notice-container">
        <div class="reserve-status-title">공지사항</div>
        <button id="btn" type="button" class="btn right3" onclick="open830()">공지 추가</button>
        <script>
            function open830() {
                document.querySelector('.notice-add-container').style.display = 'flex';
            }
        </script>
        <div class="btn-close" onclick="close254()">&nbsp;X&nbsp;</div>
        <script>
            function close254() {
                document.querySelector('.notice-container').style.display = 'none';
            }
        </script>
        <div class="reserve-status-table-container">
            <table id="reserve-status-table" style="width: 684px;">
                <thead>
                    <tr>
                        <th>메세지 번호</th>
                        <th>직원 번호</th>
                        <th>메시지</th>
                        <th>공지 날짜</th>
                    </tr>
                </thead>
				<tbody>
					<%
					   List<EmployeeDTO> employeeList = bookDAO.getCommunityList();
					
					   if(employeeList != null){
						   for(EmployeeDTO employee : employeeList) {	
					   %>
						<tr>
						   <td><%=employee.getCommno()%></td>
						   <td><%=employee.getEmp_id()%></td>
						   <td><%=employee.getMessage()%></td>
						   <td><%=employee.getSend_date()%></td>
					   </tr>
					   <%
						   }
					   }
				   %> 
			   </tbody>
			</table>
        </div>
    </div>

	<div class="notice-add-container">
        <div class="reserve-title">공지사항 추가</div>
        <div class="btn-close" onclick="close351()">&nbsp;X&nbsp;</div>
        <script type="text/javascript">
            function close351() {
                document.querySelector('.notice-add-container').style.display = 'none';
            }
        </script>
        <div class="reserve-table-container">
            <br/>
                <form action="community_action.jsp" method="post" id="frm_community">
                    <label> 직원 번호:<input type ="text" id="input_empno" name= "empno" value="<%=empno%>"></label><br/><br/> 
                    <label> 메시지:<input type ="text" id="input-message" name= "message"></label>
                    <center><button type ="submit" id="btn" class="btn" style="background-color: #f5f5f5; margin-top: 10px;">공지 추가</button> </center>
                </form>	
        </div>
    </div>
	
	<div class="modal-container member-message-container">
        <div class="reserve-status-title">메세지 전송내역</div>
        <div class="btn-close btn-reserve-expiration-status-container-close" onclick="open389()">&nbsp;X&nbsp;</div>
        <script>
            function open389() {
                document.querySelector('.member-message-container').style.display = 'none';
            }
        </script>
        <div class="reserve-status-table-container">
            <table id="reserve-status-table" style="width: 684px;">
                <thead>
                    <tr>
                        <th>회원번호</th>
						<th>회원명</th>
						<th>전달한 메세지</th>
						<th>메세지 전달날짜</th>
                    </tr>
                </thead>
				<tbody>
					<%
					request.setCharacterEncoding("UTF-8"); //문자 인코딩 설정 한글깨짐 방지
		
					MsgDAO msgDAO = new MsgDAO();
					List<MsgDTO> msgList = null;
					
					msgList = msgDAO.selectMsgAll();
					
			  		if (msgList != null) {
			           for (MsgDTO msg : msgList) { %>
			           	<tr>
							<td><%=msg.getMembno()%></td>
			           		<td><%=msg.getMname()%></td>
			           		<td class="td"><div class="scroll"><%=msg.getMessage()%></td>
			           		<td><%=msg.getSend_date()%></td>			           		
			           	</tr>
					<% } 
			} else {
				System.out.println("NULL");
			}
          	%>
				</tbody>
			 </table>
	  		<center><button type = 'button' id="btn_msg" onclick="msg()"> 알림메세지전송 </button></center>
      </div>
         
   </div>
   
	<div class="msg-page">
		<div class="msg-page-body">
	      <h2> 알림 메세지 전송 페이지 </h2>
	      <p> 회원번호와 전송할 메세지를 입력하세요.</p>
	  	  <button type="button" id="btn-close-msg-page" onclick="closeMsg()"> X </button>
	  	  <form action='msg_action.jsp' method="post" id="frm_msg">
	  	  		
	  	  		<p> 회원 번호 </p>
		  	  	<p> <input type="text" id="insert_membno" name="insert_msg_membno" placeholder="회원번호입력"> </p>
		  	  	<p> 회원에게 전달할 메세지 </p>
		  	  	<p> <input type="text" id="insert_msg" name="insert_msg_msg" placeholder="회원에게 전달할 입력"> </p>
		 	  <button type = 'submit' id="btn-send" onclick="sendMsg()"> 전송 </button>
	  	  </form>
	
      </div> 
   </div>

   <div class="section-title">
    <span>회원 정보</span>
    &nbsp;&nbsp;
    <button type="button" class="btn" id="btn-add-page" onclick="openAdd()">회원알림</button>
    &nbsp;
    <button type="button" class="btn" id="btn-select-page" onclick="openSelect()">회원추가</button>
   </div>
   
   <div class="add-page">
		
      <div class="add-page-body">
	      <h2> 회원 추가 페이지 </h2>
	      <p>추가할 회원을 입력하세요.</p>
	  	  <button type="button" id="btn-close-add-page" onclick="closeSelect()"> X </button>
	  	  
	  	  <form action='add_action.jsp' method="post" id="frm_add">
	  	  
	  	  		
	  	  		<p> 회원 이름 </p>
		  	  	<p> <input type="text" name="insert_add_mname" placeholder="회원이름 입력"> </p>
		  	  	<p> 회원 주소 </p>
		  	  	<p> <input type="text" name="insert_add_maddress" placeholder="회원 주소 입력"> </p>
		  	  	<p> 회원 전화번호 </p>
		  	  	<p> <input type="text" name="insert_add_mphone" placeholder="회원 전화번호 입력"> </p>
		 	  <button type = 'submit' id="btn-add" onclick="add()"> 추가 </button>
	  	  </form>
	
      </div>
         
   </div>
   
   

	<div class="search-box">
		<div class="search-group">
			<form action='bookRentalSystem.jsp' method="post" id="frm_membno">
				<input type="text" id="input-m-membno" name="m_membno"
					placeholder="회원번호">
				<button type="submit">검색</button>
			</form>
		</div>
		<div class="search-group">
			<form action='bookRentalSystem.jsp' method='post' id="frm_mname">
				<input type="text" id="input-m-mname" name="m_mname" placeholder="회원명">
				<button type="submit">검색</button>
			</form>
		</div>
		<div class="search-group">
			<form action='bookRentalSystem.jsp' method='post' id="frm_mphone">
				<input type="text" id="input-m-mphone" name="m_mphone"
					placeholder="휴대폰번호">
				<button type="submit">검색</button>
			</form>
		</div>
		<div class="search-group">
			<form action='bookRentalSystem.jsp' method='post' id="frm_mstatus">
				<input type="text" id="input-m-mstatus" name="m_mstatus"
					placeholder="대여상태">
				<button type="submit">검색</button>
			</form>
		</div>
	</div>



	<table id="customerTable">
		<thead>
			<tr>
				<th>회원번호</th>
				<th>회원명</th>
				<th>휴대폰번호</th>
				<th>주소</th>
				<th>대여상태</th>
			</tr>
		</thead>
		<tbody>


			<%
			if (memberList != null) {
			%>
			<%
				for (MemberInfoDTO member : memberList) {
				%>
				<tr>
					<td><%=member.getMembno()%></td>
					<td><%=member.getMname()%></td>
					<td><%=member.getMphone()%></td>
					<td><%=member.getMaddress()%></td>
					<td><%=member.getMstatus()%></td>
				</tr>
				<%
				}
			}
			%>



		</tbody>
	</table>


<!-- ******************* 나은 파트 ******************* -->
	<div class="section-title">회원 대여 내역 조회</div>
	
	<div class="search-box">
		<div class="search-group" style="display: flex;">
			<form action='bookRentalSystem.jsp' method='post'>
				<input type="text" id="memberNoInput" name='mr_memberno'
					placeholder="회원번호">
				<button type="submit">검색</button>
			</form>
		</div>
		<div class="search-group" style="display: flex;">
			<form action='bookRentalSystem.jsp' method='post'>
				<input type="text" id="memberNameInput" name='mr_membername'
					placeholder="회원명">
				<button type="submit">검색</button>
			</form>
		</div>
		<div class="search-group">
			<form action='bookRentalSystem.jsp' method='post'>
				<input type="text" id="memberPhoneInput" name='mr_memberphone'
					placeholder="휴대폰번호">
				<button type="submit">검색</button>
			</form>
		</div>
	</div>
	
		
	<!-- 회원 대여내역이 뜨는 부분 -->
	<table id="historyTable">
		<thead>
			<tr>
				<th>대여번호</th>
				<th>회원명</th>
				<th>도서제목</th>
				<th>대여날짜</th>
				<th>반납기한</th>
				<th>연체날짜</th>
				<th>정지날짜</th>
				<th>반납날짜</th>
				<th>대여상태</th>
				<th>반납하기</th>
			</tr>
		</thead>
		
		<tbody>
		<%
			if (rentalList != null) { //조회한 회원 대여 내역이 존재하면
		%>
			<%
				for (int i = 0; i<rentalList.size(); i++) { //조회된 갯수만큼 출력
			%>
			<tr>
				<!-- 회원 대여 번호, 이름 id값 동적 할당 -->
				<td id="membRentalNO<%=i%>" ><%=rentalList.get(i).getRentalno()%></td>
				<td id="membName<%=i%>" ><%=rentalList.get(i).getMname()%></td>
				<td><%=rentalList.get(i).getBookName()%></td>

				<td><%=rentalList.get(i).getrDate()%></td>
				<td><%=rentalList.get(i).getRtDate()%></td>
				
				<!-- 날짜가 null인경우 어떻게 출력할건지 결정 -->
				<td><%=rentalList.get(i).getOdDate() == null ? "" : rentalList.get(i).getOdDate()%></td>
				<td><%=rentalList.get(i).getStDate() == null ? "" : rentalList.get(i).getStDate()%></td>
				<td><%=rentalList.get(i).getCoDate() == null ? "" : rentalList.get(i).getCoDate()%></td>

				<td><%=rentalList.get(i).getrStatus()%></td>

				<% if (!rentalList.get(i).getrStatus().equals("반납완료")) { %>
					<td><button type = 'button' id="btn_return_page<%=i%>" onclick="openConfirmReturn(<%=i%>)">반납</button></td>
				<% } else { %>
					<td></td>
				<% } %>
				<!-- 대여현황조회 form을 위해 hidden 타입의 input창 생성 -->
				<form action="return_action.jsp" method="POST" id="frm-return">
					<input type="hidden" id="returnNoInput" name="returnNo">
				</form>
				
			</tr>
				<%
				} //for문 끝
				%>
			<%
			} //if문 끝
			%>
		</tbody>
	</table>
	
	<div class="section-title">
		<span>대여 현황 조회</span>
        &nbsp;&nbsp;&nbsp;<button type="button" class="btn" onclick="openOverdueList()">연체현황조회</button>
        &nbsp;&nbsp;<button type="button" class="btn" onclick="openStopList()">정지현황조회</button>
        &nbsp;&nbsp;<button type="button" class="btn" onclick="openStopCancelList()">정지해제가능회원조회</button>
		&nbsp;&nbsp;<button type="button" class="btn btn-reserve-status" onclick="open933()">예약내역조회</button>
        <script>
    		function open933() {
    			document.querySelector('.reserve-status-container').style.display = 'flex';
    		}
    	</script>
    	&nbsp;&nbsp;<button type="button" class="btn btn-reserve-expiration-status" onclick="open543()">예약만료내역조회</button>
    	<script>
    		function open543() {
    			document.querySelector('.reserve-expiration-status-container').style.display = 'flex';
    		}
    	</script>
	</div>
	
	<div class="modal-container overdue-status-container">
        <div class="reserve-status-title">연체현황조회</div>
        <div class="btn-close" onclick="closeOverdueList()">&nbsp;X&nbsp;</div>
        <div class="reserve-status-table-container">
            <table id="reserve-status-table" style="width: 684px;">
                <thead>
                    <tr>
                        <th>대여번호</th>
						<th>회원명</th>
						<th>도서제목</th>
						<th>대여날짜</th>
						<th>반납기한</th>
						<th>대여상태</th>
						<th>연체전환</th>
                    </tr>
                </thead>
				<tbody>
				<%
					//td가 6개
					//tr이 행, td가 열
					RentalDAO rentalDAO2 = new RentalDAO();
					List<RentalDTO> overdueMemberList = rentalDAO2.selectOverdueMember();
					if(overdueMemberList != null){
						for(int i=0; i<overdueMemberList.size(); i++){
					
					%>
							<tr>
								<td id="od-rental-no<%=i%>" ><%=overdueMemberList.get(i).getRentalno()%></td>
								<td><%=overdueMemberList.get(i).getMname()%></td>
								<td class="td"><div class="scroll3"><%=overdueMemberList.get(i).getBookName()%></td>
								<td><%=overdueMemberList.get(i).getrDate()%></td>
								<td><%=overdueMemberList.get(i).getRtDate()%></td>
								<td><%=overdueMemberList.get(i).getrStatus()%></td>
								<td><button id="od-btn<%=i%>" onclick="convertToOverdue(<%=i%>)">연체</button></td>
								
								<form action="overdue_action.jsp" method="POST" id="frm-overdue">
									<input type="hidden" id="input-od-rentno" name="OdRentalhiddenId">
								</form>
								
							</tr>
						<%}
					}%>
			</tbody>
		</table>
			
		</div> <!-- overdue-modal-content 끝 -->
		</div> <!-- overdue-modal-body 끝 -->
	</div> <!-- overdue-modal 끝 -->
	
	<div class="modal-container stop-status-container" style="font-size: 0.9em;">
        <div class="reserve-status-title" >정지현황조회</div>
        <div class="btn-close" onclick="closeStopList()">&nbsp;X&nbsp;</div>
        <div class="reserve-status-table-container">
            <table id="reserve-status-table" style="width: 684px;">
                <thead>
                    <tr>
                        <th>대여번호</th>
						<th>회원명</th>
						<th>도서제목</th>
						<th>대여날짜</th>
						<th>반납기한</th>
						<th>연체날짜</th>
						<th>대여상태</th>
						<th>정지전환</th>
                    </tr>
                </thead>
				<tbody>
				<%
					RentalDAO rentalDAO3 = new RentalDAO();
					List<RentalDTO> stopMemberList = rentalDAO2.selectStopMember();
					
					if(stopMemberList != null){
					for(int i=0; i<stopMemberList.size(); i++){
				%>
					<tr>
						<td id="st-rental-no<%=i%>"><%=stopMemberList.get(i).getRentalno()%></td>
						<td><%=stopMemberList.get(i).getMname()%></td>
						<td class="td"><div class="scroll4"><%=stopMemberList.get(i).getBookName()%></td>
						<td><%=stopMemberList.get(i).getrDate()%></td>
						<td><%=stopMemberList.get(i).getRtDate()%></td>
						<td><%=stopMemberList.get(i).getOdDate()%></td>
						<td><%=stopMemberList.get(i).getrStatus()%></td>				
						<td><button id="st-btn<%=i%>" onclick="convertToStop(<%=i%>)">정지</button></td>
						
						<form action="stop_action.jsp" method="POST" id="frm-stop">
							<input type="hidden" id="input-st-rentno" name="StRentalhiddenId">
						</form>
					</tr>
					<%}}%>
			</tbody>
		</table>
			
		</div> <!-- stop-modal-content 끝 -->
		</div> <!-- stop-modal-body 끝 -->
	</div> <!-- stop-modal 끝 -->
	
	<div class="modal-container stop-clear-status-container" style="font-size: 0.9em;">
        <div class="reserve-status-title">정지해제가능회원조회</div>
        <div class="btn-close" onclick="closeStopCancelList()">&nbsp;X&nbsp;</div>
        <div class="reserve-status-table-container">
            <table id="reserve-status-table" style="width: 684px;">
                <thead>
                    <tr>
                        <th>대여번호</th>
						<th>회원명</th>
						<th>도서제목</th>
						<th>연체날짜</th>
						<th>정지기한</th>
						<th>반납날짜</th>
						<th>정지해제</th>
                    </tr>
                </thead>
				<tbody>
				<%
					// 정지해제가능회원조회
					RentalDAO rentalDAO4 = new RentalDAO();
					List<RentalDTO> stopCancelList = rentalDAO4.selectStopCancelMember();
					
					if(stopCancelList != null){
					for(int i=0; i<stopCancelList.size(); i++){
				%>
					<tr>
						<td id="st-cancel-rental-no<%=i%>" ><%=stopCancelList.get(i).getRentalno()%></td>
						<td><%=stopCancelList.get(i).getMname()%></td>
						<td class="td"><div class="scroll4"><%=stopCancelList.get(i).getBookName()%></td>						
						<td><%=stopCancelList.get(i).getOdDate()%></td>
						<td><%=stopCancelList.get(i).getStDate()%></td>
						<td><%=stopCancelList.get(i).getCoDate()%></td>
						<td><button id="st-cancel-btn<%=i%>" onclick="convertToStopCancel(<%=i%>)">해제</button></td>
						
						<form action="stop_cancel_action.jsp" method="POST" id="frm-stop-cancel">
							<input type="hidden" id="input-st-cancel-rentno" name="StCancelRentalhiddenId">
						</form>
					</tr>
					<%}
					}%>
			</tbody>
		</table>
			
		</div> <!-- stop-modal-content 끝 -->
		</div> <!-- stop-modal-body 끝 -->
	</div> <!-- stop-modal 끝 -->
	
	<div class="modal-container reserve-status-container">
        <div class="reserve-status-title">예약내역조회</div>
        <div class="btn-close btn-reserve-status-container-close">&nbsp;X&nbsp;</div>
        
        <div class="reserve-status-table-container">
            <table id="reserve-status-table" style="width: 684px;">
                <thead>
                    <tr>
                        <th>예약번호</th>
                        <th>회원명</th>
                        <th>도서제목</th>
                        <th>예약대기날짜</th> 
                        <th>예약완료날짜</th>    
                        <th>예약상태</th> 
                        <th>구분</th>
                    </tr>
                </thead>
                <tbody>
                <%                
              
                ReserveStatusDAO reserveStatusDAO = new ReserveStatusDAO();
                // 예약내역조회 다오 메서드 호출
                List<ReserveStatusDTO> reserveList = reserveStatusDAO.selectAllReserveStatus();
                
                if (reserveList != null) { 
                		
                	for (int i=0; i< reserveList.size(); i++) { 
                	%>
                	<form action="rt_action.jsp" method="post" id="frm-reserve-rental">
                		<tr>
	                        <td><%=reserveList.get(i).getReserve_id()%></td>
	                        <td><%=reserveList.get(i).getMname()%></td>
	                        <td class="td"><div class="scroll"><%=reserveList.get(i).getBname()%></div></td>
	                        <td><%=reserveList.get(i).getReserve_wait_date()%></td>
	                        <td><%=reserveList.get(i).getReserve_comp_date()%></td>
	                        <td><strong><%=reserveList.get(i).getReserve_status()%></strong></td>
	                        <td>
	                        	<% if (reserveList.get(i).getReserve_status().equals("예약완료")) { %>
		        					<button type="submit" class="btn" >대여</button>
		    					<% } %>
	                        </td>
	                        <input type="hidden" id="input-reserve-rental-bookno" name="bookHiddenId" value="<%=reserveList.get(i).getBookno()%>">
                    		<input type="hidden" id="input-reserve-rental-membno" name="memberId" value="<%=reserveList.get(i).getMembno()%>">
                    	</tr>
                    </form>
                <% } 
                }%>
                </tbody>
            </table>
        </div>
    </div>
    
    <div class="modal-container reserve-expiration-status-container">
        <div class="reserve-status-title">예약만료내역조회</div>
        <div class="btn-close btn-reserve-expiration-status-container-close" onclick="close543()">&nbsp;X&nbsp;</div>
        <script>
    		function close543() {
    			document.querySelector('.reserve-expiration-status-container').style.display = 'none';
    		}
    	</script>
        <div class="reserve-status-table-container">
            <table id="reserve-status-table" style="width: 684px;">
                <thead>
                    <tr>
                        <th>예약번호</th>
                        <th>회원명</th>
                        <th>도서제목</th>
                        <th>예약완료날짜</th>    
                        <th>예약상태</th>
                        <th>구분</th>
                    </tr>
                </thead>
                <tbody>
                <%
                
                // 예약만료내역조회 다오 메서드 호출
                List<ReserveStatusDTO> reserveCancelList = reserveStatusDAO.selectReserveExpirationStatus();
                
                if (reserveCancelList != null) {
                	for (int i = 0; i < reserveCancelList.size(); i++) { %>
                		<form action="reservationCancel_action.jsp" method="post" id="frm-reserve-cancel">
	                		<tr>
	                			<input type="hidden" id="input-rsv-reserve_id" name="rsv_reserve_id">	                			
		                        <td id="param-rsvno<%=i%>"><%=reserveCancelList.get(i).getReserve_id()%></td>
		                        <td><%=reserveCancelList.get(i).getMname()%></td>
		                        <td class="td"><div class="scroll"><%=reserveCancelList.get(i).getBname()%></div></td>
		                        <td><%=reserveCancelList.get(i).getReserve_comp_date()%></td>
		                        <td><strong><%=reserveCancelList.get(i).getReserve_status()%></strong></td>
		                        <% if (reserveCancelList.get(i).getReserve_status().equals("예약완료")) {%>
		                        	<td><button type="submit" class="btn" onclick="reserve_cancel(<%=i%>)">예약취소</button></td>
		                        <% } else { %>
		                        	<td></td>
		                        <% } %>
		                        <script>
		                        	function reserve_cancel(i) {
		                        		let param1 = document.querySelector('#param-rsvno'+i).innerText;
		                        		document.querySelector('#input-rsv-reserve_id').value = param1;
		                        		console.log("text 통과1");
		                        		if (document.querySelector('#input-rsv-reserve_id').value != null) {
		                        			document.querySelector('#frm-reserve-cancel').submit();		                        			
		                        		}
		                        	}
		                        </script>
	                    	</tr>
                    	</form>
                <% } 
                }%>
                </tbody>
            </table>
        </div>
    </div>
    
	<div class="search-box">
        <div class="search-group">
	        <form action="bookRentalSystem.jsp" method="POST" id="frm_rentno">
	            <input type="text" name="rs_rentno" placeholder="대여번호">
	            <button type="submit">검색</button>
	        </form>
        </div>
        <div class="search-group">
	        <form action="bookRentalSystem.jsp" method="POST" id="frm_mname">
	            <input type="text" name="rs_mname" placeholder="회원명">
	            <button type="submit">검색</button>
	        </form>
        </div>
        <div class="search-group">
	        <form action="bookRentalSystem.jsp" method="POST" id="frm_bname">
	            <input type="text" name="rs_bname" placeholder="도서제목">
	            <button type="submit">검색</button>
	        </form>
        </div>  
        <form action="bookRentalSystem.jsp" method="POST" id="frm_date">
            <div class="form-group" style="display: inline-block;">
                <label for="start-date" style="font-size: 1rem;">대여날짜</label>
                <input type="date" name="rs_startDate" style="padding: 7px;">
            </div>&nbsp;
            <div class="form-group" style="display: inline-block;">
                <label for="end-date">종료범위지정</label>
                <input type="date" name="rs_endDate" style="padding: 7px;">
            </div>
            <button type="submit">검색</button>
        </form> 
        <div class="search-group">
        	&nbsp;&nbsp;&nbsp;
        	<form action="bookRentalSystem.jsp" method="POST" id="frm_rstatus">
	            <input type="text" name="rs_rstatus" placeholder="대여상태">
	            <button type="submit">검색</button>
            </form>
        </div>
    </div>
    
	<table id="bookTable">
        <thead>
            <tr>
                <th>대여번호</th>
                <th>회원명</th>
                <th>도서제목</th>
                <th>대여날짜</th> 
                <th>반납기한</th>    
                <th>연체날짜</th> 
                <th>정지날짜</th>  
                <th>반납날짜</th>           
                <th>대여상태</th>
                <th>구분</th>
            </tr>
        </thead>
        <tbody>
            <%if (rentalStatusList != null) {
	        	 for (int i=0; i< rentalStatusList.size(); i++) { %>
	        	 <form action="return_action.jsp" method="post">
		           	<tr>
						<td><%=rentalStatusList.get(i).getRentno()%></td>
		           		<td><%=rentalStatusList.get(i).getMname()%></td>
		           		<td><%=rentalStatusList.get(i).getBname()%></td>
		           		<td><%=rentalStatusList.get(i).getRental_date()%></td>
		           		<td><%=rentalStatusList.get(i).getReturn_date()%></td>
		           		<td><%=rentalStatusList.get(i).getOd_date()%></td>
		           		<td><%=rentalStatusList.get(i).getStop_date()%></td>
		           		<td><%=rentalStatusList.get(i).getComp_date()%></td>
		           		<td><%=rentalStatusList.get(i).getRstatus()%></td>
		           		<td>
		           			<% if (!"반납완료".equals(rentalStatusList.get(i).getRstatus())) { %>
	        					<button type="submit" class="btn">반납</button>
	    					<% } %>
		           		</td>
		           	</tr>
		           		<input type="hidden" name="returnNo" value="<%=rentalStatusList.get(i).getRentno()%>">
	           	</form>
			<% } 
			} else {
				System.out.println("NULL");
			}%>
        </tbody>
    </table>
    
    <div class="section-title">도서 정보
    	&nbsp;&nbsp;&nbsp;<button type="button" class="btn btn-book-quantity-rental-status" onclick="test()">도서별 재고 및 대여현황</button>
        <script>
        function test() {
        	document.querySelector('.book-quantity-rental-status-container').style.display = 'flex';
        }
        </script>
    	<button class="btn right4" onclick="btnClick()">도서추가</button>
    	<button class="btn right5" onclick="bookqClick()">도서 수량 업데이트</button>
    	
    </div>
    <div class="bookadd" id="bookadd">
        <h1> 도서 추가 <button class="right4" onclick="btnClick()">X</button> </h1>
        <form action="bookaddition_action.jsp" method="post" id="frm_book">
            <label> 책 이름 : <input type ="text" id="input_bname" name= "b_bname"> </label><br/>
            <label> 저자 : &nbsp;&nbsp;&nbsp;&nbsp;<input type ="text" id="input_bauthor" name= "b_bauthor"> </label><br/>
            <label> 출판사 : <input type ="text" id="input_bpublish" name= "b_bpublish"> </label><br/>
            <label> 가격 : &nbsp;&nbsp;&nbsp;&nbsp;<input type ="text" id="input_bprice" name= "b_bprice"> </label><br/>
            <label> 분류번호 :     
                <select name="b_genrno">
                    <option id="input_genrno"> 소설 </option>
                    <option id="input_genrno"> 시/에세이 </option>
                    <option id="input_genrno"> 경제/경영 </option>
                    <option id="input_genrno"> 자기계발 </option>
                    <option id="input_genrno"> 만화 </option>
                </select> 
            </label><br/>
            <label> 발행일 : <input type ="date" id="input_bdate" name= "b_bdate"> </label><br/>
            <label> 수량 : &nbsp;&nbsp;&nbsp;&nbsp;<input type ="text" id="input_bcount" name= "b_bcount"> </label><br/><br/>
            <button type = "submit" id="btn" style="border: 1px solid black; background-color: rgb(227, 227, 227);"> 도서 추가 </button>
        </form>
    </div>
    <div class="bookq" id="bookq">
        <h1> 도서 수량 업데이트 <button class="right4" onclick="bookqClick()">X</button> </h1><br/>
        <form action="bookquantity_action.jsp" method="post" id="frm_bookq">
            <label> 책 번호 : <input type ="text" id="input_bookno" name= "b_bookno"> </label><br/><br/>
            <label> 수량 : &nbsp;&nbsp;&nbsp;&nbsp;<input type ="text" id="input_bcount" name= "b_bcount"> </label><br/><br/><br/>
            <button type = "submit" id="btn" style="border: 1px solid black; background-color: rgb(227, 227, 227);"> 도서 수량 업데이트 </button>
        </form>
    </div>
    <div class="search-box">
        <div class="search-group">
        	<form action="bookRentalSystem.jsp" method="post" id="frm_bookno">
	            <input type="text" id="loanSearch1" placeholder="도서번호" name="b_bookno">
	            <button type="submit">검색</button>
            </form>
        </div>
        <div class="search-group">
        	<form action="bookRentalSystem.jsp" method="post">
	            <input type="text" id="loanSearch1" placeholder="도서제목" name="b_bname">
	            <button type="submit">검색</button>
            </form>
        </div>
        <div class="search-group">
        	<form action="bookRentalSystem.jsp" method="post">
	            <input type="text" id="loanSearch2" placeholder="장르명" name="b_gname">
	            <button type="submit">검색</button>
            </form>
        </div>
        <div class="search-group">
        	<form action="bookRentalSystem.jsp" method="post">
	            <input type="text" id="loanSearch2" placeholder="저자" name="b_bauthor">
	            <button type="submit">검색</button>
            </form>
        </div>
        <div class="search-group">
        	<form action="bookRentalSystem.jsp" method="post">
	            <input type="text" id="loanSearch2" placeholder="출판사" name="b_bpublish">
	            <button type="submit">검색</button>
            </form>
        </div>
        <div class="search-group">
        	<form action="bookRentalSystem.jsp" method="post">
	            <input type="text" id="loanSearch2" placeholder="재고" name="b_bcount">
	            <button type="submit">검색</button>
            </form>
        </div>
    </div>
    <table id="loanTable">
        <thead>
            <tr>
                <th>도서번호</th>
                <th>도서제목</th>
                <th>저자</th>
                <th>출판사</th>
                <th>가격</th>
                <th>장르</th>
                <th>발행일</th>
                <th>재고</th>
                <th>대여하기</th>
            </tr>
        </thead>
        <tbody>
	<%	
       	if(getBookList != null){
				for(int i = 0; i< getBookList.size(); i++) {%>				
	             <tr>
	                <td id="b-id<%=i%>"><%=getBookList.get(i).getBookno()%></td>
	                <td id="b-name<%=i%>"><%=getBookList.get(i).getBname()%></td>
	                <td><%=getBookList.get(i).getBauthor()%></td>
	                <td><%=getBookList.get(i).getBpublish()%></td>
	                <td><%=getBookList.get(i).getBprice()%></td>
	                <td><%=getBookList.get(i).getGname()%></td>
	                <td><%=getBookList.get(i).getBdate()%></td>
	                <td><%=getBookList.get(i).getBcount()%></td>
	                <td> <button type = 'button' id="btn-rt-page" onclick="openRt(<%=i%>)">대여</button> </td>
	            </tr>       
		<%	}
		}%>        
 	</tbody>
    </table>
    
    <div class="modal-container book-quantity-rental-status-container">
        <div class="book-reserve-title">도서별 재고 및 대여현황</div>
        <div class="btn-close btn-book-quantity-rental-status-container-close" onclick="close23232()">&nbsp;X&nbsp;</div>
        <script>
        function close23232() {
        	document.querySelector('.book-quantity-rental-status-container').style.display = 'none';
        }
        </script>
        <div class="book-quantity-rental-status-table-container">
            <table id="book-quantity-rental-status-table" style="width: 684px;">
                <thead>
                    <tr>
                        <th>도서번호</th>
                        <th>도서제목</th>
                        <th>대여현황</th>
                        <th>재고</th>
                        <th>상태</th>
                        <th>구분</th>
                    </tr>
                </thead>
                <tbody>
                <%
                BookQuantityRentalStatusDAO b = new BookQuantityRentalStatusDAO();
                
                // ArrayList 생성 후 도서별 재고 및 대여현황 목록을 DB에서 가져온다.
                List<BookQuantityRentalStatusDTO> bList = new ArrayList<BookQuantityRentalStatusDTO>();
                bList = b.selectAllBookQuantityRentalStatus();
                String param_bname = null;       
                int param_bookno = 0; 
                
                // 웹페이지의 출력한다.
                if (bList.size() != 0) {
                	for (int i = 0; i < bList.size(); i++) { %>
	                	<tr>
	                        <td id="param_bookno<%=i%>"><%=bList.get(i).getBookno()%></td>
	                        <td class="td" id="param_bname<%=i%>"><div class="scroll"><%=bList.get(i).getBname()%></div></td>
	                        <td><%=bList.get(i).getRentalStatusCount()%>건</td>
	                        <td><%=bList.get(i).getBcount()%>권</td>
	                        <td><%=bList.get(i).getRentalStatus()%></td>
	                        <td>
	                        	<!-- 예약만 가능할 경우 '예약'버튼을 추가한다. -->
	                        	<%if (bList.get(i).getRentalStatus().equals("예약만 가능")) {%>
	                        		<button id="btn-reserve<%=i%>" class="btn" style="border: 1px solid rgb(83, 83, 83)" onclick="insertReservation(<%=i%>)">
	                        			<script type="text/javascript">
	                        				function insertReservation(i) {
	                        					reserveContainer.style.display = 'flex';
	                        					
	                        					// 도서 정보를 가져온다
	                        					document.querySelector("#rsv-bname").innerText = document.querySelector("#param_bname"+i).innerText;
	                        					document.querySelector("#input_br_bookno").value = document.querySelector("#param_bookno"+i).innerText;
	                        					console.log(document.querySelector("#input_br_bookno").value);	                        	
	                        				}
	                        			</script>
	                        			<strong>예약</strong>
	                        		</button>
	                        	<%}%>
	                        </td>
                    	</tr>
                	<% }
                }
                %>
                </tbody>
            </table>
        </div>
    </div>
    
    <div class="reserve-container">
       	<div class="reserve-title">도서 예약</div>
        <div class="btn-close btn-reserve-container-close" onclick="close52()">&nbsp;X&nbsp;</div>
        <script type="text/javascript">
        	function close52() {
        		document.querySelector('.reserve-container').style.display = 'none';
        	}
        </script>
        <div class="reserve-table-container">
            <form action="reservation_action.jsp" method="post">
                <div style="margin-top: 20px;" class="td"><strong>도서명</strong>
                    <div class="scroll" id="rsv-bname"></div>
                </div>              
               	<input type="text" id="input_br_membno" name="rs-membno" placeholder="회원번호">
               	<input type="hidden" id="input_br_bookno" name="rs-bookno">
               	<button type="submit">전송</button>             
            </form>
        </div>
    </div>
    
    <div class="rt-page">
      <div class="rt-page-body">
         <h2> 대여 페이지 </h2>
          <button type="button" id="btn-close-rt-page" onclick="closeRt()"> X </button>
          
          <form action='rt_action.jsp' method="post" id="frm_rt">
             <p> 도서번호 </p>
             <p id="b-book-id"></p>
             <p> 도서이름 </p>
             <p id="b-book-name"></p>
             <input type="hidden" id="book-hiddenId" name="bookHiddenId">
      
             <p> 회원번호 </p>
             <p> <input type="text" id="search_membno" name="memberId" placeholder="회원번호 입력"> </p>
             
            <button type = 'submit' id="btn-rt"> 대여 </button>
          </form>
      </div>
   </div>
    
    <table id="rankingTable">
    <div class="section-title">인기 도서</div>
    	<thead>
         	<tr>
	             <th>도서 제목</th>
	             <th>저자</th>
	             <th>대여 횟수</th>
	         </tr>
	     </thead>
	     <tbody>
	     	<%
				List<Book3DTO> book3List = bookDAO.getBookRanking();
				for(Book3DTO book : book3List) {%>
	     	<tr>
                <td><%=book.getBname()%></td>
                <td><%=book.getBauthor()%></td>
                <td><%=book.getBcount()%></td>
            </tr>
            <%}%> 
	     </tbody>
    </table>
 <% } else {%>
		<script> 
		alert('로그인을 해주세요'); 
 	location.href = 'empLogin.jsp';	 
 		</script>
	<%}%>
  
<script src="js/script.js"></script>
</body>
</html>

