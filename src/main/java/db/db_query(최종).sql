-- 맨 하단에 DROP/SELECT 쿼리문 있습니다.

-- 테이블 생성 쿼리문
-- 고객 테이블
CREATE TABLE memberinfo(
   membno NUMBER PRIMARY KEY,
   mname VARCHAR2(15) NOT NULL,
   maddress VARCHAR2(100) NOT NULL,
   mphone VARCHAR2(13) NOT NULL,
   mstatus_id VARCHAR2(3) NOT NULL
);

-- 고객 정보 내부 도서 대여 상태
CREATE TABLE member_status(
    mstatus_id VARCHAR2(3) PRIMARY KEY,
    mstatus VARCHAR2(15) NOT NULL
);

-- 책 테이블
CREATE TABLE book(
    bookno NUMBER(4) PRIMARY KEY,
    bname VARCHAR2(80) NOT NULL,
    bauthor VARCHAR2(30) NOT NULL,
    bpublish VARCHAR2(30) NOT NULL,
    bprice NUMBER NOT NULL,
    genrno NUMBER(2) NOT NULL,
    bdate DATE
);

-- 장르 테이블
CREATE TABLE genre(
    genrno NUMBER(2) PRIMARY KEY,
    gname VARCHAR2(30) NOT NULL
);

-- 책 수량 테이블
CREATE TABLE book_quantity(
    bookno NUMBER(4) PRIMARY KEY,
    bcount NUMBER NOT NULL
);

--대출 목록
CREATE TABLE rental(
    rentno NUMBER(5) PRIMARY KEY, 
    membno NUMBER(3) NOT NULL,
    bookno NUMBER(4) NOT NULL,   
    rental_date DATE NOT NULL,
    return_date DATE NOT NULL,
    od_date DATE,
    stop_date DATE,
    comp_date DATE,
    rstatus_id VARCHAR2(3) NOT NULL    
);

-- 도서 대여 목록 내부 도서 대여 상태
create table rental_status(
    rstatus_id VARCHAR2(3) PRIMARY KEY,
    rstatus VARCHAR2(15) NOT NULL
);

-- 도서 예약 목록
CREATE TABLE reservation(
    reserve_id NUMBER(6) PRIMARY KEY,
    membno NUMBER(3) NOT NULL,
    bookno NUMBER(4) NOT NULL,
    reserve_wait_date DATE NOT NULL,
    reserve_comp_date DATE,
    reserve_status VARCHAR2(15) NOT NULL
);

-- 회원 알림 메세지
CREATE TABLE member_message(
   msgno Number PRIMARY KEY,
   membno NUMBER NOT NULL,
   message VARCHAR2(100) NOT NULL,
   send_date Date NOT NULL
);

-- 관리자 테이블
CREATE TABLE employee(
    emp_id VARCHAR2(15) PRIMARY KEY,
    ename VARCHAR2(15) NOT NULL,
    password VARCHAR2(15) NOT NULL,
    ebirth VARCHAR2(6) NOT NULL, 
    position VARCHAR2(10) NOT NULL,  
    dept_name VARCHAR2(30) NOT NULL ,
    emp_date Date NOT NULL
);

-- 관리자 커뮤니티 
CREATE TABLE employee_community(
    commno VARCHAR2(10) PRIMARY KEY,
    emp_id VARCHAR2(15) NOT NULL,
    message VARCHAR2(4000) NOT NULL,
    send_date date NOT NULL
);

-- INSERT 쿼리문
-- member_status 값 저장
INSERT INTO member_status 
VALUES ('rt', '대여중' );
INSERT INTO member_status 
VALUES ('rs', '예약' );
INSERT INTO member_status 
VALUES ('od', '연체중' );
INSERT INTO member_status 
VALUES ('nrt', '미대여' );
INSERT INTO member_status 
VALUES ('st', '정지' );

