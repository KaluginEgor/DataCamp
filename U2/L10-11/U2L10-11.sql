grant unlimited tablespace to u_sal_dw_cl;
grant unlimited tablespace to u_sal_data;

grant all privileges on u_dw_data.dw_sales to u_sal_dw_cl;
grant all privileges on u_dw_data.DW_CUSTOMERS to u_sal_dw_cl;
grant all privileges on u_dw_data.DW_STORES to u_sal_dw_cl;
grant all privileges on u_dw_data.DW_EMPLOYEES to u_sal_dw_cl;
grant all privileges on u_dw_data.DW_PIZZAS_SCD to u_sal_dw_cl;
grant all privileges on u_dw_data.DW_PROMOTIONS to u_sal_dw_cl;
grant all privileges on u_dw_data.DW_PAYMENT_METHODS to u_sal_dw_cl;
grant all privileges on u_dw_data.DW_GEO_LOCATIONS to u_sal_dw_cl;
grant all privileges on u_dw_data.DW_DATES to u_sal_dw_cl;
grant all privileges on u_dw_data.DW_GEN_PERIODS to u_sal_dw_cl;

--fct_sales
create global temporary table u_sal_dw_cl.temp_sales
ON COMMIT DELETE ROWS
as (select * from u_dw_data.dw_sales);

grant all  privileges on u_sal_dw_cl.temp_sales to u_sal_data;

insert into u_sal_dw_cl.temp_sales
(select * from  u_dw_data.dw_sales);

delete from u_sal_dw_cl.temp_sales s
WHERE NOT EXISTS (SELECT 1 FROM u_dw_data.DW_CUSTOMERS c WHERE c.customer_id=s.customer_id);

delete from u_sal_dw_cl.temp_sales s
WHERE NOT EXISTS (SELECT 1 FROM u_dw_data.DW_STORES st WHERE st.store_id=s.store_id);

delete from u_sal_dw_cl.temp_sales s
WHERE NOT EXISTS (SELECT 1 FROM u_dw_data.DW_EMPLOYEES e WHERE e.employee_id=s.employee_id);

delete from u_sal_dw_cl.temp_sales s
WHERE NOT EXISTS (SELECT 1 FROM u_dw_data.DW_PIZZAS_SCD p WHERE p.pizza_surr_id=s.pizza_surr_id);

delete from u_sal_dw_cl.temp_sales s
WHERE NOT EXISTS (SELECT 1 FROM u_dw_data.DW_PROMOTIONS p WHERE p.promotion_id=s.promotion_id);

delete from u_sal_dw_cl.temp_sales s
WHERE NOT EXISTS (SELECT 1 FROM u_dw_data.DW_PAYMENT_METHODS  p WHERE p.payment_method_id=s.payment_method_id);

delete from u_sal_dw_cl.temp_sales s
WHERE NOT EXISTS (SELECT 1 FROM u_dw_data.DW_GEO_LOCATIONS g WHERE g.country_geo_id=s.geo_id);

delete from u_sal_dw_cl.temp_sales s
WHERE NOT EXISTS (SELECT 1 FROM u_dw_data.DW_DATES d WHERE d.date_key=s.date_id);

delete from u_sal_dw_cl.temp_sales s
WHERE NOT EXISTS (SELECT 1 FROM u_dw_data.DW_GEN_PERIODS  g WHERE g.sales_cat_id=s.sales_cat_id);

MERGE INTO u_sal_data.fct_sales target
           USING (SELECT * FROM u_sal_dw_cl.temp_sales) source
              ON (target.sales_id = source.sales_id)
      WHEN NOT MATCHED THEN
         INSERT (event_dt, sales_id, pizza_surr_id, employee_id, customer_id, store_id, geo_id, date_id, payment_method_id, promotion_id, sales_cat_id, sales_amount, sales_sum, insert_dt, update_dt)
             VALUES (source.event_dt, source.sales_id, source.pizza_surr_id
                    , source.employee_id, source.customer_id, source.store_id
                    , source.geo_id, source.date_id, source.payment_method_id
                    , source.promotion_id, source.sales_cat_id, source.sales_amount, source.sales_sum
                    , source.insert_dt, source.update_dt)
      WHEN MATCHED THEN
         UPDATE SET target.event_dt=(select CURRENT_DATE from dual), target.pizza_surr_id=source.pizza_surr_id
                    , target.employee_id=source.employee_id, target.customer_id=source.customer_id
                    , target.store_id=source.store_id, target.geo_id=source.geo_id
                    , target.date_id=source.date_id,  target.payment_method_id=source.payment_method_id
                    , target.promotion_id=source.promotion_id, target.sales_cat_id=source.sales_cat_id
                    , target.sales_amount=source.sales_amount, target.sales_sum=source.sales_sum
         , target.insert_dt=source.insert_dt, target.update_dt=source.update_dt;
