package db.dto;

public class RentalStatusDTO {
	// 필드
	private int rentno;
	private String mname;
	private String bname;
	private String rental_date;
	private String return_date;
	private String od_date;
	private String stop_date;
	private String comp_date;
	private String rstatus;
	
	// 생성자
	public RentalStatusDTO() {
		
	}

	// Getter, Setter
	public int getRentno() {
		return rentno;
	}

	public void setRentno(int rentno) {
		this.rentno = rentno;
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

	public String getRental_date() {
		return rental_date;
	}

	public void setRental_date(String rental_date) {
		this.rental_date = rental_date;
	}

	public String getReturn_date() {
		return return_date;
	}

	public void setReturn_date(String return_date) {
		this.return_date = return_date;
	}

	public String getOd_date() {
		return od_date;
	}

	public void setOd_date(String od_date) {
		this.od_date = od_date;
	}

	public String getStop_date() {
		return stop_date;
	}

	public void setStop_date(String stop_date) {
		this.stop_date = stop_date;
	}

	public String getComp_date() {
		return comp_date;
	}

	public void setComp_date(String comp_date) {
		this.comp_date = comp_date;
	}

	public String getRstatus() {
		return rstatus;
	}

	public void setRstatus(String rstatus) {
		this.rstatus = rstatus;
	}
	
}
