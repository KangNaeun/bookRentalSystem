package db.dto;

public class ReserveStatusDTO {
	private int reserve_id;
	private String mname;
	private String bname;
	private String reserve_wait_date;
	private String reserve_comp_date;
	private String reserve_status;
	
	private int membno;
	private int bookno;
	
	public int getMembno() {
		return membno;
	}

	public void setMembno(int membno) {
		this.membno = membno;
	}

	public int getBookno() {
		return bookno;
	}

	public void setBookno(int bookno) {
		this.bookno = bookno;
	}

	// 생성자
	public ReserveStatusDTO() {
	}
	
	// Getter, Setter
	public int getReserve_id() {
		return reserve_id;
	}

	public void setReserve_id(int reserve_id) {
		this.reserve_id = reserve_id;
	}

	public String getMname() {
		return mname;
	}

	public void setMname(String mname) {
		this.mname = mname;
	}

	public String getBname() {
		return bname;
	}

	public void setBname(String bname) {
		this.bname = bname;
	}

	public String getReserve_wait_date() {
		return reserve_wait_date;
	}

	public void setReserve_wait_date(String reserve_wait_date) {
		this.reserve_wait_date = reserve_wait_date;
	}

	public String getReserve_comp_date() {
		return reserve_comp_date;
	}

	public void setReserve_comp_date(String reserve_comp_date) {
		this.reserve_comp_date = reserve_comp_date;
	}

	public String getReserve_status() {
		return reserve_status;
	}

	public void setReserve_status(String reserve_status) {
		this.reserve_status = reserve_status;
	}
	
}
