<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="db.dao.RentalDAO"%>
<%@ page import="db.dto.RentalDTO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<% 
		//연체 현황 조회(연체 처리 로직)
		request.setCharacterEncoding("UTF-8"); //문자 인코딩 설정 한글깨짐 방지

		String returnNo = request.getParameter("OdRentalhiddenId");
		System.out.println("연체 처리 로직으로 이동");
		
		RentalDAO rentalDAO = null;
		int overdueResult = 0; //대여테이블에서의 연체처리
		int rentNoInt = 0; //회원번호 int로 변환
		int overdueMembno = 0; //memberinfo 테이블에서 연체처리
		int convertResult = 0;  //memberinfo 테이블에서 연체처리 결과
		
		if(returnNo != null && returnNo != ""){
			rentalDAO = new RentalDAO();
			rentNoInt = Integer.parseInt(returnNo);
			//대여 테이블에서 연체전환
			overdueResult = rentalDAO.convertStatusToOverdue(rentNoInt);
		}
		
		if(overdueResult > 0){ %>
			<script>
			alert("대여 테이블에서 연체 처리 완료");
			</script>
		<%} else {%>
			<script>
			alert("대여 테이블에서 연체 처리 실패");
			</script>
		<%}
		
		//대여 테이블에서 연체전환이 잘 되었으면
		if(overdueResult != 0){
			//대여번호로 회원번호 조회
			overdueMembno = rentalDAO.findMembnoFromRental(rentNoInt);
			//회원번호로 memberinfo 테이블에서 회원 대여 상태 연체 처리
			convertResult = rentalDAO.convertStatusToOverdueFromMemberInfo(overdueMembno);
			
		}%>
		
		
			<script>
				alert("해당 회원 연체 처리완료");
				location.href="bookRentalSystem.jsp";
			</script>
		
			
		
	
</body>
</html>