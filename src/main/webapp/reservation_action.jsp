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
	
		String membnoStr = request.getParameter("rs-membno");
		String booknoStr = request.getParameter("rs-bookno");
		int membno = Integer.parseInt(membnoStr);
		int bookno = Integer.parseInt(booknoStr);
		
		System.out.println("reservation_action.jsp");
		System.out.println(membno);
		System.out.println(bookno);
		
		ReserveStatusDAO reserveStatusDAO = new ReserveStatusDAO();
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