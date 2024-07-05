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
	<h1>"reserveCancel_action.jsp" Page</h1>
	
	<% 
		request.setCharacterEncoding("UTF-8");
		
		String str_reserve_id = request.getParameter("rsv_reserve_id");
		int reserve_id = Integer.parseInt(str_reserve_id);
		System.out.println(reserve_id);
		
		ReserveCancelDAO cancelDAO = new ReserveCancelDAO();
		int result = cancelDAO.insertReserveCancel(reserve_id);
		
		if (result != 0) {%>
			<script>
				alert("저장 성공");
				location.href = 'bookRentalSystem.jsp';
			</script>
		<%} else {%>
			<script>
				alert("저장실패");
				history.back();
			</script>
		<%}
	%>
</body>
</html>