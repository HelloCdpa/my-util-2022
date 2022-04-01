-- database 생성
create database mysql_phl;
-- 사용자 생성 @서버의 주소
create user user_phl@localhost identified by '1234';
-- 사용자 삭제
drop user user_phl@localhost;
-- user_phl 에게 mysql_phl 사용 권한 부여
grant all privileges on mysql_phl.* to user_phl@localhost;
select user();

-- 컬럼 추가 , 삭제 등 
select * from naver_member;
-- 회원주소를 저장할 컬럼 필요
-- n_address varchar(50)
alter table naver_member add n_address varchar(50);
-- 컬럼 이름 변경
alter table naver_member change n_address n_add varchar(50);
-- 컬럼 타입, 크기 변경
alter table naver_member modify n_add varchar(100);
desc naver_member;
-- 컬럼 삭제
alter table naver_member drop n_add;
-- db쿼리 카테고리 정리
use mysql_phl3;
drop table test1;
create table test1 (
	col1 varchar(10),
    col2 varchar(20)
);
insert into test1 (col1, col2)
values ('aa','bb');

select * from test1;
commit;
rollback; -- 커밋을 안하고 롤백을 하면 전에 했던 내용이 취소 됨
select @@autocommit; -- 1: autocommit
set autocommit = false;
set autocommit = true;
drop table orders;
drop table customer;
drop table book;



create table book (
b_id int auto_increment,
b_bookname varchar(40) not null,
b_publisher varchar(40) not null,
b_price int not null,

constraint primary key (b_id)
);

insert into book (b_bookname, b_publisher, b_price)
values ('축구의 역사','굿 스포츠', 7000 );
insert into book (b_bookname, b_publisher, b_price)
values ('축구 스카우팅 리포트','나무수', 13000 );
insert into book (b_bookname, b_publisher, b_price)
values ('축구의 이해','대한미디어', 22000 );
insert into book (b_bookname, b_publisher, b_price)
values ('배구 바이블','대한미디어', 35000 );
insert into book (b_bookname, b_publisher, b_price)
values ('피겨 교본','굿 스포츠', 8000 );
insert into book (b_bookname, b_publisher, b_price)
values ('피칭 단계별 기술','굿 스포츠', 6000 );
insert into book (b_bookname, b_publisher, b_price)
values ('야구의 추억','이상미디어', 20000 );
insert into book (b_bookname, b_publisher, b_price)
values ('야구를 부탁해','이상미디어', 13000 );
insert into book (b_bookname, b_publisher, b_price)
values ('올림픽 이야기','삼성당', 7500 );
insert into book (b_bookname, b_publisher, b_price)
values ('olympic champions','pearson', 13000 );

select * from book;

create table customer (
c_id int auto_increment,
c_name varchar(40) not null,
c_address varchar(50) not null,
c_phone varchar(20),

constraint primary key (c_id)
);

insert into customer (c_name, c_address, c_phone)
values ('손흥민','영국 런던','000-5000-0001');
insert into customer (c_name, c_address, c_phone)
values ('김연아','대한민국 서울','000-6000-0001');
insert into customer (c_name, c_address, c_phone)
values ('김연경','중국 상하이','000-7000-0001');
insert into customer (c_name, c_address, c_phone)
values ('류현진','캐나다 토론토','000-8000-0001');
insert into customer (c_name, c_address, c_phone)
values ('이강인','스페인 마요르카',null);

select * from customer;



create table orders (
o_id int auto_increment,
c_id int,
b_id int,
o_saleprice int not null,
o_orderdate date not null,

constraint foreign key (c_id)references customer(c_id) on delete cascade,
constraint foreign key (b_id)references book(b_id)on delete cascade,
constraint primary key (o_id)

);
insert into orders (c_id, b_id, o_saleprice, o_orderdate)
values(1,1,6000,str_to_date('2021-07-01','%Y-%m-%d'));
insert into orders (c_id, b_id, o_saleprice, o_orderdate)
values(1,3,21000,str_to_date('2021-07-03','%Y-%m-%d'));
insert into orders (c_id, b_id, o_saleprice, o_orderdate)
values(2,5,8000,str_to_date('2021-07-03','%Y-%m-%d'));
insert into orders (c_id, b_id, o_saleprice, o_orderdate)
values(3,6,6000,str_to_date('2021-07-04','%Y-%m-%d'));
insert into orders (c_id, b_id, o_saleprice, o_orderdate)
values(4,7,20000,str_to_date('2021-07-05','%Y-%m-%d'));
insert into orders (c_id, b_id, o_saleprice, o_orderdate)
values(1,2,12000,str_to_date('2021-07-07','%Y-%m-%d'));
insert into orders (c_id, b_id, o_saleprice, o_orderdate)
values(4,8,13000,str_to_date('2021-07-07','%Y-%m-%d'));
insert into orders (c_id, b_id, o_saleprice, o_orderdate)
values(3,10,12000,str_to_date('2021-07-08','%Y-%m-%d'));
insert into orders (c_id, b_id, o_saleprice, o_orderdate)
values(2,10,7000,str_to_date('2021-07-09','%Y-%m-%d'));
insert into orders (c_id, b_id, o_saleprice, o_orderdate)
values(3,8,13000,str_to_date('2021-07-10','%Y-%m-%d'));

