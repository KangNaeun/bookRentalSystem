package db.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import db.util.DBConnectionManager;

public class ReturnDAO {
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	//회원번호로 대여상태 조사
	public String selectMemberStatus(int membno) {
		
		String mstatus = null;
		
		try {

			conn = DBConnectionManager.connectDB();

			String query = " select mststus_id from memberinfo where membno = ? ";

			psmt = conn.prepareStatement(query);
			psmt.setInt(1, membno);

			rs = psmt.executeQuery();

			if (rs.next()) {
				mstatus = rs.getString("mststus_id");
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionManager.disconnectDB(conn, psmt, rs);
		}

		return mstatus;
	}
	
	
	
	//반납을 위해 회원번호로 멤버의 대여상태를 rt로 update
	public int updateMemberStatusToRT(int membno){
		int updateResult = 0;
		try {

			conn = DBConnectionManager.connectDB();

			String query = " UPDATE memberInfo SET mstatus_id = 'rt' "
					+ " WHERE membno = ? ";

			psmt = conn.prepareStatement(query);
			psmt.setInt(1, membno);

			updateResult = psmt.executeUpdate();

			

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionManager.disconnectDB(conn, psmt, rs);
		}

		return updateResult;
	}
	
	//대여 테이블에서 회원번호로 해당회원이 연체된 책의 수량을 조사 
	public int searchOverdueBookCount(int membno) {
		int overdueCount = 0;
		try {

			conn = DBConnectionManager.connectDB();

			String query = " select count(*) 연체된책수량 "
					+ " from rental "
					+ " where membno = ? and ( rstatus_id = 'od' or rstatus_id = 'st' ) ";

			psmt = conn.prepareStatement(query);
			psmt.setInt(1, membno);

			rs = psmt.executeQuery();

			if (rs.next()) {
				overdueCount = rs.getInt("연체된책수량");
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionManager.disconnectDB(conn, psmt, rs);
		}

		return overdueCount;
	}
	
	
	//회원 번호로 회원의 대여상태를 'nrt'로 update
	public int updateMemberStatusToNRT(int membno){
		int updateResult = 0;
		try {

			conn = DBConnectionManager.connectDB();

			String query = " UPDATE memberInfo SET mstatus_id = 'nrt' "
					+ " WHERE membno = ? ";

			psmt = conn.prepareStatement(query);
			psmt.setInt(1, membno);

			updateResult = psmt.executeUpdate();

			

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionManager.disconnectDB(conn, psmt, rs);
		}

		return updateResult;
	}
	
	
	//대여테이블에서 대여번호로 해당 대여내역에 해당하는 회원번호를 조사(ex. 대여번호 1000에 해당하는 회원이 누군지)
	public int findMembnoAtRentalTable(int rentno) {
		int rentalMembno = 0;
		try {

			conn = DBConnectionManager.connectDB();

			String query = " SELECT membno FROM rental WHERE rentno = ? ";

			psmt = conn.prepareStatement(query);
			psmt.setInt(1, rentno);

			rs = psmt.executeQuery();

			if (rs.next()) {
				rentalMembno = rs.getInt("membno");
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionManager.disconnectDB(conn, psmt, rs);
		}

		return rentalMembno;
	}
	
	//회원번호로 대여테이블에서 아직 반납하지 않은 도서수량을 조사
	public int countMemberRentalHistory(int membno) {

		int countResult = 0;
		try {

			conn = DBConnectionManager.connectDB();

			String query = " select count(*) 미반납도서수량 " + " from rental " + " where membno = ? and rstatus_id != 'cp' ";

			psmt = conn.prepareStatement(query);
			psmt.setInt(1, membno);

			rs = psmt.executeQuery();

			if (rs.next()) {
				countResult = rs.getInt("미반납도서수량");
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionManager.disconnectDB(conn, psmt, rs);
		}

		return countResult;
	}

	//대여번호로 대여테이블에서 대여상태를 'cp'로 update하고 반납완료날짜를 sysdate로 update
	public int returnBookAtRentalTable(int rentno) {

		int returnResult = 0;
		try {

			conn = DBConnectionManager.connectDB();

			String query = " UPDATE rental " + " SET rstatus_id = 'cp', comp_date = sysdate " + " WHERE rentno = ? ";

			psmt = conn.prepareStatement(query);
			psmt.setInt(1, rentno);

			returnResult = psmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionManager.disconnectDB(conn, psmt, rs);
		}

		return returnResult;
	}
}
