CREATE OR REPLACE PACKAGE BODY u_dw_cl.pkg_cleansing_load_ref_promotions

AS
   PROCEDURE load_promotions
   AS
   BEGIN
      MERGE INTO u_dw_data.DW_PROMOTIONS target
           USING (SELECT * FROM u_sa_promotions_data.sa_promotions) source
              ON (target.promotion_id = source.promotion_id)
      WHEN NOT MATCHED THEN
         INSERT (promotion_id, promotion_desc, promotion_percent, promotion_type_id, promotion_type_desc, insert_dt, update_dt)
             VALUES (source.promotion_id, source.promotion_desc, source.promotion_percent, source.promotion_type_id, source.promotion_type_desc
             , (select CURRENT_DATE from DUAL)
             , (select CURRENT_DATE from DUAL))
      WHEN MATCHED THEN
         UPDATE SET target.promotion_desc=source.promotion_desc, target.promotion_percent=source.promotion_percent 
         , target.promotion_type_id=source.promotion_type_id, target.promotion_type_desc=source.promotion_type_desc
         , target.update_dt= (select CURRENT_DATE from dual);

      --Commit Results
      COMMIT;
   END load_promotions;
END;
/