-- rental_status 값 저장
INSERT INTO rental_status
VALUES ('rt', '대여중');
INSERT INTO rental_status
VALUES ('od', '연체중');
INSERT INTO rental_status
VALUES ('st', '정지');
INSERT INTO rental_status
VALUES ('rs', '예약');
INSERT INTO rental_status
VALUES ('cc', '예약취소');
INSERT INTO rental_status
VALUES ('cp', '반납완료');
select * from rental;
-- rental 값 저장
INSERT INTO rental(rentno, membno, bookno, rental_date, return_date, rstatus_id)
VALUES (10000, 100, 1000, SYSDATE, SYSDATE+7, 'rt');
--정지전환으로 쓸 더미
INSERT INTO rental(rentno, membno, bookno, rental_date, return_date, od_date, rstatus_id)
VALUES ((SELECT MAX(rentno) FROM rental)+1, 100, 1001, TO_DATE('2024-06-17', 'YYYY-MM-DD'), TO_DATE('2024-06-17', 'YYYY-MM-DD')+7, TO_DATE('2024-06-17', 'YYYY-MM-DD')+8, 'od');
INSERT INTO rental(rentno, membno, bookno, rental_date, return_date, rstatus_id)
VALUES ((SELECT MAX(rentno) FROM rental)+1, 101, 1003, SYSDATE, SYSDATE+7, 'rt');
INSERT INTO rental(rentno, membno, bookno, rental_date, return_date, comp_date, rstatus_id)
VALUES ((SELECT MAX(rentno) FROM rental)+1, 101, 1004, TO_DATE('2024-04-17', 'YYYY-MM-DD'), TO_DATE('2024-04-17', 'YYYY-MM-DD')+7, TO_DATE('2024-04-17', 'YYYY-MM-DD')+3, 'cp');
INSERT INTO rental(rentno, membno, bookno, rental_date, return_date, od_date, rstatus_id)
VALUES ((SELECT MAX(rentno) FROM rental)+1, 102, 1010, TO_DATE('2024-06-26', 'YYYY-MM-DD'), TO_DATE('2024-06-26', 'YYYY-MM-DD')+7, TO_DATE('2024-06-26', 'YYYY-MM-DD')+8, 'od');
INSERT INTO rental(rentno, membno, bookno, rental_date, return_date, rstatus_id)
VALUES ((SELECT MAX(rentno) FROM rental)+1, 103, 1001, SYSDATE, SYSDATE+7, 'rt');
INSERT INTO rental(rentno, membno, bookno, rental_date, return_date, rstatus_id)
VALUES ((SELECT MAX(rentno) FROM rental)+1, 103, 1006, SYSDATE, SYSDATE+7, 'rt');
INSERT INTO rental(rentno, membno, bookno, rental_date, return_date, od_date, rstatus_id)
VALUES ((SELECT MAX(rentno) FROM rental)+1, 104, 1013, TO_DATE('2024-06-12', 'YYYY-MM-DD'), TO_DATE('2024-06-12', 'YYYY-MM-DD')+7, TO_DATE('2024-06-12', 'YYYY-MM-DD')+8, 'od');
INSERT INTO rental(rentno, membno, bookno, rental_date, return_date, comp_date, rstatus_id)
VALUES ((SELECT MAX(rentno) FROM rental)+1, 105, 1023, TO_DATE('2024-06-01', 'YYYY-MM-DD'), TO_DATE('2024-06-01', 'YYYY-MM-DD')+7, TO_DATE('2024-06-01', 'YYYY-MM-DD')+5, 'cp');
INSERT INTO rental(rentno, membno, bookno, rental_date, return_date, rstatus_id)
VALUES ((SELECT MAX(rentno) FROM rental)+1, 106, 1009, SYSDATE, SYSDATE+7, 'rt');
INSERT INTO rental(rentno, membno, bookno, rental_date, return_date, rstatus_id)
VALUES ((SELECT MAX(rentno) FROM rental)+1, 106, 1021, SYSDATE, SYSDATE+7, 'rt');
INSERT INTO rental(rentno, membno, bookno, rental_date, return_date, od_date, stop_date, comp_date, rstatus_id)
VALUES ((SELECT MAX(rentno) FROM rental)+1, 107, 1024, TO_DATE('2024-06-10', 'YYYY-MM-DD'), TO_DATE('2024-06-10', 'YYYY-MM-DD')+7, TO_DATE('2024-06-10', 'YYYY-MM-DD')+8, TO_DATE('2024-06-10', 'YYYY-MM-DD')+15, TO_DATE('24/06/25', 'YY/MM/DD'), 'cp');
INSERT INTO rental(rentno, membno, bookno, rental_date, return_date, comp_date, rstatus_id)
VALUES ((SELECT MAX(rentno) FROM rental)+1, 108, 1024, TO_DATE('2024-06-05', 'YYYY-MM-DD'), TO_DATE('2024-06-05', 'YYYY-MM-DD')+7, TO_DATE('2024-06-05', 'YYYY-MM-DD')+6, 'cp');
INSERT INTO rental(rentno, membno, bookno, rental_date, return_date, rstatus_id)
VALUES ((SELECT MAX(rentno) FROM rental)+1, 109, 1011, SYSDATE, SYSDATE+7, 'rt');
INSERT INTO rental(rentno, membno, bookno, rental_date, return_date, rstatus_id)
VALUES ((SELECT MAX(rentno) FROM rental)+1, 106, 1002, SYSDATE, SYSDATE+7, 'rt');

