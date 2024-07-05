package db.dto;

public class BookQuantityRentalStatusDTO {
	private int bookno;
	private String bname;
	private int rentalStatusCount;
	private int bcount;
	private String rentalStatus;
	
	public int getBookno() {
		return bookno;
	}
	public void setBookno(int bookno) {
		this.bookno = bookno;
	}
	public String getBname() {
		return bname;
	}
	public void setBname(String bname) {
		this.bname = bname;
	}
	public int getRentalStatusCount() {
		return rentalStatusCount;
	}
	public void setRentalStatusCount(int rentalStatusCount) {
		this.rentalStatusCount = rentalStatusCount;
	}
	public int getBcount() {
		return bcount;
	}
	public void setBcount(int bcount) {
		this.bcount = bcount;
	}
	public String getRentalStatus() {
		return rentalStatus;
	}
	public void setRentalStatus(String rentalStatus) {
		this.rentalStatus = rentalStatus;
	}
	
}
