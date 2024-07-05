package db.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import db.dto.ReserveStatusDTO;
import db.util.DBConnectionManager;

public class ReserveStatusDAO {
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
public List<ReserveStatusDTO> selectAllReserveStatus() {
		
		List<ReserveStatusDTO> reserveList = null;
		
		try {
			conn = DBConnectionManager.connectDB();
			
			String query = "SELECT r.reserve_id, m.mname, b.bname, "
					+ "    TO_CHAR(r.reserve_wait_date, 'YYYY-MM-DD') reserve_wait_date, "
					+ "    TO_CHAR(r.reserve_comp_date, 'YYYY-MM-DD') reserve_comp_date, "
					+ "    r.reserve_status, b.bookno, m.membno "
					+ " FROM reservation r, memberInfo m, book b "
					+ " WHERE r.membno = m.membno AND r.bookno = b.bookno "
					+ " ORDER BY r.reserve_id ";
					
			psmt = conn.prepareStatement(query);
			
			rs = psmt.executeQuery();
			
			reserveList = new ArrayList<ReserveStatusDTO>();
		
			while (rs.next()) {
				ReserveStatusDTO reserve = new ReserveStatusDTO();
				reserve.setReserve_id(rs.getInt("reserve_id"));
				reserve.setMname(rs.getString("mname"));
				reserve.setBname(rs.getString("bname"));
				reserve.setReserve_wait_date(rs.getString("reserve_wait_date"));
				reserve.setReserve_comp_date(rs.getString("reserve_comp_date") == null ? "" : rs.getString("reserve_comp_date"));
				reserve.setReserve_status(rs.getString("reserve_status"));
				
				reserve.setBookno(rs.getInt("bookno"));
				reserve.setMembno(rs.getInt("membno"));
				
				
				
				reserveList.add(reserve);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionManager.disconnectDB(conn, psmt, rs); // Close resources properly
		}
		
		return reserveList;
	}

	public List<ReserveStatusDTO> selectReserveExpirationStatus() {
		
		List<ReserveStatusDTO> reserveList = null;
		
		try {
			conn = DBConnectionManager.connectDB();
			
			String query = "SELECT r.reserve_id, m.mname, b.bname, "
					+ "    TO_CHAR(r.reserve_wait_date, 'YYYY-MM-DD') reserve_wait_date, "
					+ "    TO_CHAR(r.reserve_comp_date, 'YYYY-MM-DD HH24:MI') reserve_comp_date, "
					+ "    r.reserve_status "
					+ " FROM reservation r, memberInfo m, book b "
					+ " WHERE r.membno = m.membno AND r.bookno = b.bookno "
					+ " AND r.reserve_comp_date+2 < SYSDATE ";
					
			psmt = conn.prepareStatement(query);
			
			rs = psmt.executeQuery();
			
			reserveList = new ArrayList<ReserveStatusDTO>();
		
			while (rs.next()) {
				ReserveStatusDTO reserve = new ReserveStatusDTO();
				reserve.setReserve_id(rs.getInt("reserve_id"));
				reserve.setMname(rs.getString("mname"));
				reserve.setBname(rs.getString("bname"));
				reserve.setReserve_wait_date(rs.getString("reserve_wait_date"));
				reserve.setReserve_comp_date(rs.getString("reserve_comp_date") == null ? "" : rs.getString("reserve_comp_date"));
				reserve.setReserve_status(rs.getString("reserve_status"));
				
				reserveList.add(reserve);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionManager.disconnectDB(conn, psmt, rs); // Close resources properly
		}
		
		return reserveList;
	}
	
	public int insertReservation(int membno, int bookno) {

		int result = 0;

		try {
			conn = DBConnectionManager.connectDB();
			
			String query = "DECLARE "
	                + "    v_membno NUMBER := ?; "
	                + "    v_bookno NUMBER := ?; "
	                + "    s_membno NUMBER; "
	                + "BEGIN "
	                + "    INSERT INTO reservation(reserve_id, membno, bookno, reserve_wait_date, reserve_status) "
	                + "    VALUES ((SELECT NVL(MAX(reserve_id)+1, 100000) FROM reservation), v_membno, v_bookno, SYSDATE, '예약대기'); "
	                + "    "
	                + "    SELECT membno INTO s_membno "
	                + "    FROM memberInfo "
	                + "    WHERE mstatus_id IN ('nrt', 'rt', 'rs') AND membno = v_membno; "
	                + "    "
	                + "    IF s_membno IS NOT NULL THEN "
	                + "        UPDATE memberInfo "
	                + "        SET mstatus_id = 'rs' "
	                + "        WHERE membno = s_membno; "
	                + "    END IF; "
	                + "END;";

			psmt = conn.prepareStatement(query);


			psmt.setInt(1, membno);
			psmt.setInt(2, bookno);

			result = psmt.executeUpdate();	//쿼리 DB전달 실행

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBConnectionManager.disconnectDB(conn, psmt, null);
		}

		return result;
	}
}
