CREATE OR REPLACE PACKAGE BODY u_dw_cl.pkg_cleansing_load_ref_sales

AS
   PROCEDURE load_sales
   AS
   BEGIN
      MERGE INTO u_dw_data.DW_SALES target
           USING (SELECT * FROM u_sa_sales_data.sa_sales) source
              ON (target.sales_id = source.sales_id)
      WHEN NOT MATCHED THEN
         INSERT (event_dt, sales_id, pizza_surr_id, employee_id, customer_id, store_id, geo_id, date_id, payment_method_id, promotion_id, sales_cat_id, sales_amount, sales_sum, insert_dt, update_dt)
             VALUES ((select CURRENT_DATE from DUAL), source.sales_id, source.pizza_id
                    , source.employee_id, source.customer_id, source.store_id
                    , source.geo_id, source.date_id, source.payment_method_id
                    , source.promotion_id, source.sales_cat_id, source.sales_amount, source.sales_sum
             , (select CURRENT_DATE from DUAL)
             , (select CURRENT_DATE from DUAL))
      WHEN MATCHED THEN
         UPDATE SET target.event_dt=(select CURRENT_DATE from dual), target.pizza_surr_id=source.pizza_id
                    , target.employee_id=source.employee_id, target.customer_id=source.customer_id
                    , target.store_id=source.store_id, target.geo_id=source.geo_id
                    , target.date_id=source.date_id,  target.payment_method_id=source.payment_method_id
                    , target.promotion_id=source.promotion_id, target.sales_cat_id=source.sales_cat_id
                    , target.sales_amount=source.sales_amount, target.sales_sum=source.sales_sum
         , target.update_dt= (select CURRENT_DATE from dual);

      --Commit Results
      COMMIT;
   END load_sales;
END;
/