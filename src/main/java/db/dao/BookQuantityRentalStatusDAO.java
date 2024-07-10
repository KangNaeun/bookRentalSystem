package db.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import db.dto.BookQuantityRentalStatusDTO;
import db.util.DBConnectionManager;

public class BookQuantityRentalStatusDAO {

	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	// 리스트로 도서별 재고 및 대여현황 조회
	public List<BookQuantityRentalStatusDTO> selectAllBookQuantityRentalStatus() {
		
		List<BookQuantityRentalStatusDTO> bookQuantityRentalStatusList = null;
		
		try {
			conn = DBConnectionManager.connectDB();
			
			String query = " SELECT COALESCE(rental_counts.bookno, book_quantities.bookno) AS bookno, "
					+ "       b.bname AS 도서명, "
					+ "       COALESCE(rental_counts.대여현황, 0) AS 대여현황, "
					+ "       NVL(book_quantities.재고, 0) AS 재고, "
					+ "       CASE  "
					+ "            WHEN COALESCE(rental_counts.대여현황, 0) = NVL(book_quantities.재고, 0) THEN '예약만 가능' "
					+ "            ELSE '대여가능' "
					+ "       END AS 구분 "
					+ "FROM ( "
					+ "    SELECT bookno, COUNT(*) AS 대여현황 "
					+ "    FROM rental "
					+ "    WHERE rental.rstatus_id IN ('rt', 'od', 'st', 'rs') "
					+ "    GROUP BY bookno "
					+ ") rental_counts "
					+ "FULL OUTER JOIN ( "
					+ "    SELECT b.bookno, bq.bcount AS 재고 "
					+ "    FROM book b "
					+ "    LEFT JOIN genre g ON b.genrno = g.genrno "
					+ "    LEFT JOIN book_quantity bq ON b.bookno = bq.bookno "
					+ ") book_quantities ON rental_counts.bookno = book_quantities.bookno "
					+ "LEFT JOIN book b ON COALESCE(rental_counts.bookno, book_quantities.bookno) = b.bookno "
					+ "ORDER BY COALESCE(rental_counts.bookno, book_quantities.bookno) ";
					
			psmt = conn.prepareStatement(query);
			
			rs = psmt.executeQuery();
			
			bookQuantityRentalStatusList = new ArrayList<BookQuantityRentalStatusDTO>();
		
			while (rs.next()) {
				BookQuantityRentalStatusDTO bookQuantityRentalStatus = new BookQuantityRentalStatusDTO();
				
				bookQuantityRentalStatus.setBookno(rs.getInt("bookno"));
				bookQuantityRentalStatus.setBname(rs.getString("도서명"));
				bookQuantityRentalStatus.setRentalStatusCount(rs.getInt("대여현황"));
				bookQuantityRentalStatus.setBcount(rs.getInt("재고"));
				bookQuantityRentalStatus.setRentalStatus(rs.getString("구분"));
				
				bookQuantityRentalStatusList.add(bookQuantityRentalStatus);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionManager.disconnectDB(conn, psmt, rs); // Close resources properly
		}
		
		return bookQuantityRentalStatusList;
	}
}