select * from orders;
select * from book;
select * from customer;

-- 1. 모든 도서의 가격과 도서명 조회 
select b_bookname, b_price from book;
-- 2. 모든 출판사 이름 조회 
select b_publisher from book;
-- 2.1 중복값을 제외한 출판사 이름 조회 
select distinct b_publisher from book;
-- 3. BOOK테이블의 모든 내용 조회 
select * from book;
-- 4. 20000원 미만의 도서만 조회 
select * from book where b_price < 20000;
-- 5. 10000원 이상 20000원 이하인 도서만 조회
select * from book where b_price <= 20000 && b_price >=10000;
-- 6. 출판사가 굿스포츠 또는 대한미디어인 도서 조회 
select * from book where b_publisher = '굿 스포츠' or b_publisher ='대한미디어';
-- 7. 도서명에 축구가 포함된 모든 도서를 조회
select * from book where b_bookname like '%축구%';
-- 8. 도서명의 두번째 글자가 구인 도서 조회
select * from book where b_bookname like '_구%';
-- 9. 축구 관련 도서 중 가격이 20000원 이상인 도서 조회
select * from book where b_bookname like '%축구%' and b_price >=20000;
-- 10. 책 이름순으로 전체 도서 조회
select * from book order by b_bookname asc;
-- 11. 도서를 가격이 낮은 것 부터 조회하고 같은 가격일 경우 도서명을 가나다 순으로 조회
select * from book order by b_price asc, b_bookname asc;


-- 12. 주문 도서의 총 판매액 조회 
select sum(o_saleprice) from orders;
-- 13. 1번 고객이 주문한 도서 총 판매액 조회 
select sum(o_saleprice) from orders where c_id=1;
-- 14. ORDERS 테이블로 부터 평균판매가, 최고판매가, 최저판매가 조회 
select round(avg(o_saleprice),1), max(o_saleprice), min(o_saleprice) from orders;
-- 15. 고객별로 주문한 도서의 총 수량과 총 판매액 조회 (GROUP BY 활용)
select c_id,count(o_id),sum(o_saleprice) from orders group by c_id;
-- 16. 가격이 8,000원 이상인 도서를 구매한 고객(where)에 대해 /고객별 주문 도서의 총 수량 조회 (GROUP BY 활용)
select c_id,count(o_id),count(b_id) from orders where o_saleprice>=8000 group by c_id having count(c_id)>=2;
--    (단, 8,000원 이상 도서 두 권 이상 구매한 고객만(그룹핑한 결과에 대한 조건 having)) 
-- 17. 2번 고객 총 구매액
select sum(o_saleprice) from orders group by c_id having c_id=2;
-- 18. 2번 고객이 구매한 도서의 수
select count(b_id) from orders group by c_id having c_id=2;
-- 19. 서점에 있는 도서의 총 권수
select count(b_id) from book;
-- 20. 출판사의 총 수 
select count(distinct b_publisher) from book;

