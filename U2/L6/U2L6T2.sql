--task 2.1
 
 --HIGHEST_SALES_AMOUNT AND HIGHEST_SALES_SUM
 SELECT DISTINCT store_id, geo_id, date_id, FIRST_VALUE(sales_amount)
 OVER (PARTITION BY store_id, geo_id, date_id ORDER BY sales_amount DESC
       ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
       AS "HIGHEST_SALES_AMOUNT",
     FIRST_VALUE(sales_sum)
 OVER (PARTITION BY store_id, geo_id, date_id ORDER BY sales_sum DESC
       ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
       AS "HIGHEST_SALES_SUM"
FROM u_dw_data.dw_sales
ORDER BY store_id, geo_id, date_id;

 --LOWEST_SALES_AMOUNT AND LOWEST_SALESS_SUM
 SELECT DISTINCT pizza_surr_id,
 LAST_VALUE(sales_amount)
 OVER (PARTITION BY pizza_surr_id ORDER BY sales_amount DESC
       ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
       AS "LOWEST_SALES_AMOUNT",
 LAST_VALUE(sales_sum)
 OVER (PARTITION BY pizza_surr_id ORDER BY sales_sum DESC
       ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
       AS "LOWEST_SALES_SUM"
 FROM u_dw_data.dw_sales
 ORDER BY pizza_surr_id;
 
--task 2.2

select * from (
select store_id, sales_amount
       , RANK() OVER (PARTITION BY sales_cat_id ORDER BY sales_amount) sales_rank
  from u_dw_data.dw_sales
)   where sales_rank<=50;

select * from (
select store_id, sales_amount
       , DENSE_RANK() OVER (PARTITION BY sales_cat_id ORDER BY sales_amount) sales_dense_rank
  from u_dw_data.dw_sales
)   where sales_dense_rank<=50;

select * from (
select store_id, sales_amount
       , ROW_NUMBER() OVER (PARTITION BY sales_cat_id ORDER BY sales_amount) sales_row_number
  from u_dw_data.dw_sales
)   where sales_row_number<=50;

--task 2.3

SELECT DISTINCT geo_id
                , MAX(sales_amount)
  OVER (PARTITION BY  geo_id ORDER BY sales_amount DESC
       ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
       AS "MAX_SALES_AMOUNT"
                , MIN(sales_amount)
  OVER (PARTITION BY geo_id ORDER BY sales_amount DESC
       ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
       AS "MIN_SALES_AMOUNT"
                , ROUND(AVG(sales_amount)
  OVER (PARTITION BY geo_id ORDER BY sales_amount DESC
       ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING), 0)
       AS "AVG_SALES_AMOUNT"
  FROM u_dw_data.dw_sales
 ORDER BY geo_id;