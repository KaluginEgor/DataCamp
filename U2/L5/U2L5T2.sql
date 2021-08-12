VARIABLE n_all_data NUMBER;
VARIABLE n_customer NUMBER;
VARIABLE n_store NUMBER;
VARIABLE n_summary NUMBER;
BEGIN
 -- set values to 0 to disable
 :n_all_data := 0; -- 1 to enable
 :n_customer := 2; -- 2 to enable
 :n_store  := 0; -- 3 to enable
 :n_summary  := 4; -- 4 to enable
END;


SET AUTOTRAcE ON;
 
 SELECT /*+ gather_plan_statistics */ p.pizza_desc pizza
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
 HAVING GROUPING_ID(st.store_desc, cus.first_name)+1 IN(:n_all_data,:n_customer,:n_store,:n_summary)
  ORDER BY 5, 1, 2, 3, 4, 6;


create or replace view lab5 as 
SELECT /*+ gather_plan_statistics */ s.sales_id id
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
    AND d.date_month_number_of_yr BETWEEN 1 AND 13;

SET AUTOTRACE ON;   
SELECT * FROM lab5
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