select * from customer;
select * from book;
select * from orders;
-- 21. 7월 4일 ~ 7일 사이에 주문한 도서의 주문번호 조회 
select o_id from orders where o_orderdate between str_to_date ('2021-07-04','%Y-%m-%d') and  str_to_date ('2021-07-07','%Y-%m-%d');
-- 22. 7월 4일 ~ 7일 사이에 주문하지 않은 도서의 주문번호 조회 
select o_id from orders where o_orderdate not between str_to_date ('2021-07-04','%Y-%m-%d') and  str_to_date ('2021-07-07','%Y-%m-%d');
-- 23번 부터는 조인 활용 
-- 23. 고객, 주문 테이블 조인하여 고객번호 순으로 정렬
-- ambiguous 애매하다 
select o.*,c.* from orders o, customer c where o.c_id = c.c_id order by o.c_id asc;
-- 24. 고객이름(CUSTOMER), 고객이 주문한 도서 가격(ORDERS) 조회 
select o.o_saleprice, c.c_name from orders o, customer c where o.c_id = c.c_id order by o.c_id asc;
-- 25. 고객별(GROUP)로 주문한 도서의 총 판매액(SUM)과 고객이름을 조회하고 조회 결과를 가나다 순으로 정렬 
select sum(o_saleprice) from orders group by c_id; 
select c.c_name as'고객이름',sum(o.o_saleprice) as '총판매액' from orders o, customer c where o.c_id = c.c_id group by c.c_id order by c.c_name asc;
-- 26. 고객명과 고객이 주문한 도서명을 조회(3테이블 조인)
select c.c_name as '고객명',b.b_bookname as'주문한 도서명' from orders o, customer c, book b where o.c_id = c.c_id and b.b_id = o.b_id;
-- 27. 2만원(SALEPRICE) 이상 도서를 주문한 고객의 이름과 도서명을 조회 
select o.o_saleprice as '가격',c.c_name as '고객명',b.b_bookname as'주문한 도서명' from orders o, customer c, book b
	where o.c_id = c.c_id and b.b_id = o.b_id and o.o_saleprice>=20000;
-- 28. 손흥민 고객의 총 구매액과 고객명을 함께 조회
select sum(o.o_saleprice) as '총 구매액',c.c_name as '고객명' from orders o, customer c, book b
	where o.c_id = c.c_id and b.b_id = o.b_id and c.c_name='손흥민';
-- 29. 손흥민 고객의 총 구매수량과 고객명을 함께 조회
select count(o.b_id) as '총 구매수량',c.c_name as '고객명' from orders o, customer c, book b
	where o.c_id = c.c_id and b.b_id = o.b_id and c.c_name='손흥민';
    
select * from customer;
select * from book;
select * from orders;
-- 30. 가장 비싼 도서의 이름을 조회 
select max(b_price) from book;
select b_bookname from book where b_price = (select max(b_price) from book);
-- 31. 책을 구매한 이력이 있는 고객의 이름을 조회
select c_name as '책을 구매한 사람들'from customer c, orders o where c.c_id = o.c_id group by c_name; 
-- 1,2,3,4, 고객의 이름을 조회
select c_name from customer where c_id=1 or c_id=2 or c_id=3 or c_id=4;
select c_name from customer where c_id in(1,2,3,4);
select c_name from customer where c_id in(select c_id from orders);


-- 32. 도서의 가격(PRICE)과 판매가격(SALEPRICE)의 차이가 가장 많이 나는 주문 조회 
select b.b_price - o.o_saleprice from orders o, book b where o.b_id= b.b_id;
select max(b.b_price-o.o_saleprice) from orders o, book b where o.b_id= b.b_id and b.b_price - o.o_saleprice;

select * from book b, orders o
	where b.b_id = o.b_id and b.b_price-o.o_saleprice=(select max((b.b_price-o.o_saleprice))
		from book b, orders o where b.b_id=o.b_id);
-- 33. 고객별 평균 구매 금액이 도서의 판매 평균 금액 보다 높은 고객의 이름 조회 
select c.c_name, round(avg(o_saleprice),1) from orders o, customer c 
	where o.c_id = c.c_id 
		group by c.c_id
            having round(avg(o.o_saleprice),1)>(select round(avg(o_saleprice),1) from orders);
            
select round(avg(o_saleprice),1) from orders;
-- 34. 고객번호가 5인 고객의 주소를 대한민국 인천으로 변경 
update customer set c_address = '대한민국 인천' where c_id = 5;  
select * from customer;
-- 35. 이강인 고객의 주소를 손흥민 고객 주소와 똑같은 값으로 변경 
-- update customer set c_address = (select c_address from customer where c_name = '손흥민') where c_id = 5; -- mysql 에서는 안됨
    
    update customer set c_address = (select c_address from (select c_address from customer where c_name = '손흥민')as temp) 
	where c_id = 5;
    
    select c_id from customer where c_name = '이강인';
select c_address from customer where c_name = '손흥민';

