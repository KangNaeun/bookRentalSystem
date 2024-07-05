//재빈
const buttonReserveStatus = document.querySelector('.btn-reserve-status');
const reserveStatusContainer = document.querySelector('.reserve-status-container');
const buttonReserveClose = document.querySelector('.btn-reserve-status-container-close');
const buttonBookReserve = document.querySelector('.btn-book-reserve');
const bookReserveContainer = document.querySelector('.book-reserve-container');
const buttonBookClose = document.querySelector('.btn-book-reserve-container-close');
const buttonReserveExpirationStatus = document.querySelector('.btn-reserve-expiration-status');
const reserveExpirationStatusContainer = document.querySelector('.reserve-expiration-status-container');
const buttonReserveExpirationClose = document.querySelector('.btn-reserve-expiration-status-container-close');
const reserveContainer = document.querySelector('.reserve-container');
const reserveContainer2 = document.querySelector('.reserve-container2');
const buttonReserveClose2 = document.querySelector('.btn-reserve-container-close');
const buttonReserveClose3 = document.querySelector('.btn-reserve-container-close2');
const buttonReserve = document.getElementById('btn-reserve');
const buttonReserve2 = document.getElementById('btn-reserve2');
const bookQuantityRentalStatusContainer = document.querySelector('.book-quantity-rental-status-container');
const buttonBookQuantityRentalStatus = document.querySelector('.btn-book-quantity-rental-status');
const buttonBookQuantityRentalStatusClose = document.querySelector('.btn-book-quantity-rental-status-container-close');


buttonReserveStatus.addEventListener('click', selectReserveStatus);
buttonReserveClose.addEventListener('click', closeReserveStatus);
buttonBookReserve.addEventListener('click', selectBookReserve);
buttonBookClose.addEventListener('click', closeBookReserve);
buttonReserveExpirationStatus.addEventListener('click', selectReserveExpirationStatus);
buttonReserveExpirationClose.addEventListener('click', closeReserveExpirationStatus);
buttonReserve.addEventListener('click', selectReserve);
buttonReserve2.addEventListener('click', selectReserve2);
buttonReserveClose2.addEventListener('click', closeReserve);
buttonReserveClose3.addEventListener('click', closeReserve2);
buttonBookQuantityRentalStatus.addEventListener('click', selectBookQuantityRentalStatus);
buttonBookQuantityRentalStatusClose.addEventListener('click', closeBookQuantityRentalStatus);

function selectReserveStatus() {
    reserveStatusContainer.style.display = 'flex';
}

function closeReserveStatus() {
    reserveStatusContainer.style.display = 'none';
}

function selectBookReserve() {
    bookReserveContainer.style.display = 'flex';
}

function closeBookReserve() {
    bookReserveContainer.style.display = 'none';
}

function selectReserveExpirationStatus() {
    reserveExpirationStatusContainer.style.display = 'flex';
}

function closeReserveExpirationStatus() {
    reserveExpirationStatusContainer.style.display = 'none';
}

function selectReserve() {
    reserveContainer.style.display = 'flex';
}

function selectReserve2() {
    reserveContainer2.style.display = 'flex';
}

function closeReserve() {
    reserveContainer.style.display = 'none';
}

function closeReserve2() {
    reserveContainer2.style.display = 'none';
}

function selectBookQuantityRentalStatus() {
    bookQuantityRentalStatusContainer.style.display = 'flex';
}

function closeBookQuantityRentalStatus() {
    bookQuantityRentalStatusContainer.style.display = 'none';
}

// 예시: 페이지 로드 후 특정 조건에 따라 스크롤 추가
document.addEventListener('DOMContentLoaded', function() {
    const thCell = document.querySelector('.td'); // 첫 번째 td 요소 선택
    const divScrollable = thCell.querySelector('.scrollable-content');

    if (divScrollable.scrollWidth > divScrollable.clientWidth) {
        // 가로 스크롤이 필요한 경우, 추가적인 클래스나 스타일을 적용하거나 처리합니다.
        divScrollable.classList.add('scroll-needed');
    }
});











//세준

function btnClick() {
    const mydiv = document.getElementById('bookadd');
    const style = window.getComputedStyle(mydiv);
    
    if (style.display === 'none') {
        mydiv.style.display = 'block';
    } else {
        mydiv.style.display = 'none';
    }
}