-- 대여 -> 연체전환
update rental
set rental_date = TO_DATE('24/06/22', 'YY/MM/DD'),
return_date = TO_DATE('24/06/29', 'YY/MM/DD')
where rentno = 10005;

-- 정지 -> 정지 해제


-- 예약내역조회에 뜰 예시
INSERT INTO reservation(reserve_id, membno, bookno, reserve_wait_date, reserve_status)
VALUES ((SELECT NVL(MAX(reserve_id)+1, 100000) FROM reservation), 101, 1002, 
TO_DATE('24/07/03', 'YY-MM-DD'), '예약대기');

INSERT INTO reservation(reserve_id, membno, bookno, reserve_wait_date, reserve_status)
VALUES ((SELECT NVL(MAX(reserve_id)+1, 100000) FROM reservation), 108, 1002, 
TO_DATE('24/07/03', 'YY-MM-DD'), '예약대기');

-- 예약 만료내역에 뜰 예시
INSERT INTO rental(rentno, membno, bookno, rental_date, return_date, rstatus_id)
values ((SELECT MAX(rentno) FROM rental)+1, 105, 1002, 
TO_DATE('24/07/03', 'YY-MM-DD'), TO_DATE('24/07/10', 'YY-MM-DD'), 'rs');

INSERT INTO reservation(reserve_id, membno, bookno, reserve_wait_date, reserve_comp_date, reserve_status)
VALUES ((SELECT NVL(MAX(reserve_id)+1, 100000) FROM reservation), 105, 1002, 
TO_DATE('24/06/20', 'YY-MM-DD'), TO_DATE('24/06/25', 'YY-MM-DD'), '예약완료');

-- book_quantity 값 저장
INSERT INTO book_quantity
VALUES (1000, 3);
INSERT INTO book_quantity
VALUES ((SELECT MAX(bookno) FROM book_quantity)+1, 4);
INSERT INTO book_quantity
VALUES ((SELECT MAX(bookno) FROM book_quantity)+1, 2);
INSERT INTO book_quantity
VALUES ((SELECT MAX(bookno) FROM book_quantity)+1, 1);
INSERT INTO book_quantity
VALUES ((SELECT MAX(bookno) FROM book_quantity)+1, 3);
INSERT INTO book_quantity
VALUES ((SELECT MAX(bookno) FROM book_quantity)+1, 2);
INSERT INTO book_quantity
VALUES ((SELECT MAX(bookno) FROM book_quantity)+1, 4);
INSERT INTO book_quantity
VALUES ((SELECT MAX(bookno) FROM book_quantity)+1, 3);
INSERT INTO book_quantity
VALUES ((SELECT MAX(bookno) FROM book_quantity)+1, 2);
INSERT INTO book_quantity
VALUES ((SELECT MAX(bookno) FROM book_quantity)+1, 3);
INSERT INTO book_quantity
VALUES ((SELECT MAX(bookno) FROM book_quantity)+1, 2);
INSERT INTO book_quantity
VALUES ((SELECT MAX(bookno) FROM book_quantity)+1, 3);
INSERT INTO book_quantity
VALUES ((SELECT MAX(bookno) FROM book_quantity)+1, 2);
INSERT INTO book_quantity
VALUES ((SELECT MAX(bookno) FROM book_quantity)+1, 4);
INSERT INTO book_quantity
VALUES ((SELECT MAX(bookno) FROM book_quantity)+1, 3);
INSERT INTO book_quantity
VALUES ((SELECT MAX(bookno) FROM book_quantity)+1, 3);
INSERT INTO book_quantity
VALUES ((SELECT MAX(bookno) FROM book_quantity)+1, 4);
INSERT INTO book_quantity
VALUES ((SELECT MAX(bookno) FROM book_quantity)+1, 2);
INSERT INTO book_quantity
VALUES ((SELECT MAX(bookno) FROM book_quantity)+1, 3);
INSERT INTO book_quantity
VALUES ((SELECT MAX(bookno) FROM book_quantity)+1, 3);
INSERT INTO book_quantity
VALUES ((SELECT MAX(bookno) FROM book_quantity)+1, 5);
INSERT INTO book_quantity
VALUES ((SELECT MAX(bookno) FROM book_quantity)+1, 4);
INSERT INTO book_quantity
VALUES ((SELECT MAX(bookno) FROM book_quantity)+1, 5);
INSERT INTO book_quantity
VALUES ((SELECT MAX(bookno) FROM book_quantity)+1, 3);
INSERT INTO book_quantity
VALUES ((SELECT MAX(bookno) FROM book_quantity)+1, 4);

