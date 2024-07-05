package db.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import db.dto.RentalDTO;
import db.util.DBConnectionManager;

public class RentalDAO {
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	//예약테이블에서 예약내역 삭제
	public int deleteReserve(int membno, int bookno) {
		int rsDeleteStatus = 0;

		try {

			conn = DBConnectionManager.connectDB();

			String query = " delete from reservation where membno = ? and bookno = ? ";

			psmt = conn.prepareStatement(query);
			psmt.setInt(1, membno);
			psmt.setInt(2, bookno);

			rsDeleteStatus = psmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionManager.disconnectDB(conn, psmt, rs);
		}

		return rsDeleteStatus;
	}
	
	
	//대여테이블에서 예약된 대여 건의 대여번호를 가져오는 메소드
		public int updaterstatusFromRental(int rservRtno) {
				int rsRentalResult = 0;
				try {

					conn = DBConnectionManager.connectDB();

					String query = " update rental set rstatus_id = 'rt' where rentno = ? ";

					psmt = conn.prepareStatement(query);
					psmt.setInt(1, rservRtno);
					

					rsRentalResult = psmt.executeUpdate();

					
					
					

				} catch (SQLException e) {
					e.printStackTrace();
				} finally {
					DBConnectionManager.disconnectDB(conn, psmt, rs);
				}

				return rsRentalResult;
		}
	
	
	
	
	//대여테이블에서 예약된 대여 건의 대여번호를 가져오는 메소드
	public int searchStatusRSFromRental(int membno, int bookno) {
			int rsRentalResult = 0;
			try {

				conn = DBConnectionManager.connectDB();

				String query = " select rentno from rental where membno = ? and bookno = ? and rstatus_id = 'rs' ";

				psmt = conn.prepareStatement(query);
				psmt.setInt(1, membno);
				psmt.setInt(2, bookno);

				rs = psmt.executeQuery();

				if (rs.next()) {
					rsRentalResult = rs.getInt("rentno");
				}

			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				DBConnectionManager.disconnectDB(conn, psmt, rs);
			}

			return rsRentalResult;
	}
	
	
	
	
	
	
	
	
	
	//정지 상태를 해제
	public int convertStatusFromMemberInfo(int membno) {
		int convertResult = 0;

		try {

			conn = DBConnectionManager.connectDB();

			String query = " UPDATE memberinfo "
					+ "SET mstatus_id = "
					+ "    CASE WHEN ( select count(*) from rental where membno = ? and rstatus_id != 'cp' ) = 0 "
					+ "            THEN 'nrt' "
					+ "        ELSE "
					+ "            CASE "
					+ "                WHEN ( select count(*) from rental where membno = ? and rstatus_id = 'st' ) > 0 THEN 'st' "
					+ "                WHEN ( select count(*) from rental where membno = ? and rstatus_id = 'od' ) > 0 THEN 'od' "
					+ "                WHEN ( select count(*) from rental where membno = ? and rstatus_id = 'rt' ) > 0 THEN 'rt' "
					+ "                WHEN ( select count(*) from rental where membno = ? and rstatus_id = 'rs' ) > 0 THEN 'rs' "
					+ "            END "
					+ "    END "
					+ "WHERE membno = ? ";

			psmt = conn.prepareStatement(query);
			psmt.setInt(1, membno);
			psmt.setInt(2, membno);
			psmt.setInt(3, membno);
			psmt.setInt(4, membno);
			psmt.setInt(5, membno);
			psmt.setInt(6, membno);
			
			

			convertResult = psmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionManager.disconnectDB(conn, psmt, rs);
		}

		return convertResult;
	}
	
