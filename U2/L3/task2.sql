DROP TABLE u_sb_mbackup.pizza_hierarchy;

CREATE TABLE u_sb_mbackup.pizza_hierarchy (
pizza_parent_id number,
pizza_id number,
pizza_desc varchar(50));

insert into  u_sb_mbackup.pizza_hierarchy
select 0
      , rownum
      ,'Category ' || TO_CHAR(rownum)
from dual
connect by level <=10;


insert into  u_sb_mbackup.pizza_hierarchy
select round(DBMS_RANDOM.VALUE(1,10),0)
      , rownum + 10
      , 'Pizza ' || TO_CHAR(rownum+10)
from dual
connect by level <=100;


select 
pizza_parent_id,
pizza_id,
pizza_desc,
connect_by_root pizza_desc as root,
sys_connect_by_path(pizza_desc,':') path_categoty_pizza
from u_sb_mbackup.pizza_hierarchy
start with pizza_parent_id = 0
connect by prior pizza_id = pizza_parent_id
order siblings by pizza_parent_id;
