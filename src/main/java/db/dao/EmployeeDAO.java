package db.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import db.dto.BookDTO;
import db.dto.EmployeeDTO;
import db.util.DBConnectionManager;

public class EmployeeDAO {
	
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	public EmployeeDTO employeeLogin(String empno , String password) {
		
		EmployeeDTO employee = null;
		
		try {
			conn = DBConnectionManager.connectDB();

			String query = " select * from employee "
					+ " where empno = ? and password = ? ";

			psmt = conn.prepareStatement(query);
			psmt.setString(1, empno);
			psmt.setString(2, password);

			rs = psmt.executeQuery(); // 쿼리 DB전달 실행

			if (rs.next()) { // 더이상 가져올 데이터가 없을때까지~
				employee = new EmployeeDTO();
				
				employee.setEmpno(rs.getInt("empno"));
				employee.setPassword(rs.getString("password"));
				employee.setEname(rs.getString("ename"));

				System.out.println("로그인성공");				
				
			} else {
				//로그인 실패
				System.out.println("로그인실패");
				
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBConnectionManager.disconnectDB(conn, psmt, rs);
		}

		return employee;
	}
	
	


	
}