	//정지 상태를 해제할 수 있는 회원 조회
	public List<RentalDTO> selectStopCancelMember(){
		RentalDTO rentalMember = null;
		List<RentalDTO> rentalList = null;

		try {
			conn = DBConnectionManager.connectDB();

			String query = " select r.rentno 대여번호, m.mname 회원이름, b.bname 도서제목, TO_CHAR(r.od_date, 'YY/MM/DD') 연체날짜, TO_CHAR(r.stop_date, 'YY/MM/DD') 정지날짜, TO_CHAR(r.comp_date, 'YY/MM/DD') 반납날짜 "
					+ " from rental r, memberinfo m, book b "
					+ " where r.comp_date +7 < SYSDATE "
					+ " and r.bookno = b.bookno "
					+ " and r.membno = m.membno "
					+ " and r.stop_date is not null "
					+ " and r.comp_date is not null "
					+ " and m.mstatus_id = 'st' ";

			psmt = conn.prepareStatement(query);

			rs = psmt.executeQuery();

			while (rs.next()) {
				if(rentalMember == null){
					rentalMember = new RentalDTO();
				}
				if (rentalList == null) {
					rentalList = new ArrayList<RentalDTO>();
				}

				int rsRno = rs.getInt("대여번호");
				String rsMname = rs.getString("회원이름");
				String rsBname = rs.getString("도서제목");
				
				String rsOddate = rs.getString("연체날짜");
				String rsStdate = rs.getString("정지날짜");
				String rsCodate = rs.getString("반납날짜");
				
				
				rentalMember.setRentalno(rsRno);
				rentalMember.setMname(rsMname);
				rentalMember.setBookName(rsBname);
				
				rentalMember.setOdDate(rsOddate);
				rentalMember.setStDate(rsStdate);
				rentalMember.setCoDate(rsCodate);
				

				rentalList.add(rentalMember);

			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionManager.disconnectDB(conn, psmt, rs);
		}

		return rentalList;
	}
	
	//대여 테이블에서 정지 날짜 update
		public int updateStopDateFromRental(int rentno) {
			int convertResult = 0;

			try {

				conn = DBConnectionManager.connectDB();

				String query = " UPDATE rental "
						+ "SET stop_date = SYSDATE, rstatus_id = 'st' "
						+ "WHERE rentno = ? ";

				psmt = conn.prepareStatement(query);
				psmt.setInt(1, rentno);
				

				convertResult = psmt.executeUpdate();

			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				DBConnectionManager.disconnectDB(conn, psmt, rs);
			}

			return convertResult;
		}
	
	//회원정보 테이블에서 정지처리
	public int convertStatusToStopFromMemberInfo(int rentno) {
		int convertResult = 0;

		try {

			conn = DBConnectionManager.connectDB();

			String query = " UPDATE memberinfo "
					+ " SET mstatus_id = 'st' "
					+ " WHERE membno = ( select membno from rental where rentno = ? ) ";

			psmt = conn.prepareStatement(query);
			psmt.setInt(1, rentno);
			

			convertResult = psmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionManager.disconnectDB(conn, psmt, rs);
		}

		return convertResult;
	}
	
	
	//정지 현황 조회
	public List<RentalDTO> selectStopMember() {

		RentalDTO rentalMember = null;
		List<RentalDTO> rentalList = null;

		try {
			conn = DBConnectionManager.connectDB();

			String query = " select r.rentno 대여번호, m.mname 회원이름, b.bname 도서제목, "
					+ " TO_CHAR(r.rental_date, 'YY/MM/DD') 대여날짜, TO_CHAR(r.return_date, 'YY/MM/DD') 반납기한, TO_CHAR(r.od_date, 'YY/MM/DD') 연체날짜, rs.rstatus 대여상태 "
					+ " from rental r, memberinfo m, book b, rental_status rs "
					+ " where r.membno = m.membno "
					+ " and r.rstatus_id = rs.rstatus_id "
					+ " and r.bookno = b.bookno "
					+ " and od_date is not null "
					+ " and od_date +7 < SYSDATE "
					+ " and m.mstatus_id != 'st' ";

			psmt = conn.prepareStatement(query);

			rs = psmt.executeQuery();

			while (rs.next()) {
				if (rentalList == null) {
					rentalList = new ArrayList<RentalDTO>();
				}

				int rsRno = rs.getInt("대여번호");
				String rsMname = rs.getString("회원이름");
				String rsBname = rs.getString("도서제목");
				
				String rsRdate = rs.getString("대여날짜");
				String rsRedate = rs.getString("반납기한");
				String rsOddate = rs.getString("연체날짜");
				String rsRstatus = rs.getString("대여상태");

				rentalMember = new RentalDTO(rsRno, rsMname, rsBname,
						rsRdate, rsRedate, rsOddate, rsRstatus);
				rentalList.add(rentalMember);

			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionManager.disconnectDB(conn, psmt, rs);
		}

		return rentalList;
	}
	
	
	
	
	
	//회원 테이블에서 연체 처리
		public int convertStatusToOverdueFromMemberInfo(int membno) {
			int convertResult = 0;

			try {

				conn = DBConnectionManager.connectDB();

				String query = " UPDATE memberinfo "
						+ " SET mstatus_id = 'od' "
						+ " WHERE membno = ? ";

				psmt = conn.prepareStatement(query);
				psmt.setInt(1, membno);
				

				convertResult = psmt.executeUpdate();

			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				DBConnectionManager.disconnectDB(conn, psmt, rs);
			}

			return convertResult;
		}
		
		
	//대여 테이블에서 회원 번호 가져오기
		public int findMembnoFromRental(int rentno) {
			
			int membno = 0;
			try {

				conn = DBConnectionManager.connectDB();

				String query = " select membno from rental where rentno = ? ";

				psmt = conn.prepareStatement(query);
				psmt.setInt(1, rentno);
				

				rs = psmt.executeQuery();
				
				if(rs.next()) {
					membno = rs.getInt("membno");
				}

			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				DBConnectionManager.disconnectDB(conn, psmt, rs);
			}

			return membno;
		}
	
	
	
	
	//대여 테이블에서 연체 처리
	public int convertStatusToOverdue(int rentno) {
		int overdueResult = 0;

		try {

			conn = DBConnectionManager.connectDB();

			String query = " UPDATE rental "
					+ " SET rstatus_id = 'od', od_date = SYSDATE"
					+ " WHERE rentno = ? ";

			psmt = conn.prepareStatement(query);
			psmt.setInt(1, rentno);
			

			overdueResult = psmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionManager.disconnectDB(conn, psmt, rs);
		}

		return overdueResult;
	}
	
	//연체 현황 조회 (연체로 돌릴 사람)
	public List<RentalDTO> selectOverdueMember() {

		RentalDTO rentalMember = null;
		List<RentalDTO> rentalList = null;

		try {
			conn = DBConnectionManager.connectDB();

			String query = " select r.rentno 대여번호, "
					+ " m.mname 회원명, "
					+ " b.bname 도서제목, "
					+ " TO_CHAR(r.rental_date, 'YY/MM/DD') 대여날짜, "
					+ " TO_CHAR(r.return_date, 'YY/MM/DD') 반납기한, "
					+ " rs.rstatus 대여상태 "
					+ " from rental r, memberinfo m, book b, rental_status rs "
					+ " where r.membno = m.membno and r.bookno = b.bookno "
					+ " and r.return_date < sysdate "
					+ " and r.rstatus_id = 'rt' and r.od_date IS NULL "
					+ " and r.rstatus_id = rs.rstatus_id ";

			psmt = conn.prepareStatement(query);

			rs = psmt.executeQuery();

			while (rs.next()) {
				if (rentalList == null) {
					rentalList = new ArrayList<RentalDTO>();
				}

				int rsRno = rs.getInt("대여번호");
				String rsMname = rs.getString("회원명");
				String rsBname = rs.getString("도서제목");
				
				String rsRdate = rs.getString("대여날짜");
				String rsRedate = rs.getString("반납기한");
				String rsRstatus = rs.getString("대여상태");
				//System.out.println(rsRstatus);

				rentalMember = new RentalDTO(rsRno, rsMname, rsBname,
						rsRdate, rsRedate, rsRstatus);
				rentalList.add(rentalMember);

			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionManager.disconnectDB(conn, psmt, rs);
		}

		return rentalList;
	}
	
	
	
	
	
	
	
	
	
	
	// 휴대폰 번호로 회원의 대여내역 조회
	public List<RentalDTO> selectRentalMemberByPhone(String memberPhone) {

		RentalDTO rentalMember = null;
		List<RentalDTO> rentalList = null;

		try {
			conn = DBConnectionManager.connectDB();

			String query = " select r.rentno 대여번호, m.mname 회원명, b.bname 도서제목, "
					+ " TO_CHAR(r.rental_date) 대여날짜, TO_CHAR(r.return_date) 반납기한, TO_CHAR(r.od_date) 연체날짜, TO_CHAR(r.stop_date) 정지날짜, TO_CHAR(r.comp_date) 반납날짜, rs.rstatus 대여상태 "
					+ " from rental r, memberinfo m, book b, rental_status rs "
					+ " where m.mphone= ? and m.membno = r.membno and b.bookno = r.bookno and r.rstatus_id = rs.rstatus_id ";

			psmt = conn.prepareStatement(query);
			psmt.setString(1, memberPhone);

			rs = psmt.executeQuery();

			while (rs.next()) {
				if (rentalList == null) {
					rentalList = new ArrayList<RentalDTO>();
				}

				int rsRno = rs.getInt("대여번호");
				String rsMname = rs.getString("회원명");
				String rsBname = rs.getString("도서제목");

				String rsRdate = rs.getString("대여날짜");
				String rsRedate = rs.getString("반납기한");
				String rsOdate = rs.getString("연체날짜");

				String rsSdate = rs.getString("정지날짜");
				String rsCdate = rs.getString("반납날짜");
				String rsRstatus = rs.getString("대여상태");

				rentalMember = new RentalDTO(rsRno, rsMname, rsBname, rsRdate, rsRedate, rsOdate, rsSdate, rsCdate,
						rsRstatus);
				rentalList.add(rentalMember);

			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionManager.disconnectDB(conn, psmt, rs);
		}

		return rentalList;
	}

	// 이름으로 회원의 대여내역 조회
	public List<RentalDTO> selectRentalMemberByName(String memberName) {

		RentalDTO rentalMember = null;
		List<RentalDTO> rentalList = null;

		try {
			conn = DBConnectionManager.connectDB();

			String query = " select r.rentno 대여번호, m.mname 회원명, b.bname 도서제목, "
					+ " TO_CHAR(r.rental_date) 대여날짜, TO_CHAR(r.return_date) 반납기한, TO_CHAR(r.od_date) 연체날짜, TO_CHAR(r.stop_date) 정지날짜, TO_CHAR(r.comp_date) 반납날짜, rs.rstatus 대여상태 "
					+ " from rental r, memberinfo m, book b, rental_status rs "
					+ " where m.mname= ? and m.membno = r.membno and b.bookno = r.bookno and r.rstatus_id = rs.rstatus_id ";

			psmt = conn.prepareStatement(query);
			psmt.setString(1, memberName);

			rs = psmt.executeQuery();

			while (rs.next()) {
				if (rentalList == null) {
					rentalList = new ArrayList<RentalDTO>();
				}

				int rsRno = rs.getInt("대여번호");
				String rsMname = rs.getString("회원명");
				String rsBname = rs.getString("도서제목");

				String rsRdate = rs.getString("대여날짜");
				String rsRedate = rs.getString("반납기한");
				String rsOdate = rs.getString("연체날짜");

				String rsSdate = rs.getString("정지날짜");
				String rsCdate = rs.getString("반납날짜");
				String rsRstatus = rs.getString("대여상태");

				rentalMember = new RentalDTO(rsRno, rsMname, rsBname, rsRdate, rsRedate, rsOdate, rsSdate, rsCdate,
						rsRstatus);
				rentalList.add(rentalMember);

			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionManager.disconnectDB(conn, psmt, rs);
		}

		return rentalList;
	}

	// 회원 번호로 대여내역 조회
	public List<RentalDTO> selectRentalMemberByNo(int memberNo) {

		RentalDTO rentalMember = null;
		List<RentalDTO> rentalList = null;

		try {
			conn = DBConnectionManager.connectDB();

			String query = " select r.rentno 대여번호, m.mname 회원명, b.bname 도서제목, "
					+ " TO_CHAR(r.rental_date) 대여날짜, TO_CHAR(r.return_date) 반납기한, TO_CHAR(r.od_date) 연체날짜, TO_CHAR(r.stop_date) 정지날짜, TO_CHAR(r.comp_date) 반납날짜, rs.rstatus 대여상태 "
					+ " from rental r, memberinfo m, book b, rental_status rs "
					+ " where m.membno= ? and m.membno = r.membno and b.bookno = r.bookno and r.rstatus_id = rs.rstatus_id ";

			psmt = conn.prepareStatement(query);
			psmt.setInt(1, memberNo);

			rs = psmt.executeQuery();

			while (rs.next()) {
				if (rentalList == null) {
					rentalList = new ArrayList<RentalDTO>();
				}

				int rsRno = rs.getInt("대여번호");
				String rsMname = rs.getString("회원명");
				String rsBname = rs.getString("도서제목");

				String rsRdate = rs.getString("대여날짜");
				String rsRedate = rs.getString("반납기한");
				String rsOdate = rs.getString("연체날짜");

				String rsSdate = rs.getString("정지날짜");
				String rsCdate = rs.getString("반납날짜");
				String rsRstatus = rs.getString("대여상태");

				rentalMember = new RentalDTO(rsRno, rsMname, rsBname, rsRdate, rsRedate, rsOdate, rsSdate, rsCdate,
						rsRstatus);
				rentalList.add(rentalMember);

			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionManager.disconnectDB(conn, psmt, rs);
		}

		return rentalList;
	}

	// 회원번호, 책번호로 대여 내역에 insert
	public int insertRentalHistory(int membno, int bookno) {
		int insertCount = 0;

		try {

			conn = DBConnectionManager.connectDB();

			String query = " INSERT INTO rental(RENTNO, MEMBNO, BOOKNO, RENTAL_DATE, RETURN_DATE, RSTATUS_ID) "
					+ " VALUES( (select max(rentno)+1 from rental), ?, ?, sysdate, sysdate+7, 'rt') ";

			psmt = conn.prepareStatement(query);
			psmt.setInt(1, membno);
			psmt.setInt(2, bookno);

			insertCount = psmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionManager.disconnectDB(conn, psmt, rs);
		}

		return insertCount;
	}

	// 책을 빌리면 회원 대여상태를 'rt'로 전환
	public int updateRentalMemberStatus(int membno) {
		int rsUpdateStatus = 0;

		try {

			conn = DBConnectionManager.connectDB();

			String query = " UPDATE memberinfo SET mstatus_id = 'rt' where membno = ? ";

			psmt = conn.prepareStatement(query);
			psmt.setInt(1, membno);

			rsUpdateStatus = psmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionManager.disconnectDB(conn, psmt, rs);
		}

		return rsUpdateStatus;
	}

	// 책이 대여 가능한지 알아보기 위해, 대여테이블에서 빌려진 책의 수량 조회
	public int searchRentedBookCount(int bookno) {
		int rsBookCount = 0;

		try {

			conn = DBConnectionManager.connectDB();

			String query = " select count(bookno) 책수량 from rental where bookno = ? and rstatus_id NOT IN ('cp', 'cc', 'rs') ";

			psmt = conn.prepareStatement(query);
			psmt.setInt(1, bookno);

			rs = psmt.executeQuery();

			if (rs.next()) {
				rsBookCount = rs.getInt("책수량");
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionManager.disconnectDB(conn, psmt, rs);
		}

		return rsBookCount;
	}

	// 대여테이블에서 회원번호로 해당 회원의 대여이력 건수를 조회
	public int searchMemberHistoryCount(int membno) {
		int rsBookCount = 0;
		try {

			conn = DBConnectionManager.connectDB();

			String query = " select count(membno) 대여도서이력 from rental where membno = ? and rstatus_id NOT IN ('cp', 'cc') ";

			psmt = conn.prepareStatement(query);
			psmt.setInt(1, membno);

			rs = psmt.executeQuery();

			if (rs.next()) {
				rsBookCount = rs.getInt("대여도서이력");
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionManager.disconnectDB(conn, psmt, rs);
		}

		return rsBookCount;
	}

	// 책 번호로 우리가 보유한 책의 수량을 조사
	public int searchBookCount(int bookno) {
		int rsBookCount = 0;
		try {

			conn = DBConnectionManager.connectDB();

			String query = " select bcount from book_quantity where bookno = ? ";

			psmt = conn.prepareStatement(query);
			psmt.setInt(1, bookno);

			rs = psmt.executeQuery();

			if (rs.next()) {
				rsBookCount = rs.getInt("bcount");
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionManager.disconnectDB(conn, psmt, rs);
		}

		return rsBookCount;
	}

	// 회원 대여상태 변환을 위해 회원정보 테이블에서 회원 대여상태 조회
	public String searchMemberStatus(int membno) {

		String rsMembStatus = null;

		try {

			conn = DBConnectionManager.connectDB();

			String query = " select mstatus_id from memberinfo where membno = ? ";

			psmt = conn.prepareStatement(query);
			psmt.setInt(1, membno);

			rs = psmt.executeQuery();

			if (rs.next()) {
				rsMembStatus = rs.getString("mstatus_id");
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionManager.disconnectDB(conn, psmt, rs);
		}

		return rsMembStatus;
	}
}
