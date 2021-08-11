
CREATE MATERIALIZED VIEW u_dw_data.mv_sales_month
BUILD IMMEDIATE
REFRESH COMPLETE ON DEMAND  START WITH SYSDATE NEXT (SYSDATE + 1/1440)
AS SELECT * FROM (SELECT /*+ gather_plan_statistics */ s.sales_id id
       , p.pizza_desc pizza
       , geo.geo_country_desc country
       , st.store_desc store
       , cus.first_name customer
       , d.date_month_number_of_yr month
       , gen.sales_cat_desc sale_category
       , s.sales_amount sales_amount
   FROM u_dw_data.dw_sales s 
       join u_dw_data.dw_geo_locations geo on s.geo_id = geo.country_geo_id
       join u_dw_data.dw_gen_periods gen on s.sales_cat_id = gen.sales_cat_id
       join u_dw_data.dw_dates d on s.date_id = d.date_key 
       join u_dw_data.dw_stores st on s.store_id = st.store_id  
       join u_dw_data.dw_customers cus  on s.customer_id = cus.customer_id 
       join u_dw_data.dw_pizzas_scd p on s.pizza_surr_id = p.pizza_surr_id 
  WHERE d.date_year_number IN (2018) 
    AND d.date_month_number_of_yr BETWEEN 1 AND 13)
group by month, store, customer, country, sale_category
     model
    dimension by (sum(id) as id)
     measures (store
     , sum(sales_amount) sales_amount
     , sale_category 
     , customer 
     , country
     ,  month
     ,0 as income
     )
     rules (income[any] = sales_amount[cv()]); 

SELECT * FROM u_dw_data.mv_sales_month;

SELECT * FROM u_dw_data.mv_sales_month ORDER BY id;

UPDATE u_dw_data.dw_sales 
SET sales_amount=sales_amount*2
WHERE sales_id=4;

SELECT * FROM u_dw_data.mv_sales_month ORDER BY id;