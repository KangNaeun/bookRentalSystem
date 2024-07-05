package db.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import db.util.DBConnectionManager;


public class ReserveCompDAO {
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	//예약완료
	public int reserveComp(int rentno) {
	    int updateResult = 0;

	    try {
	        conn = DBConnectionManager.connectDB();
	        
	        // PL/SQL 블록 시작
	        String query = "DECLARE "
	                + "    v_bookno NUMBER; "
	                + "    v_reserve_id NUMBER; "
	                + "    v_membno NUMBER; "
	                + "BEGIN "
	                + "    SELECT bookno INTO v_bookno "
	                + "    FROM rental "
	                + "    WHERE rentno = ?; "
	                + " "
	                + "    SELECT reserve_id, membno INTO v_reserve_id, v_membno "
	                + "    FROM reservation "
	                + "    WHERE bookno = v_bookno "
	                + "    AND reserve_status = '예약대기' "
	                + "    ORDER BY reserve_wait_date "
	                + "    FETCH FIRST 1 ROWS ONLY; "
	                + " "
	                + "    IF v_reserve_id IS NOT NULL THEN "
	                + "        INSERT INTO rental(rentno, membno, bookno, rental_date, return_date, rstatus_id) "
	                + "        VALUES ((SELECT NVL(MAX(rentno)+1, 10000) FROM rental), v_membno, v_bookno, SYSDATE, SYSDATE + 7, 'rs'); "
	                + " "
	                + "        UPDATE reservation "
	                + "        SET reserve_comp_date = SYSDATE, reserve_status = '예약완료' "
	                + "        WHERE reserve_id = v_reserve_id; "
	                + "    END IF; "
	                + " "
	                + "END; ";

	        // PreparedStatement 생성 및 바인드 변수 설정
	        psmt = conn.prepareStatement(query);
	        psmt.setInt(1, rentno);

	        // 쿼리 실행
	        updateResult = psmt.executeUpdate();  //쿼리 DB전달 실행

	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        DBConnectionManager.disconnectDB(conn, psmt, null);
	    }

	    return updateResult;
	}
}
