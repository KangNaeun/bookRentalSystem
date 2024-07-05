package db.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


import db.dto.FindDTO;
import db.util.DBConnectionManager;

public class JoinDAO {
	
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	public int joinEmployee(String emp_id, String ename, String password, String ebirth) {

		int result = 0;

		try {
			conn = DBConnectionManager.connectDB();

			String query = "INSERT INTO employee "
					+ "VALUES ( ? , ? , ? , ? , '사원', '영업부', SYSDATE) ";
			
			psmt = conn.prepareStatement(query);
			
			psmt.setString(1, emp_id);
			psmt.setString(2, ename);
			psmt.setString(3, password);
			psmt.setString(4, ebirth);

			result = psmt.executeUpdate();// 쿼리 DB전달 실행
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBConnectionManager.disconnectDB(conn, psmt, null); // conn psmt rs
		}

		return result;

	}
	
	public List<FindDTO> findId(String ename, String ebirth) {

		List<FindDTO> findList=null;
		try {
			conn = DBConnectionManager.connectDB();

			String query = " select emp_id "
					+ " from employee "
					+ " where ename = ? and ebirth = ? ";
			
			psmt = conn.prepareStatement(query);
			
			psmt.setString(1, ename);
			psmt.setString(2, ebirth);

			rs= psmt.executeQuery();// 쿼리 DB전달 실행
			
			while(rs.next()) {
				if(findList ==null)
					findList = new ArrayList<FindDTO>();
				
				FindDTO find = new FindDTO(rs.getString("emp_id"));
				findList.add(find);
						
			}
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBConnectionManager.disconnectDB(conn, psmt, rs); // conn psmt rs
		}

		return findList;

	}
	
	public List<FindDTO> findPw(String emp_id, String ebirth) {

		List<FindDTO> findList=null;
		try {
			conn = DBConnectionManager.connectDB();

			String query = " select password "
					+ " from employee "
					+ " where emp_id = ? and ebirth = ? ";
			
			psmt = conn.prepareStatement(query);
			
			psmt.setString(1, emp_id);
			psmt.setString(2, ebirth);

			rs= psmt.executeQuery();// 쿼리 DB전달 실행
			
			while(rs.next()) {
				if(findList ==null)
					findList = new ArrayList<FindDTO>();
				
				FindDTO find = new FindDTO();
				find.setPassword(rs.getString("password"));
				findList.add(find);
						
			}
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBConnectionManager.disconnectDB(conn, psmt, rs); // conn psmt rs
		}

		return findList;

	}
	
	public List<FindDTO> loginEmployee(String emp_id, String password) {

		List<FindDTO> employeeList = null;
		try {
			conn = DBConnectionManager.connectDB();

			String query = " select ename, emp_id "
					+ "from employee "
					+ "where emp_id = ? and password = ? ";
			
			psmt = conn.prepareStatement(query);
			
			psmt.setString(1, emp_id);
			psmt.setString(2, password);

			rs= psmt.executeQuery();// 쿼리 DB전달 실행
			
			while(rs.next()) {
				if(employeeList ==null)
					employeeList = new ArrayList<FindDTO>();
				
				FindDTO login = new FindDTO();
				
				login.setEname(rs.getString("ename"));
				login.setEmp_id(rs.getString("emp_id"));
				
				employeeList.add(login);
						
			}
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBConnectionManager.disconnectDB(conn, psmt, rs); // conn psmt rs
		}

		return employeeList;

	}
	
	

}
