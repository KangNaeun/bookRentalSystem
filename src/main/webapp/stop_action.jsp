<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="db.dto.RentalDTO"%>
<%@ page import="db.dao.RentalDAO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	request.setCharacterEncoding("UTF-8"); //문자 인코딩 설정 한글깨짐 방지
	
	// 대여번호를 가져옴
	String stRentno = request.getParameter("StRentalhiddenId");
	
	int rentnoInt = 0;
	if(stRentno != null && stRentno != ""){
		rentnoInt = Integer.parseInt(stRentno);
	}
	
	//정지 전환 로직 (대여테이블 + 회원정보테이블)
	RentalDAO rentalDAO = new RentalDAO();
	if(rentalDAO.updateStopDateFromRental(rentnoInt) > 0){
		if(rentalDAO.convertStatusToStopFromMemberInfo(rentnoInt) > 0){%>
		<script>
			alert("회원 상태 정지 전환");
			location.href="bookRentalSystem.jsp";
		</script>
	<%} else {%>
		<script>
			alert("회원 상태 정지 전환 실패");
			history.back();
		</script>
	<%}
	}
	
	
	
	%>
</body>
</html>