const frm_book = document.querySelector('#frm_book');		
frm_book.addEventListener('submit', (e)=>{
    e.preventDefault();	//기본 이벤트 중지. submit 폼 전송 막기!
        
    let input_bname = document.querySelector('#input_bname');
    let input_bauthor = document.querySelector('#input_bauthor');
    let input_bpublish = document.querySelector('#input_bpublish');
    let input_bprice = document.getElementById('input_bprice');
    let input_genrno = document.getElementById('input_genrno');
    let input_bdate = document.querySelector('#input_bdate');
    let input_bcount = document.querySelector('#input_bcount');

    input_bname.value = input_bname.value.trim();
    input_bauthor.value = input_bauthor.value.trim();
    input_bpublish.value = input_bpublish.value.trim();
    input_bprice.value = input_bprice.value.trim();
    input_genrno.value = input_genrno.value.trim();
    input_bdate.value = input_bdate.value.trim();
    input_bcount.value = input_bcount.value.trim();
    
    if(input_bname.value.trim() == '' || input_bname.value == null ){	//.trim() -> 띄어쓰기 빈칸이 있는지 확인!
        alert('책 이름은 필수 입력입니다.');
        input_bname.focus();
        return false;
    }
    if(input_bauthor.value.trim() == '' || input_bname.value == null ){
        alert('저자는 필수 입력입니다.');
        input_bauthor.focus();
        return false;
    }
    if(input_bpublish.value.trim() == '' || input_bname.value == null ){
        alert('출판사는 필수 입력입니다.');
        input_bpublish.focus();
        return false;
    }
    if(input_bprice.value.trim() == '' || input_bname.value == null ){
        alert('가격은 필수 입력입니다.');
        input_bprice.focus();
        return false;
    }
    if(input_genrno.value.trim() == '' || input_bname.value == null ){
        alert('분류이름은 필수 입력입니다.');
        input_genrno.focus();
        return false;
    }
    if(input_bdate.value.trim() == '' || input_bname.value == null ){
        alert('날짜는 필수 입력입니다.');
        input_bdate.focus();
        return false;
    }
    if(input_bcount.value.trim() == '' || input_bname.value == null ){
        alert('수량은 필수 입력입니다.');
        input_bcount.focus();
        return false;
    }
    
    //검증 모두 통과
    //저장하는 단계 진행!
    frm_book.submit();
    
});	


function bookqClick() {
    const mydiv = document.getElementById('bookq');
    const style = window.getComputedStyle(mydiv);
    
    if (style.display === 'none') {
        mydiv.style.display = 'block';
    } else {
        mydiv.style.display = 'none';
    }
}

function employeeClick() {
	const mydiv = document.querySelector('.notice-container');
	const style = window.getComputedStyle(mydiv);
	
    if (style.display === 'none') {
        mydiv.style.display = 'block';
    } else {
        mydiv.style.display = 'none';
    }
}

function communityClick() {
    const mydiv = document.querySelector('.notice-container');
    if (mydiv.style.display === 'none') {
        mydiv.style.display = 'block';
    } else {
        mydiv.style.display = 'none';
    }
}






//정민
//로그아웃	
//알림메세지	
function msg() {	//알림메세지 모달창 열기
	document.querySelector('.msg-page').style.display = 'block';
}

function closeMsg() { //알림메세지 모달창 닫기
	document.querySelector('.msg-page').style.display = 'none';
}
function sendMsg() { //알림메세지 전송
	document.querySelector('.msg-page').style.display = 'none';
}


//회원추가	
function openAdd() { //회원추가 모달창 열기
	document.querySelector('.member-message-container').style.display = 'flex';
}

function add() { //회원추가
	document.querySelector('.add-page').style.display = 'none';
}


//회원알림
function openSelect(){ //회원추가 모달창 열기
	document.querySelector('.add-page').style.display ='block';
}

function closeSelect(){ //회원추가 모달창 닫기
	document.querySelector('.add-page').style.display ='none';
}













/* ***************** 나은 ***************** */
function openStopCancelList(){
	document.querySelector(".stop-clear-status-container").style.display = 'flex';
}

