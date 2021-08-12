SET AUTOTRACE ON;

SELECT /*+ gather_plan_statistics */ p.pizza_desc pizza
       , decode(GROUPING(st.store_desc),1,'ALL STORES',st.store_desc) store
       , decode(GROUPING(cus.first_name),1,'ALL CUSTOMERS',cus.first_name) customer
       , d.date_month_number_of_yr month
       , gen.sales_cat_desc sale_category
       , geo.geo_country_desc country
       , SUM(s.sales_amount) sales_amount
   FROM u_sal_data.fct_sales s 
       join u_sal_data.dim_dates d on s.date_id = d.date_key 
       join u_sal_data.dim_geo_locations geo on s.geo_id = geo.country_geo_id
       join u_sal_data.dim_gen_periods gen on s.sales_cat_id = gen.sales_cat_id
       join u_sal_data.dim_stores st on s.store_id = st.store_id  
       join u_sal_data.dim_customers cus  on s.customer_id = cus.customer_id 
       join u_sal_data.dim_pizzas_scd p on s.pizza_surr_id = p.pizza_surr_id 
  WHERE d.date_year_number IN (2018) 
    AND d.date_month_number_of_yr BETWEEN 1 AND 13
  GROUP BY d.date_month_number_of_yr
           , p.pizza_desc
           , ROLLUP(st.store_desc, cus.first_name)
           , gen.sales_cat_desc, geo.geo_country_desc
  ORDER BY 4, 1, 2, 3;