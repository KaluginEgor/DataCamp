--task1

CREATE TABLE t2 AS
 SELECT TRUNC( rownum / 100 ) id, rpad( rownum,100 ) t_pad
   FROM dual
  CONNECT BY rownum < 100000;
  
CREATE INDEX t2_idx1 ON t2
  ( id );

select blocks from user_segments where segment_name = 'T2';

select count(distinct (dbms_rowid.rowid_block_number(rowid))) block_ct from t2 ;

SET autotrace ON;

SELECT COUNT( * )
   FROM t2 ;

DELETE FROM t2;

select blocks from user_segments where segment_name = 'T2';

select count(distinct (dbms_rowid.rowid_block_number(rowid))) block_ct from t2 ;

SET autotrace ON;

SELECT COUNT( * )
   FROM t2 ;

INSERT INTO t2
  ( ID, T_PAD )
  VALUES
  (  1,'1' );

COMMIT;

select blocks from user_segments where segment_name = 'T2';

select count(distinct (dbms_rowid.rowid_block_number(rowid))) block_ct from t2 ;

SET autotrace ON;

SELECT COUNT( * )
   FROM t2 ;

TRUNCATE TABLE t2;

select blocks from user_segments where segment_name = 'T2';

select count(distinct (dbms_rowid.rowid_block_number(rowid))) block_ct from t2 ;

SET autotrace ON;

SELECT COUNT( * )
   FROM t2 ;

--task2
DROP TABLE t1;
DROP TABLE t2;

CREATE TABLE t2 AS
 SELECT TRUNC( rownum / 100 ) id, rpad( rownum,100 ) t_pad
   FROM dual
  CONNECT BY rownum < 100000;
  
CREATE INDEX t2_idx1 ON t2
  ( id );
  
CREATE TABLE t1 AS
 SELECT MOD( rownum, 100 ) id, rpad( rownum,100 ) t_pad
   FROM dual
  CONNECT BY rownum < 100000;

CREATE INDEX t1_idx1 ON t1
  ( id );
  
EXEC dbms_stats.gather_table_stats( USER,'t1',method_opt=>'FOR ALL COLUMNS SIZE 1',CASCADE=>TRUE );

EXEC dbms_stats.gather_table_stats( USER,'t2',method_opt=>'FOR ALL COLUMNS SIZE 1',CASCADE=>TRUE );

SELECT t.table_name||'.'||i.index_name idx_name,
        i.clustering_factor,
        t.blocks,
        t.num_rows
   FROM user_indexes i, user_tables t
  WHERE i.table_name = t.table_name
    AND t.table_name  IN( 'T1','T2' );

--task3
CREATE UNIQUE INDEX udx_t1 ON t1( t_pad );

set autotrace on;
SELECT t1.*  FROM t1 where t1.t_pad = '1';


--task4
set autotrace on;
SELECT t2.*  FROM t2 where t2.id = '1';

drop table t1;
drop table t2;
--task5
CREATE TABLE employees AS
    SELECT *
      FROM scott.emp;
      
CREATE INDEX idx_emp01 ON employees
      ( empno, ename, job );
      
set autotrace on;
SELECT /*+INDEX_SS(emp idx_emp01)*/ emp.* FROM employees emp where ename = 'SCOTT';

set autotrace on;
SELECT /*+FULL*/ emp.* FROM employees emp WHERE ename = 'SCOTT';

drop table employees;