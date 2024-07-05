package db.dto;

public class BookDTO {
	int bookno;
	String bname;
	String bauthor;
	String bpublish;
	int bprice;
	int genrno;
	

	public BookDTO(String bname, String bauthor, String bpublish, int bprice, int genrno) {
		super();
		this.bname = bname;
		this.bauthor = bauthor;
		this.bpublish = bpublish;
		this.bprice = bprice;
		this.genrno = genrno;
	}
	public BookDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
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
	public String getBauthor() {
		return bauthor;
	}
	public void setBauthor(String bauthor) {
		this.bauthor = bauthor;
	}
	public String getBpublish() {
		return bpublish;
	}
	public void setBpublish(String bpublish) {
		this.bpublish = bpublish;
	}
	public int getBprice() {
		return bprice;
	}
	public void setBprice(int bprice) {
		this.bprice = bprice;
	}
	public int getGenrno() {
		return genrno;
	}
	public void setGenrno(int genrno) {
		this.genrno = genrno;
	}
	public BookDTO(int bookno, String bname, String bauthor, String bpublish, int bprice, int genrno) {
		super();
		this.bookno = bookno;
		this.bname = bname;
		this.bauthor = bauthor;
		this.bpublish = bpublish;
		this.bprice = bprice;
		this.genrno = genrno;
	}
	
	
	
	
	
	

}
