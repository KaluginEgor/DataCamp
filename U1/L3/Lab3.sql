--task1
create tablespace tbs_lab datafile '/oracle/u02/oradata/DMORCL21DB/ekalugin_db/db_lab_001.dat' size 5M autoextend ON next 5M MAXSIZE 100M;

create user SCOTT identified by tiger default tablespace tbs_lab;

grant connect to SCOTT;
grant resource to SCOTT;

grant select on dept to SCOTT;
grant select on emp to SCOTT;

--task2
create table t
  ( a int,
    b varchar2(4000) default rpad('*',4000,'*'),
    c varchar2(3000) default rpad('*',3000,'*')
   );
   
insert into t (a) values ( 1);
insert into t (a) values ( 2);
insert into t (a) values ( 3);
commit;
delete from t where a = 2 ;
commit;
insert into t (a) values ( 4);
commit;

select a from t;

drop table T;
drop table dept;
drop table emp;
drop table pk_dept;
drop table pk_emp;
drop table salgrade;

Create table t ( x int primary key, y clob, z blob );

select segment_name, segment_type from user_segments;

drop table T;

Create table t
               ( x int primary key,
                 y clob,
                 z blob )
    SEGMENT CREATION IMMEDIATE;

select segment_name, segment_type  from user_segments;

SELECT DBMS_METADATA.GET_DDL('TABLE','T') FROM dual;

--task3
CREATE TABLE emp AS
SELECT
  object_id empno
, object_name ename
, created hiredate
, owner job
FROM
  all_objects;

alter table emp add constraint emp_pk primary key(empno);

begin
  dbms_stats.gather_table_stats( user, 'EMP', cascade=>true );
end;

CREATE TABLE heap_addresses
  (
    empno REFERENCES emp (empno) ON DELETE CASCADE,
    addr_type VARCHAR2(10),
    street VARCHAR2(20),
    city VARCHAR2(20),
    state VARCHAR2(2),
    zip NUMBER,
    PRIMARY KEY (empno,addr_type)
  );

CREATE TABLE iot_addresses
  (
    empno REFERENCES emp (empno) ON DELETE CASCADE,
    addr_type VARCHAR2(10),
    street    VARCHAR2(20),
    city      VARCHAR2(20),
    state     VARCHAR2(2),
    zip       NUMBER,
    PRIMARY KEY (empno,addr_type)
  )
  ORGANIZATION INDEX;

INSERT INTO heap_addresses
SELECT empno, 'WORK' , '123 main street' , 'Washington' , 'DC' , 20123 FROM emp;
  
INSERT INTO iot_addresses
SELECT empno , 'WORK' , '123 main street' , 'Washington' , 'DC' , 20123 FROM emp;
--
INSERT INTO heap_addresses
SELECT empno, 'HOME' , '123 main street' , 'Washington' , 'DC' , 20123 FROM emp;
  
INSERT INTO iot_addresses
SELECT empno, 'HOME' , '123 main street' , 'Washington' , 'DC' , 20123 FROM emp;
--
INSERT INTO heap_addresses
SELECT empno, 'PREV' , '123 main street' , 'Washington' , 'DC' , 20123 FROM emp;
  
INSERT INTO iot_addresses
SELECT empno, 'PREV' , '123 main street' , 'Washington' , 'DC' , 20123 FROM emp;
--
INSERT INTO heap_addresses
SELECT empno, 'SCHOOL' , '123 main street' , 'Washington' , 'DC' , 20123 FROM emp;
  
INSERT INTO iot_addresses
SELECT empno, 'SCHOOL' , '123 main street' , 'Washington' , 'DC' , 20123 FROM emp;

Commit;

exec dbms_stats.gather_table_stats(user, 'HEAP_ADDRESSES' );
exec dbms_stats.gather_table_stats(user, 'IOT_ADDRESSES' );

