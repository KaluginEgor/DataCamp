--daily reports

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
/

SET AUTOTRACE ON;

SELECT /*+ gather_plan_statistics */ p.pizza_desc pizza
       , decode(GROUPING(st.store_desc),1,'ALL STORES',st.store_desc) store
       , decode(GROUPING(cus.first_name),1,'ALL CUSTOMERS',cus.first_name) customer
       , d.date_day_number_of_yr day
       , SUM(s.sales_amount) sales_amount
  FROM u_sa_sales_data.sa_sales s 
       join u_sa_dates_data.sa_dates d on s.date_id = d.date_key 
       join u_sa_stores_data.sa_stores st on s.store_id = st.store_id  
       join u_sa_customers_data.sa_customers cus  on s.customer_id = cus.customer_id 
       join u_sa_pizzas_data.sa_pizzas p on s.pizza_id = p.pizza_id 
 WHERE d.date_year_number IN (2018) 
   AND d.date_day_number_of_yr BETWEEN 1 AND 366
 GROUP BY d.date_day_number_of_yr
          , p.pizza_desc
          , CUBE(st.store_desc, cus.first_name)
HAVING GROUPING_ID(st.store_desc,cus.first_name)+1 IN(:n_all_data,:n_customer,:n_store,:n_summary)
ORDER BY 4, 1, 2, 3;
 
--monthly report

SET AUTOTRAcE ON;
 
 SELECT /*+ gather_plan_statistics */ p.pizza_desc pizza
       , decode(GROUPING(st.store_desc),1,'ALL STORES',st.store_desc) store
       , decode(GROUPING(cus.first_name),1,'ALL CUSTOMERS',cus.first_name) customer
       , d.date_month_number_of_yr month
       , SUM(s.sales_amount) sales_amount
   FROM u_sa_sales_data.sa_sales s 
       join u_sa_dates_data.sa_dates d on s.date_id = d.date_key 
       join u_sa_stores_data.sa_stores st on s.store_id = st.store_id  
       join u_sa_customers_data.sa_customers cus  on s.customer_id = cus.customer_id 
       join u_sa_pizzas_data.sa_pizzas p on s.pizza_id = p.pizza_id 
  WHERE d.date_year_number IN (2018) 
    AND d.date_month_number_of_yr BETWEEN 1 AND 13
  GROUP BY d.date_month_number_of_yr
           , p.pizza_desc
           , ROLLUP(st.store_desc, cus.first_name)
 HAVING GROUPING_ID(st.store_desc, cus.first_name)+1 IN(:n_all_data,:n_customer,:n_store,:n_summary)
  ORDER BY 4, 1, 2, 3;
  
  
--

SET AUTOTRAcE ON;
SELECT 
         d.date_year_number year
        , d.date_qtr_number_of_yr quarter
        , d.date_month_number_of_yr month
        , d.date_day_number_of_yr day
        , GROUPING_Id(d.date_year_number
                      , d.date_qtr_number_of_yr
                      , d.date_month_number_of_yr
                      , d.date_day_number_of_yr) gid
                      , p.category_desc pizza_category
                      , decode(GROUPING(st.store_desc),1,'ALL STORES',st.store_desc) store
                      , decode(GROUPING(cus.first_name),1,'ALL CUSTOMERS',cus.first_name) customer
                      , SUM(S.sales_amount) sales_amount
  FROM u_sa_sales_data.sa_sales s 
       join u_sa_dates_data.sa_dates d on s.date_id = d.date_key 
       join u_sa_stores_data.sa_stores st on s.store_id = st.store_id  
       join u_sa_customers_data.sa_customers cus  on s.customer_id = cus.customer_id 
       join u_sa_pizzas_data.sa_pizzas p on s.pizza_id = p.pizza_id
 GROUP BY p.category_desc
          , ROLLUP(st.store_desc, cus.first_name)
          , ROLLUP(d.date_year_number
                   , d.date_qtr_number_of_yr
                   , d.date_month_number_of_yr
                   , d.date_day_number_of_yr);

