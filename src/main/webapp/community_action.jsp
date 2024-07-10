<%@ page import="db.dao.BookDAO" %>
<%@ page import="db.dto.EmployeeDTO" %>
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
		request.setCharacterEncoding("UTF-8");	//문자 인코딩 설정 - 한글깨짐 방지
		System.out.println(request.getParameter("empno"));		//request - 요청 , response - 응답 
		System.out.println(request.getParameter("message"));
		
		//request.getParameter 결과 -> String
		String empno = request.getParameter("empno");	//int는 쓸수 없음 대신 integer로 받아서 저장
		String message = request.getParameter("message");
	
		BookDAO bookDAO = new BookDAO();
 		int result = bookDAO.setCommunity(empno, message);
	
		if ( result > 0 ){
	%>
		<script>
			alert('공지 추가 완료');
			location.href = 'bookRentalSystem.jsp';	
		</script>
	<%	
		} else {
	%>		
		<script>
			alert('공지 추가 실패');
			history.back();	//뒤로가기		//addDept.jsp 저장하려는 페이지 -> 추가 -> addDept_action.jsp
		</script>
	<% 
		}	
		
	%>
</body>
</html>