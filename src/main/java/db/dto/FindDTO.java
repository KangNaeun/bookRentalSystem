package db.dto;

public class FindDTO {
	String emp_id;
	String ename;
	String password;

	public FindDTO(String emp_id) {
		this.emp_id=emp_id;
		
	}
	public FindDTO() {
		super();
	}

	public String getEmp_id() {
		return emp_id;
	}
	public void setEmp_id(String emp_id) {
		this.emp_id = emp_id;
	}
	public String getEname() {
		return ename;
	}
	public void setEname(String ename) {
		this.ename = ename;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	
	
}