-- genre 값 저장
INSERT INTO genre VALUES (1, '소설');
INSERT INTO genre VALUES (2, '시/에세이');
INSERT INTO genre VALUES (3, '경제/경영');
INSERT INTO genre VALUES (4, '자기계발');
INSERT INTO genre VALUES (5, '만화');

-- book 값 저장
-- 소설
INSERT INTO book
VALUES (1000, '아이가 없는 집', '알렉스 안도릴', '필름', 16200, 1, TO_DATE('2024-06-12', 'YYYY-MM-DD'));
INSERT INTO book
VALUES ((SELECT MAX(bookno) FROM book)+1, '모순', '양귀자', '쓰다', 13000, 1, TO_DATE('2013-04-01', 'YYYY-MM-DD'));
INSERT INTO book
VALUES ((SELECT MAX(bookno) FROM book)+1, '후이늠', '강화길', '대한출판문화협회', 11000, 1, TO_DATE('2024-06-26', 'YYYY-MM-DD'));
INSERT INTO book
VALUES ((SELECT MAX(bookno) FROM book)+1, '흐르는 강물처럼', '셀리 리드', '다산책방', 17000, 1, TO_DATE('2024-01-08', 'YYYY-MM-DD'));
INSERT INTO book
VALUES ((SELECT MAX(bookno) FROM book)+1, '이처럼 사소한 것들', '클레어 키건', '다산책방', 13800, 1, TO_DATE('2023-11-27', 'YYYY-MM-DD'));  
-- 시/에세이
INSERT INTO book
VALUES ((SELECT MAX(bookno) FROM book)+1, '허송세월', '김훈', '나남', 18000, 2, TO_DATE('2024-06-20', 'YYYY-MM-DD'));
INSERT INTO book
VALUES ((SELECT MAX(bookno) FROM book)+1, '우리는 날마다 조금씩 행복해진다', '얼미부부', '웅진지식하우스', 17500, 2, TO_DATE('2024-06-19', 'YYYY-MM-DD'));
INSERT INTO book
VALUES ((SELECT MAX(bookno) FROM book)+1, '소중한 보물들', '패트릭 브링리', '웅진지식하우스', 17500, 2, TO_DATE('2023-11-24', 'YYYY-MM-DD'));
INSERT INTO book
VALUES ((SELECT MAX(bookno) FROM book)+1, '그럼에도 불구하고 나는 내가 좋았어', '박채린', '북플레저', 18000, 2, TO_DATE('2024-06-12', 'YYYY-MM-DD'));
INSERT INTO book
VALUES ((SELECT MAX(bookno) FROM book)+1, '보편의 단어', '이기주', '말글터', 16000, 2, TO_DATE('2024-01-11', 'YYYY-MM-DD'));
-- 경제/경영
INSERT INTO book
VALUES ((SELECT MAX(bookno) FROM book)+1, '더 머니북', '토스', '비바리퍼블리카', 22000, 3, TO_DATE('2024-05-27', 'YYYY-MM-DD'));
INSERT INTO book
VALUES ((SELECT MAX(bookno) FROM book)+1, '불변의 법칙', '모건 하우절', '서삼독', 25000, 3, TO_DATE('2024-02-28', 'YYYY-MM-DD'));
INSERT INTO book
VALUES ((SELECT MAX(bookno) FROM book)+1, '돈의 심리학', '모건 하우절', '인플루엔셜', 19800, 3, TO_DATE('2023-11-06', 'YYYY-MM-DD'));
INSERT INTO book
VALUES ((SELECT MAX(bookno) FROM book)+1, '저는 브랜딩을 하는 사람입니다', '허준', '필름', 18500, 3, TO_DATE('2024-05-22', 'YYYY-MM-DD'));
INSERT INTO book
VALUES ((SELECT MAX(bookno) FROM book)+1, '어떻게 살 것인가', '이광수', '이든하우스', 17000, 3, TO_DATE('2024-05-02', 'YYYY-MM-DD'));
--자기계발
INSERT INTO book
VALUES ((SELECT MAX(bookno) FROM book)+1, '포커스 리딩', '박성후', '지니의서재', 18800, 4, TO_DATE('2024-06-19', 'YYYY-MM-DD'));
INSERT INTO book
VALUES ((SELECT MAX(bookno) FROM book)+1, '나를 사랑하는 것이 먼저다', '후션즈', '지니의서재', 17800, 4, TO_DATE('2024-06-25', 'YYYY-MM-DD'));
INSERT INTO book
VALUES ((SELECT MAX(bookno) FROM book)+1, '가장 빛나는 나이에 싸구려로 살지 마라', '차이유린', '더페이지', 17800, 4, TO_DATE('2024-06-25', 'YYYY-MM-DD'));
INSERT INTO book
VALUES ((SELECT MAX(bookno) FROM book)+1, '무엇이 인간관계를 힘들게 하는가', '장샤오헝', '이든서재', '17800', 4, TO_DATE('2024-06-25', 'YYYY-MM-DD'));
INSERT INTO book
VALUES ((SELECT MAX(bookno) FROM book)+1, '세이노의 가르침', '세이노', '데이원', 7200, 4, TO_DATE('2023-03-02', 'YYYY-MM-DD'));
--만화
INSERT INTO book
VALUES ((SELECT MAX(bookno) FROM book)+1, '사카모토 데이즈16', 'Yuto Suzuki', '대원씨아이', 6000, 5, TO_DATE('2024-06-27', 'YYYY-MM-DD'));
INSERT INTO book
VALUES ((SELECT MAX(bookno) FROM book)+1, '주술회전 26', 'Gege Akutami', '서울미디어코믹스', 6000, 5, TO_DATE('2024-06-30', 'YYYY-MM-DD'));
INSERT INTO book
VALUES ((SELECT MAX(bookno) FROM book)+1, '스파이 패밀리13', 'Tatsuya Endo', '학산문화사', 6000, 5, TO_DATE('2024-06-25', 'YYYY-MM-DD'));
INSERT INTO book
VALUES ((SELECT MAX(bookno) FROM book)+1, '원피스 108', 'EIICHIRO ODA', '대원씨아이', 5500, 5, TO_DATE('2024-05-31', 'YYYY-MM-DD'));
INSERT INTO book
VALUES ((SELECT MAX(bookno) FROM book)+1, '나 혼자만 레벨업11', '장성락', '디앤씨미디어', 16000, 5, TO_DATE('2024-06-04', 'YYYY-MM-DD'));

