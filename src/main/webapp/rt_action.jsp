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

	// 회원번호와 도서번호를 'int'로 변환하기 위한 변수 초기화 과정
	int memberIdInt = 0;
	int bookIdInt = 0;

	//String으로 받은 form request가 null이 아니면(값이 잘 들어오면)
	if (bookId != null && memberId != null) { 
		//int 형으로 변환
		memberIdInt = Integer.parseInt(memberId); 
		bookIdInt = Integer.parseInt(bookId);
	}

	// 회원번호와 도서번호를 DTO 객체 생성 매개변수에 넣고 해당 회원 객체를 생성
	RentalDTO rentDTO = new RentalDTO(memberIdInt, bookIdInt);
	RentalDAO rentDAO = new RentalDAO();

	// 해당 회원의 회원번호를 가져와 회원 대여 상태를 조사하는 DAO 메서드의 매개변수에 넣는다.
	String memberStatus = rentDAO.searchMemberStatus(rentDTO.getMembno());

	int bookCount = 0; 			// 도서 재고량
	int rentedBookCount = 0;	// 대여중인 도서량
	
	//회원 대여 상태가 미대여(nrt) 또는 대여(rt) 또는 예약(rs)이면
	if (memberStatus.equals("nrt") || memberStatus.equals("rt") || memberStatus.equals("rs")) {		
		//회원이 대여한 책 권수 조사(5권 이하로만 빌릴 수 있음)
		if (rentDAO.searchMemberHistoryCount(rentDTO.getMembno()) < 5) {
			
			//책수량조사
			//도서관이 가지고 있는 해당 책 총수량
			bookCount = rentDAO.searchBookCount(rentDTO.getBookno());
			
			//현재 해당 도서가 몇권 대여중인지 조사
			rentedBookCount = rentDAO.searchRentedBookCount(rentDTO.getBookno());
			
			// 1) bookIdInt, memberIdInt을 매개변수로 rental 테이블 조회한다(만약 조회가 된다면 대여변호를 변수에 저장)
			int rentNo = rentDAO.searchStatusRSFromRental(rentDTO.getMembno(), rentDTO.getBookno());
			
			//도서관이 가진 책 수량 - 빌려진 책 수량 > 0 (빌릴 수 있으면)
			if (rentNo == 0) {
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
			// rentNo가 0이 아니라면 해당 회원은 해당 도서의 예약이 완료되었기 때문에 대여가 가능하다는 뜻이므로 대여 진행 가능
			} else { 
				//회원 대여상태를 대여중(rt)로 UPDATE
				int updateCount = rentDAO.updateRentalMemberStatus(rentDTO.getMembno());
			
				//대여현황 테이블에서 해당 도서번호로 예약중인 대여번호를 대여중(rt)로 UPDATE
				int updateCountReserve = rentDAO.updaterstatusFromRental(rentNo);
				
				// 예약 대기열(reservation 테이블)에서 해당 도서로 예약을 완료한 건은 삭제한다.
				int deleteCount = rentDAO.deleteReserve(rentDTO.getMembno(), rentDTO.getBookno());					
				
				if(updateCount != 0 && updateCountReserve != 0 && deleteCount != 0){%>
					<script>
						alert("대여 성공");
						location.href = "bookRentalSystem.jsp";
					</script>
				<%}				
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
	} %>
</body>
</html>