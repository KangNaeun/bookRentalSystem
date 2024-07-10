<%@ page import="db.dto.MemberInfoDTO"%>
<%@ page import="db.dao.MemberInfoDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원추가</title>
</head>
<body>

	<%
		request.setCharacterEncoding("UTF-8"); //문자 인코딩 설정 한글깨짐 방지
		
		//폼에서 전달받은  input 값 각 변수에 저장
		String mname = request.getParameter("insert_add_mname"); //고객이름
		String maddress = request.getParameter("insert_add_maddress");//고객주소
		String mphone = request.getParameter("insert_add_mphone");//고객전화번호
		
		
		MemberInfoDAO addDAO = new MemberInfoDAO(); //addDAO 객체 생성
		
		int result = addDAO.insertMemberInfo(mname, maddress, mphone); //insertMemberInfo메서드를 호출하고 회원정보를 result에 저장, 결과를 int로 반환
		
		if (result > 0) {
	  %>
	  	<script>
	  		alert("저장 성공");
	  		location.href = 'bookRentalSystem.jsp';
	  	</script>
		<% } else { %>
		<script>
	  		alert("저장 실패");
	  		history.back();
	  	</script>
	  	<% } %>
</body>
</html>