-- memberinfo 값 저장
INSERT INTO memberinfo 
VALUES (100, '강지은', '충청남도 천안시 서북구 성성2길 52-1', '01012345678', 'od');
INSERT INTO memberinfo 
VALUES ((SELECT MAX(membno) FROM memberinfo)+1, '김규빈', '충청남도 천안시 서북구 두정동 봉정로 374 창성빌딩 1층', '01023456789', 'rt');
INSERT INTO memberinfo 
VALUES ((SELECT MAX(membno) FROM memberinfo)+1, '김혜민', '충청남도 천안시 동남구 먹거리3길 21', '01034567891', 'od');
INSERT INTO memberinfo 
VALUES ((SELECT MAX(membno) FROM memberinfo)+1, '박상준', '충청남도 천안시 동남구 유량동 태조산길 258', '01045678912', 'rt');
INSERT INTO memberinfo 
VALUES ((SELECT MAX(membno) FROM memberinfo)+1, '서민주', '충청남도 천안시 동남구 원성동 509-12 102호', '01056789123', 'od');
INSERT INTO memberinfo 
VALUES ((SELECT MAX(membno) FROM memberinfo)+1, '서원우', '충청남도 천안시 서북구 봉정로 168-3', '01067891234', 'rs');
INSERT INTO memberinfo 
VALUES ((SELECT MAX(membno) FROM memberinfo)+1, '우희선', '충청남도 천안시 서북구 성정중1길 26-2', '01078912345', 'rt');
INSERT INTO memberinfo 
VALUES ((SELECT MAX(membno) FROM memberinfo)+1, '윤정호', '충청남도 천안시 서북구 백석 4길 31 1층', '01089123456', 'st');
INSERT INTO memberinfo 
VALUES ((SELECT MAX(membno) FROM memberinfo)+1, '이진수', '충청남도 천안시 서북구 성정두정로 70', '01091234567', 'rs');
INSERT INTO memberinfo 
VALUES ((SELECT MAX(membno) FROM memberinfo)+1, '정지흠', '충청남도 천안시 동남구 대흥로 215 7층 703호', '01011112222', 'rt');

