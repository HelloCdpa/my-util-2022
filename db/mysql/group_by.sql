- 그룹화하기 group by 그룹화 하고 싶은 칼럼 / 조건
- 그룹화 한 곳에 조건을 줄 때 having

select deptno,job,

 round(avg(sal),1) as '직급별 평균급여'

 from emp 

 group by deptno,job 

 having sal≥2500

  order by deptno asc, job desc;

- 조건을 준 뒤 조건에 만족하는 애들을 묶어 그룹핑 하고 조건주기 하고 오름차순 정리

select job, deptno, round(avg(sal),1), count(ename)

from emp

 where sal ≥ 2000 

group by deptno, job 

having avg(sal) ≥ 3000

order by deptno asc, job desc;

dual 테이블 : 가상의 테이블 불러오는 값은 딱히 없고 select 만 보고싶을 때

 select round(1020.13929, 1) from dual;

- 테이블 조인

 - 2개의 테이블을 한번에 조회. 컬럼이 같아야하고 이름을 지정해줘야함

ex) emp / dept deptno 컬럼으로 테이블 조인

select e.*, d.* from emp e, dept d where e.deptno = d.deptno;

- 서브쿼리

: 쿼리 안에 (쿼리)를 넣는다 ()가 먼저 실행

ex) 사원 중에서 평균 월급보다 많이 월급받는 사원의 이름

select ename from emp where sal > (select avg(sal) from emp);

ex) 서브쿼리와 테이블 조인

select * from emp e, dept d where e.deptno = d.deptno and e.sal>(select avg(sal) from emp) and e.deptno = 20;

<제약조건>

- primary key : 고유한 데이터를 갖는 값 not null, unique 포함된 제약조건
- foreign key : 2개의 테이블의 연관관계를 지정하는 조건, 참조하고자 하는 값의 pk를 지정함
- unique : 특별한 값
- not null : 값이 없으면 안되는 조건

<제약조건 사용>

create table 테이블 변수 값 (

 컬럼명 타입 (크기),

 컬럼명1 타입(크기)

constraint 제약조건 제약변수명 (제약을 지정할 컬럼) 

)
