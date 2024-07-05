package db.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DBConnectionManager {

	//DB 연결
	public static Connection connectDB() {

		Connection conn = null;

		// 1. ojdbc8.jar DB연결용 라이브러리
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");

			// 2. DB Connection 연결정보
			String dbUrl = "jdbc:oracle:thin:@localhost:1521:orcl";
			String dbId = "scott";
			String dbPw = "tiger";

			conn = DriverManager.getConnection(dbUrl, dbId, dbPw);
		} catch (Exception e) {
			e.printStackTrace();
		} 

		return conn;
	}

	//DB 연결 종료
	public static void disconnectDB(Connection conn, PreparedStatement psmt, ResultSet rs )  {	//closeDB

		try {
			
			if(conn != null)
				conn.close();
			
			if(psmt != null)
				psmt.close();
			
			if(rs != null)
				rs.close();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}