--employee값 저장
INSERT INTO employee
VALUES ('01012345678', '김일번', 'qwer123', '701212', '팀장', '영업부', SYSDATE);
INSERT INTO employee
VALUES ('01074125896', '김이번', 'asd456','800923', '과장', '영업부', SYSDATE);
INSERT INTO employee
VALUES ('01032145698', '김삼번', 'zxc789','900708', '대리', '영업부', SYSDATE);
INSERT INTO employee
VALUES ('01036985214', '김사번', 'qaz741','950629', '주임', '영업부', SYSDATE);
INSERT INTO employee
VALUES ('01098745632', '김오번', 'wsx852','991011', '사원', '영업부', SYSDATE);

-- 시퀀스 생성
CREATE SEQUENCE emp_community_sequence
START WITH 10000
INCREMENT BY 1;




--도서 추가
INSERT INTO book
VALUES ((SELECT MAX(bookno) FROM book)+1, '   마녀와의 7일', '히가시노 게이고', '현대문학', 16920, 1, TO_DATE('2024-06-25', 'YYYY-MM-DD'));
INSERT INTO book
VALUES ((SELECT MAX(bookno) FROM book)+1, '싯다르타', '헤르만 헤세', '민음사', 7200, 1, TO_DATE('2002-01-20', 'YYYY-MM-DD'));
INSERT INTO book
VALUES ((SELECT MAX(bookno) FROM book)+1, '불편한 편의점', '김호연', '나무옆의자', 12600, 1, TO_DATE('2021-04-20', 'YYYY-MM-DD'));
INSERT INTO book
VALUES ((SELECT MAX(bookno) FROM book)+1, '꽃길이 따로 있나 내 삶이 꽃인 것을', '오평선', '포레스트북스', 15120, 2, TO_DATE('2024-03-22', 'YYYY-MM-DD'));
INSERT INTO book
VALUES ((SELECT MAX(bookno) FROM book)+1, '금빛 종소리', '김하나', '민음사', 15300, 2, TO_DATE('2024-06-21', 'YYYY-MM-DD'));  
INSERT INTO book
VALUES ((SELECT MAX(bookno) FROM book)+1, '자본주의', 'EBS 자본주의 제작팀', '가나출판사', 15300, 3, TO_DATE('2013-09-27', 'YYYY-MM-DD'));
INSERT INTO book
VALUES ((SELECT MAX(bookno) FROM book)+1, '돈의 속성', '김승호', '스노우폭스북스', 16020, 3, TO_DATE('2020-06-15', 'YYYY-MM-DD'));  
INSERT INTO book
VALUES ((SELECT MAX(bookno) FROM book)+1, '그의 운명에 대한 아주 개인적인 생각', '유시민', '생각의길', 15120, 4, TO_DATE('2024-06-19', 'YYYY-MM-DD'));
INSERT INTO book
VALUES ((SELECT MAX(bookno) FROM book)+1, '대화의 힘', '찰스 두히그', '갤리온', 17100, 4, TO_DATE('2024-06-25', 'YYYY-MM-DD'));  
INSERT INTO book
VALUES ((SELECT MAX(bookno) FROM book)+1, '쿠이 료코 낙서집 데이드림 아워', '쿠이 료코', '소미미디어', 52200, 5, TO_DATE('2024-06-04', 'YYYY-MM-DD'));
INSERT INTO book
VALUES ((SELECT MAX(bookno) FROM book)+1, '반딧불이의 혼례2', 'Oreco TACHIBANA', '서울미디어코믹스', 7650, 5, TO_DATE('2024-06-30', 'YYYY-MM-DD'));  