-- 36. 김씨 성을 가진 고객이 주문한 총 판매액 조회 (x)
-- 김씨 고객번호 조회
select sum(o.o_saleprice), c.c_name from orders o, customer c where o.c_id = c.c_id and c.c_name like '김%';
select sum(o_saleprice) from orders where c_id in(2,3);
select sum(o_saleprice) from orders where c_id in(select c_id from customer where c_name like '김%');

-- 37. BOOK테이블에 b_isbn 이라는 컬럼 추가 (varchar타입에 크기는 20)
alter table book add b_isbn varchar(20);

select * from book;
-- 38. b_isbn 컬럼의 타입을 int로 변경 
alter table book modify b_isbn int;
desc book;
-- 39. b_isbn 컬럼 이름을 b_isbn1 으로 변경
alter table book change b_isbn b_isbn1 int;
-- 40. b_isbn1 컬럼 삭제 
alter table book drop b_isbn1;


use mysql_phl;

 /*
	create table [테이블 이름] (
    [컬럼명1][타입](크기),
    [컬럼명2]int,
    [컬럼명n][타입](크기),
    constraint [제약조건 종류] [제약조건 이름(필수는 아님)](제약조건을 지정할 컬럼명),
    constraint [제약조건 종류] [제약조건 이름(필수는 아님)](제약조건을 지정할 컬럼명) << 계속 연결해서 쓸 수 있음.
    );
    */
    /*
    제약조건
    1. primary key(주키, 유일키, pk) : 테이블당 하나의 컬럼만 지정. 테이블에 저장된 데이터를 구분하는데 주로 사용.(not null)
									필수로 입력해야 하며, 중복값은 허용하지 않음.(unique)
    ex) 회원테이블에서 아이디,게시글테이블에서 글번호, 현실에서 주민등록번호 등
    2. foreigh key(외래키, 참조키, fk) : 2개의 테이블간 연관관계 지정시 사용, 참조하고자 하는 테이블의 pk를 지정함.
    3. not null:해당 컬럼에 값을 필수로 입력해야 함.
    4. unique: 중복값을 허용하지 않음.
    */
 -- 제약 조건 constraint
 /*
  create table 테이블 이름 ( 
   컬럼명 타입 (크기),
   컬럼명2 int,
   컬럼명n 타입 (크기),
   constraint 제약조건종류 제약조건이름-필수는아님 (제약조건지정할컬럼명),
   constraint 제약조건종류 제약조건이름-필수는아님 (제약조건지정할컬럼명)
   )
 */
 /* 
 제약조건 
 1. primary key (주키, 유일키, pk) : 테이블당 하나의 컬럼만 지정. 테이블에 저장된 데이터를 구분하는데 주로 사용.
								필수로 입력해야 하며(not null), 중복값은 허용하지 않음(unique).
	예) 회원테이블에서 아이디, 게시글 테이블에서 글번호, 현실에서 주민번호 등
 2. foreign key(외래키, 참조키, fk) : (다른 테이블이 있어야 함)2개의 테이블 간 연관관계 지정시 사용. 참조하고자 하는 테이블의 pk를 지정함.
 3. not null : 해당 컬럼에 값을 필수로 입력해야 함.
 4. unique : 중복값을 허용하지 않음. 
 */
 -- t_id 에 pk지정
 
 -- date : 날짜만 
 -- datetime : 날짜&시간
 -- 현재시간 : now()
 drop table trainee1;
create table trainee1(
	t_id varchar(20),
	t_name varchar(5),
    t_age int,
    t_birth datetime,
    t_phone varchar(20),
    t_email varchar(30),
    constraint primary key pk_trainee1(t_id)
);
drop table trainee1;
-- now() : 현재시간을 사용할 때
insert into trainee1(t_id, t_name, t_age, t_birth, t_phone, t_email)
	values('id1','이름1',20,now(),'010-1111-1111','aaa@aaa.com');
select * from trainee1;
-- pk 지정한 컬럼에 같은 값을 사용하면 중복 오류
insert into trainee1(t_id, t_name, t_age, t_birth, t_phone, t_email)
	values('id1','이름1',20,now(),'010-1111-1111','aaa@aaa.com');
-- 아이디에 널을 지정하면
insert into trainee1(t_id, t_name, t_age, t_birth, t_phone, t_email)
	values(null,'이름1',20,now(),'010-1111-1111','aaa@aaa.com');
