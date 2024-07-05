package db.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import db.dto.ReserveAbleDTO;
import db.util.DBConnectionManager;

public class ReserveAbleDAO {
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	public List<ReserveAbleDTO> selectReserveAble() {
		
		List<ReserveAbleDTO> reserveAbleList = null;
		
		try {
			conn = DBConnectionManager.connectDB();
			
			String query = "SELECT rental_counts.bookno, "
					+ "       rental_counts.대여현황, "
					+ "       NVL(book_quantities.재고, 0) AS 재고, "
					+ "       CASE  "
					+ "            WHEN 대여현황 = 재고 THEN '예약만 가능' "
					+ "            ELSE '대여가능' "
					+ "        END 구분 "
					+ "FROM ( "
					+ "    SELECT bookno, COUNT(bookno) AS 대여현황 "
					+ "    FROM rental "
					+ "    WHERE rental.rstatus_id IN ('rt', 'od', 'st', 'rs') "
					+ "    GROUP BY bookno "
					+ ") rental_counts "
					+ "LEFT OUTER JOIN ( "
					+ "    SELECT b.bookno, bq.bcount AS 재고 "
					+ "    FROM book b, genre g, book_quantity bq "
					+ "    WHERE b.genrno = g.genrno AND b.bookno = bq.bookno "
					+ ") book_quantities ON rental_counts.bookno = book_quantities.bookno "
					+ "WHERE  "
					+ "    CASE  "
					+ "        WHEN 대여현황 = 재고 THEN '예약만 가능' "
					+ "        ELSE '대여가능' "
					+ "    END = '예약만 가능'";
				
		psmt = conn.prepareStatement(query);
		
		rs = psmt.executeQuery();
		
		reserveAbleList = new ArrayList<ReserveAbleDTO>();
	
		while (rs.next()) {
			ReserveAbleDTO reserveAble = new ReserveAbleDTO();
			reserveAble.setBookno(rs.getInt("bookno"));

			reserveAbleList.add(reserveAble);
		}
		
	} catch (SQLException e) {
		e.printStackTrace();
	} finally {
		DBConnectionManager.disconnectDB(conn, psmt, rs); // Close resources properly
	}
	
	return reserveAbleList;
}
}