INSERT INTO book_quantity
VALUES ((SELECT MAX(bookno) FROM book_quantity)+1, 4);
INSERT INTO book_quantity
VALUES ((SELECT MAX(bookno) FROM book_quantity)+1, 2);
INSERT INTO book_quantity
VALUES ((SELECT MAX(bookno) FROM book_quantity)+1, 1);
INSERT INTO book_quantity
VALUES ((SELECT MAX(bookno) FROM book_quantity)+1, 3);
INSERT INTO book_quantity
VALUES ((SELECT MAX(bookno) FROM book_quantity)+1, 2);
INSERT INTO book_quantity
VALUES ((SELECT MAX(bookno) FROM book_quantity)+1, 4);
INSERT INTO book_quantity
VALUES ((SELECT MAX(bookno) FROM book_quantity)+1, 3);
INSERT INTO book_quantity
VALUES ((SELECT MAX(bookno) FROM book_quantity)+1, 2);
INSERT INTO book_quantity
VALUES ((SELECT MAX(bookno) FROM book_quantity)+1, 3);
INSERT INTO book_quantity
VALUES ((SELECT MAX(bookno) FROM book_quantity)+1, 2);
INSERT INTO book_quantity
VALUES ((SELECT MAX(bookno) FROM book_quantity)+1, 5);
--회원 추가
INSERT INTO memberinfo 
VALUES ((SELECT MAX(membno) FROM memberinfo)+1, '백종원', '충청남도 천안시 서북구 오성3길 24', '01074102589', 'nrt');
INSERT INTO memberinfo 
VALUES ((SELECT MAX(membno) FROM memberinfo)+1, '이천수', '충청남도 천안시 서북구 오성로 65', '01063025874', 'nrt');
INSERT INTO memberinfo 
VALUES ((SELECT MAX(membno) FROM memberinfo)+1, '손흥민', '충청남도 천안시 동남구 은행길 5-8', '01078965412', 'nrt');
INSERT INTO memberinfo 
VALUES ((SELECT MAX(membno) FROM memberinfo)+1, '김도영', '충청남도 천안시 동남구 대흥로 228 삼영빌딩 113,114호', '01063210258', 'nrt');
INSERT INTO memberinfo 
VALUES ((SELECT MAX(membno) FROM memberinfo)+1, '호날두', '충청남도 천안시 서북구 부성4길 16 미성화인빌2', '01069874563', 'nrt');
INSERT INTO memberinfo 
VALUES ((SELECT MAX(membno) FROM memberinfo)+1, '메시', '충청남도 천안시 서북구 검은들3길 58', '01054120369', 'nrt');
INSERT INTO memberinfo 
VALUES ((SELECT MAX(membno) FROM memberinfo)+1, '김하성', '충청남도 천안시 동남구 태조산길 258', '01069851230', 'nrt');
INSERT INTO memberinfo 
VALUES ((SELECT MAX(membno) FROM memberinfo)+1, '이범호', '충청남도 천안시 서북구 원두정8길 6 1층', '01074103698', 'nrt');
INSERT INTO memberinfo 
VALUES ((SELECT MAX(membno) FROM memberinfo)+1, '박진만', '충청남도 천안시 동남구 서부대로 139 1층 101호', '01052031476', 'nrt');


-- 시퀀스 삽입 예시
--INSERT INTO emp_community (commno, empno)
--VALUES ('COMM' || emp_community_sequence.NEXTVAL, 'Sample Name 1');

-- 테이블 읽기
--SELECT * FROM memberInfo;
--SELECT * FROM book ;
--SELECT * FROM rental;
--SELECT * FROM member_status;
--SELECT * FROM rental_status;
--SELECT * FROM book_quantity;
--SELECT * FROM genre;
--SELECT * FROM reservation;
--SELECT * FROM employee;
--SELECT * FROM employee_community;
--SELECT * FROM member_message;

-- 테이블 삭제
--DROP TABLE memberInfo;
--DROP TABLE book;
--DROP TABLE rental;
--DROP TABLE member_status;
--DROP TABLE rental_status;
--DROP TABLE book_quantity;
--DROP TABLE genre;
--DROP TABLE reservation;
--DROP TABLE employee;
--DROP TABLE employee_community;
--DROP TABLE member_message;
--DROP SEQUENCE emp_community_sequence;

COMMIT;