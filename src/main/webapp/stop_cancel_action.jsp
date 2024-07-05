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
	
	String StCancelRentno = request.getParameter("StCancelRentalhiddenId");
	
	//정지상태 해제
	int StCancelRentnoInt = 0;
	
	if(StCancelRentno != null && StCancelRentno != ""){
		StCancelRentnoInt = Integer.parseInt(StCancelRentno);
	}
	
	RentalDAO rentalDAO = new RentalDAO();
	//대여번호에서 회원번호 가져옴
	int stCancelMembno = rentalDAO.findMembnoFromRental(StCancelRentnoInt);
	System.out.println(stCancelMembno);
	
	int stCancelResult = rentalDAO.convertStatusFromMemberInfo(stCancelMembno);
	
	System.out.println(stCancelResult);
	if(stCancelResult > 0){%>
		<script>
			alert("회원 정지 상태 해제 !");
			location.href="bookRentalSystem.jsp";
		</script>
	<%}
	
	
	%>

</body>
</html>