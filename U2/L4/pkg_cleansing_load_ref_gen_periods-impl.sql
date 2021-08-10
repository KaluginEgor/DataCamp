CREATE OR REPLACE PACKAGE BODY u_dw_cl.pkg_cleansing_load_ref_gen_periods

AS
   PROCEDURE load_gen_periods
   AS
   BEGIN
      MERGE INTO u_dw_data.DW_GEN_PERIODS target
           USING (SELECT * FROM u_sa_gen_periods_data.sa_gen_periods) source
              ON (target.sales_cat_id = source.sales_cat_id)
      WHEN NOT MATCHED THEN
         INSERT (sales_cat_id, sales_cat_desc, start_amount, end_amount, insert_dt, update_dt)
             VALUES (source.sales_cat_id, source.sales_cat_desc, source.start_amount, source.end_amount
             , (select CURRENT_DATE from DUAL)
             , (select CURRENT_DATE from DUAL))
      WHEN MATCHED THEN
         UPDATE SET target.sales_cat_desc=source.sales_cat_desc, target.start_amount=source.start_amount
         , target.end_amount=source.end_amount
         , target.update_dt= (select CURRENT_DATE from dual);

      --Commit Resulst
      COMMIT;
   END load_gen_periods;
END;
/