insert into trainee1(t_id, t_name, t_age, t_birth, t_phone, t_email)
	values('id3', null ,20,now(), null ,'aaa@aaa.com');
-- 현재 database에 지정된 제약조건들 조회
select * from information_schema.table_constraints; -- 알아서 만들어짐
drop table trainee2;
create table trainee2 (
	t_id varchar(20),
	t_name varchar(5)not null,
    t_age int,
    t_birth datetime,
    t_phone varchar(20)not null,
    t_email varchar(30),
    constraint primary key pk_trainee2(t_id),
	constraint unique key nk_trainee2(t_age)
	
);

select * from information_schema.table_constraints;
-- 특정 테이블 제약조건만 볼 때
select * from information_schema.table_constraints where table_name = 'trainee2';
select * from information_schema.table_constraints where constraint_type = 'PRIMARY KEY';

insert into trainee2 (t_id, t_name, t_age, t_birth, t_phone, t_email)
	values ('id1','이름',20,now(),'010-1111-1111','aa@aa.com');
    
-- pk로 지정한 t_id에 값을 넣지 않을 때
-- error code 1048 column 't_id' cannot be null
insert into trainee2 (t_id, t_name, t_age, t_birth, t_phone, t_email)
	values (null,'이름',20,now(),'010-1111-1111','aa@aa.com');
    
-- unique 로 지정한 t_age
-- error code 1062 : duplicate entry '20' for key 'trainee2.nk_trainee2'
insert into trainee2 (t_id, t_name, t_age, t_birth, t_phone, t_email)
	values ('id2','이름',20,now(),'010-1111-1111','aa@aa.com');
select * from trainee2;
-- 테이블을 삭제하면 제약조건도 삭제됨
select * from information_schema.table_constraints where table_name = 'trainee2';
drop table trainee2;
-- 제약조건 개별 삭제
-- alter : 테이블 구조 변경, 이름변경, 타입, 크기 변경 등을 할때
alter table trainee2 drop constraint nk_trainee2;
-- pk 제약조건 삭제
alter table trainee2 drop primary key;

-- 테이블을 만들고 나서 제약 조건을 추가하는 경우
alter table trainee2 add constraint primary key(t_id);

alter table trainee2 add constraint unique un_new_trainee2(t_age);
-- 제약조건 이름을 주지 않는 경우
alter table trainee2 add constraint unique (t_email);

drop table a;
create table a(
	a1 varchar(10),
    a2 int,
    constraint primary key(a1)
);
create table b(
	b1 varchar(10),
    b2 int,
    constraint foreign key (b1) references a(a1) -- 테이블이름(참조하고자하는 컬럼 이름)
);

insert into a(a1,a2) values('aaa',111); 
insert into a(a1,a2) values('bbb',222); 
select * from a;
-- 외래키로 지정한 b테이블의 a1컬럼에 a라는 데이터 삽입
-- error code 1452 : cannot add or update a child row. a foreign key constraint fails
insert into b(b1,b2,a1) values('b111',123,'a');-- x
insert into b(b1,b2,a1) values('b111',123,'b');-- x

insert into b(b1,b2) values('aaa',123); -- o
insert into b(b1,b2) values('bbb',12); -- o
insert into b(b1,b2) values('ccc',1233); -- x
drop table d;
drop table c;
create table c(
	c1 varchar(10),
    c2 int,
    constraint primary key(c1)
);

drop table d;
create table d(
	d1 varchar(20),
    d2 int,
    c1 int,
    constraint primary key(d1),
    constraint foreign key(c1) references c(c1) -- 테이블이름(참조하고자하는 컬럼 이름)
);

insert into c(c1,c2) values ('c1데이터1',10);
insert into c(c1,c2) values ('c1데이터2',20);

insert into d(d1,d2,d3) values ('d1데이터1',10,'d1데이터1'); -- x
insert into d(d1,d2,d3) values ('d1데이터1',10,'c1데이터1'); -- o

-- 외래키 문법, 외래키 사용시 어떤 제약이 있는 지
-- 외래키 지정시 주의사항
-- 일반적으로 다른 테이블의 pk를 외래키로 참조함
-- 참조하고자 하는 컬럼의 타입을 동일하게 해야 함 
desc d;

