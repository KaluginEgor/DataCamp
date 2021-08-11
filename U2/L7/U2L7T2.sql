GRANT CREATE MATERIALIZED VIEW TO u_dw_data;

--task 2.1

drop MATERIALIZED VIEW u_dw_data.sales_month;

CREATE MATERIALIZED VIEW u_dw_data.sales_month
TABLESPACE ts_dw_data_01
BUILD DEFERRED
REFRESH COMPLETE ON DEMAND
AS SELECT /*+ gather_plan_statistics */ p.pizza_desc pizza
       , geo.geo_country_desc country
       , decode(GROUPING(st.store_desc),1,'ALL STORES',st.store_desc) store
       , decode(GROUPING(cus.first_name),1,'ALL CUSTOMERS',cus.first_name) customer
       , d.date_month_number_of_yr month
       , gen.sales_cat_desc sale_category
       , SUM(s.sales_amount) sales_amount
   FROM u_dw_data.dw_sales s 
       join u_dw_data.dw_geo_locations geo on s.geo_id = geo.country_geo_id
       join u_dw_data.dw_gen_periods gen on s.sales_cat_id = gen.sales_cat_id
       join u_dw_data.dw_dates d on s.date_id = d.date_key 
       join u_dw_data.dw_stores st on s.store_id = st.store_id  
       join u_dw_data.dw_customers cus  on s.customer_id = cus.customer_id 
       join u_dw_data.dw_pizzas_scd p on s.pizza_surr_id = p.pizza_surr_id 
  WHERE d.date_year_number IN (2018) 
    AND d.date_month_number_of_yr BETWEEN 1 AND 13
  GROUP BY d.date_month_number_of_yr
           , p.pizza_desc
           , gen.sales_cat_desc
           , geo.geo_country_desc
           , ROLLUP(st.store_desc, cus.first_name)
  ORDER BY 5, 1, 2, 3, 4, 6;
  
SELECT * FROM u_dw_data.sales_month;

EXECUTE DBMS_MVIEW.REFRESH('u_dw_data.sales_month');

SELECT * FROM u_dw_data.sales_month;

--task 2.2
CREATE MATERIALIZED VIEW u_dw_data.sales_day
TABLESPACE ts_dw_data_01
  BUILD IMMEDIATE
REFRESH ON COMMIT 
AS SELECT /*+ gather_plan_statistics */ p.pizza_desc pizza
       , st.store_desc store
       , cus.first_name customer
       , d.date_day_number_of_yr day
       , SUM(s.sales_amount) sales_amount
  FROM u_dw_data.dw_sales s 
       , u_dw_data.dw_dates d 
       , u_dw_data.dw_stores st 
       , u_dw_data.dw_customers cus  
       , u_dw_data.dw_pizzas_scd p 
 WHERE d.date_year_number IN (2018) 
   AND d.date_day_number_of_yr BETWEEN 1 AND 366
   AND s.date_id = d.date_key 
   AND s.store_id = st.store_id  
   AND s.customer_id = cus.customer_id 
   AND s.pizza_surr_id = p.pizza_surr_id 
 GROUP BY d.date_day_number_of_yr
          , p.pizza_desc
          , st.store_desc
          , cus.first_name
ORDER BY 4, 1, 2, 3;

SELECT * FROM u_dw_data.sales_day;


UPDATE u_dw_data.dw_sales 
SET sales_amount=sales_amount*2
WHERE pizza_surr_id=100
AND store_id=57976
AND customer_id=674085;
COMMIT;

SELECT * FROM u_dw_data.sales_day 
ORDER BY 4, 1, 2, 3;