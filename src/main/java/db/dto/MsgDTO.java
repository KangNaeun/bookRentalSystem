package db.dto;

//알림메세지
public class MsgDTO {
	int  membno; //고객번호
	String mname; //고객이름
	String message; //전달할메세지
	String send_date; //메세지를 전달한 날짜
	
	public MsgDTO() {
		super();
	}

	
	public int getMembno() {
		return membno;
	}
	

	public String getMname() {
		return mname;
	}

	public void setMname(String mname) {
		this.mname = mname;
	}

	public void setMembno(int membno) {
		this.membno = membno;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getSend_date() {
		return send_date;
	}

	public void setSend_date(String send_date) {
		this.send_date = send_date;
	}
	
	

}
