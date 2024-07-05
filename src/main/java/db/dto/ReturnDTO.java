package db.dto;

public class ReturnDTO {
	int rentno; // 반납을 위한 대여번호
	int membno; // 반납을 위한 멤버번호

	// 생성자
	public ReturnDTO(int rentno) {
		this.rentno = rentno;
	}

	public ReturnDTO(int rentno, int membno) {
		this.rentno = rentno;
		this.membno = membno;
	}

	// getter & setter
	public int getRentno() {
		return rentno;
	}

	public void setRentno(int rentno) {
		this.rentno = rentno;
	}

	public int getMembno() {
		return membno;
	}

	public void setMembno(int membno) {
		this.membno = membno;
	}

}