function closeStopCancelList(){
	document.querySelector(".stop-clear-status-container").style.display = 'none';
}


function convertToStopCancel(i){
	//정지 대여번호
	let st_cancel_rentno = document.querySelector("#st-cancel-rental-no"+i).innerText;
	
	let st_cancel_hidden_input = document.querySelector("#input-st-cancel-rentno");
	st_cancel_hidden_input.value = st_cancel_rentno;
	
	console.log(st_cancel_hidden_input.value);
	
	if(st_cancel_hidden_input.value != null){
		document.querySelector("#frm-stop-cancel").submit();
	} else {
		alert("대여번호가 바르게 전송되지 않았습니다");
	}
}




//연체버튼이 눌리면 대여번호를 가져와서 form 전송
function convertToOverdue(i){
	//연체대여번호
	let od_rentno = document.querySelector("#od-rental-no"+i).innerText;
	
	let od_hidden_input = document.querySelector("#input-od-rentno");
	od_hidden_input.value = od_rentno;
	
	console.log(od_hidden_input.value);
	
	if(od_hidden_input.value != null){
		document.querySelector("#frm-overdue").submit();
	} else {
		alert("대여번호가 바르게 전송되지 않았습니다");
	}
	
}


function openStopList(){
	//정지 현황 모달창 flex
	document.querySelector(".stop-status-container").style.display = 'flex';
}

function closeStopList(){
	//정지 현황 모달창 none
	document.querySelector(".stop-status-container").style.display = 'none';
}



function convertToStop(i){
	//정지대여번호
	let st_rentno = document.querySelector("#st-rental-no"+i).innerText;
	
	let st_hidden_input = document.querySelector("#input-st-rentno");
	st_hidden_input.value = st_rentno;
	
	console.log(st_hidden_input.value);
	
	if(st_hidden_input.value != null){
		document.querySelector("#frm-stop").submit();
	} else {
		alert("대여번호가 바르게 전송되지 않았습니다");
	}
}


//도서정보에서 대여 버튼을 누르면 모달창이 열리게 함
function openRt(i){
	document.querySelector('.rt-page').style.display ='block';
	
	//도서 번호를 가져옴
	let b_id = document.querySelector('#b-id'+i).innerText;
	document.querySelector('#b-book-id').innerText = b_id;
	
	//도서 번호를 가져옴 회원이름을 가져옴
	let b_name = document.querySelector('#b-name'+i).innerText;
	document.querySelector('#b-book-name').innerText = b_name;
	
	//hidden 처리된 input창에 도서 번호를 넣음
	document.querySelector('#book-hiddenId').value = b_id;
	console.log(document.querySelector('#book-hiddenId').value);
}

//도서정보에서 열린 모달창이 닫히게 함  
function closeRt(){
	document.querySelector('.rt-page').style.display ='none';
}




//연체조회버튼이 눌리면 modal창을 나오게 하는 함수(아직 구현X)
function openOverdueList(){
	console.log("연체조회 버튼 눌림");
	document.querySelector(".overdue-status-container").style.display = 'flex';
}

function closeOverdueList(){
	console.log("연체조회 버튼 눌림");
	document.querySelector(".overdue-status-container").style.display = 'none';
}



//회원 대여내역 조회에서 반납버튼을 누르면 hidden된 input창에 대여번호를 담고 form을 날리는 메소드
function openConfirmReturn(i){				
  let return_result = confirm("반납으로 전환하시겠습니까?");
  
  //confirm창에서 관리자가 확인을 누르면(값이 true)					
  if(return_result){
	  
	  //hidden된 input창에 동적할당된 id값을 가지고 있는 tr의 대여번호를 담음				
	  let return_no = document.querySelector("#returnNoInput");
	  return_no.value = document.querySelector("#membRentalNO"+i).innerText;
				  
	  console.log(return_no.value);
	  
	  //대여 번호를 잘 가져왔으면 form 전송				
	  if(return_no != null ){
		  document.getElementById("frm-return").submit();
		  
	  } else {
		  alert("도서번호와 회원 정보가 제대로 전송되지 않았습니다.");
		  history.back();
	  }
					  
					  
  } else { //confirm창에서 취소를 누르면
	  alert("반납이 취소되었습니다");
  }
				  
}




