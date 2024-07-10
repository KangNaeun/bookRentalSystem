<%@ page import="db.dao.ReserveStatusDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
		
		// 도서번호와 회원번호를 파라미터로 받는다.
		String membnoStr = request.getParameter("rs-membno");
		String booknoStr = request.getParameter("rs-bookno");
		// int 타입으로 변환
		int membno = Integer.parseInt(membnoStr);
		int bookno = Integer.parseInt(booknoStr);
		
		ReserveStatusDAO reserveStatusDAO = new ReserveStatusDAO();
		// 예약 대기를 진행하는 다오 메서드 호출
		int result = reserveStatusDAO.insertReservation(membno, bookno);
		
		if (result == 0) {%>		
			<script>alert("저장 실패");
			history.back();
			</script>
			
		<%} else { %>
			<script>alert("저장 성공");
			location.href = 'bookRentalSystem.jsp';
			</script>			
	<%}%>
</body>
</html>