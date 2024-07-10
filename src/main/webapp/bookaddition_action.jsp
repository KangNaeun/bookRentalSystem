<%@ page import="db.dao.BookDAO" %>
<%@ page import="db.dto.BookDTO" %>
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
		System.out.println(request.getParameter("b_bname"));		//request - 요청 , response - 응답 
		System.out.println(request.getParameter("b_bauthor"));
		System.out.println(request.getParameter("b_bpublish"));
		System.out.println(request.getParameter("b_bprice"));
		System.out.println(request.getParameter("b_genrno"));
		System.out.println(request.getParameter("b_bdate"));
		System.out.println(request.getParameter("b_bcount"));
		
		//request.getParameter 결과 -> String
		String bname = request.getParameter("b_bname");
		String bauthor = request.getParameter("b_bauthor");
		String bpublish = request.getParameter("b_bpublish");
		//int는 쓸수 없음 대신 integer로 받아서 저장
		int bprice = Integer.parseInt(request.getParameter("b_bprice"));	
		String genrnoSTR = request.getParameter("b_genrno");
		
		int genrno = 0;
		
		switch (genrnoSTR){
		
		case "소설" :
			genrno = 1 ;
			break;
		case "시/에세이" :
			genrno = 2 ;
			break;
		case "경제/경영" :
			genrno = 3 ;
			break;
		case "자기계발" :
			genrno = 4 ;
			break;
		case "만화" :
			genrno = 5 ;
			break;
		}
		
		String bdate = request.getParameter("b_bdate");
		// 도서 재고 파라미터 값 저장
		int bcount = Integer.parseInt(request.getParameter("b_bcount"));
	
		BookDAO bookDAO = new BookDAO();
		
		// 도서 추가
		int result = bookDAO.bookaddition(bname, bauthor, bpublish, bprice, genrno, bdate);
		// 도서 재고 추가
		int result2 = bookDAO.bookquantity(bcount);	
		
		if ( result > 0 && result2 > 0){
	%>
		<script>
			alert('저장 성공');
			location.href = 'bookRentalSystem.jsp';	//
		</script>
	<%	
		} else {
	%>		
		<script>
			alert('저장 실패');
			history.back();	//뒤로가기		//addDept.jsp 저장하려는 페이지 -> 추가 -> addDept_action.jsp
		</script>
	<% 
		}	
		
	%>
</body>
</html>