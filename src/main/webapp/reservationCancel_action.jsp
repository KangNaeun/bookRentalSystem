<%@ page import="db.dao.ReserveCancelDAO" %>
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
		
		// 예약번호를 파라미터로 받는다.
		String str_reserve_id = request.getParameter("rsv_reserve_id");
		int reserve_id = Integer.parseInt(str_reserve_id);
		
		// 예약을 취소하는 다오 메서드를 호출
		ReserveCancelDAO cancelDAO = new ReserveCancelDAO();
		int result = cancelDAO.insertReserveCancel(reserve_id);
		int result2 = cancelDAO.insertReserveCancelChangeToNrt(reserve_id);
		
		if (result != 0) {%>
			<script>
				alert("예약취소 성공");
				<% if (result2 != 0) { %>
					alert("예약 취소한 회원 다시 nrt로 변경 성공");
					location.href = 'bookRentalSystem.jsp';
				<%}%>
				location.href = 'bookRentalSystem.jsp';
			</script>
		<%} else {%>
			<script>
				alert("예약취소 실패");
				history.back();
			</script>
		<%}%>
</body>
</html>