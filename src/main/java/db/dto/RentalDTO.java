package db.dto;

public class RentalDTO {
	int membno; // 멤버번호
	int bookno; // 책번호
	int rentalno; // 회원대여번호
	String mname; // 회원이름
	String bookName; // 책이름
	
	String rDate; // 대여날짜
	String rtDate; // 반납기한
	String odDate; // 연체날짜
	
	String stDate; // 정지날짜
	String coDate; // 반납날짜
	String rStatus; // 반납상태
	
	
	
	
	
	public RentalDTO(int rentalno, String mname, String bookName, String odDate, String stDate) {
		this.rentalno = rentalno;
		this.mname = mname;
		this.bookName = bookName;
		this.odDate = odDate;
		this.stDate = stDate;
	}

	public RentalDTO(int rentalno, String mname, String bookName, String rDate, String rtDate, String odDate,
			String rStatus) {
		this.rentalno = rentalno;
		this.mname = mname;
		this.bookName = bookName;
		this.rDate = rDate;
		this.rtDate = rtDate;
		this.odDate = odDate;
		this.rStatus = rStatus;
	}

	public RentalDTO(int rentalno, String mname, String bookName, String rDate, String rtDate, String rStatus) {
		this.rentalno = rentalno;
		this.mname = mname;
		this.bookName = bookName;
		
		this.rDate = rDate;
		this.rtDate = rtDate;
		this.rStatus = rStatus;
	}

	///////////////////////////////////
	
	
	
	public RentalDTO(int rentalno, String mname, String bookName, String rDate, String rtDate, String odDate,
			String stDate, String coDate, String rStatus) {

		this.mname = mname;
		this.rentalno = rentalno;
		this.bookName = bookName;

		this.rDate = rDate;
		this.rtDate = rtDate;
		this.odDate = odDate;

		this.stDate = stDate;
		this.coDate = coDate;
		this.rStatus = rStatus;
	}
	
	

	// 생성자
	public RentalDTO() {
	}

	public RentalDTO(int membno, int bookno) {
		this.membno = membno;
		this.bookno = bookno;
	}
	
	

	// getter & setter
	
	public String getMname() {
		return mname;
	}



	public void setMname(String mname) {
		this.mname = mname;
	}
	
	public String getrDate() {
		return rDate;
	}

	public void setrDate(String rDate) {
		this.rDate = rDate;
	}

	public int getRentalno() {
		return rentalno;
	}

	public void setRentalno(int rentalno) {
		this.rentalno = rentalno;
	}

	public String getBookName() {
		return bookName;
	}

	public void setBookName(String bookName) {
		this.bookName = bookName;
	}

	public String getRtDate() {
		return rtDate;
	}

	public void setRtDate(String rtDate) {
		this.rtDate = rtDate;
	}

	public String getOdDate() {
		return odDate;
	}

	public void setOdDate(String odDate) {
		this.odDate = odDate;
	}

	public String getStDate() {
		return stDate;
	}

	public void setStDate(String stDate) {
		this.stDate = stDate;
	}

	public String getCoDate() {
		return coDate;
	}

	public void setCoDate(String coDate) {
		this.coDate = coDate;
	}

	public String getrStatus() {
		return rStatus;
	}

	public void setrStatus(String rStatus) {
		this.rStatus = rStatus;
	}
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

}
