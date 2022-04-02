use spring_nftgame;

-- 회원번호, 아이디, 비밀번호, 이름, 이메일, 전화번호, 프로필사진 
drop table member_table;

create table member_table(
	m_number bigint auto_increment,
	m_id varchar(20) not null,
    m_password varchar(20) not null,
	m_name varchar(20) not null,
    m_email varchar(100),
    m_phone varchar(100),
    m_likegame varchar(50) not null,
    m_profilename varchar(100) default "기본프로필사진.png",
    m_point bigint default 10,
    
    constraint primary key(m_number),
    constraint unique key(m_id)
);
insert  member_table (m_id, m_password, m_name, m_email,m_phone,m_profilename, m_point, m_likegame)
    values("admin","123","관리자","admin@","0109999999","dogefather.jpg", 1000, "cyber dragon");
delete from member_table where m_id="admin";

select * from member_table;


drop table category_table;
    create table category_table (
    cate_number int auto_increment,
    cate_name varchar(30) not null,
    
    constraint primary key (cate_number)
    );
    
    insert category_table (cate_name)
    value("사이버드래곤");
    
    select * from category_table;
    select c.cate_name from category_table c, board_table b where b.cate_number = c.cate_number;

drop table point_table;

create table point_table (
	p_number bigint auto_increment,
	m_id varchar(20),
    p_point int,
	p_pointdate datetime not null,
    p_type varchar(20),
    
 constraint primary key (p_number),   
 constraint foreign key(m_id) references member_table(m_id) on delete cascade
);
select * from point_table order by p_pointdate desc;



drop table board_table;

create table board_table(
b_number bigint auto_increment,
cate_number int,
m_id varchar(20),
b_title varchar(20) not null,
b_contents varchar(1000) not null,
b_date datetime not null,
b_hits int default 0,
b_filename varchar(100),
like_count int default 0,

 constraint primary key (b_number),
 constraint foreign key(m_id) references member_table(m_id)  on delete cascade,
 constraint foreign key(cate_number) references category_table(cate_number)
    );
    
     insert board_table (m_id,b_title, b_contents, b_date,b_filename)
    values("admin","공지사항","뭐냐면",now(),"안녕.jpg");
    select * from board_table;
    
    
    
drop table comment_table;

create table comment_table(
	c_number bigint auto_increment,
    b_number bigint,
    m_id varchar(20),
    c_contents varchar(200) not null,
    c_date datetime not null,
    constraint primary key (c_number),
	constraint foreign key(m_id) references member_table(m_id) on delete cascade,
    constraint foreign key(b_number) references board_table(b_number) on delete cascade
    
    );
insert into comment_table (m_id, b_number, c_contents, c_date)
values("admin",1,"정말 멋진 의견!!", now());

select * from comment_table ;

drop table nft_table;

create table nft_table (
	nft_number bigint auto_increment,
	nft_filename varchar(100) not null,
    nft_name varchar(50) not null, 
    nft_price bigint not null,
    nft_date datetime not null,
    m_id varchar(20) default "admin",
    nft_intro varchar(100),
    nft_sell boolean default false,
    
    constraint primary key (nft_number),
    constraint foreign key(m_id) references member_table(m_id) on delete cascade
);

select * from nft_table ;

insert nft_table (nft_filename, nft_name, nft_price, nft_date)
values ("phl.jpg", "zozo", 20000, now());

drop table like_table;

create table like_table (
like_number bigint auto_increment,
m_id varchar(20),
b_number bigint,
like_check int default 0,

constraint primary key (like_number),
constraint foreign key(m_id) references member_table(m_id) on delete cascade,
constraint foreign key(b_number) references board_table(b_number) on delete cascade
);

select * from like_table ;