COMMIT;

--dim_customers
create global temporary table u_sal_dw_cl.temp_customers
ON COMMIT DELETE ROWS
as (select * from u_dw_data.DW_CUSTOMERS c where c.customer_id in (select customer_id from u_sal_data.fct_sales));

insert into u_sal_dw_cl.temp_customers 
(select * from u_dw_data.DW_CUSTOMERS c where c.customer_id in (select customer_id from u_sal_data.fct_sales));

MERGE INTO u_sal_data.dim_customers target
           USING (SELECT * FROM u_sal_dw_cl.temp_customers) source
              ON ( target.customer_id = source.customer_id)
      WHEN NOT MATCHED THEN
         INSERT (customer_id, first_name, last_name, gender, age, email, phone, country_geo_id, geo_country_desc, insert_dt, update_dt)
             VALUES (source.customer_id, source.first_name, source.last_name, source.gender, source.age, source.email, source.phone, source.country_geo_id, source.geo_country_desc
             , source.insert_dt, source.update_dt)
      WHEN MATCHED THEN
         UPDATE SET target.first_name=source.first_name, target.last_name=source.last_name 
         , target.gender=source.gender, target.age=source.age, target.email=source.email 
         , target.phone=source.phone, target.country_geo_id=source.country_geo_id, target.geo_country_desc=source.geo_country_desc
         , target.insert_dt=source.insert_dt, target.update_dt=source.update_dt;
COMMIT;

--dim_stores

create global temporary table u_sal_dw_cl.temp_stores
ON COMMIT DELETE ROWS
as (select * from u_dw_data.DW_STORES c where c.store_id in (select store_id from u_sal_data.fct_sales));

insert into u_sal_dw_cl.temp_stores
(select * from u_dw_data.DW_STORES c where c.store_id in (select store_id from u_sal_data.fct_sales));

MERGE INTO u_sal_data.dim_stores target
                USING (SELECT * FROM u_sal_dw_cl.temp_stores) source
                ON (target.store_id = source.store_id)
            WHEN NOT MATCHED THEN
                 INSERT (store_id, store_desc, email, phone, manager_id, manager_first_name, manager_last_name, insert_dt, update_dt)
                     VALUES (source.store_id, source.store_desc, source.email, source.phone, source.manager_id
                     , source.manager_first_name, source.manager_last_name
                     , source.insert_dt, source.update_dt)
            WHEN MATCHED THEN
                     UPDATE SET target.store_desc=source.store_desc, target.email=source.email
                     , target.phone=source.phone, target.manager_id=source.manager_id
                     , target.manager_first_name=source.manager_first_name, target.manager_last_name=source.manager_last_name
                     , target.insert_dt=source.insert_dt, target.update_dt=source.update_dt;
COMMIT;

--dim_employees

create global temporary table u_sal_dw_cl.temp_employees
ON COMMIT DELETE ROWS
as (select * from u_dw_data.DW_EMPLOYEES e where e.employee_id in (select employee_id from u_sal_data.fct_sales));

insert into u_sal_dw_cl.temp_employees
(select * from u_dw_data.DW_EMPLOYEES e where e.employee_id in (select employee_id from u_sal_data.fct_sales));

MERGE INTO u_sal_data.dim_employees target
           USING (SELECT * FROM u_sal_dw_cl.temp_employees) source
              ON ( target.employee_id = source.employee_id)
      WHEN NOT MATCHED THEN
         INSERT (employee_id, first_name, last_name, gender, age, email, phone, store_id, hire_date, manager_id, manager_first_name, manager_last_name, insert_dt, update_dt)
             VALUES (source.employee_id, source.first_name, source.last_name, source.gender, source.age, source.email, source.phone, source.store_id, source.hire_date, source.manager_id, source.manager_first_name, source.manager_last_name
             , source.insert_dt, source.update_dt)
      WHEN MATCHED THEN
         UPDATE SET target.first_name=source.first_name, target.last_name=source.last_name 
         , target.gender=source.gender, target.age=source.age, target.email=source.email 
         , target.phone=source.phone, target.store_id=source.store_id, target.hire_date=source.hire_date
         , target.manager_id=source.manager_id, target.manager_first_name=source.manager_first_name, target.manager_last_name=source.manager_last_name
         , target.insert_dt=source.insert_dt, target.update_dt=source.update_dt;
