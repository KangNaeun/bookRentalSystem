package db.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import db.dto.BookInfoDTO;
import db.util.DBConnectionManager;

public class BookInfoDAO {
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	public List<BookInfoDTO> selectBookInfoByBookno(int bookno) {
			
			List<BookInfoDTO> bookList = null;
			
			try {
				conn = DBConnectionManager.connectDB();
				
				String query = "SELECT b.bookno, b.bname, b.bauthor, g.gname, bq.bcount "
						+ " FROM book b, genre g, book_quantity bq "
						+ " WHERE b.genrno = g.genrno AND b.bookno = bq.bookno "
						+ " AND b.bookno = ? ";
					
			psmt = conn.prepareStatement(query);
			psmt.setInt(1, bookno);
			
			rs = psmt.executeQuery();
			
			bookList = new ArrayList<BookInfoDTO>();
		
			while (rs.next()) {
				BookInfoDTO book = new BookInfoDTO();
				book.setBookno(rs.getInt("bookno"));
				book.setBname(rs.getString("bname"));
				book.setBauthor(rs.getString("bauthor"));
				book.setGname(rs.getString("gname"));
				book.setBcount(rs.getInt("bcount"));
				
				bookList.add(book);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionManager.disconnectDB(conn, psmt, rs); // Close resources properly
		}
		
		return bookList;
	}
}