/*
emp dept 테이블의 컬럼 명 타입 크기는 그대로 따라하고
dept테이블의 deptno를 pk로
emp 테이블의 empno 컬럼을 pk로 deptnno 컬럼을 dept 테이블의 deptno를 참조하는 fk로 제약조건을 지정하여 테이블생성
테이블 이름은 각각 emp1 dept1으로

*/

CREATE TABLE dept1 (
    deptno INT,
    dname VARCHAR(14),
    loc VARCHAR(13),
    constraint primary key(deptno)
);


CREATE TABLE emp1 (
    empno INT,
    ename VARCHAR(10),
    job VARCHAR(9),
    mgr INT,
    hiredate DATE,
    sal INT,
    comm INT,
    deptno INT,
    constraint primary key(empno),
    constraint foreign key(deptno) references dept1(deptno)  
);


CREATE TABLE bonus (
    ename VARCHAR(10),
    job VARCHAR(9),
    sal INT,
    comm INT
);


CREATE TABLE salgrade (
    grade INT,
    losal INT,
    hisal INT
);
    

INSERT INTO DEPT VALUES	(10,'ACCOUNTING','NEW YORK');
INSERT INTO DEPT VALUES (20,'RESEARCH','DALLAS');
INSERT INTO DEPT VALUES (30,'SALES','CHICAGO');
INSERT INTO DEPT VALUES	(40,'OPERATIONS','BOSTON');    

INSERT INTO EMP VALUES (7369,'SMITH','CLERK',7902, str_to_date('17-12-1980','%d-%m-%Y'),800,NULL,20);
INSERT INTO EMP VALUES (7499,'ALLEN','SALESMAN',7698,str_to_date('20-2-1981','%d-%m-%Y'),1600,300,30);
INSERT INTO EMP VALUES (7521,'WARD','SALESMAN',7698,str_to_date('22-2-1981','%d-%m-%Y'),1250,500,30);
INSERT INTO EMP VALUES (7566,'JONES','MANAGER',7839,str_to_date('2-4-1981','%d-%m-%Y'),2975,NULL,20);
INSERT INTO EMP VALUES (7654,'MARTIN','SALESMAN',7698,str_to_date('28-9-1981','%d-%m-%Y'),1250,1400,30);
INSERT INTO EMP VALUES (7698,'BLAKE','MANAGER',7839,str_to_date('1-5-1981','%d-%m-%Y'),2850,NULL,30);
INSERT INTO EMP VALUES (7782,'CLARK','MANAGER',7839,str_to_date('9-6-1981','%d-%m-%Y'),2450,NULL,10);
INSERT INTO EMP VALUES (7788,'SCOTT','ANALYST',7566,str_to_date('13-7-87','%d-%m-%Y'),3000,NULL,20);
INSERT INTO EMP VALUES (7839,'KING','PRESIDENT',NULL,str_to_date('17-11-1981','%d-%m-%Y'),5000,NULL,10);
INSERT INTO EMP VALUES (7844,'TURNER','SALESMAN',7698,str_to_date('8-9-1981','%d-%m-%Y'),1500,0,30);
INSERT INTO EMP VALUES (7876,'ADAMS','CLERK',7788,str_to_date('13-7-87','%d-%m-%Y'),1100,NULL,20);
INSERT INTO EMP VALUES (7900,'JAMES','CLERK',7698,str_to_date('3-12-1981','%d-%m-%Y'),950,NULL,30);
INSERT INTO EMP VALUES (7902,'FORD','ANALYST',7566,str_to_date('3-12-1981','%d-%m-%Y'),3000,NULL,20);
INSERT INTO EMP VALUES (7934,'MILLER','CLERK',7782,str_to_date('23-1-1982','%d-%m-%Y'),1300,NULL,10);
		 
INSERT INTO SALGRADE VALUES (1,700,1200);
INSERT INTO SALGRADE VALUES (2,1201,1400);
INSERT INTO SALGRADE VALUES (3,1401,2000);
INSERT INTO SALGRADE VALUES (4,2001,3000);
INSERT INTO SALGRADE VALUES (5,3001,9999);
drop table e;
drop table f;

create table e (
e1 int,
e2 varchar(10),
constraint primary key(e1)
);
create table f (
f1 int,
f2 varchar(20),
e1 int,
constraint primary key(f1),
-- constraint foreign key (e1) references e(e1) on delete cascade
constraint foreign key (e1) references e(e1) on delete set null
);