COMMIT;

--dim_pizzas_scd

create global temporary table u_sal_dw_cl.temp_pizzas
ON COMMIT DELETE ROWS
as (select * from u_dw_data.DW_PIZZAS_SCD p where p.pizza_surr_id in (select pizza_surr_id from u_sal_data.fct_sales));

insert into u_sal_dw_cl.temp_pizzas
(select * from u_dw_data.DW_PIZZAS_SCD p where p.pizza_surr_id in (select pizza_surr_id from u_sal_data.fct_sales));

MERGE INTO u_sal_data.dim_pizzas_scd target
           USING (SELECT * FROM u_sal_dw_cl.temp_pizzas) source
              ON ( target.pizza_surr_id = source.pizza_surr_id)
      WHEN NOT MATCHED THEN
         INSERT (pizza_surr_id, pizza_id, pizza_desc, category_id, category_desc, pizza_weight, pizza_diameter, pizza_price, valid_from, valid_to, is_active, insert_dt)
             VALUES (source.pizza_surr_id, source.pizza_id, source.pizza_desc, source.category_id, source.category_desc, source.pizza_weight, source.pizza_diameter
             , source.pizza_price, source.valid_from, source.valid_to, source.is_active, source.insert_dt)
      WHEN MATCHED THEN
         UPDATE SET target.pizza_desc=source.pizza_desc, target.category_id=source.category_id 
         , target.category_desc=source.category_desc, target.pizza_weight=source.pizza_weight, target.pizza_diameter=source.pizza_diameter 
         , target.pizza_price=source.pizza_price, target.valid_from=source.valid_from, target.valid_to=source.valid_to
         , target.is_active=source.is_active
         , target.insert_dt=source.insert_dt;
COMMIT;

--dim_promotions

create global temporary table u_sal_dw_cl.temp_promotions
ON COMMIT DELETE ROWS
as (select * from u_dw_data.DW_PROMOTIONS p where p.promotion_id in (select promotion_id from u_sal_data.fct_sales));

insert into u_sal_dw_cl.temp_promotions
(select * from u_dw_data.DW_PROMOTIONS p where p.promotion_id in (select promotion_id from u_sal_data.fct_sales));

MERGE INTO u_sal_data.dim_promotions target
           USING (SELECT * FROM u_sal_dw_cl.temp_promotions) source
              ON (target.promotion_id = source.promotion_id)
      WHEN NOT MATCHED THEN
         INSERT (promotion_id, promotion_desc, promotion_percent, promotion_type_id, promotion_type_desc, insert_dt, update_dt)
             VALUES (source.promotion_id, source.promotion_desc, source.promotion_percent, source.promotion_type_id, source.promotion_type_desc
             , source.insert_dt, source.update_dt)
      WHEN MATCHED THEN
         UPDATE SET target.promotion_desc=source.promotion_desc, target.promotion_percent=source.promotion_percent 
         , target.promotion_type_id=source.promotion_type_id, target.promotion_type_desc=source.promotion_type_desc
         , target.insert_dt=source.insert_dt, target.update_dt=source.update_dt;
COMMIT;

--dim_payment_methods

create global temporary table u_sal_dw_cl.temp_payment_methods
ON COMMIT DELETE ROWS
as (select * from u_dw_data.DW_PAYMENT_METHODS p where p.payment_method_id in (select payment_method_id from u_sal_data.fct_sales));

insert into u_sal_dw_cl.temp_payment_methods
(select * from u_dw_data.DW_PAYMENT_METHODS p where p.payment_method_id in (select payment_method_id from u_sal_data.fct_sales));

