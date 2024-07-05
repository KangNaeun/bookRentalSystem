package db.dto;



//회원추가
public class MemberInfoDTO {
	// 필드
	int membno; // 고객번호
	String mname; // 고객이름
	String maddress; // 고객주소
	String mphone; // 고객전화번호
	String mstatus; // 고객대여상태

	// 생성자
	public MemberInfoDTO() {
		super();
	}

	// Getter, Setter
	public int getMembno() {
		return membno;
	}

	public void setMembno(int membno) {
		this.membno = membno;
	}

	public String getMname() {
		return mname;
	}

	public void setMname(String mname) {
		this.mname = mname;
	}

	public String getMaddress() {
		return maddress;
	}

	public void setMaddress(String maddress) {
		this.maddress = maddress;
	}

	public String getMphone() {
		return mphone;
	}

	public void setMphone(String mphone) {
		this.mphone = mphone;
	}

	public String getMstatus() {
		return mstatus;
	}

	public void setMstatus(String mstatus) {
		this.mstatus = mstatus;
	}

}
