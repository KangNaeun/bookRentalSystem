<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="db.dto.RentalDTO"%>
<%@ page import="db.dao.RentalDAO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body> 
	<%
	//대여
	request.setCharacterEncoding("UTF-8"); //문자 인코딩 설정 한글깨짐 방지
	
	//도서 정보에서 책 정보 조회 후 대여처리
	String bookId = request.getParameter("bookHiddenId"); //hidden처리된 input창으로 가져온 책 번호
	String memberId = request.getParameter("memberId"); //관리자가 입력한 회원 번호

	System.out.println(bookId);
	System.out.println(memberId);

	int memberIdInt = 0;
	int bookIdInt = 0;

	if (bookId != null && memberId != null) { //String으로 받은 form request가 null이 아니면(값이 잘 들어오면)
		memberIdInt = Integer.parseInt(memberId); //int 형으로 변환
		bookIdInt = Integer.parseInt(bookId);
	}

	RentalDTO rentDTO = new RentalDTO(memberIdInt, bookIdInt); //rentalDTO 객체 생성

	RentalDAO rentDAO = new RentalDAO();

	// 회원 대여 상태 조사
	String memberStatus = rentDAO.searchMemberStatus(rentDTO.getMembno());

	int bookCount = 0;
	int rentedBookCount = 0;
	
	//회원 대여 상태가 미대여라면
	if (memberStatus.equals("nrt")) {

		//회원이 대여한 책 권수 조사(5권 이하로만 빌릴 수 있음)
		if (rentDAO.searchMemberHistoryCount(rentDTO.getMembno()) < 5) {

			//책수량조사
			//도서관이 가지고 있는 해당 책 총수량
			bookCount = rentDAO.searchBookCount(rentDTO.getBookno());
			System.out.println(bookCount);

			//빌려진 책 수량
			rentedBookCount = rentDAO.searchRentedBookCount(rentDTO.getBookno());
			System.out.println(bookCount - rentedBookCount);

			//도서관이 가진 책 수량 - 빌려진 책 수량 > 0 (빌릴 수 있으면)
			if (bookCount - rentedBookCount > 0) {
				//회원 대여상태를 'rt'로 update
				int updateCount = rentDAO.updateRentalMemberStatus(rentDTO.getMembno());
				//rental 테이블에 추가 insert
				int insertCount = rentDAO.insertRentalHistory(rentDTO.getMembno(), rentDTO.getBookno());
				%>
				<script>
					alert("대여 성공");
					location.href = "bookRentalSystem.jsp";
				</script>
				<%
			} else {
				%>
				<script>
					alert("대여할 책의 잔여 수량이 부족합니다. 대여 불가.");
					history.back();
				</script>
				<%
			}
		} else {
			%>
			<script>
				alert("대여 가능 권수(5권) 초과. 대여 불가.");
				history.back();
			</script>
			<%
		}

	} else if (memberStatus.equals("od") || memberStatus.equals("st")) { //회원 대여상태가 연체이거나 정지인 경우
		%>
		<script>
			alert("연체 혹은 정지상태 입니다. 대여 불가.");
			history.back();
		</script>
		<%
	} else if (memberStatus.equals("rt")) { //회원이 대여상태가 대여중인 경우

		//회원이 대여한 책 권수 조사(5권 이하로만 빌릴 수 있음)
		if (rentDAO.searchMemberHistoryCount(rentDTO.getMembno()) < 5) {
			
			//책수량조사
			//도서관이 가지고 있는 해당 책 총수량
			bookCount = rentDAO.searchBookCount(rentDTO.getBookno());
			System.out.println(bookCount);
	
			//빌려진 책 수량
			rentedBookCount = rentDAO.searchRentedBookCount(rentDTO.getBookno());
			System.out.println(bookCount - rentedBookCount);
			
			//도서관이 가진 책 수량 - 빌려진 책 수량 > 0 (빌릴 수 있으면)
			if (bookCount - rentedBookCount > 0) {
				//int updateCount = rentDAO.updateRentalMemberStatus(rentDTO.getMembno()); //회원을 대여상태로 update
				int insertCount = rentDAO.insertRentalHistory(rentDTO.getMembno(), rentDTO.getBookno()); //rental 테이블에 추가 insert
			%>
				<script>
					alert("대여 성공");
					location.href = "bookRentalSystem.jsp";
				</script>
			<%
			} else {
			%>
				<script>
					alert("대여할 책의 잔여 수량이 부족합니다. 대여 불가.");
					history.back();
				</script>
			<%
			}
	
		} else {
			%>
			<script>
				alert("대여 가능 권수(5권) 초과. 대여 불가.");
				history.back();
			</script>
			<%
		}

	} else if (memberStatus.equals("rs")){
		
		// 1) bookIdInt, memberIdInt을 매개변수로 rental 테이블 조회한다 'rs'
		// 2) 조회 결과를 객체로 받아 getter를 이용해서 = bookIdInt, memberIdInt 같으면 대여 DAO 실행
		int rservRtno = rentDAO.searchStatusRSFromRental(rentDTO.getMembno(), rentDTO.getBookno());
		
		if(rservRtno != 0){
			//회원이 대여한 책 권수 조사(5권 이하로만 빌릴 수 있음)
			if (rentDAO.searchMemberHistoryCount(rentDTO.getMembno()) < 5) {

				

				//도서관이 가진 책 수량 - 빌려진 책 수량 > 0 (빌릴 수 있으면)
				
					//회원 대여상태를 'rt'로 update
					int updateCount = rentDAO.updateRentalMemberStatus(rentDTO.getMembno());
					//대여번호를 rt
					int updateCountReserve =  rentDAO.updaterstatusFromRental(rservRtno);
					int deleteCount = rentDAO.deleteReserve(rentDTO.getMembno(), rentDTO.getBookno());
					
					
					if(updateCount != 0 && updateCountReserve != 0 && deleteCount != 0){%>
						<script>
							alert("대여 성공");
							location.href = "bookRentalSystem.jsp";
						</script>
					<%}
					
					
					
				
			} else {
				%>
				<script>
					alert("대여 가능 권수(5권) 초과. 대여 불가.");
					history.back();
				</script>
				<%
			}
		}
		
	}
	%>




</body>
</html>