MERGE INTO u_sal_data.dim_payment_methods target
           USING (SELECT * FROM u_sal_dw_cl.temp_payment_methods) source
              ON (target.payment_method_id = source.payment_method_id)
      WHEN NOT MATCHED THEN
         INSERT (payment_method_id, payment_method_desc, insert_dt, update_dt)
             VALUES (source.payment_method_id, source.payment_method_desc
             , source.insert_dt, source.update_dt)
      WHEN MATCHED THEN
         UPDATE SET target.payment_method_desc=source.payment_method_desc
         , target.insert_dt=source.insert_dt, target.update_dt=source.update_dt;
COMMIT;

--dim_geo_locations

create global temporary table u_sal_dw_cl.temp_geo_locations
ON COMMIT DELETE ROWS
as (select * from u_dw_data.DW_GEO_LOCATIONS g where g.country_geo_id in (select geo_id from u_sal_data.fct_sales));

insert into u_sal_dw_cl.temp_geo_locations
(select * from u_dw_data.DW_GEO_LOCATIONS g where g.country_geo_id in (select geo_id from u_sal_data.fct_sales));

MERGE INTO u_sal_data.dim_geo_locations target
           USING (SELECT * FROM u_sal_dw_cl.temp_geo_locations) source
              ON (target.country_geo_id = source.country_geo_id)
      WHEN NOT MATCHED THEN
         INSERT (country_geo_id, geo_country_id, geo_country_code_a2, geo_country_code_a3, geo_country_desc, region_geo_id, geo_region_id
         , geo_region_code, geo_region_desc, contenet_geo_id, geo_part_id, geo_part_code, geo_part_desc, system_geo_id, geo_system_id
         , geo_system_code, geo_system_desc
         , insert_dt, update_dt)
             VALUES (source.country_geo_id, source.geo_country_id, source.geo_country_code_a2, source.geo_country_code_a3
             , source.geo_country_desc, source.region_geo_id, source.geo_region_id, source.geo_region_code
             , source.geo_region_desc, source.contenet_geo_id, source.geo_part_id, source.geo_part_code
             , source.geo_part_desc, source.system_geo_id, source.geo_system_id, source.geo_system_code, source.geo_system_desc
             , source.insert_dt, source.update_dt)
      WHEN MATCHED THEN
         UPDATE SET target.geo_country_id=source.geo_country_id, target.geo_country_code_a2=source.geo_country_code_a2
         , target.geo_country_code_a3=source.geo_country_code_a3, target.geo_country_desc=source.geo_country_desc
         , target.region_geo_id=source.region_geo_id, target.geo_region_id=source.geo_region_id
         , target.geo_region_code=source.geo_region_code, target.geo_region_desc=source.geo_region_desc
         , target.contenet_geo_id=source.contenet_geo_id, target.geo_part_id=source.geo_part_id
         , target.geo_part_code=source.geo_part_code, target.geo_part_desc=source.geo_part_desc
         , target.system_geo_id=source.system_geo_id, target.geo_system_id=source.geo_system_id
         , target.geo_system_code=source.geo_system_code, target.geo_system_desc=source.geo_system_desc
         , target.insert_dt=source.insert_dt, target.update_dt=source.update_dt;
COMMIT;

--dim_dates

create global temporary table u_sal_dw_cl.temp_dates
ON COMMIT DELETE ROWS
as (select * from u_dw_data.DW_DATES d where d.date_key in (select date_id from u_sal_data.fct_sales));

insert into u_sal_dw_cl.temp_dates
(select * from u_dw_data.DW_DATES d where d.date_key in (select date_id from u_sal_data.fct_sales));