insert into e(e1,e2) values (1, '데이터1');
insert into e(e1,e2) values (2, '데이터2');
insert into e(e1,e2) values (3, '데이터3');
insert into e(e1,e2) values (4, '데이터4');

insert into f(f1,f2,e1) values (1, 'data1', 1);
insert into f(f1,f2,e1) values (2, 'data2', 2);
insert into f(f1,f2,e1) values (3, 'data3', 3);
insert into f(f1,f2,e1) values (4, 'data4', 4);
-- insert into f(f1,f2,e1) values (3, 'data3', 3);
select * from e;
select * from f;
-- e테이블 삭제 : Error Code: 3730. Cannot drop table 'e' referenced by a foreign key constraint 'f_ibfk_1' on table 'f'.
-- 자식테이블 먼저 삭제해야 부모테이블이 삭제됨
drop table e;
drop table f;
-- 데이터 삭제
delete from f ;
-- Error Code: 1175. You are using safe update mode and you tried to update a table without a WHERE that uses a KEY column.
-- To disable safe mode, toggle the option in Preferences -> SQL Editor and reconnect.
delete from f where f1=2; -- pk컬럽값
select * from f;
select * from e;
-- e테이블의 e1의 값이 3인 데이터 삭제 
-- 참조관계 설정 시 f에 
-- on delete cascade하묜 부모테이블에 담긴 데이터 삭제시 자식 테이블에 참조한 데이터도 함께 삭제됨 (카페탈퇴)
-- on delete set null을하면 참조한 데이터 자리가 null이 됨 (게시글 삭제)
delete from e where e1=3;
-- Error Code: 1451. Cannot delete or update a parent row: 
-- a foreign key constraint fails (`mysql_phl`.`f`, CONSTRAINT `f_ibfk_1` FOREIGN KEY (`e1`) REFERENCES `e` (`e1`))

-- 수정 쿼리
-- e테이블의 데이터2라는 값을 데이터234로 수정
update e set e2='데이터234' where e1=2;
-- update 테이블 set 컬럼=변경할데이터 where pk컬럼=값;


/*
실제 사이트를 참고하여 테이블 설계
네이버 회원가입 페이지를 참고, 네이버 회원 데이터를 저장할 naver_member라는 테이블 생성
네이버 또는 다음카페 글쓰기 화면을 참고해 게시글을 저장할  naver_board 라는 테이블 생성
member테이블과의 참조관계 설정
테이블 총 4개
추가사항으로 아래 두 테이블을 만드는 경우 참조관계 설정
1. 게시글 카테고리 테이블
2. 게시글 댓글 테이블
*/
use mysql_phl;


drop table naver_member;
drop table naver_cate;
drop table naver_board;
drop table naver_comment;



create table naver_member (
 n_id varchar (20),
 n_password varchar(30) not null,
 n_name varchar(10) not null,
 n_birth date not null,
 n_email varchar(40),
 n_gender varchar(5) not null,
 n_phone varchar(20) not null,
 
 constraint primary key (n_id),
 constraint unique key (n_phone)

);

insert into naver_member(n_id, n_password, n_name, n_birth, n_email, n_gender, n_phone)
values ('phl10211','123','박혜린', str_to_date('1995-10-21','%Y-%m-%d'),'phl1021@aa','F','010998999');




create table naver_cate (
c_cate varchar (30),
c_number int auto_increment,
constraint primary key (c_number)
);




create table naver_board (
 b_cate int,
 b_id varchar (20),
 b_datetime datetime not null,
 b_title varchar(50) not null,
 b_contents varchar(1000),
 b_hit int not null,
 b_like int not null,
 b_number int,
 constraint foreign key (b_id) references naver_member(n_id) on delete cascade,
 constraint foreign key (b_cate) references naver_cate(c_number) on delete cascade,
 constraint primary key (b_number)
);



create table naver_comment (
c_number int auto_increment,
c_writer varchar(20) not null,
c_date datetime not null,
c_contents varchar(200) not null,
b_number int not null,
constraint primary key(c_number), 
constraint foreign key (c_writer) references naver_member(n_id) on delete cascade,
constraint foreign key (b_number) references naver_board(b_number) on delete cascade

);

select * from naver_member;
select * from naver_board;

insert into naver_comment(c_writer,c_date,c_contents,b_number)
 values('id',now(),'댓글내용1',1);
 
 insert into naver_comment(c_writer,c_date,c_contents,b_number)
 values('id2',now(),'댓글내용1',1);

select * from never_comment;