set autotrace on;
SELECT *
   FROM emp ,
        heap_addresses
  WHERE emp.empno = heap_addresses.empno
  AND emp.empno   = 42;

set autotrace on;
SELECT *
   FROM emp ,
        iot_addresses
  WHERE emp.empno = iot_addresses.empno
  AND emp.empno   = 42; 
  

drop table heap_addresses;
drop table iot_addresses;
drop table emp;

--task4
CREATE cluster emp_dept_cluster( deptno NUMBER( 2 ) )
    SIZE 1024 
    STORAGE( INITIAL 100K NEXT 50K );
    
CREATE INDEX idxcl_emp_dept on cluster emp_dept_cluster;

CREATE TABLE dept
  (
    deptno NUMBER( 2 ) PRIMARY KEY,
    dname  VARCHAR2( 14 ),
    loc    VARCHAR2( 13 )
  )
  cluster emp_dept_cluster ( deptno ) ;
 
 CREATE TABLE emp
  (
    empno NUMBER PRIMARY KEY,
    ename VARCHAR2( 10 ),
    job   VARCHAR2( 9 ),
    mgr   NUMBER,
    hiredate DATE,
    sal    NUMBER,
    comm   NUMBER,
    deptno NUMBER( 2 ) REFERENCES dept( deptno )
  )
  cluster emp_dept_cluster ( deptno ) ;

INSERT INTO dept ( deptno , dname , loc)
SELECT deptno , dname , loc
   FROM SCOTT.DEPT;
   
commit;

 INSERT INTO emp ( empno, ename, job, mgr, hiredate, sal, comm, deptno )
 SELECT rownum, ename, job, mgr, hiredate, sal, comm, deptno
   FROM SCOTT.EMP;
      
commit;

SELECT *
   FROM
  (
     SELECT dept_blk, emp_blk, CASE WHEN dept_blk <> emp_blk THEN '*' END flag, deptno
       FROM
      (
         SELECT dbms_rowid.rowid_block_number( dept.rowid ) dept_blk, dbms_rowid.rowid_block_number( emp.rowid ) emp_blk, dept.deptno
           FROM emp , dept
          WHERE emp.deptno = dept.deptno
      )
  )
ORDER BY deptno;

drop table emp;
drop table dept;

--task5
CREATE cluster hash_cluster( deptno NUMBER( 2 ) )
    HASHKEYS 1000
    SIZE 1024 
    STORAGE( INITIAL 100K NEXT 50K );

CREATE TABLE dept
  (
    deptno NUMBER( 2 ) PRIMARY KEY
  , dname  VARCHAR2( 14 )
  , loc    VARCHAR2( 13 )
  )
  cluster hash_cluster ( deptno ) ;

CREATE TABLE emp
  (
    empno NUMBER PRIMARY KEY
  , ename VARCHAR2( 10 )
  , job   VARCHAR2( 9 )
  , mgr   NUMBER
  , hiredate DATE
  , sal    NUMBER
  , comm   NUMBER
  , deptno NUMBER( 2 ) REFERENCES dept( deptno )
  )
  cluster hash_cluster ( deptno ) ;

INSERT INTO dept( deptno , dname , loc)
SELECT deptno , dname , loc
   FROM scott.dept;
   
commit;

 INSERT INTO emp ( empno, ename, job, mgr, hiredate, sal, comm, deptno )
 SELECT rownum, ename, job, mgr, hiredate, sal, comm, deptno
   FROM scott.emp
      
commit;

SELECT *
   FROM
  (
     SELECT dept_blk, emp_blk, CASE WHEN dept_blk <> emp_blk THEN '*' END flag, deptno
       FROM
      (
         SELECT dbms_rowid.rowid_block_number( dept.rowid ) dept_blk, dbms_rowid.rowid_block_number( emp.rowid ) emp_blk, dept.deptno
           FROM emp , dept
          WHERE emp.deptno = dept.deptno
      )
  )
ORDER BY deptno;

drop table emp;
drop table dept;