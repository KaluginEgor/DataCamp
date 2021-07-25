CREATE TABLE sales
  ( prod_id       NUMBER(6)
  , cust_id       NUMBER
  , time_id       DATE
  , channel_id    CHAR(1)
  , promo_id      NUMBER(6)
  , quantity_sold NUMBER(3)
  , amount_sold   NUMBER(10,2)
  )
 PARTITION BY RANGE (time_id) INTERVAL (NUMTODSINTERVAL(1,'DAY'))
 SUBPARTITION BY LIST (channel_id)
   SUBPARTITION TEMPLATE
   ( SUBPARTITION p_catalog VALUES ('C')
   , SUBPARTITION p_internet VALUES ('I')
   , SUBPARTITION p_partners VALUES ('P')
   , SUBPARTITION p_direct_sales VALUES ('S')
   , SUBPARTITION p_tele_sales VALUES ('T')
   )
 (PARTITION before_2000 VALUES LESS THAN (TO_DATE('01-JAN-2000','dd-MON-yyyy')),
 PARTITION before_2001 VALUES LESS THAN (TO_DATE('01-JAN-2001','dd-MON-yyyy')),
 PARTITION before_2002 VALUES LESS THAN (TO_DATE('01-JAN-2002','dd-MON-yyyy'))
  )
PARALLEL;

ALTER TABLE sales
      merge partitions before_2000, before_2001;
      
alter table sales
    modify partition before_2002
        add subpartition p_new
            values ('N') tablespace lab9; 

alter table sales
    move subpartition p_new tablespace lab9_1;

alter table sales
    split partition for(TO_DATE('01-JAN-2001','dd-MON-yyyy')) at (TO_DATE('15-JAN-2001','dd-MON-yyyy'));

alter table sales truncate partition before_2002;