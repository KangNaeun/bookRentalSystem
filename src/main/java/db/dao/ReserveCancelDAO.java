package db.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import db.util.DBConnectionManager;

public class ReserveCancelDAO {
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	public int insertReserveCancel(int reserve_id) {
	    int result = 0;

	    try {
	        conn = DBConnectionManager.connectDB();
	        
	        String query = "DECLARE "
	                + "    v_membno NUMBER; "
	                + "    v_bookno NUMBER; "
	                + "    v_reserve_id NUMBER := ?; "
	                + "    s_reserve_id NUMBER; "
	                + "    s_membno NUMBER; "
	                + "BEGIN "
	                + "    UPDATE reservation "
	                + "    SET reserve_status = '예약취소' "
	                + "    WHERE reserve_id = v_reserve_id; "
	                + "    "
	                + "    SELECT membno, bookno INTO v_membno, v_bookno "
	                + "    FROM reservation "
	                + "    WHERE reserve_id = v_reserve_id; "
	                + "    "
	                + "    UPDATE rental "
	                + "    SET rstatus_id = 'cc' "
	                + "    WHERE membno = v_membno "
	                + "    AND bookno = v_bookno "
	                + "    AND rstatus_id = 'rs'; "
	                + "    "
	                + "    BEGIN "
	                + "        BEGIN "
	                + "            SELECT reserve_id, membno INTO s_reserve_id, s_membno "
	                + "            FROM reservation "
	                + "            WHERE bookno = v_bookno "
	                + "            AND reserve_status = '예약대기' "
	                + "            ORDER BY reserve_wait_date "
	                + "            FETCH FIRST 1 ROWS ONLY; "
	                + "        EXCEPTION "
	                + "        WHEN OTHERS THEN "
	                + "            s_reserve_id := null; "
	                + "        END; "
	                + "        "
	                + "        IF s_reserve_id IS NOT NULL THEN "
	                + "            INSERT INTO rental(rentno, membno, bookno, rental_date, return_date, rstatus_id) "
	                + "            VALUES ((SELECT MAX(rentno) FROM rental) + 1, s_membno, v_bookno, SYSDATE, SYSDATE+7, 'rs'); "
	                + "            "
	                + "            UPDATE reservation "
	                + "            SET reserve_comp_date = SYSDATE, reserve_status = '예약완료' "
	                + "            WHERE reserve_id = s_reserve_id; "
	                + "        END IF; "
	                + "    END; "
	                + "END;";

	        psmt = conn.prepareStatement(query);
	        psmt.setInt(1, reserve_id);

	        result = psmt.executeUpdate();  //쿼리 DB전달 실행

	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        DBConnectionManager.disconnectDB(conn, psmt, null);
	    }

	    return result;
	}
}
