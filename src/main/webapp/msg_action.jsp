<%@ page import="db.dto.MsgDTO"%>
<%@ page import="db.dao.MsgDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>알림메세지전송</title>
</head>
<body> 

	<%
		request.setCharacterEncoding("UTF-8"); //문자 인코딩 설정 한글깨짐 방지
		
		//폼에서 전달받은  input 값 각 변수에 저장
		String membno = request.getParameter("insert_msg_membno");
		String message = request.getParameter("insert_msg_msg");
		
		System.out.println(membno);
		System.out.println(message);
		
		
		int membnoInt = 0;
		
		if(membno != null && membno != ""){
			membnoInt = Integer.parseInt(membno);
		} else { %>
			<script>alert("회원번호에 숫자를 입력해주세요");</script>
		<%}%>
		<%

		
		MsgDAO msgDAO = new MsgDAO(); //msgDAO 객체 생성
		
		int result = msgDAO.insertMessage(membnoInt, message);//insertMessage메서드를 호출하고 알림을 전송할 내용을 result에 저장, 결과를 int로 반환
		
		System.out.println(result);
		
		if(result > 0){%>
			<script>
				alert("회원 알림 메세지 전송 완료");
				location.href="bookRentalSystem.jsp";
			</script>
		<%} else {%>
			<script>
				alert("회원 알림 메세지 전송 실패");
				location.href="bookRentalSystem.jsp";
			</script>
		<%}
	 	 %>

</body>
</html>