--task1
set autotrace off;

set autotrace on;

set autotrace traceonly;

set autotrace on explain;

set autotrace on statistics;

set autotrace on explain statistics;

set autotrace traceonly explain;
set autotrace traceonly statistics;
set autotrace traceonly explain statistics;

set autotrace off explain;
set autotrace off statistics;
set autotrace off explain statistics;

--task2

set autotrace on explain;
SELECT  *
     FROM scott.emp e, scott.dept d
    WHERE e.deptno = d.deptno
      AND d.deptno   = 10;
      
set autotrace on explain;
SELECT  /*+ USE_MERGE(emp dept) */ * 
     FROM scott.emp e, scott.dept d
    WHERE e.deptno = d.deptno;
    
set autotrace on explain;
select /*+ USE_HASH(emp dept) */ empno, ename, dname, loc
       from scott.dept, scott.emp
      where emp.deptno = dept.deptno;

set autotrace on explain;
select /*+ USE_HASH */ empno, ename, dname, loc
       from scott.dept, scott.emp;
       
set autotrace on explain;
SELECT  *
     FROM scott.emp e LEFT OUTER JOIN scott.dept d ON (e.deptno = d.deptno);

       
set autotrace on explain;
SELECT  *
     FROM scott.emp e RIGHT OUTER JOIN scott.dept d ON (e.deptno = d.deptno);

set autotrace on explain;
select e1.ename, e1.deptno, e1.job
           ,e2.ename, e2.deptno, e2.job
       from scott.emp e1 full outer join  scott.emp e2
 on (e1.empno = e2.empno);
 
set autotrace on explain;
SELECT DName
       FROM SCOTT.dept dept
      WHERE deptno IN
            ( SELECT deptno FROM scott.emp );
            
set autotrace on explain;
SELECT  *
     FROM scott.dept WHERE EXISTS (
        SELECT /*+HASH_SJ*/ * FROM scott.emp WHERE emp.deptno = dept.deptno );

set autotrace on explain;
SELECT  *
     FROM scott.dept WHERE EXISTS (
        SELECT /*+NL_SJ*/ * FROM scott.emp WHERE emp.deptno = dept.deptno );

set autotrace on explain;
SELECT *
     FROM scott.dept WHERE EXISTS (
        SELECT /*+NO_SEMIJOIN*/ * FROM scott.emp WHERE emp.deptno = dept.deptno );

set autotrace on explain;        
SELECT DName
       FROM SCOTT.dept dept
      WHERE deptno NOT IN
            ( SELECT deptno FROM scott.emp );

set autotrace on explain;
SELECT *
     FROM scott.dept WHERE NOT EXISTS (
        SELECT /*+ NL_AJ */ *  FROM scott.emp WHERE emp.deptno = dept.deptno );

set autotrace on explain;        
SELECT DName
       FROM SCOTT.dept dept
      WHERE deptno NOT IN
            ( SELECT /*+ HASH_AJ */ deptno FROM scott.emp WHERE deptno < 10);
            