MERGE INTO u_sal_data.dim_dates TARGET
     USING (SELECT * FROM  u_sal_dw_cl.temp_dates) SOURCE
        ON ( TARGET.date_key = SOURCE.date_key)
      WHEN NOT MATCHED THEN
        INSERT (date_key, date_full_number, date_full_string, date_weekday_fl, date_us_civil_holiday_fl, date_last_day_of_week_fl
                , date_last_day_of_month_fl, date_last_day_of_qtr_fl, date_last_day_of_yr_fl
                , date_day_of_week_name, date_day_of_week_abbr, date_day_number_of_week, date_day_number_of_month, date_day_number_of_qtr
                , date_day_number_of_yr, date_week_number_of_month, date_week_number_of_qtr, date_week_number_of_yr 
                , date_week_begin_dt, date_week_end_dt, date_year_number, date_month_name, date_month_name_abbr
                , date_month_number_of_yr, date_month_begin_dt, date_month_end_dt, date_qtr_number_of_yr
                , date_qtr_begin_dt, date_qtr_end_dt, date_yr_begin_dt, date_yr_end_dt
                , insert_dt, update_dt)
        VALUES (SOURCE.date_key, SOURCE.date_full_number, SOURCE.date_full_string, SOURCE.date_weekday_fl, SOURCE.date_us_civil_holiday_fl
                , SOURCE.date_last_day_of_week_fl, SOURCE.date_last_day_of_month_fl, SOURCE.date_last_day_of_qtr_fl, SOURCE.date_last_day_of_yr_fl
                , SOURCE.date_day_of_week_name, SOURCE.date_day_of_week_abbr, SOURCE.date_day_number_of_week
                , SOURCE.date_day_number_of_month, SOURCE.date_day_number_of_qtr, SOURCE.date_day_number_of_yr, SOURCE.date_week_number_of_month, SOURCE.date_week_number_of_qtr, SOURCE.date_week_number_of_yr
                , SOURCE.date_week_begin_dt, SOURCE.date_week_end_dt, SOURCE.date_year_number, SOURCE.date_month_name
                , SOURCE.date_month_name_abbr, SOURCE.date_month_number_of_yr, SOURCE.date_month_begin_dt, SOURCE.date_month_end_dt
                , SOURCE.date_qtr_number_of_yr, SOURCE.date_qtr_begin_dt, SOURCE.date_qtr_end_dt
                , SOURCE.date_yr_begin_dt, SOURCE.date_yr_end_dt
                , SOURCE.insert_dt, SOURCE.update_dt)
      WHEN MATCHED THEN
        UPDATE SET  TARGET.date_full_number=SOURCE.date_full_number, TARGET.date_full_string=SOURCE.date_full_string
                   , TARGET.date_weekday_fl=SOURCE.date_weekday_fl, TARGET.date_us_civil_holiday_fl=SOURCE.date_us_civil_holiday_fl
                   , TARGET.date_last_day_of_week_fl=SOURCE.date_last_day_of_week_fl, TARGET.date_last_day_of_month_fl=SOURCE.date_last_day_of_month_fl
                   , TARGET.date_last_day_of_qtr_fl=SOURCE.date_last_day_of_qtr_fl, TARGET.date_last_day_of_yr_fl=SOURCE.date_last_day_of_yr_fl
                   , TARGET.date_day_of_week_name=SOURCE.date_day_of_week_name, TARGET.date_day_of_week_abbr=SOURCE.date_day_of_week_abbr, TARGET.date_day_number_of_week=SOURCE.date_day_number_of_week
                   , TARGET.date_day_number_of_month=SOURCE.date_day_number_of_month, TARGET.date_day_number_of_qtr=SOURCE.date_day_number_of_qtr
                   , TARGET.date_day_number_of_yr=SOURCE.date_day_number_of_yr
                   , TARGET.date_week_number_of_month=SOURCE.date_week_number_of_month, TARGET.date_week_number_of_qtr=SOURCE.date_week_number_of_qtr
                   , TARGET.date_week_number_of_yr=SOURCE.date_week_number_of_yr, TARGET.date_week_begin_dt=SOURCE.date_week_begin_dt
                   , TARGET.date_week_end_dt=SOURCE.date_week_end_dt, TARGET.date_year_number=SOURCE.date_year_number, TARGET.date_month_name=SOURCE.date_month_name
                   , TARGET.date_month_name_abbr=SOURCE.date_month_name_abbr, TARGET.date_month_number_of_yr=SOURCE.date_month_number_of_yr
                   , TARGET.date_month_begin_dt=SOURCE.date_month_begin_dt, TARGET.date_month_end_dt=SOURCE.date_month_end_dt
                   , TARGET.date_qtr_number_of_yr=SOURCE.date_qtr_number_of_yr, TARGET.date_qtr_begin_dt=SOURCE.date_qtr_begin_dt
                   , TARGET.date_qtr_end_dt=SOURCE.date_qtr_end_dt
                   , TARGET.date_yr_begin_dt=SOURCE.date_yr_begin_dt, TARGET.date_yr_end_dt=SOURCE.date_yr_end_dt
                   , TARGET.insert_dt=SOURCE.insert_dt, TARGET.update_dt =SOURCE.update_dt;
COMMIT;

--dim_gen_periods

