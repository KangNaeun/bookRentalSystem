<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="db.dto.ReturnDTO"%>
<%@ page import="db.dao.ReturnDAO"%>

<%@ page import="db.dao.ReserveCompDAO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body> 
	<%
	//반납
	request.setCharacterEncoding("UTF-8"); //문자 인코딩 설정 한글깨짐 방지

	String returnNo = request.getParameter("returnNo");
	
	
	System.out.println(returnNo);
	
	
	int returnNoInt = Integer.parseInt(returnNo); 
	
	ReturnDTO returnDTO = new ReturnDTO(returnNoInt);
	ReturnDAO returnDAO = new ReturnDAO();
	
	//대여번호로 대여테이블에서 책을 'cp'상태로 update하고 comp_date를 syadate로 수정 
	int returnUpdate = returnDAO.returnBookAtRentalTable(returnDTO.getRentno());
	
	//'cp' 상태로 update가 잘 되었으면
	if(returnUpdate > 0){%>
		<script>
		alert("rental 테이블 반납처리 완료");
		</script>
		
		<%
		//회원이 더이상 빌린 책이 없는지 체크
		
		//대여 현황조회에서 이름을 가져와서 조회하기에는 동명이인 가능성 때문에 대여번호로 회원번호 조회
		int rentalMembno = returnDAO.findMembnoAtRentalTable(returnDTO.getRentno());
		
		//rentalDTO객체에 회원 번호 set
		returnDTO.setMembno(rentalMembno);
						
		//위에서 얻은 회원번호로 해당 회원의 미반납 수량조회
		int countRental = returnDAO.countMemberRentalHistory(returnDTO.getMembno());
		
		//해당 회원이 더 이상 빌린 책이 없다면
		if(countRental == 0){
			//회원이 빌린 모든 책이 반납 완료면, 'nrt'로 회원 상태 변경
			//정지 회원이 아닌경우에만!!!!!!!
			int updateStatus = returnDAO.updateMemberStatusToNRT(returnDTO.getMembno());
			
			//'nrt'로 회원 상태 update가 잘되었으면
			if(updateStatus > 0){%>
				<script>
					alert("해당 회원 모든 책 반납완료! 회원상태 미대여로 전환");
				</script>
		<%	}
			
		} else {//반납한 책이 남아있으면 + 연체된 책이 있으면 연체 // 책 남아있고 + 그냥 반납상태면 대여중상태로 전환
			
			//연체 회원이 빌린 책들 중에 연체된 책이 있는지 조사
			int overdueCount = returnDAO.searchOverdueBookCount(returnDTO.getMembno());
			
			if(overdueCount == 0){ //연체상태인데 연체된 책이 더 이상 없으면 회원 상태를'rt'로 상태전환
				int updateToRT =returnDAO.updateMemberStatusToRT(returnDTO.getMembno());
					

			}
			

	 }
	} else{  %> 
		<script>
			alert("반납처리 실패");
		</script>
	<%}
	
	
	ReserveCompDAO reserveCompDAO = new ReserveCompDAO();
	System.out.println("/*/*/*/*/*/*/*/*/*/*/"+returnDTO.getRentno());
	int reserveResult = reserveCompDAO.reserveComp(returnDTO.getRentno());

	if(reserveResult > 0){%>  
		<script>
 			alert("이 책은 예약된 도서입니다. 예약대기자에게 예약이 완료되었습니다."); 
 		</script> 
	<%} 
 	%> 
	
	<script>
		location.href = "bookRentalSystem.jsp";
	</script>
	
	
</body>
</html>