create global temporary table u_sal_dw_cl.temp_gen_periods
ON COMMIT DELETE ROWS
as (select * from u_dw_data.DW_GEN_PERIODS g where g.sales_cat_id in (select sales_cat_id from u_sal_data.fct_sales));

insert into u_sal_dw_cl.temp_gen_periods
(select * from u_dw_data.DW_GEN_PERIODS g where g.sales_cat_id in (select sales_cat_id from u_sal_data.fct_sales));

MERGE INTO u_sal_data.dim_gen_periods target
           USING (SELECT * FROM u_sal_dw_cl.temp_gen_periods) source
              ON (target.sales_cat_id = source.sales_cat_id)
      WHEN NOT MATCHED THEN
         INSERT (sales_cat_id, sales_cat_desc, start_amount, end_amount, insert_dt, update_dt)
             VALUES (source.sales_cat_id, source.sales_cat_desc, source.start_amount, source.end_amount
             , SOURCE.insert_dt, SOURCE.update_dt)
      WHEN MATCHED THEN
         UPDATE SET target.sales_cat_desc=source.sales_cat_desc, target.start_amount=source.start_amount
         , target.end_amount=source.end_amount
         , TARGET.insert_dt=SOURCE.insert_dt, TARGET.update_dt =SOURCE.update_dt;
COMMIT;

--EXCHANGE PARTITION

  CREATE TABLESPACE archive_2019
   DATAFILE '/oracle/u02/oradata/DMORCL19DB/ekalugin_db/archive_2019_data_01.dat'
       SIZE 50M
 AUTOEXTEND ON NEXT 10M
    SEGMENT SPACE MANAGEMENT AUTO;
    

    CREATE TABLE u_sal_dw_cl.sales_2019 TABLESPACE archive_2019 
NOLOGGING COMPRESS PARALLEL 4 AS SELECT * FROM u_dw_data.dw_sales
    WHERE date_id >= 20190000
      AND date_id < 20200000;

ALTER TABLE u_sal_data.fct_sales MODIFY CONSTRAINT PK_FCT_SALES DISABLE;


SELECT COUNT(*) FROM u_sal_data.fct_sales PARTITION (sales_2019);

SELECT COUNT(*) FROM u_sal_dw_cl.sales_2019;

ALTER TABLE u_sal_data.fct_sales EXCHANGE PARTITION sales_2019
 WITH TABLE u_sal_dw_cl.sales_2019 INCLUDING INDEXES;

ALTER TABLE u_sal_data.fct_sales MODIFY CONSTRAINT PK_FCT_SALES ENABLE NOVALIDATE;
ALTER TABLE u_sal_data.fct_sales MODIFY CONSTRAINT PK_FCT_SALES RELY;



--MERGE PARTITIONS

     CREATE TABLESPACE before_2019
   DATAFILE '/oracle/u02/oradata/DMORCL19DB/ekalugin_db/before_2019_data_01.dat'
       SIZE 50M
 AUTOEXTEND ON NEXT 10M
    SEGMENT SPACE MANAGEMENT AUTO;

   ALTER TABLE u_sal_data.fct_sales MERGE PARTITIONS sales_2017, sales_2018
    INTO PARTITION sales_before_2019 TABLESPACE before_2019 
COMPRESS UPDATE GLOBAL INDEXES PARALLEL 4;


   CREATE TABLE u_sal_dw_cl.sales_before_2019 TABLESPACE before_2019 
NOLOGGING COMPRESS PARALLEL 4 AS SELECT * FROM u_dw_data.dw_sales
    WHERE date_id > 20170000 AND date_id < 20190000


SELECT COUNT(*) FROM u_sal_data.fct_sales PARTITION (sales_before_2019);

SELECT COUNT(*) FROM u_sal_dw_cl.sales_before_2019;

ALTER TABLE u_sal_data.fct_sales MODIFY CONSTRAINT PK_FCT_SALES DISABLE;

ALTER TABLE  u_sal_data.fct_sales    EXCHANGE PARTITION sales_before_2019
 WITH TABLE u_sal_dw_cl.sales_before_2019 INCLUDING INDEXES;

ALTER TABLE u_sal_data.fct_sales MODIFY CONSTRAINT PK_FCT_SALES ENABLE NOVALIDATE;
ALTER TABLE u_sal_data.fct_sales MODIFY CONSTRAINT PK_FCT_SALES RELY;
